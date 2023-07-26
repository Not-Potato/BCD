package kr.co.bcd.board.comment.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.bcd.board.comment.model.dto.Comment;

@Repository
public class CommentDao {

	public int selectCommentCount(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.selectCommentCount", idx);
	}

	public List<Comment> detailComment(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectList("boardMapper.detailComment", idx);
	}

	public int insert(SqlSessionTemplate sqlSession, Comment comment) {
		return sqlSession.insert("boardMapper.insertComment", comment);
	}

}
