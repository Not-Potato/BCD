package kr.co.bcd.board.post.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.bcd.board.post.model.dao.PostDao;
import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.common.paging.model.PageInfo;

@Service
public class PostServiceImpl implements PostService {
	
	@Autowired
	private PostDao postDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount(String category, String keyword) {
		return postDao.selectListCount(sqlSession, category, keyword);
	}
	
	@Override
	public List<Post> selectListAll(PageInfo pi, String category, String keyword) {
		return postDao.selectListAll(sqlSession, pi, category, keyword);
	}

	public Post detailBoard(int idx) {
		//return postDao.detailBoard(sqlSession, idx);
		return null;
	}


}
