<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="../common/head.jsp" %>
</head>
<body>
	<%@ include file="../common/header.jsp" %>

	<div class="container d-flex justify-content-center mt-5 mb-5">
		<div class="w-75 mt-5">
			<!-- history.back -->
			<div class="">
				<button type="button" class="mb-3" style="border: none; background: none;">
					<i class="bi bi-chevron-left text-start fs-2"></i>
				</button>
			</div>
			
			<!-- post -->
			<div>
				<!-- 제목, 게시글 정보(작성자, 작성일, 조회수) -->
				<div class="border-bottom">
					<h1 class="fw-bold fs-1 mt-5">제목이 들어가는 자리입니다만은 ? </h1>
					<h3 class="fs-6 mt-5 mb-5">
						<span>프사</span>
						<span>작성자</span>
						<span>작성일</span>
						<span>조회수</span>
					</h3>
				</div>
				
				<!-- 내용 (글 내용, 투표, 후기) -->
				<div>
				</div>
			</div>

			<!-- comment -->
			<div>
				<!-- 댓글 수 -->
				<div>
				</div>
				
				<!-- 댓글 입력 창 (본인 프로필 사진, 댓글 input, 등록 버튼 -->
				<div>
				</div>

				<!-- 해당 글에 작성되어 있는 댓글 불러오기 (작성자 닉네임, 프로필 사진, 작성일, 댓글 내용 + 수정/삭제 버튼) -->
				<div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>