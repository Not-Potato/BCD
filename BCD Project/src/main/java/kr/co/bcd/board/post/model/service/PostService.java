package kr.co.bcd.board.post.model.service;

import java.util.List;

import kr.co.bcd.board.post.model.dto.Post;
import kr.co.bcd.common.paging.model.PageInfo;


public interface PostService {
	// 전체 게시글 수 구하기
	int selectListCount(String category, String keyword, String searchTxt);
	
	// 게시글 목록 가져오기
	List<Post> selectListAll(PageInfo pi, String category, String keyword, String searchTxt);
	
	// 게시글 작성하기
	int insertPost(Post post);
	
	// 게시글 조회수 업데이트
	int viewsUpdate(Post post);
	
	// 게시글 조회하기 (상세 페이지)
	Post detailBoard(int idx);
	
	// 투표 진행 상태 변경하기 
	// STATUS => A:진행중(디폴트) B:정상종료 C:조기마감
	int updateStatus(Post post);
	
	// 게시글 번호 받아서 작성자 idx 가져오기
	int selectWriterIdx(int idx);
	
	// 리뷰 작성 + 수정 (UPDATE)
	int updateReview(Post post);
	
	// 게시글 상태 조회하기 (ver.1: delete_date is null)
	int isNotDelPost(int idx);
	
	// 게시글 상태 조회하기 (ver.2: get status)
	Post selectStatus(int idx);	
	
	// 게시글 수정하기 (title, content)
	int updatePost(Post post);
	
	// 게시글 삭제하기 (delete_date)
	int markPostAsDeleted(int idx);
	
	// 인기 카테고리 가져오기
	List<Post> selectPopularCategory();
	
	//내가 쓴 글 수 구하기
	int selectMyListCount(int memIdx);
	
	//내가 쓴 글 가져오기
	List<Post> selectMyListAll(PageInfo pi, int memIdx);
	
}
