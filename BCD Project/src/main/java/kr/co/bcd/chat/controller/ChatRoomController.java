package kr.co.bcd.chat.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.chat.model.service.ChatRoomServiceImpl;
import kr.co.bcd.common.paging.model.PageInfo;
import kr.co.bcd.common.paging.template.Pagination;
import kr.co.bcd.member.model.service.MemberServiceImpl;

@Controller
@RequestMapping("/chat")
public class ChatRoomController {
	
	@Autowired
	private ChatRoomServiceImpl chatRoomService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@GetMapping("/list.do")
	public String chatRoomList(@RequestParam(value="category", defaultValue="" )String category,
							   @RequestParam(value="cpage", defaultValue = "1") int currentPage,
							   //@RequestParam(value="idx", defaultValue=0)int idx,
							   HttpSession session,
							   Model model) {
		int listCount = chatRoomService.selectListCount(category);
		int pageLimit = 10;
		int boardLimit = 15;
		
		int row = listCount - (currentPage - 1)*boardLimit;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		List<ChatRoom> list = chatRoomService.selectListAll(pi, category);
		
//		String participants = chatRoomService.getParticipants(idx);
//		String[] participantsArray = participants.split(",");
//		int participantsLength=participantsArray.length;
		
		
//		model.addAttribute("participantsLength",participantsLength);
		model.addAttribute("list", list);
		model.addAttribute("row", row);
		model.addAttribute("pi", pi);
		
		System.out.println("채팅방 몇 개 : "+listCount);
		return "chat/chatRoomList";
		
	} 
	@PostMapping("/createChatRoom.do")
	public String createChatRoom (ChatRoom chatRoom, HttpSession session, Model model) {
		int result = chatRoomService.createChatRoom(chatRoom);
		
		//int memberIdx = 1;
		//String memberNickname = memberService.selectNickname(memberIdx);
		
		
		
	    if(result>0) {
	    	//model.addAttribute("memberNickname",memberNickname);
	    	model.addAttribute("list" , chatRoom);
	    	return "chat/chatRoom";
	    } else {
	    	return "chat/chatRoomList";
	    }
		
	}
	
}
