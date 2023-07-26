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
		} else {
			sessionManage.setSessionMsg("작성에 실패하였습니다", "error", session);
		}
		return "redirect:/board/list.do"; 		
	}
	
	@PostMapping("/earlyClosed.do")
	public String earlyClosed(@RequestParam(value = "writerIdx") int writerIdx,
							  @RequestParam(value = "postIdx") int postIdx, HttpSession session) {
		
		// TODO: 페이지에서 받아온 writerIdx와 session에서 받아온 현재 접속자 idx가 동일한지 확인하기
//		boolean myPost = writerIdx == (int)session.getAttribute("memberIdx") ? true : false;
		boolean myPost = true;
		
		// DB POST 테이블에서 delete date 없는 글인지, 현재 상태 A(진행 중) 맞는지 확인
		int postStatus = postService.selectPostStatus(postIdx);
		
		// 위 두 조건에 만족하면 DB UPDATE 진행 (STATUS 칼럼 C로 변경)
		if (myPost == true && postStatus == 1) {
			Post post = new Post();
			post.setIdx(postIdx);
			post.setStatus("C");
			int result = postService.updateStatus(post);	
			if (result > 0) {
				sessionManage.setSessionMsg("즉시 마감 처리가 완료되었습니다!", "success", session);
			} else {
				sessionManage.setSessionMsg("즉시 마감 처리에 실패했습니다!", "error", session);				
			}
		} else {
			sessionManage.setSessionMsg("즉시 마감 처리가 불가능한 투표입니다!", "error", session);							
		}		
		return "redirect:/board/detail.do?idx=" + postIdx;
	}
	
	@GetMapping("/goEdit.do")
	public String goEdit(@RequestParam(value = "idx") int idx, HttpSession session) {
		// TODO: 작성자 = 현재 접속자 ck
		// TODO: delete date 없는 글 맞는지 ck
		// TODO: 위 두 조건 만족 시 edit page 접속
		return "";
	}
	
	@GetMapping("/delete.do")
	public String delete(@RequestParam(value = "idx") int idx, HttpSession session) {
		// TODO: 작성자 = 현재 접속자 ck
		// TODO: delete date 없는 글 맞는지 ck
		// TODO: 위 두 조건 만족 시 DB UPDATE 진행 (P_DELETE_DATE 칼럼에 SYSDATE 추가)
		return "";
	}
}