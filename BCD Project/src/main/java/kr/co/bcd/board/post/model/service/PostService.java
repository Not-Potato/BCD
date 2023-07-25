package kr.co.bcd.board.post.model.service;

import java.util.List;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.common.paging.model.PageInfo;


public interface PostService {
	// 전체 게시글 수 구하기
	int selectListCount(String category, String keyword);
	
	// 게시글 목록 가져오기
	List<Post> selectListAll(PageInfo pi, String category, String keyword);
	
	// 게시글 작성하기
	int insertPost(Post post);
	
	// 게시글 조회수 업데이트
	int viewsUpdate(Post post);
	
	// 게시글 조회하기 (상세 페이지)
	Post detailBoard(int idx);
	
	// 게시글 상태 조회하기 (삭제되지 않은 글 + 진행 중인 투표)
	int selectPostStatus(int idx);
	
	// 투표 진행 상태 변경하기 
	// STATUS => A:진행중(디폴트) B:정상종료 C:조기마감
	int updateStatus(Post post);
}
