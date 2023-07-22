<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="../common/head.jsp" %>
	
	<!-- tooltip css -->
	<link rel="stylesheet" href="../../../resources/css/common/tooltip.css" />
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
					<h1 class="fw-bold fs-1 mt-5">@@제목이 들어가는 자리입니다만은 ?@@</h1>
					<h3 class="fs-6 mt-5 mb-5">
						<span>@@프사@@</span>
						<span>@@작성자@@</span>
						<span>@@작성일@@</span>
						<span>@@조회수@@</span>
					</h3>
				</div>
				
				<!-- 내용 (투표, 글 내용, 후기) -->
				<div>
					<!-- 
					1. 작성자 
					2. not 작성자 + 참여 전 
					3. not 작성자 + 참여 후 
					세 가지 케이스로 분기하기 
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
							<div class="border rounded-top d-flex justify-content-between align-items-center w-75 m-auto" style="height: 100px; padding: 10px;">
								<div>@@선택지1@@</div>
								<div>VS</div>
								<div>@@선택지2@@</div>							
							</div>
							<button type="button" class="btn rounded-bottom btn-primary w-75 m-auto p-3" style="border-top-left-radius: 0; border-top-right-radius: 0;">투표하기</button>
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
								@@
								어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..
								어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..
								어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..어쩌구저쩌구..
								@@
							</p>
	                	</div>
					</div>
					

					<!-- 
					1. 후기가 없는 경우 접속한 사람이 작성자일 때 -> 후기 작성 버튼
					2. 후기가 없는 경우 접속한 사람이 not 작성자일 때 -> !!!!현재 상태!!!!
					3. 후기가 있는 경우 접속한 사람이 작성자일 때 -> 후기 수정/삭제 버튼
					4. 후기가 있는 경우 접속한 사람이 not 작성자일 때 -> 후기 보여 주기
					두 가지 케이스로 분기하기 
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
		                    <span class="ms-2">@@댓글 수@@</span>
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
				<div class="mt-5 border-bottom pb-3">
					<div class="d-flex align-items-center justify-content-between">
						<div class="d-flex align-items-center">
							<img src="https://url.kr/rsihxp" class="rounded-circle" style="width: 50px;">
							<p class="m-0 fw-bold fs-5 lh-1 ms-2">
								@@닉네임@@
								<br>
								<span class="text-secondary fs-6 fw-light">@@작성일@@</span>
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
							@@
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..							
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..							
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..							
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..							
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..댓글내용..												
							@@
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>