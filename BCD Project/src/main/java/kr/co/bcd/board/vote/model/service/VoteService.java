package kr.co.bcd.board.vote.model.service;

public interface VoteService {
	// 총 투표자 수 구하기
	int selectVoteCount(int idx);
	
	// 각 항목 투표자 수 구하기
	int selectVoteCount(int idx, String AorB);
}
