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
	public ResponseEntity<String> editComment(@RequestBody Comment comment, HttpSession session) {
		// TODO: 현재 접속자 == 댓글 작성자 ck
		int userIdx = (int)session.getAttribute("memberIdx");
		int commentAuthorIdx = commentService.getCommentAuthor(comment.getIdx());
		
		// TODO: 수정 가능한 comment인지 (delect_date 존재하지 않는지) ck 
		int isValid = commentService.isCommentValid(comment.getIdx());
		
		// TODO: DB UPDATE 진행 (content update)
		if(userIdx == commentAuthorIdx && isValid == 1) {
			int result = commentService.updateComment(comment);
			
			if(result > 0) {
				return ResponseEntity.ok("success");
			} else {
				return ResponseEntity.ok("error"); // 실패일 때도 ok로 넘기는 게 맞나?
			}
		} else {			
			return ResponseEntity.ok("error"); // 실패일 때도 ok로 넘기는 게 맞나?22
		}
	}
	
	@PostMapping("/delete.do")
	@ResponseBody
	public ResponseEntity<String> deleteComment(Integer idx, HttpSession session) {
		// TODO: 현재 접속자 == 댓글 작성자 ck
		int userIdx = (int)session.getAttribute("memberIdx");
		int commentAuthorIdx = commentService.getCommentAuthor(idx);
		
		// TODO: 수정 가능한 comment인지 (delect_date 존재하지 않는지) ck 
		int isValid = commentService.isCommentValid(idx);
		
		// TODO: DB UPDATE 진행 (content update)
		if(userIdx == commentAuthorIdx && isValid == 1) {
			int result = commentService.markCommentAsDeleted(idx);
			
			if(result > 0) {
				return ResponseEntity.ok("success");
			} else {
				return ResponseEntity.ok("error"); // 실패일 때도 ok로 넘기는 게 맞나?
			}
		} else {			
			return ResponseEntity.ok("error"); // 실패일 때도 ok로 넘기는 게 맞나?22
		}
	}
}
