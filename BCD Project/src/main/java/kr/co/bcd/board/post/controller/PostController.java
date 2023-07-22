package kr.co.bcd.board.post.controller;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.bcd.board.comment.model.service.CommentServiceImpl;
import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.board.post.model.service.PostServiceImpl;
import kr.co.bcd.board.vote.model.service.VoteServiceImpl;
import kr.co.bcd.common.controller.SessionManageController;
import kr.co.bcd.common.paging.model.PageInfo;
import kr.co.bcd.common.paging.template.Pagination;
import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;

@Controller
@RequestMapping("/post")
public class PostController {
	@Autowired
	private PostServiceImpl postService;
	
	@Autowired
	private CommentServiceImpl commentService;
	
	@Autowired
	private VoteServiceImpl voteService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@Autowired
	private SessionManageController sessionManage;
	
	@GetMapping("/write.do")
	public String write(Model model, HttpSession session, HttpServletRequest request) {
		sessionManage.getSessionMsg(session, model);
		model.addAttribute("referer", (String)request.getHeader("REFERER"));
		return "/board/write";
	}
	
	@PostMapping("/insert.do")
	public String writing(Post post, HttpSession session) {
//		세션에서 작성자 회원 고유번호 가져오기
//		post.setMemIdx((int)session.getAttribute("memberIdx"));
		// TODO: test code
		post.setMemIdx(1);
		
		System.out.println(post);
		
		// 데드라인(투표 마감일) 데이터 정제
		post.setDeadline(LocalDateTime.parse(post.getDeadline(), DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
//        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
//        LocalDateTime before = LocalDateTime.parse(post.getDeadline(), DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
//        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
        
        System.out.println(post.getDeadline());
		
		
		// DB insert
		int result = postService.insertPost(post);
		
		if (result > 0) {
			sessionManage.setSessionMsg("성공적으로 작성되었습니다.", "success", session);
			return "redirect:/board/list.do";
		} else {
			sessionManage.setSessionMsg("작성에 실패하였습니다", "error", session);
			return "redirect:/board/list.do"; 		
		}
	}
}
