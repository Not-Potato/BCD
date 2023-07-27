package kr.co.bcd.chat.handler;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.co.bcd.member.model.service.MemberServiceImpl;

@Component
public class ChatMsgHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private static Logger logger = LoggerFactory.getLogger(ChatMsgHandler.class);
	
	@Autowired
	private MemberServiceImpl memberService;
	
	//클라이언트가 서버와 연결 시 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessionList.add(session);
		logger.info(session.getId()+"님 채팅 서버 연결 되었습니다.");
		System.out.println(session.getId()+ "님 채팅 서버 연결 되었습니다.");	
		//세션에서 memberIdx 가져오기
		//int memberIdx = (int) session.getAttribute("memberIdx");
		int memberIdx = 3;
		String memberNickname = memberService.selectNickname(memberIdx);
		String enterMessage = memberNickname + "님이 입장하셨습니다.";
        for (WebSocketSession webSession : sessionList) {
            webSession.sendMessage(new TextMessage(enterMessage));
        }
	}
	//메시지 전송 시 실행 -> 서버에서 메시지 받아서 연결된 세션에 뿌려주는?????
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		logger.info("{} : {}", session.getId(), message.getPayload());
		for(WebSocketSession webSession : sessionList) {
			webSession.sendMessage(new TextMessage(message.getPayload()));
			System.out.println("서버가 받은 메시지" + message.getPayload());
		}
	}
	//클라이언트가 서버와 연결 종료 시 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		sessionList.remove(session);
		logger.info("연결이 해제되었습니다.", session.getId());
		System.out.println(session.getId()+ "님 채팅 서버 연결 해제 되었습니다.");	
		int memberIdx = 3;
		String memberNickname = memberService.selectNickname(memberIdx);
		String outMessage = memberNickname + "님이 퇴장하셨습니다.";
        for (WebSocketSession webSession : sessionList) {
            webSession.sendMessage(new TextMessage(outMessage));
        }

		
	}
	

}
