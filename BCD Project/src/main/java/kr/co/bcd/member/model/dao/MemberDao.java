package kr.co.bcd.member.model.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import kr.co.bcd.member.model.dto.Member;


@Repository
public class MemberDao {

	public int memberJoin(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.memberJoin", member);
	}

	public Member selectMember(SqlSessionTemplate sqlSession, int memberIdx) {
	
		return sqlSession.selectOne("memberMapper.selectMember", memberIdx);
	}

	public String selectNickname(SqlSessionTemplate sqlSession, int memberIdx) {
		return sqlSession.selectOne("memberMapper.selectNickname", memberIdx);
	}

	public void updateProfile(SqlSessionTemplate sqlSession, Member member) {
		sqlSession.update("memberMapper.updateProfile", member);
	}

	public int nicknameCheck(SqlSessionTemplate sqlSession, String nickname) {
		return sqlSession.selectOne("memberMapper.nicknameCheck", nickname);
	}

	public int checkEmail(SqlSessionTemplate sqlSession, Member member) {
		System.out.println(member.getSnsId());
		System.out.println(member.getSnsType());
		return sqlSession.selectOne("memberMapper.checkEmail", member);
	}

	public int checkIdx(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.selectOne("memberMapper.checkIdx", member);
	}

	public int checkId(SqlSessionTemplate sqlSession, String snsId) {
		return sqlSession.selectOne("memberMapper.checkId", snsId);
	}

	public int idCheck(SqlSessionTemplate sqlSession, String id) {
		return sqlSession.selectOne("memberMapper.idCheck", id);
	}

	public int phoneJoin(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.phoneJoin", member);
	}

	public int phoneCheck(SqlSessionTemplate sqlSession, String phoneNumber) {
		return sqlSession.selectOne("memberMapper.phoneCheck", phoneNumber);
	}

	public int phoneLogin(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.selectOne("memberMapper.phoneLogin", member);
	}

	public void withdraw(SqlSessionTemplate sqlSession, int memberIdx) {
		 sqlSession.update("memberMapper.withdraw", memberIdx);
	}

	public String selectProfile(SqlSessionTemplate sqlSessionTemplate, int memIdx) {
		return sqlSessionTemplate.selectOne("memberMapper.selectProfile", memIdx) == null ? 
				"https://bcd-project.s3.ap-northeast-2.amazonaws.com/default_profile_img.png" : sqlSessionTemplate.selectOne("memberMapper.selectProfile", memIdx);
	}
}




