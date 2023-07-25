package kr.co.bcd.board.comment.model.service;

import java.util.List;

import kr.co.bcd.board.comment.model.dto.Comment;

public interface CommentService {
	// 게시글 댓글 수 구하기
	int selectCommentCount(int idx);
	
	// 게시글 댓글 리스트 가져오기
	List<Comment> detailComment(int idx);
}
