package kr.co.bcd.chat.controller;

import org.springframework.stereotype.Controller;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/chatroom") 
public class ChatRoomController {
=======
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git

@Controller
@RequestMapping("/chat")
public class ChatRoomController {
	
	@GetMapping("/chatRoomList")
	public String test() {
		
		
		System.out.println("됐나??");
		
		return "chat/chatRoomList";
		
	} 
	
}
