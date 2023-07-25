package kr.co.bcd.chat.handler;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@RequestMapping("/chatMsg")
public class ChatMsgHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private static Logger logger = LoggerFactory.getLogger(ChatMsgHandler.class);
	
	//연결 시 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		sessionList.add(session);
		logger.info("{} 님이 입장하셨습니다", session.getId());
		
	}
	//메시지 전송 시 실행
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		logger.info("{} : {}", session.getId(), message.getPayload());
		for(WebSocketSession webSession : sessionList) {
			webSession.sendMessage(new TextMessage(message.getPayload()));
		}
	}
	//연결 종료 시 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		sessionList.remove(session);
		logger.info("{} 님이 퇴장하셨습니다.", session.getId());
		
	}
	

}
