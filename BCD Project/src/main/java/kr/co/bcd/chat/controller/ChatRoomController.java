package kr.co.bcd.chat.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
							   //@RequestParam(value="idx", defaultValue="")int idx,
							   HttpSession session,
							   Model model) {
		int listCount = chatRoomService.selectListCount(category);
		int pageLimit = 10;
		int boardLimit = 15;
		
		int row = listCount - (currentPage - 1)*boardLimit;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		List<ChatRoom> list = chatRoomService.selectListAll(pi, category);
		
		int memberIdx = 3;
		String memberNickname = memberService.selectNickname(memberIdx);
		System.out.println("닉네임 : " + memberNickname);
		
//		String participants = chatRoomService.getParticipants(idx);
//		String[] participantsArray = participants.split(",");
//		int participantsLength=participantsArray.length;
		
		
//		model.addAttribute("participantsLength",participantsLength);
		model.addAttribute("memberNickname",memberNickname);
		model.addAttribute("list", list);
		model.addAttribute("row", row);
		model.addAttribute("pi", pi);
		
		System.out.println("채팅방 몇 개 : "+listCount);
		return "chat/chatRoomList";
		
	} 
	@PostMapping("/create.do")
	public String createChatRoom (ChatRoom chatRoom, HttpSession session, Model model) {
		int result = chatRoomService.createChatRoom(chatRoom);
		System.out.println("이것도 0이겠지..."+chatRoom.getIdx());
		System.out.println("이건 나오나??..."+chatRoom.getTitle());
		int createdChatRoomIdx = chatRoom.getIdx();
		
//		int memberIdx = 3;
//		String memberNickname = memberService.selectNickname(memberIdx);
		
        
	    if(result>0) {
//	    	System.out.println(memberNickname);
//	    	model.addAttribute("memberNickname",memberNickname);
//	    	model.addAttribute("chatRoom" , chatRoom);
//	    	return "chat/chatRoom";
	    	
	    	return "redirect:/chat/enter.do?idx="+createdChatRoomIdx;
	    } else {
	    	return "chat/chatRoomList";
	    }
		
	}
	
	@RequestMapping("enter.do")
	public String enterChatRoom(@RequestParam(value="idx")int idx, Model model, HttpSession session) {
		
		ChatRoom result = chatRoomService.enterChatRoom(idx);
		
		if(!Objects.isNull(result)) {
			
			//지금 누른 채팅방 idx 저장
			result.setIdx(idx);
			
			//채팅 참여자 목록 가져와서 배열로 바꾸기
//			String getParticipants = result.getParticipants();
//			List<String> participantsList = Arrays.asList(getParticipants.split(","));
//			
			//test 사용
			int memberIdx = 3;
			//세션에 저장된 memberIdx로 참여자 목록에 닉네임 저장 
//			int memberIdx = (int) session.getAttribute("memberIdx");
			String newParticipant = memberService.selectNickname(memberIdx);
			
//			participantsList.add(newParticipant);		
//			String updateParticipants = String.join(",", participantsList);
//			result.setParticipants(updateParticipants);
			
			//DB 대화 목록 가져오기
			
			model.addAttribute("result", result);
			model.addAttribute("memberNickname", newParticipant);
			
			return "chat/chatRoom";
		
		}else {
			
			return "chat/chatRoomList";
		}
		
	}
	
}
