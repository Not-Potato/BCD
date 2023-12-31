package kr.co.bcd.member.model.dto;

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
public class Member {
	//  ------------------------ 모든 회원 공통 사항 ----------------------------
	private int idx;						// 회원 고유 번호
	private String phone;					// 회원 전화번호
	private String nickname;				// 회원 닉네임
	private String joinDate;				// 가입일
	private String deleteDate;				// 탈퇴일
	
	// 프로필 사진 관련 사항
//	private String profile;				// 프로필 사진 변경된 파일명
	private String profilePath;			// 프로필 사진 저장 경로
//	private String profileOrigin;		// 프로필 사진 원본 파일명
	
	//  ------------------------ 일반 회원 입력 사항 ----------------------------
	private String id;						// 일반 회원 ID
	private String pwd;						// 일반 회원 pw
	
	//  ------------------------- SNS 회원 입력 사항 -----------------------------
	private String snsId;					// sns 회원 id
	private String snsType;					// sns 회원 type
	
	
	// pwd 확인용
	private String pwdChk;
	
	// -------------------------- profile img URL --------------------------------
	//private String profileURL;				// AWS 업로드 URL (DB 저장)
	
	//private String profileOrigin;			// 프로필 사진 원본 파일명 (DB 저장 X)

	// TODO: 
	// 1. profile 관련 기존 컬럼 삭제
	// 2. profile 관련 새로운 컬럼 추가 (DB => profileURL)
	// 3. member-mapper 수정 (map 수정)
	// 4. 저장 시점에서 uploadFile.uploadPostFile(file, member);
	//    => 참고 패키지: common/aws/*
}
