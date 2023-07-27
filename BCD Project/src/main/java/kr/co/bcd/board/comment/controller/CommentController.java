package kr.co.bcd.board.comment.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
