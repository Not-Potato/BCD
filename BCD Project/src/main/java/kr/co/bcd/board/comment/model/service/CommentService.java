package kr.co.bcd.board.comment.model.service;

public interface CommentService {
	// 게시글 댓글 수 구하기
	int selectCommentCount(int idx);
}
