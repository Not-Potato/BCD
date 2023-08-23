package kr.co.bcd.chat.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;

import kr.co.bcd.chat.handler.ChatMsgHandler;
import kr.co.bcd.chat.interceptor.ChatInterceptor;

@Controller
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		//핸들러 bean, 경로 저장, setAllowed는 모든 출처에서 접근을 허용하여 클라이언트-서버간의 실시간 통신 가능하게
		registry.addHandler(chatMsgHandler(), "/chatMsg/{idx}").setAllowedOrigins("*")
				.addInterceptors(new ChatInterceptor());
		
	}   
	@Bean //내가 만든 핸들러 bean으로 저장
	public WebSocketHandler chatMsgHandler() {
		return new ChatMsgHandler();
	}
	
//	@Bean
//	 public HandshakeInterceptor ChatInterceptor() {
//        return new HandshakeInterceptor() {
//            public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, 
//                  WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
//
//                // Get the URI segment corresponding to the auction id during handshake
//                String path = request.getURI().getPath();
//                String auctionId = path.substring(path.lastIndexOf('/') + 1);
//
//                // This will be added to the websocket session
//                attributes.put("auctionId", auctionId);
//                return true;
//            }
	
	
	
	
	
	
	
	
	
	
}
