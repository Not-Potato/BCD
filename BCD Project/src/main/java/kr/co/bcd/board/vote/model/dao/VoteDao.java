package kr.co.bcd.board.vote.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.bcd.board.vote.model.dto.Vote;

@Repository
public class VoteDao {

	public int selectVoteCount(SqlSessionTemplate sqlSession, int idx) {
        Vote vote = new Vote();
        vote.setPostIdx(idx);
        vote.setSeleted(null);
		return sqlSession.selectOne("boardMapper.selectVoteCount", vote);
	}

	public int selectVoteCount(SqlSessionTemplate sqlSession, int idx, String AorB) {
        Vote vote = new Vote();
        vote.setPostIdx(idx);
        vote.setSeleted(AorB);
		return sqlSession.selectOne("boardMapper.selectVoteCount", vote);
	}
	
	public int selectVoteCountOne(SqlSessionTemplate sqlSession, Vote vote) {
		return sqlSession.selectOne("boardMapper.selectVoteCountOne", vote);
	}
	
	public Vote selectVoterStatus(SqlSessionTemplate sqlSession, Vote vote) {
		return sqlSession.selectOne("boardMapper.selectVoterStatus", vote);
	}

	public int insertVote(SqlSessionTemplate sqlSession, Vote vote) {
		return sqlSession.insert("boardMapper.insertVote", vote);
	}

	public int deleteVote(SqlSessionTemplate sqlSession, Vote vote) {
		return sqlSession.delete("boardMapper.deleteVote", vote);
	}
}
