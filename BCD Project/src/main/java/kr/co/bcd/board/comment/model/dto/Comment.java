package kr.co.bcd.board.comment.model.dto;

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
public class Comment {
	private int idx;				// 댓글 고유 번호
	private int postIdx;			// 댓글이 포함된 게시글 번호
	private int memIdx;				// 댓글 작성자의 회원 번호
	private String content;			// 댓글 내용
	private String createDate;		// 댓글 작성일
	private String deleteDate;		// 댓글 삭제일
	
	// -------- 추가 사항 ------------
	private String nickname;		// 작성자 닉네임
}
