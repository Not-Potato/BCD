package kr.co.bcd.member.model.dao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import kr.co.bcd.member.model.dto.Member;


@Repository
public class MemberDao {

	public int register(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.register", member);
	}

}
