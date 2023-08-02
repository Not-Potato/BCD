package kr.co.bcd.chat.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

import kr.co.bcd.chat.model.dto.ChatMsg;
import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.chat.model.service.ChatRoomServiceImpl;
import kr.co.bcd.member.model.service.MemberServiceImpl;

@Component
public class ChatMsgHandler extends TextWebSocketHandler {
	
	private Map<Integer, List<WebSocketSession>> RoomSessionList = new HashMap<>();
	private static Logger logger = LoggerFactory.getLogger(ChatMsgHandler.class);
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private ChatRoomServiceImpl chatRoomService;
	
	//클라이언트가 서버와 연결 시 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		
		int idx = extractIdx(session);
		
        //이전 대화 내역, 입장 메시지, 닉네임 담을 MAP
		Map<String, Object> chatData = new HashMap<>();
		
		//이전 대화 가져오기
	    List<ChatMsg> previousChat = chatRoomService.previousChat(idx);
	    
	    //닉네임 담을 리스트
//	    List<ObjectNode> msgNnicknameList = new ArrayList<>();
	    List<String> senderNicknameList = new ArrayList<>();
	    
	    for(ChatMsg chatMsg : previousChat) {
	    	String senderNickname=memberService.selectNickname(chatMsg.getSenderIdx());
	    	
//	    	ObjectMapper objectMapper = new ObjectMapper();
//	    	ObjectNode chatMsgJson = objectMapper.valueToTree(chatMsg);
//	    	chatMsgJson.put("senderNickname", senderNickname);
	    	
	    	senderNicknameList.add(senderNickname);
	    }
	    
	    chatData.put("previousChat", previousChat);
	    chatData.put("senderNicknameList", senderNicknameList);
	    
	  
	    
	   
	    
		//sessions에 RoomSessionList key인 idx에 맞는 ArrayList를 가져와 대입하고 만약 빈값이라면 새로운 ArrayList를 대입.
		List <WebSocketSession> sessionList = RoomSessionList.getOrDefault(idx, new ArrayList<>());
		//그니까 기존 채팅방에 있는 세션을 가져오고 -> 새로 연결된 세션을 리스트에 넣어주고 -> 다시 채팅방 idx에 해당하는 리스트를 업데이트
		sessionList.add(session);
		RoomSessionList.put(idx, sessionList);
		
		logger.info(session.getId()+"님 채팅 서버 연결 되었습니다.");
		System.out.println(session.getId()+ "님 채팅 서버 연결 되었습니다.");	
		
//      현재 memberIdx 세션에서 가져오기(websocketsession 때문에 httpsession은 interceptor만들고 사용가능)		
//		int memberIdx = 1;
		HttpSession httpSession = (HttpSession) session.getAttributes().get("httpSession");
		int memberIdx = (int) httpSession.getAttribute("memberIdx");
		
		String memberNickname = memberService.selectNickname(memberIdx);
		ChatMsg enterMessage = new ChatMsg();
		//발신자 enterMsg로 해서 js가 senderIdx : enterMsg 받으면 입장메시지 출력하도록
		enterMessage.setSenderIdx(-1);
		enterMessage.setContent(memberNickname+ "님이 입장하셨습니다.");
		chatData.put("enterMessage", enterMessage);

//		//메시지 리스트 만들기
//		List<ChatMsg> preNenterMsg = new ArrayList<>();
//		//이전 대화 리스트 넣기
//		preNenterMsg.addAll(previousChat);
//		//입장 메시지 넣기
//		preNenterMsg.add(enterMessage);
		
		
		ObjectMapper objectMapper = new ObjectMapper();
	    String jsonMessage = objectMapper.writeValueAsString(chatData);
	    System.out.println("jsonmessage"+jsonMessage);
        
		for (WebSocketSession webSession : sessionList) {
            webSession.sendMessage(new TextMessage(jsonMessage));
        }
	}
	//메시지 전송 시 실행 -> 서버에서 메시지 받아서 연결된 세션에 뿌려주는?????
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		logger.info("{} : {}", session.getId(), message.getPayload());
		
//		//JS로 message 가져오기 (sender, message, sendDate (+ roomIdx 추가)담은 JS 객체 형식을 JSON 문자열화 (stringify)
		String payload = message.getPayload();
