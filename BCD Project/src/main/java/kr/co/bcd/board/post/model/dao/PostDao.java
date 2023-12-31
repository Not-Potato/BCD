package kr.co.bcd.board.post.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.jdbc.Null;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.common.paging.model.PageInfo;


@Repository
public class PostDao {
	public int selectListCount(SqlSessionTemplate sqlSession, List<String> selectedCategories, String status) {
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("categoryList", selectedCategories);
		
		if (status != null && !status.isEmpty()) {
			paramMap.put("status", status);
		}
		
        System.out.println("맵: " + paramMap);
		return sqlSession.selectOne("boardMapper.selectListCount", paramMap);
	}

	public List<Post> selectListAll(SqlSessionTemplate sqlSession, PageInfo pi, List<String> selectedCategories, String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("categoryList", selectedCategories);
        paramMap.put("keyword", keyword);
        
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectListAll", paramMap, rowBounds);
	}

	public int insertPost(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.insert("boardMapper.insertPost", post);
	}

	public int viewsUpdate(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.update("boardMapper.viewsUpdate", post);
	}

	public Post detailBoard(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.detailBoard", idx);
	}
	
	public int updateStatus(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.update("boardMapper.updateStatus", post);
	}

	public int selecetWriterIdx(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.selectWriterIdx", idx);
	}

	public int updateReview(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.update("boardMapper.updateReview", post);
	}

	public int isNotDelPost(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.isNotDelPost", idx);
	}

	public Post selectStatus(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.selectOne("boardMapper.selectStatus", idx);
	}

	public int updatePost(SqlSessionTemplate sqlSession, Post post) {
		return sqlSession.update("boardMapper.updatePost", post);
	}

	public int markPostAsDeleted(SqlSessionTemplate sqlSession, int idx) {
		return sqlSession.update("boardMapper.markPostAsDeleted", idx);
	}
	
	public List<Post> selectPopularCategory(SqlSessionTemplate sqlSession) {
		return sqlSession.selectList("boardMapper.selectPopularCategory");
	}
}
