package kr.co.bcd.board.vote.model.dto;

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
public class Vote {
	private int idx;				// 투표 고유 번호
	private int postIdx;			// 투표가 포함되어 있는 게시글의 번호
	private int memIdx;				// 투표 참여자의 회원 번호
	private String seleted;			// 투표된 항목 (A: 항목1, B: 항목2)
}