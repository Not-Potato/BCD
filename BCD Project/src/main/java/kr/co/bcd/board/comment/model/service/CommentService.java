package kr.co.bcd.board.comment.model.service;

import java.util.List;

import kr.co.bcd.board.comment.model.dto.Comment;

public interface CommentService {
	// 게시글 댓글 수 구하기
	int selectCommentCount(int idx);
	
	// 게시글 댓글 리스트 가져오기
	List<Comment> detailComment(int idx);
	
	// 댓글 작성
	int insert(Comment comment);
	
	// 댓글 작성자 가져오기
	int getCommentAuthor(int idx);
	
	// 유효한 댓글(delete date 칼럼 null)인지 확인
	int isCommentValid(int idx);
	
	// 댓글 수정
	int updateComment(Comment comment);
	
	// 댓글 삭제
	int markCommentAsDeleted(int idx);
}
