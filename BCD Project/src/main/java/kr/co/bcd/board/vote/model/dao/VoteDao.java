package kr.co.bcd.board.vote.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class VoteDao {

	public int selectVoteCount(SqlSessionTemplate sqlSession, int idx) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("idx", idx);
        paramMap.put("choice", null);
		return sqlSession.selectOne("boardMapper.selectVoteCount", paramMap);
	}

	public int selectVoteCount(SqlSessionTemplate sqlSession, int idx, String AorB) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("idx", idx);
        paramMap.put("choice", AorB);
		return sqlSession.selectOne("boardMapper.selectVoteCount", paramMap);
	}

}
