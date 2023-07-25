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
			<div class="d-flex justify-content-between">
				<button type="button" class="mb-3" style="border: none; background: none;" data-tooltip="뒤로 가기">
					<i class="bi bi-chevron-left fs-2"></i>
				</button>
				
				<div>
					<button type="button" class="mb-3" style="border: none; background: none;" onclick="location.href='#'" data-tooltip="수정하기">
						<i class="bi bi-eraser-fill fs-2"></i>
					</button>
					<button type="button" class="mb-3" style="border: none; background: none;" onclick="location.href='#'" data-tooltip="삭제하기">
						<i class="bi bi-trash-fill fs-2 ms-3"></i>
					</button>
				</div>
			</div>
			
			<!-- post -->
			<div>
				<!-- 제목, 게시글 정보(작성자, 작성일, 조회수) -->
				<div class="border-bottom">
					<h1 class="fw-bold fs-1 mt-5">${ post.title }</h1>
					<h3 class="fs-6 mt-5 mb-5">
						<span>@@프사@@</span>
						<span class="me-3">${ post.writer }</span>
						
						<span class="me-3">${ post.createDate }</span>
						<span>${ post.views }</span>
					</h3>
				</div>
				
				<!-- 내용 (투표, 글 내용, 후기) -->
				<div>
					<!-- 
					1. 진행중 -> a. 작성자 / b. 참여자-참여전 / c. 참여자-참여후
					2. 마감
					네 가지 케이스로 분기하기 
					-->
					<!-- 투표 -->
					<div style="margin-top: 100px; margin-bottom: 150px;">
						<div class="border-bottom mb-5">
							<p class="fs-4 fw-bold d-flex align-items-center">
			                    <i class="bi bi-check2-square"></i>
			                    <span class="ms-2">골라 줘!</span>
		                	</p>
						</div>
						
						<div class="d-flex flex-column">
							<div class="border border-bottom-0 rounded-top d-flex justify-content-between align-items-center w-75 m-auto" style="height: 50px; padding: 10px;" >
								<p class="fs-4 fw-bold mb-0">${ post.voteTitle }</p>
							</div>
							<div class="border w-75 m-auto border-bottom-0 d-flex justify-content-between"  style="padding: 10px;">
								<p class="mb-0">${ post.mainCategory }</p>
								<p class="mb-0">${ post.subCategory }</p>
								<p class="mb-0">${ post.deadline }까지</p>
							</div>
							<div class="border d-flex justify-content-between align-items-center w-75 m-auto" style="height: 100px; padding: 10px;">
								<div>${ post.vote1ST }</div>
								<div>VS</div>
								<div>${ post.vote2ND }</div>							
							</div>
							<button type="button" class="btn rounded-bottom btn-primary w-75 m-auto p-3" style="border-top-left-radius: 0; border-top-right-radius: 0;"  data-tooltip="pick!">
								투표하기
							</button>
						</div>
					</div>

					<!-- 글 내용 -->
					<div class="mt-5" style="margin-bottom: 150px;">
						<div class="border-bottom mb-5">
							<p class="fs-4 fw-bold d-flex align-items-center">
			                    <i class="bi bi-body-text"></i>
			                    <span class="ms-2">투표 소개</span>
		                	</p>
						</div>
	                	
	                	<div>
							<p class="lh-lg p-3 m-0 text-break">
								${ post.content }
							</p>
	                	</div>
					</div>
					

					<!-- 
					후기가
					1. 있는 경우 a. 작성자인 경우(수정/삭제) / b. 작성자가 아닌 경우(read only)
					2. 없는 경우 a. 작성자인 경우(작성) / b. 작성자가 아닌 경우(업습니다)
					네 가지 케이스로 분기하기 
					-->
					<!-- 후기 -->
					<div class="mt-5" style="margin-bottom: 150px;">
						<div class="w-75 m-auto p-4 border rounded d-flex align-items-center">
							<p class="text-danger fw-bold d-flex align-items-center mb-0">
								<i class="bi bi-emoji-wink-fill fs-4"></i>
								<span class="ms-2">아직 작성된 후기가 존재하지 않아요!</span>
							</p>
						</div>
					</div>
				</div>
			</div>

			<!-- comment -->
			<div>
				<!-- 댓글 수 -->
				<div>
					<div class="border-bottom mb-5">
						<p class="fs-4 fw-bold d-flex align-items-center">
		                    <i class="bi bi-chat-right-dots-fill"></i>
		                    <span class="ms-2">${ post.commentCount }</span>
	                	</p>
					</div>
				</div>
				
				<!-- 댓글 입력 창 (본인 프로필 사진, 댓글 input, 등록 버튼 -->
				<div>
					<div class="input-group mb-3">
						<textarea class="form-control p-3" style="height: 150px; resize: none;" placeholder="댓글을 입력해 주세요!"></textarea>
						<button class="btn btn-outline-primary p-5" type="button">작성</button>
					</div>
				</div>

				<!-- 해당 글에 작성되어 있는 댓글 불러오기 (작성자 닉네임, 프로필 사진, 작성일, 댓글 내용 + 수정/삭제 버튼) -->

<c:choose>
	<c:when test="${empty comment}">
				<div>
					<p>등록된 댓글이 존재하지 않습니다.</p>
					<p>제일 먼저 댓글을 남겨 보세요!</p>					
				</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${comment}">
				<div class="mt-5 border-bottom pb-3">
					<div class="d-flex align-items-center justify-content-between">
						<div class="d-flex align-items-center">
							<img src="https://url.kr/rsihxp" class="rounded-circle" style="width: 50px;">
							<p class="m-0 fw-bold fs-5 lh-1 ms-2">
								${ item.nickname }
								<br>
								<span class="text-secondary fs-6 fw-light">${ item.createDate }</span>
							</p>
						</div>
						<div class="">
							<a class="text-decoration-none me-2 pe-auto" href="#">
								수정
							</a>
							<a class="text-decoration-none pe-auto" href="#">
								삭제
							</a>
						</div>
					</div>
					
					<div class="mt-2">
						<p class="lh-lg m-0 text-break">
							${ item.content }
						</p>
					</div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>		
			</div>
		</div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>