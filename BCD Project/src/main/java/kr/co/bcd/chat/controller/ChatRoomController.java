package kr.co.bcd.chat.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.bcd.chat.model.dto.ChatRoom;
import kr.co.bcd.chat.model.service.ChatRoomServiceImpl;
import kr.co.bcd.common.controller.SessionManageController;
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
	
	@Autowired
	private SessionManageController sessionManage;
	
	@GetMapping("/list.do")
	public String chatRoomList(@RequestParam(value="category", defaultValue="" )String category,
							   @RequestParam(value="cpage", defaultValue = "1") int currentPage,
							   @RequestParam(value="searchTxt", defaultValue = "") String searchTxt,
							   HttpSession session,
							   HttpServletResponse response,
							   Model model)throws Exception {
		
		int listCount = chatRoomService.selectListCount(category);
		int pageLimit = 10;
		int boardLimit = 16;
		
		int row = listCount - (currentPage - 1)*boardLimit;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		List<ChatRoom> list = chatRoomService.selectListAll(pi, category, searchTxt);
		List<Integer> participantsSizeList = new ArrayList<>(); 
		List<String> roomOwnerList = new ArrayList<>();
		
		
		String roomOwner;
		
		for (ChatRoom chatRoom : list) {
			String participants =chatRoom.getParticipants();
			System.out.println("참여자좀 가져와!!"+participants);
			int participantsSize = 1;
			
			if(participants.contains(",")) {
				List<String> participantsList = Arrays.asList(participants.split(","));
				//참여자 수 구하기
				participantsSize = participantsList.size();
				roomOwner = participantsList.get(0);
				System.out.println("tntn"+participantsSize);
				
			}else {
				roomOwner = participants;
			}	
			System.out.println("tntn111"+participantsSize);
		
			//if밖에 있어야 순서대로 , 있으면 size 저장, 없으면 1로 저장
			
			participantsSizeList.add(participantsSize);
			roomOwnerList.add(roomOwner);
			
		} 
		//session null check 
		
		int memberIdx = (int) session.getAttribute("memberIdx");
		String memberNickname = memberService.selectNickname(memberIdx);
		System.out.println("닉네임 : " + memberNickname);
		
		model.addAttribute("roomOwnerList", roomOwnerList);
		model.addAttribute("participantsSizeList",participantsSizeList);
		model.addAttribute("memberNickname",memberNickname);
		model.addAttribute("list", list);
		model.addAttribute("row", row);
		model.addAttribute("pi", pi);
		
		
		System.out.println("채팅방 몇 개 : "+listCount);
		return "chat/chatRoomList";
		
	} 
	
	@PostMapping("/create.do")
	public String createChatRoom (ChatRoom chatRoom, HttpSession session, Model model) {
		
		
//		int memberIdx = 1;
		int memberIdx = (int) session.getAttribute("memberIdx");
		String memberNickname = memberService.selectNickname(memberIdx);
		
		chatRoom.setParticipants(memberNickname);
		
		int result = chatRoomService.createChatRoom(chatRoom);
		System.out.println("이것도 0이겠지..."+chatRoom.getIdx());
		System.out.println("이건 나오나??..."+chatRoom.getTitle());
		int createdChatRoomIdx = chatRoom.getIdx();
		
		
        
	    if(result>0) {
	
	    	sessionManage.setSessionMsg("채팅방이 성공적으로 생성되었습니다!", "success", session);
	    
	    	return "redirect:/chat/enter.do?idx="+createdChatRoomIdx;
	    } else {
	    	sessionManage.setSessionMsg("채팅방 생성에 실패했습니다!", "error", session);
	    	
	    	return "chat/chatRoomList";
	    }
		
	}
	
	@RequestMapping("enter.do")
	public String enterChatRoom(@RequestParam(value="idx")int idx, Model model, HttpSession session) {
		
    	sessionManage.getSessionMsg(session, model);

		ChatRoom result = chatRoomService.enterChatRoom(idx);
		
		if(!Objects.isNull(result)) {
			
			//지금 누른 채팅방 idx 저장
			result.setIdx(idx);
			
			//test 사용
//			int memberIdx = 1;
			//세션에 저장된 memberIdx로 참여자 목록에 닉네임 저장 
			int memberIdx = (int) session.getAttribute("memberIdx");
			String newParticipant = memberService.selectNickname(memberIdx);
			System.out.println("뉴멤버"+newParticipant);

			
			//채팅 참여자 목록 가져오기
			String getParticipants = result.getParticipants();
			System.out.println("db멤버"+getParticipants);
			System.out.println("맞니?"+getParticipants.contains(newParticipant));

			int participantsSize;
			String roomOwner;
			
			//참여자라면 -> db에 저장되어있는 닉네임이라면 개설자 (createChatRoom.do에서 저장하고 오기 때문)
			if(!getParticipants.contains(newParticipant)) {
				getParticipants += ("," + newParticipant);
				//배열로 바꾸기
				List<String> participantsList = Arrays.asList(getParticipants.split(","));
				
				roomOwner = participantsList.get(0);
				
				System.out.println("추가될 참여자 : " + newParticipant);
				
				result.setParticipants(getParticipants);
				chatRoomService.updateParticipants(result);
				
				//jsp에서 참여자 리스트 출력
				model.addAttribute("participantsList", participantsList);

				//참여자 수 구하기
				participantsSize = participantsList.size();
				
				for (String participant : participantsList) {
					System.out.println("참여자 목록 출력 : "+participant);
				}	
			}	
			else {
				roomOwner = getParticipants;
				participantsSize = 1;
			}	
			//DB 대화 목록 가져오기
			
			System.out.println("participantsSize사이즈"+participantsSize);
		
		model.addAttribute("roomOwner",roomOwner);	
		model.addAttribute("result", result);
		model.addAttribute("memberIdx", memberIdx);
		model.addAttribute("memberNickname", newParticipant);
		model.addAttribute("participantsSize", participantsSize);

		return "chat/chatRoom";
		}
			
		
		else {
			
			return "chat/chatRoomList";
		}
		
	}
	@PostMapping("/modify.do")
	public String chatRoomModify(ChatRoom chatRoom ,Model model,HttpSession session){
		System.out.println("들어왔니????");
		
		int idx = chatRoom.getIdx();
		System.out.println("IDX:" +idx);
		
		if(chatRoom!=null) {
			
			int isModified = chatRoomService.modifyChatRoom(chatRoom);
			
			if(isModified>0) {
				
				model.addAttribute("result", chatRoom);

				sessionManage.setSessionMsg("채팅방이 성공적으로 수정되었습니다!", "success", session);
			    
		    	return "redirect:/chat/enter.do?idx="+idx;
			}
			else {
				sessionManage.setSessionMsg("채팅방 수정에 실패했습니다!", "error", session);
			    
		    	return "redirect:/chat/enter.do?idx="+idx;
				
			}
			
		} 
		else {
			sessionManage.setSessionMsg("오류가 발생했습니다!", "error", session);
		    
	    	return "chat/chatRoomList";
		}
		
	}
	
//	@GetMapping("/toGetSession.do")
//	public String toGetSession (HttpSession session, Model model) {
//		sessionManage.getSessionMsg(session, model);
//		
//		return "redirect:/";
//		
//	}
	
	
}
