package kr.co.bcd.board.vote.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.bcd.board.post.model.service.PostServiceImpl;
import kr.co.bcd.board.vote.model.dto.Vote;
import kr.co.bcd.board.vote.model.service.VoteServiceImpl;
import kr.co.bcd.common.controller.SessionManageController;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/vote")
public class VoteController {
	@Autowired
	private VoteServiceImpl voteService;
	
	@Autowired
	private PostServiceImpl postService;
	
	@Autowired
	private SessionManageController sessionManage;
	
	@PostMapping("voted.do")
	public String voted(Vote vote, HttpSession session) {
		// TODO: 로그인한 유저인지 확인
//		vote.setMemIdx((int)session.getAttribute("membetIdxd"));
		
		// DB VOTE 테이블에서 중복 투표 여부 확인 (투표한 적 없는 사용자 맞는지)
		int voteStatus = voteService.selectVoteCountOne(vote);

		// DB POST 테이블에서 마감 시간 안 지난 거 맞는지 + delete date 없는 글인지 확인
		String postStatus = postService.selectPostStatus(vote.getPostIdx());

		// 해당 글에 투표한 적이 없는 회원이면서 && 유효한 투표라면 --> DB 업데이트
		if (voteStatus == 0 && postStatus == "A") {
			int result = voteService.insertVote(vote);
			if (result > 0) {
				sessionManage.setSessionMsg("투표가 완료되었습니다.", "success", session);
			} else {
				sessionManage.setSessionMsg("투표에 실패했습니다", "error", session);
			}
		// 중복 참여자 OR 삭제된 게시글 OR 종료된 투표 --> 실패
		} else {
			sessionManage.setSessionMsg("현재 참여할 수 없는 투표입니다!", "error", session);			
		}
		
		return "redirect:/board/detail.do?idx=" + vote.getPostIdx();
	}
	
	@PostMapping("cancle.do")
	public String cancle(Vote vote, HttpSession session) {
		// DB VOTE 테이블에서 투표 여부 확인 (정말 기존 투표자 맞는지)
		int voteStatus = voteService.selectVoteCountOne(vote);

		// DB POST 테이블에서 마감 시간 안 지난 거 맞는지 + delete date 없는 글인지 확인
		String postStatus = postService.selectPostStatus(vote.getPostIdx());
		
		// 해당 글에 투표한 적 있는 회원이면서 && 현재 기준 유효한 투표라면 --> DB 업데이트 (DELETE)
		if (voteStatus > 0 && postStatus == "A") {
			int result = voteService.deleteVote(vote);
			if (result > 0) {
				sessionManage.setSessionMsg("성공적으로 철회되었습니다!", "success", session);
			} else {
				sessionManage.setSessionMsg("투표 철회에 실패하였습니다.", "error", session);
			}
		} else {
			sessionManage.setSessionMsg("현재 수정할 수 없는 투표입니다!", "error", session);
		}
		
		return "redirect:/board/detail.do?idx=" + vote.getPostIdx();
	}
}
