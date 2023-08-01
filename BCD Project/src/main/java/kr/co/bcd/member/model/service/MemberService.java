package kr.co.bcd.member.model.service;
import kr.co.bcd.member.model.dto.Member;

public interface MemberService {
	//회원정보 가져오기
	Member selectMember(int memberIdx);
	
	//회원 idx로 회원 닉네임 가져오기
	String selectNickname(int memberIdx);
	
	//신규회원등록 sns
	int memberJoin(Member member);
	
	//신규회원등록 phone
	int memberPhoneJoin(Member member);
	
	//회원정보수정
	void updateProfile(Member member);
	
	//닉네임 중복확인 (ajax)
	int nicknameCheck(String nickname);

	//소셜로그인회원 가입여부 확인용 
	int checkEmail(Member member);
	
	//소셜로그인회원 가입 시 인덱스 번호 가져오기
	int checkIdx(String email);

	//소셜로그인회원 회원가입 (이메일)
	int checkId(String snsId);

	//휴대폰인증회원 회원가입 
	int idCheck(String id);

	


}
