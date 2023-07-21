package kr.co.bcd.member.model.dao;

<<<<<<< HEAD
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import kr.co.bcd.member.model.dto.Member;
=======
import org.springframework.stereotype.Repository;
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git

@Repository
public class MemberDao {

	public int register(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.register", member);
	}

}
