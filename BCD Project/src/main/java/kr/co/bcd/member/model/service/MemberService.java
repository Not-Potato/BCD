package kr.co.bcd.member.model.service;
import kr.co.bcd.member.model.dto.Member;

public interface MemberService {
	//회원정보 가져오기
	Member selectMember(int memberIdx);
	
	//회원 idx로 회원 닉네임 가져오기
	String selectNickname(int memberIdx);
	
	//신규회원등록
	int register(Member member);

	//회원정보수정
	void updateProfile(Member member);
	
	//닉네임 중복확인 (ajax)
	int nicknameCheck(String nickname);

	//소셜로그인회원 가입여부 확인용 
	int checkPhone(String phone);

	

}
