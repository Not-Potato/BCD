package kr.co.bcd.board.vote.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class VoteDao {

	public int selectVoteTotalCount(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.selectVoteTotalCount", idx);
	}

}
