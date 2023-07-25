package kr.co.bcd.board.comment.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.bcd.board.comment.model.dao.CommentDao;
import kr.co.bcd.board.comment.model.dto.Comment;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectCommentCount(int idx) {
		return commentDao.selectCommentCount(sqlSession, idx);
	}
	
	@Override
	public List<Comment> detailComment(int idx) {
		return commentDao.detailComment(sqlSession, idx);
	}

}
