package kr.co.bcd.board.post.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.common.paging.model.PageInfo;

@Repository
public class PostDao {

	public int selectListCount(SqlSessionTemplate sqlSession, String category, String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("category", category);
        paramMap.put("keyword", keyword);
		return sqlSession.selectOne("boardMapper.selectListCount", paramMap);
	}

	public List<Post> selectListAll(SqlSessionTemplate sqlSession, PageInfo pi, String category, String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("category", category);
        paramMap.put("keyword", keyword);
        
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("boardMapper.selectListAll", paramMap, rowBounds);
	}

}
