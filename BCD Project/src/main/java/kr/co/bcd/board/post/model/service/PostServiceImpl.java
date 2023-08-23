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
	public int selectListCount(List<String> selectedCategories, String keyword, String searchTxt) {
		return postDao.selectListCount(sqlSession, selectedCategories, keyword, searchTxt);
	}
	
	@Override
	public List<Post> selectListAll(PageInfo pi, List<String> selectedCategories, String keyword, String searchTxt) {
		return postDao.selectListAll(sqlSession, pi, selectedCategories, keyword, searchTxt);
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
	
	@Override
	public List<Post> selectPopularCategory() {
		return postDao.selectPopularCategory(sqlSession);
	}

	public int selectMyListCount(int memIdx) {
		return postDao.selectMyListCount(sqlSession, memIdx);
	}

	public List<Post> selectMyListAll(PageInfo pi, int memIdx) {
		return postDao.selectMyListAll(sqlSession, pi, memIdx);
	}
}
