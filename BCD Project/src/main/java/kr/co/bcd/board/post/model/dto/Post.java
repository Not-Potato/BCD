package kr.co.bcd.board.post.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Post {
	// ------------------ 게시글 공통 사항 ------------------ 
	private int idx;					// 게시글 고유 번호
	private int memIdx;					// 작성자 회원 번호

	// ------------------ 투표 관련 사항 ------------------ 
	private String status;				// 투표 진행 현황 (A:진행중, B:마감)
	private String mainCategory; 		// 메인 카테고리
	private String subCategory;			// 서브 카테고리
	private String voteTitle;			// 투표 제목
	private String deadline;			// 투표 마감일
	private String vote1ST;				// 투표 항목1
	private String vote2ND;				// 투표 항목2
	// 각 항목 img upload 관련
	private String uploadPath;			// 이미지 파일 저장 경로
	private String upload1st;			// 이미지1 업로드 변경된 파일명
	private String upload2nd;			// 이미지2 업로드 변경된 파일명
	private String upload1stOrigin;		// 이미지1 원본 파일명
	private String upload2ndOrigin;		// 이미지2 원본 파일명
	
	// ------------------ 본문 관련 사항 ------------------ 
	private String title;				// 본문 제목
	private String content;				// 본문 내용
	private String review;				// 후기
	private int views;					// 조회수
	private String createDate;			// 작성일
	private String deleteDate;			// 삭제일
	
	
}
