<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="./common/head.jsp" %>
	
	<!-- swiper plugin -->
	<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />

	<!-- card css -->
	<link rel="stylesheet" href="../../resources/css/common/card.css" />
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<!-- banner -->
	<section id="visual">
		<div class="swiper mySwiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide bg-primary" style="width: 100%; height: 350px;">Slide 1</div>
				<div class="swiper-slide bg-secondary" style="width: 100%; height: 350px;">Slide 2</div>
				<div class="swiper-slide bg-info" style="width: 100%; height: 350px;">Slide 3</div>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</section>

	<div class="container">
	
		<!-- board list -->
		<main>

			<div class="card mt-3" style="border: none;">
						<!-- 대분류 -->
				<div class="card-header bg-transparent">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item">
							<a class="nav-link active text-primary" aria-current="true" href="#">인기항목</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark" href="#">큰고민</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark" href="#">작은고민</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark" href="#">모두보기</a>
						</li>
					</ul>
				</div>
				<div class="card-body ps-0">
				 	<!-- 소분류 -->
					<div class="mb-2">
						<a class="btn btn-primary">카테고리1</a>
						<a class="btn btn-primary">카테고리2</a>
						<a class="btn btn-primary">카테고리3</a>
					</div>
					
					<!-- 적용된 필터 -->
					<div class="">
						<a class="btn btn-primary">카테고리1</a>
						<a class="btn btn-primary">카테고리2</a>
						<a class="btn btn-outline-primary">
							<i class="bi bi-arrow-repeat"></i>
							초기화
						</a>
					</div>
					
				</div>
			</div>

			
			<div class="d-flex justify-content-between">
				<!-- 상태 기준 정렬 -->
				<div>
					<ul class="d-flex ps-0">
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark">
								<i class="bi bi-check-all"></i>
								전체
							</a>
						</li>
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark">
								<i class="bi bi-check"></i>
								골라줘!
							</a>
						</li>
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark">
								<i class="bi bi-check"></i>
								골랐어!
							</a>
						</li>
					</ul>
				</div>
				
				<div>
					<!-- 드롭다운 정렬 -->
					<div class="btn-group">
						<button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							전체
						</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">참여도 순</a></li>
							<li><a class="dropdown-item" href="#">박빙 순</a></li>
							<li><a class="dropdown-item" href="#">댓글 순</a></li>
						</ul>
					</div>
				</div>
			</div>
			
			<div class="row">
<c:choose>
	<c:when test="${empty list}">
					<tr>
						<td colspan="5">
							<h3 class="text-center">등록된 글이 없습니다.</h3>
						</td>
					</tr>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${list}">
				<div class="col-xl-3 col-sm-6">
				    <div class="card-shadow card">
				        <div class="card-body">
				            <div class="mb-2">
				                <div class="badge bg-primary text-wrap rounded p-2 me-1 ps-3 pe-3">
				                    골라줘!
				                </div>
				                <div class="badge bg-success text-wrap rounded p-2 ps-3 pe-3">
				                    골라줘!
				                </div>
				            </div>
				
				            <div class="fs-6 text-secondary mb-2">
				                마감일 | <span>${ item.deadline }</span>
				            </div>
				
				            <div class="fw-bold fs-5 mb-2 col-12 d-inline-block text-truncate">
				                ${ item.title }
				            </div>
				
				            <div class="badge border text-dark border-success text-wrap rounded p-2 me-2 ps-3 pe-3 mb-2">
				                ${ item.subCategory }
				            </div>
				
				            <div class="d-flex  mb-2">
				                <div class="d-flex align-items-center me-3">
				                    <i class="bi bi-person-fill fs-5"></i>
				                    <span class="ms-2">${ item.writer }</span>
				                </div>
				
				                <div class="d-flex align-items-center">
				                    <i class="bi bi-chat-right-dots-fill"></i>
				                    <span class="ms-2">${ item.commentCount }</span>
				                </div>
				
				            </div>
				
				            <div class="" style="font-size: 14px;">
				                현재 <span class="text-primary">${ item.voteCount }</span>명이 투표에 참여했어요!
				            </div>
				        </div>
				    </div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>			
			</div>
		</main>
	</div>
	
	<%@ include file="./common/footer.jsp" %>
	
	<!-- Swiper JS -->
	<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
	
	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper(".mySwiper", {
			pagination: {
				el: ".swiper-pagination",
			},
		});
	</script>
</body>
</html>