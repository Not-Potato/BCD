package kr.co.bcd.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chat")
public class ChatRoomController {
	
	@GetMapping("/chatRoomList")
	public String test() {
		
		
		System.out.println("됐나??");
		
		return "chat/chatRoomList";
		
	} 
	
}
