package kr.co.bcd.member.model.service;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.bcd.member.model.dao.MemberDao;
import kr.co.bcd.member.model.dto.Member;


@Service
public class MemberServiceImpl implements MemberService {


	@Autowired 
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;

	
	//public Member detailMember(int idx) {
		//return memberDao.detailMember(sqlSession, idx);
		//return null;
	//}
	
	@Override
	public int memberJoin (Member member) {
		return memberDao.memberJoin(sqlSession, member);
	}

	@Override 
	public int memberPhoneJoin(Member member) {
		return memberDao.memberPhoneJoin(sqlSession, member);	
	}
	
	@Override
	public Member selectMember(int memberIdx) {
		return memberDao.selectMember(sqlSession, memberIdx);
		
	}
	
	@Override
	public String selectNickname(int memberIdx) {
		return memberDao.selectNickname(sqlSession, memberIdx);
		
	}
	
	@Override
	public void updateProfile(Member member) {
		memberDao.updateProfile(sqlSession, member);
		
	}
	
	@Override
	public int nicknameCheck(String nickname) {
		return memberDao.nicknameCheck(sqlSession, nickname);
	}
	
	@Override
	public int checkEmail(Member member) {
		return memberDao.checkEmail(sqlSession, member);
	}

	@Override
	public int checkIdx(String email) {
		return memberDao.checkIdx(sqlSession, email);
	}

	@Override 
	public int checkId(String snsId) {	
		return memberDao.checkId(sqlSession, snsId);
	}

	@Override 
	public int idCheck(String id) {
		return memberDao.idCheck(sqlSession, id);
	}
	
	


	
}
