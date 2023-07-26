package kr.co.bcd.board.vote.model.service;

import kr.co.bcd.board.vote.model.dto.Vote;

public interface VoteService {
	// 총 투표자 수 구하기
	int selectVoteCount(int idx);
	
	// 각 항목 투표자 수 구하기
	int selectVoteCount(int idx, String AorB);
	
	// 투표 여부 확인하기
	int selectVoteCountOne(Vote vote);
	
	// 투표 여부 확인하기
	Vote selectVoterStatus(Vote vote);
	
	// 투표하기
	int insertVote(Vote vote);
	
	// 투표 철회하기
	int deleteVote(Vote vote);
}
