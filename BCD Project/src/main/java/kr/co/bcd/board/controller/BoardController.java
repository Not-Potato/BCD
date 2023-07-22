package kr.co.bcd.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.bcd.board.comment.model.service.CommentServiceImpl;
import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.board.post.model.service.PostServiceImpl;
import kr.co.bcd.board.vote.model.service.VoteServiceImpl;
import kr.co.bcd.common.paging.model.PageInfo;
import kr.co.bcd.common.paging.template.Pagination;
import kr.co.bcd.member.model.dto.Member;
import kr.co.bcd.member.model.service.MemberServiceImpl;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private PostServiceImpl postService;
	
	@Autowired
	private CommentServiceImpl commentService;
	
	@Autowired
	private VoteServiceImpl voteService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	@GetMapping("/list.do")
	public String boardList(@RequestParam(value="category", defaultValue="") String category, 
							@RequestParam(value = "keyword", defaultValue = "") String keyword,
							@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
							HttpSession session, 
							Model model){
							
		// 전체 게시글 수 구하기
		int listCount = postService.selectListCount(category, keyword);
		int pageLimit = 10;		// 보여질 페이지 수
//		int boardLimit = 15;	// 한 페이지에 들어갈 게시글 수
// TODO: TEST CODE
		int boardLimit = 30;	// test 중이라 개수 늘림
		
		// 글 번호 뒤에서부터 출력해 주는 변수
		// 1p --> row = 전체 게시글 수
		// 2p --> row = 전체 게시글 수 - boardLimit
		// 3p --> row = 전체 게시글 수 - boardLimit * 2
		int row = listCount - (currentPage - 1) * boardLimit;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		// 페이징 처리 끝
		
		
		// 목록 불러오기
		List<Post> list = postService.selectListAll(pi, category, keyword);
		
		Member m = new Member();

		// 1. 작성일 날짜까지만 가져오도록 문자열 자르기
		// 2. 댓글 수 가져오기
		// 3. 투표 참여자 수 가져오기
		// 4. 작성자 닉네임 가져오기
		for (Post p : list) {
			p.setCreateDate(p.getCreateDate().substring(0, 10));
			p.setDeadline(p.getDeadline().substring(0, 10));
			p.setCommentCount( commentService.selectCommentCount(p.getIdx()) );
			p.setVoteCount( voteService.selectVoteTotalCount(p.getIdx()) );
//			m = memberService.getMember(p.getMemIdx());
//			p.setWriter(m.getNickname);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("row", row);
		model.addAttribute("pi", pi);
		
		// 댓글 수 불러오기
		
		// 투표자 수 불러오기
		
		// 작성자 닉네임 불러오기
		
		return "home";
	}
}
