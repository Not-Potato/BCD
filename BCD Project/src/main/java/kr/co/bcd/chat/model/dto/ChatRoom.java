package kr.co.bcd.chat.model.dto;

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
public class ChatRoom {
	private int idx;							// 고유 번호
	private String participants;				// 참여자 목록 TODO: DATA TYPE CHK
	private String category;					// 카테고리
	private String title;						// 제목
	private String createDate;					// 개설일
	private String entDate;						// 종료일
}
