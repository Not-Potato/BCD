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

	@Override
	public int insertPost(Post post) {
		return postDao.insertPost(sqlSession, post);
	}

	@Override
	public int viewsUpdate(Post post) {
		return postDao.viewsUpdate(sqlSession, post);
	}

	@Override
	public Post detailBoard(int idx) {
		return postDao.detailBoard(sqlSession, idx);
	}

	@Override
	public int updateStatus(Post post) {
		return postDao.updateStatus(sqlSession, post);
	}

	@Override
	public int selectWriterIdx(int idx) {
		return postDao.selecetWriterIdx(sqlSession, idx);
	}

	@Override
	public int updateReview(Post post) {
		return postDao.updateReview(sqlSession, post);
	}

	@Override
	public int isNotDelPost(int idx) {
		return postDao.isNotDelPost(sqlSession, idx);
	}

	@Override
	public Post selectStatus(int idx) {
		return postDao.selectStatus(sqlSession, idx);
	}

	@Override
	public int updatePost(Post post) {
		return postDao.updatePost(sqlSession, post);
	}

	@Override
	public int markPostAsDeleted(int idx) {
		return postDao.markPostAsDeleted(sqlSession, idx);
	}
	
}