//		//JSON 메시지를 ChatMsg 객체로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		ChatMsg chatMsg = objectMapper.readValue(payload, ChatMsg.class);
		int result = chatRoomService.msgSave(chatMsg);
			if(result>0) {
				//chatMsg 객체를 다시 json형식으로 변환
				ObjectNode chatMsgJson = objectMapper.valueToTree(chatMsg);
				//sender의 닉네임 구하기
				String senderNickname=memberService.selectNickname(chatMsg.getSenderIdx());    
				chatMsgJson.put("senderNickname", senderNickname);
				String responsePayload = objectMapper.writeValueAsString(chatMsgJson);
				logger.info("chatMsg", session.getId(), message.getPayload());
				int idx = chatMsg.getRoomIdx();
//      		JS에서 roomIdx 보내므로 필요없음.
//				int idx = extractIdx(session);
				List <WebSocketSession>sessionList = RoomSessionList.getOrDefault(idx, new ArrayList<>());
				for(WebSocketSession webSession : sessionList) {
					webSession.sendMessage(new TextMessage(responsePayload));
					System.out.println("서버가 받은 메시지" + message.getPayload());
				}
				
			}
	}
	//클라이언트가 서버와 연결 종료 시 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		
		logger.info("연결이 해제되었습니다.", session.getId());
		System.out.println(session.getId()+ "님 채팅 서버 연결 해제 되었습니다.");	
		
		int idx = extractIdx(session);
		List<WebSocketSession> sessionList = RoomSessionList.getOrDefault(idx, new ArrayList<>());
		sessionList.remove(session);
		RoomSessionList.put(idx, sessionList);
		
		//httpsession 가져오기
		HttpSession httpSession = (HttpSession) session.getAttributes().get("httpSession");
		//퇴장한 사람 DB 삭제
		outChatRoom(session,httpSession);
		
//		 Object memberIdxObject = session.getAttributes().get("memberIdx");
//		 // memberIdxObject를 int 타입으로 변환
//		 int memberIdx = Integer.parseInt(memberIdxObject.toString());

		
		
		int memberIdx = (int) httpSession.getAttribute("memberIdx");
		//int memberIdx = 1;
		String memberNickname = memberService.selectNickname(memberIdx);
		ChatMsg outMessage = new ChatMsg();
		outMessage.setSenderIdx(-2);
		outMessage.setContent(memberNickname+ "님이 퇴장하셨습니다.");
		
		ObjectMapper objectMapper = new ObjectMapper();
	    String jsonMessage = objectMapper.writeValueAsString(outMessage);
	    
        for (WebSocketSession webSession : sessionList) {
            webSession.sendMessage(new TextMessage(jsonMessage));
        }

		
	}

	//웹소켓 연결 시 생성된 url 가지고 와서 roomIdx 추출
	private int extractIdx(WebSocketSession session) {
       
		String uri = session.getUri().toString();
        // "/"로 자른 배열
        String[] uriParts = uri.split("/");
        //마지막 part -> int로 형변환 
        return Integer.parseInt(uriParts[uriParts.length - 1]);
    }
	
	public void outChatRoom(WebSocketSession session, HttpSession httpSession) {
		//채팅방 idx 가져오기
		int idx = extractIdx(session);
		//채팅방 정보 가져오기 (채팅방 들어 갈 때 가져왔던 정보)
		ChatRoom chatRoom = chatRoomService.enterChatRoom(idx);
		//사용자 닉네임 가져오기
	//	int memberIdx = 1; 
	  //세션에서 memberIdx 가져오기
		int memberIdx = (int) httpSession.getAttribute("memberIdx");
		String memberNickname = memberService.selectNickname(memberIdx);
		if(chatRoom != null) {
			String participants = chatRoom.getParticipants();
			if(participants.contains(memberNickname)){
				if(participants.startsWith(participants+",")) {
					participants = participants.replace(memberNickname + ",", "");
				}else if(!participants.contains(",")){
					if(participants.equals(memberNickname)) {
						chatRoomService.deleteChatRoom(idx);
						chatRoomService.deleteChatMsg(idx);
					}
//					else {
//						participants = participants.replace(memberNickname, "");
//					}
				}else {
					participants = participants.replace("," + memberNickname, "");
				}
				chatRoom.setParticipants(participants);
				chatRoomService.updateParticipants(chatRoom);
			}
			
		}
		
	}
	

}
