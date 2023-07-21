package kr.co.bcd.board.post.model.service;

import java.util.List;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.common.paging.model.PageInfo;


public interface PostService {
	// 전체 게시글 수 구하기
	int selectListCount(String category, String keyword);
	
	// 게시글 목록 가져오기
	List<Post> selectListAll(PageInfo pi, String category, String keyword);
	
}
