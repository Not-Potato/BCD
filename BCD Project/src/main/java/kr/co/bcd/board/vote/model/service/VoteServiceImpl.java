package kr.co.bcd.board.vote.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.bcd.board.vote.model.dao.VoteDao;
import kr.co.bcd.board.vote.model.dto.Vote;

@Service
public class VoteServiceImpl implements VoteService {
	
	@Autowired
	private VoteDao voteDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectVoteCount(int idx) {
		return voteDao.selectVoteCount(sqlSession, idx);
	}

	@Override
	public int selectVoteCount(int idx, String AorB) {
		return voteDao.selectVoteCount(sqlSession, idx, AorB);
	}
	
	@Override
	public int selectVoteCountOne(Vote vote) {
		return voteDao.selectVoteCountOne(sqlSession, vote);
	}
	
	@Override
	public Vote selectVoterStatus(Vote vote) {
		return voteDao.selectVoterStatus(sqlSession, vote);
	}
	
	@Override
	public int insertVote(Vote vote) {
		return voteDao.insertVote(sqlSession, vote);
	}
	
	@Override
	public int deleteVote(Vote vote) {
		return voteDao.deleteVote(sqlSession, vote);
	}
}
