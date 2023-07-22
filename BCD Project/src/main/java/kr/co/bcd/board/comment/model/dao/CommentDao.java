package kr.co.bcd.board.comment.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDao {

	public int selectCommentCount(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.selectCommentCount", idx);
	}

}
