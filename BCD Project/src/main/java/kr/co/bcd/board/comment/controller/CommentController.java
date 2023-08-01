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
import kr.co.bcd.common.controller.DataValidationController;
import kr.co.bcd.common.controller.SessionManageController;

@Controller
@RequestMapping("/comment")
public class CommentController {
	@Autowired
	CommentServiceImpl commentService;
	
	@Autowired
	SessionManageController sessionManage;
	
	@Autowired
	private DataValidationController dataValidation;
	
	@PostMapping("/insert.do")
	public String insert(Comment comment, HttpSession session) {
		// 로그인된 상태인지 확인
		if (session.getAttribute("memberIdx") == null) {
			sessionManage.setSessionMsg("로그인 후 이용해 주시기 바랍니다!", "error", session);
		} else {
			// Data null 체크 & 글자수 제한
			boolean contentLength = dataValidation.LanguageCheck(comment.getContent(), 100);
			
			// DB INSERT
			if (contentLength) {				
				comment.setMemIdx((int)session.getAttribute("memberIdx"));
				int result = commentService.insert(comment);
				if (result > 0) {
					sessionManage.setSessionMsg("성공적으로 작성되었습니다!", "success", session);			
				} else {
					sessionManage.setSessionMsg("작성에 실패하였습니다.", "error", session);								
				}
			} else {
				sessionManage.setSessionMsg("입력 가능한 범위를 초과하여 댓글 등록에 실패하였습니다.", "error", session);												
			}
		}
		return "redirect:/board/detail.do?idx=" + comment.getPostIdx();
	}
	
	@PostMapping("/edit.do")
	@ResponseBody
	public ResponseEntity<String> editComment(@RequestBody Comment comment, HttpSession session) {
		// 현재 접속자 == 댓글 작성자 ck
		int userIdx = (int)session.getAttribute("memberIdx");
		int commentAuthorIdx = commentService.getCommentAuthor(comment.getIdx());
		
		// 수정 가능한 comment인지 (delect_date 존재하지 않는지) ck 
		int isValid = commentService.isCommentValid(comment.getIdx());
		
		// DB UPDATE 진행 (content update)
		if(userIdx == commentAuthorIdx && isValid == 1) {
			boolean contentLength = dataValidation.LanguageCheck(comment.getContent(), 100);
			if (contentLength) {				
				int result = commentService.updateComment(comment);
				
				if(result > 0) {
					return ResponseEntity.ok("success");
				} else {
					return ResponseEntity.ok("error"); // 실패일 때도 ok로 넘기는 게 맞나?
				}
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
		// 현재 접속자 == 댓글 작성자 ck
		int userIdx = (int)session.getAttribute("memberIdx");
		int commentAuthorIdx = commentService.getCommentAuthor(idx);
		
		// 수정 가능한 comment인지 (delect_date 존재하지 않는지) ck 
		int isValid = commentService.isCommentValid(idx);
		
		// DB UPDATE 진행 (content update)
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
