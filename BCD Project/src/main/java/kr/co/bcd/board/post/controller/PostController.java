package kr.co.bcd.board.post.controller;


import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.StringJoiner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import kr.co.bcd.board.comment.model.service.CommentServiceImpl;
import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.board.post.model.service.PostServiceImpl;
import kr.co.bcd.board.vote.model.dto.Vote;
import kr.co.bcd.board.vote.model.service.VoteServiceImpl;
import kr.co.bcd.common.aws.S3UploadController;
import kr.co.bcd.common.controller.DataValidationController;
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
	
	@Autowired
	private DataValidationController dataValidation;
	
	@Autowired
	private S3UploadController uploadFile;
	
	@GetMapping("/write.do")
	public String write(Model model, HttpSession session, HttpServletRequest request) {
		sessionManage.getSessionMsg(session, model);
		model.addAttribute("referer", (String)request.getHeader("REFERER"));
		return "/board/write";
	}
	
	@PostMapping("/insert.do")
	public String writing(MultipartFile file1, MultipartFile file2, Post post, HttpSession session) throws IllegalStateException, IOException  {
//		세션에서 작성자 회원 고유번호 가져오기
		post.setMemIdx((int)session.getAttribute("memberIdx"));
		// TODO: test code
		post.setMemIdx(2);
		
		System.out.println(post);
		
		// 대분류, 소분류, 투표 제목, 마감일, 선택지1, 선택지 2, 제목, 내용 => null ck & 글자수 제한 ck
		boolean mainCategoryNullCk = dataValidation.nullCheck(post.getMainCategory());
		boolean subCategoryNullCk = dataValidation.nullCheck(post.getSubCategory());
		boolean voteTitleNullCk = dataValidation.nullCheck(post.getVoteTitle());
		boolean deadlineNullCk = dataValidation.nullCheck(post.getDeadline());
		boolean vote1STNullCk = dataValidation.nullCheck(post.getVote1ST());
		boolean vote2NDNullCk = dataValidation.nullCheck(post.getVote2ND());
		boolean titleNullCk = dataValidation.nullCheck(post.getTitle());
		boolean contentNullCk = dataValidation.nullCheck(post.getContent());
		
		List<String> nullCkErrors = new ArrayList<>();
		
		if (!mainCategoryNullCk) nullCkErrors.add("대분류");
		if (!subCategoryNullCk) nullCkErrors.add("소분류");
		if (!voteTitleNullCk) nullCkErrors.add("투표 제목");
		if (!deadlineNullCk) nullCkErrors.add("마감일");
		if (!vote1STNullCk) nullCkErrors.add("선택지 1 항목");
		if (!vote2NDNullCk) nullCkErrors.add("선택지 2 항목");
		if (!titleNullCk) nullCkErrors.add("제목");
		if (!contentNullCk) nullCkErrors.add("내용");
		
		if (nullCkErrors.size() > 0) {
			StringJoiner joiner = new StringJoiner(", ");
			for (String s : nullCkErrors) {
				joiner.add(s);
			}
			String nullErrList = "[" + joiner.toString() + "]";
			sessionManage.setSessionMsg(nullErrList + "이 입력되지 않았습니다.", "error", session);
			return "redirect:/board/write.do";
		}
		
		boolean mainCategoryLength = dataValidation.LanguageCheck(post.getMainCategory(), 300);
		boolean subCategoryLength = dataValidation.LanguageCheck(post.getSubCategory(), 300);
		boolean voteTitleLength = dataValidation.LanguageCheck(post.getVoteTitle(), 300);
		boolean deadlineLength = dataValidation.LanguageCheck(post.getDeadline(), 300);
		boolean vote1STLength = dataValidation.LanguageCheck(post.getVote1ST(), 90);
		boolean vote2NDLength = dataValidation.LanguageCheck(post.getVote2ND(), 90);
		boolean titleLength = dataValidation.LanguageCheck(post.getTitle(), 300);
		boolean contentLength = dataValidation.LanguageCheck(post.getContent(), 9000);
		
		List<String> validationErrors = new ArrayList<>();
		
		if (!mainCategoryLength) validationErrors.add("대분류");
		if (!subCategoryLength) validationErrors.add("소분류");
		if (!voteTitleLength) validationErrors.add("투표 제목");
		if (!deadlineLength) validationErrors.add("마감일");
		if (!vote1STLength) validationErrors.add("선택지 1 항목");
		if (!vote2NDLength) validationErrors.add("선택지 2 항목");
		if (!titleLength) validationErrors.add("제목");
		if (!contentLength) validationErrors.add("내용");
		
		if (validationErrors.size() > 0) {
			StringJoiner joiner = new StringJoiner(", ");
			for (String s : validationErrors) {
				joiner.add(s);
			}
			String lenErrList = "[" + joiner.toString() + "]";
			sessionManage.setSessionMsg(lenErrList + "이 입력 가능한 범위를 초과합니다.", "error", session);
			return "redirect:/board/write.do";
		}
		
		// 데드라인(투표 마감일) 데이터 정제
		post.setDeadline(LocalDateTime.parse(post.getDeadline(), DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
		
		// img upload
		if(!file1.isEmpty() || !file2.isEmpty()) {			
			try {
				post = uploadFile.uploadPostFile(file1, file2, post);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("이미지 업로드 후: " + post);
		
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
		
		if (!myPost) {
			sessionManage.setSessionMsg("본인이 게시한 투표만 상태를 변경할 수 있습니다!", "error", session);
			return "redirect:/board/detail.do?idx=" + postIdx;
		} else {			
			// DB POST 테이블에서 delete_date 칼럼에 데이터 없는 글인지 확인
			int isNotDelPost = postService.isNotDelPost(postIdx);
			
			// 존재하는(삭제되지 않은 상태의) 글이라면
			if (isNotDelPost == 1) {
				// 진행 상태(투표 진행 상태) 가져오기
				String status = postService.selectStatus(postIdx).getStatus();
				// 진행중인 투표라면
				if (status.equals("A")) {
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
			} else {
				
			}
		}
		
		return "redirect:/board/detail.do?idx=" + postIdx;
	}

	@PostMapping("/review.do")
	public String updateReview(Post post, HttpSession session,
							   @RequestParam(value="reviewMode") String reviewMode) {
		// 작성 OR 수정 체크 (alert 창 띄울 때 사용)
		String mode = reviewMode.equals("write") ? "작성" : reviewMode.equals("edit") ? "수정" : "삭제";
		
		// 작성자 현재 접속자 일치하는지 ck
		int postWriterIdx = postService.selectWriterIdx(post.getIdx());

		// DB POST 테이블에서 delete_date 칼럼에 데이터 없는 글인지 확인
		int isNotDelPost = postService.isNotDelPost(post.getIdx());
		
		// 존재하는(삭제되지 않은 상태의) 글이라면
		if (isNotDelPost == 1) {
			// 진행 상태(투표 진행 상태) 가져오기
			String status = postService.selectStatus(post.getIdx()).getStatus();
			if (!status.equals("A") && postWriterIdx == (int)session.getAttribute("memberIdx")) {
				if (mode.equals("삭제")) {
					post.setReview("");
				} else {				
					// TODO: 데이터 규격 검사
					boolean isContentNull = dataValidation.nullCheck(post.getReview());
					boolean isContentLength = dataValidation.LanguageCheck(post.getReview(), 900);
					
					if (!isContentNull) {
						sessionManage.setSessionMsg("내용이 입력되지 않았습니다!", "error", session);
						return "redirect:/board/detail.do?idx=" + post.getIdx();
					}

					if (!isContentLength) {
						sessionManage.setSessionMsg("내용이 입력되지 않았습니다!", "error", session);
						return "redirect:/board/detail.do?idx=" + post.getIdx();
					}
				}
				
				// 작성, 수정, 삭제 => DB UPDATE 실행
				int result = postService.updateReview(post);
				
				if (result > 0) {
					sessionManage.setSessionMsg("리뷰 " + mode + "이(가) 완료되었습니다!", "success", session);
				} else {
					sessionManage.setSessionMsg("리뷰 " + mode + " 중 오류가 발생했습니다.", "error", session);				
				}				
			} else {
				sessionManage.setSessionMsg("리뷰 " + mode + "이(가) 불가능한 글입니다!", "error", session);
			}
		} else {
			sessionManage.setSessionMsg("존재하지 않는 글입니다!", "error", session);			
			return "redirect:/";
		}
		return "redirect:/board/detail.do?idx=" + post.getIdx();
	}
	
	@GetMapping("/goEdit.do")
	public String goEdit(@RequestParam(value = "idx") int idx, HttpSession session, Model model) {
		// 작성자 = 현재 접속자 ? "접속" : "돌려보내"
		int postWriterIdx = postService.selectWriterIdx(idx);

		if (postWriterIdx == (int)session.getAttribute("memberIdx")) {
			// DB 조회
			Post post = postService.detailBoard(idx);
			
			// DB 조회 성공 시
			if (!Objects.isNull(post)) {
				// 작성일 포매팅
				post.setCreateDate(post.getCreateDate().substring(0, 19));
				
				// 투표 참여자 수
				post.setVoteCount( voteService.selectVoteCount(idx) );
				
				// 한 명 이상 투표한 경우 백분율로 변환 + 현재 접속자가 투표에 참여했는지 여부 확인하기
				if (post.getVoteCount() > 0) {			
					double totalCount = (double)post.getVoteCount();
					double a = (voteService.selectVoteCount(idx, "A") / totalCount);
					double b = (voteService.selectVoteCount(idx, "B") / totalCount);
					post.setProbA((int) Math.round(a * 100));								
					post.setProbB((int) Math.round(b * 100));
					
					// 세션에 저장된 회원 번호가 존재한다면 (비회원 상태가 아니라면)
					if (session.getAttribute("memberIdx") != null) {
						Vote vote = new Vote();
						vote.setMemIdx((int)session.getAttribute("memberIdx"));
						vote.setPostIdx(post.getIdx());
						// 투표에 참여한 회원이라면
						if (voteService.selectVoteCountOne(vote) > 0) {
							model.addAttribute("vote", voteService.selectVoterStatus(vote));
						}
					}
					// 참여자가 없는 경우 50 대 50으로 표시
				} else {
					post.setProbA(0);
					post.setProbB(0);
				}
				model.addAttribute("post", post);
				return "/board/write";
			} else {
				return "/common/errorPage";
			}
		} else {
			sessionManage.setSessionMsg("잘못된 접근입니다.", "error", session);
			return "redirect:/board/detail.do?idx=" + idx;
		}
	}
	
	@PostMapping("update.do")
	public String update(Post post, HttpSession session) {
		// 작성자 = 현재 접속자 ck
		int postWriterIdx = postService.selectWriterIdx(post.getIdx());
		// delete date 없는 글 맞는지 ck
		int isNotDelPost = postService.isNotDelPost(post.getIdx());
		// 위 두 조건 만족 시 DB UPDATE 진행 (title, content 두 가지 only)
		if (postWriterIdx == (int)session.getAttribute("memberIdx") && isNotDelPost == 1) {
			// TODO: 제목, 내용 => null ck & 글자수 제한 ck
			int result = postService.updatePost(post);
			if (result > 0) {				
				sessionManage.setSessionMsg("게시글 수정이 완료되었습니다!", "success", session);				
			} else {
				sessionManage.setSessionMsg("게시글 수정에 실패했습니다.", "error", session);				
			}
		} else {			
			sessionManage.setSessionMsg("수정할 수 있는 글이 아닙니다.", "error", session);				
		}
		
		return "redirect:/board/detail.do?idx=" + post.getIdx();
	}
	
	@GetMapping("/delete.do")
	public String delete(@RequestParam(value = "idx") int idx, HttpSession session) {
		// 작성자 = 현재 접속자 ck
		int postWriterIdx = postService.selectWriterIdx(idx);
		// delete date 없는 글 맞는지 ck
		int isNotDelPost = postService.isNotDelPost(idx);
		// 위 두 조건 만족 시 DB UPDATE 진행 (title, content 두 가지 only)
		if (postWriterIdx == (int)session.getAttribute("memberIdx") && isNotDelPost == 1) {
			int result = postService.markPostAsDeleted(idx);
			if (result > 0) {				
				sessionManage.setSessionMsg("게시글 삭제가 완료되었습니다!", "success", session);				
			} else {
				sessionManage.setSessionMsg("게시글 삭제에 실패했습니다.", "error", session);				
			}
		} else {			
			sessionManage.setSessionMsg("삭제할 수 있는 글이 아닙니다.", "error", session);				
		}
		
		return "redirect:/";
	}
	
}