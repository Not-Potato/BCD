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
		vote.setMemIdx((int)session.getAttribute("memberIdx"));

		System.out.println(vote);
		
		// 선택된 항목 존재하는지 ck
		if (vote.getSeleted() != null) {	
			// DB POST 테이블에서 delete_date 칼럼에 데이터 없는 글인지 확인
			int isNotDelPost = postService.isNotDelPost(vote.getPostIdx());
			System.out.println(isNotDelPost);
			
			// 존재하는(삭제되지 않은 상태의) 글이라면
			if (isNotDelPost == 1) {
				// 진행 상태(투표 진행 상태) 가져오기
				String status = postService.selectStatus(vote.getPostIdx()).getStatus();
				System.out.println(status);
				
				// 진행중인 투표라면
				if (status.equals("A")) {
					// DB VOTE 테이블에서 중복 투표 여부 확인 (투표한 적 없는 사용자 맞는지)
					int voteStatus = voteService.selectVoteCountOne(vote);
					
					// 유효한 투표이면서 && 해당 글에 투표한 적이 없는 회원이라면 --> DB 업데이트
					if (voteStatus == 0) {
						int result = voteService.insertVote(vote);
						
						if (result > 0) {
							sessionManage.setSessionMsg("투표가 완료되었습니다.", "success", session);
						} else {
							sessionManage.setSessionMsg("투표에 실패했습니다", "error", session);
						}					
					}
					// 종료된 투표라면
				} else {
					sessionManage.setSessionMsg("현재 참여할 수 없는 투표입니다!", "error", session);
				}
				// 존재하지 않는(삭제된 상태의) 글이라면
			} else {
				sessionManage.setSessionMsg("게시글을 찾을 수 없습니다!", "error", session);
				return "redirect:/";
			}
		// 항목이 선택되지 않았다면
		} else {
			sessionManage.setSessionMsg("선택된 항목이 존재하지 않습니다!", "error", session);
		}
		return "redirect:/board/detail.do?idx=" + vote.getPostIdx();
	}
	
	@PostMapping("cancle.do")
	public String cancle(Vote vote, HttpSession session) {

		// DB POST 테이블에서 delete_date 칼럼에 데이터 없는 글인지 확인
		int isNotDelPost = postService.isNotDelPost(vote.getPostIdx());

		// 존재하는(삭제되지 않은 상태의) 글이라면
		if (isNotDelPost == 1) {
			// 진행 상태(투표 진행 상태) 가져오기
			String status = postService.selectStatus(vote.getPostIdx()).getStatus();
			// 진행중인 투표라면
			if (status.equals("A")) {
				// DB VOTE 테이블에서 투표 여부 확인
				int voteStatus = voteService.selectVoteCountOne(vote);
				
				// 유효한 투표이면서 && 해당 글에 투표한 적이 있는 회원이라면 --> DB 업데이트
				if (voteStatus > 0) {
					int result = voteService.deleteVote(vote);
					
					if (result > 0) {
						sessionManage.setSessionMsg("성공적으로 철회되었습니다!", "success", session);
					} else {
						sessionManage.setSessionMsg("투표 철회에 실패하였습니다.", "error", session);
					}					
				} else {
					sessionManage.setSessionMsg("참여 기록이 확인되지 않습니다!", "error", session);
				}
			} else {
				sessionManage.setSessionMsg("현재 상태를 변경할 수 없는 투표입니다!", "error", session);
			}
		}
		
		return "redirect:/board/detail.do?idx=" + vote.getPostIdx();
	}
}
