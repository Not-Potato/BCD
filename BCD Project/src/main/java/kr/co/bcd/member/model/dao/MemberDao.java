package kr.co.bcd.member.model.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import kr.co.bcd.member.model.dto.Member;


@Repository
public class MemberDao {

	public int register(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.register", member);
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

	public int checkPhone(SqlSessionTemplate sqlSession, String phone) {
		return sqlSession.selectOne("memberMapper.checkPhone", phone);
	}

	public int checkIdx(SqlSessionTemplate sqlSession, String phone) {
		return sqlSession.selectOne("memberMapper.checkIdx", phone);
	}

}
