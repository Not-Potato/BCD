package kr.co.bcd.board.comment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.bcd.board.comment.model.dto.Comment;
import kr.co.bcd.board.comment.model.service.CommentServiceImpl;
import kr.co.bcd.common.controller.SessionManageController;

@Controller
@RequestMapping("/comment")
public class CommentController {
	@Autowired
	CommentServiceImpl commentService;
	
	@Autowired
	SessionManageController sessionManage;
	
	@PostMapping("/insert.do")
	public String insert(Comment comment, HttpSession session) {
		// TODO: 로그인된 상태인지 확인
		if (session.getAttribute("memberIdx") == null) {
			sessionManage.setSessionMsg("로그인 후 이용해 주시기 바랍니다!", "error", session);
		} else {
			// DB INSERT
			comment.setMemIdx((int)session.getAttribute("memberIdx"));
			int result = commentService.insert(comment);
			if (result > 0) {
				sessionManage.setSessionMsg("성공적으로 작성되었습니다!", "success", session);			
			} else {
				sessionManage.setSessionMsg("작성에 실패하였습니다.", "error", session);								
			}
		}
		return "redirect:/board/detail.do?idx=" + comment.getPostIdx();
	}
	
	@PostMapping("/edit.do")
	@ResponseBody
	public ResponseEntity<String> editComment(@RequestBody Comment comment) {
		// TODO: 현재 접속자 == 댓글 작성자 ck
		// TODO: 수정 가능한 comment인지 (delect_date 존재하지 않는지) ck 
		// TODO: DB UPDATE 진행 (content update)
		
		// 제대로 된 comment(댓글 객체) 넘어오는 것 확인 완료!
		System.out.println(comment);
		return ResponseEntity.ok("성공");
	}
	
	@PostMapping("/delete.do")
	@ResponseBody
	public ResponseEntity<String> deleteComment(Integer idx) {
		// TODO: 현재 접속자 == 댓글 작성자 ck
		// TODO: 수정 가능한 comment인지 (delete_date 존재하지 않는지) ck
		// TODO: DB UPDATE 진행 (delete_date update)
		
		// 제대로 된 idx(댓글 고유 번호) 넘어오는 것 확인 완료!
		System.out.println(idx); 
		return ResponseEntity.ok("성공");
	}
}
