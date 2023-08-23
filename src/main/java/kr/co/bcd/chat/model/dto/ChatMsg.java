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
public class ChatMsg {
	private int idx;					// 메시지 고유 번호
	private int roomIdx;				// 채팅방 고유 번호
	private int senderIdx;				// 발신자 고유 번호
	private String content;				// 메시지 내용
	private String sendDate;			// 메시지 발신 시각
	
	//-----------DB에 없는 필드-------------------
	private String senderNickname;
	private String memberProfile;
}
