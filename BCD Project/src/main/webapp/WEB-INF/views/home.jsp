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
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-repeat" viewBox="0 0 16 16">
								<path d="M11.534 7h3.932a.25.25 0 0 1 .192.41l-1.966 2.36a.25.25 0 0 1-.384 0l-1.966-2.36a.25.25 0 0 1 .192-.41zm-11 2h3.932a.25.25 0 0 0 .192-.41L2.692 6.23a.25.25 0 0 0-.384 0L.342 8.59A.25.25 0 0 0 .534 9z"/>
								<path fill-rule="evenodd" d="M8 3c-1.552 0-2.94.707-3.857 1.818a.5.5 0 1 1-.771-.636A6.002 6.002 0 0 1 13.917 7H12.9A5.002 5.002 0 0 0 8 3zM3.1 9a5.002 5.002 0 0 0 8.757 2.182.5.5 0 1 1 .771.636A6.002 6.002 0 0 1 2.083 9H3.1z"/>
							</svg>
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
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-all" viewBox="0 0 16 16">
									<path d="M8.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L2.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093L8.95 4.992a.252.252 0 0 1 .02-.022zm-.92 5.14.92.92a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 1 0-1.091-1.028L9.477 9.417l-.485-.486-.943 1.179z"/>
								</svg>
								전체
							</a>
						</li>
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark">
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
									<path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
								</svg>
								골라줘!
							</a>
						</li>
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark">
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
									<path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
								</svg>
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
				                마감일 | <span>${ item.createDate }</span>
				            </div>
				
				            <div class="fw-bold fs-5 mb-2 col-12 d-inline-block text-truncate">
				                ${ item.title }
				            </div>
				
				            <div class="badge border text-dark border-success text-wrap rounded p-2 me-2 ps-3 pe-3 mb-2">
				                ${ item.subCategory }
				            </div>
				
				            <div class="d-flex  mb-2">
				                <div class="d-flex align-items-center me-3">
				                    <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
				                        <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
				                    </svg>
				                    <span class="ms-2">@작성자@</span>
				                </div>
				
				                <div class="d-flex align-items-center">
				                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" fill="currentColor" class="bi bi-chat-right-dots-fill" viewBox="0 0 16 16">
				                        <path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353V2zM5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
				                    </svg>
				                    <span class="ms-2">@댓글수@</span>
				                </div>
				
				            </div>
				
				            <div class="" style="font-size: 14px;">
				                현재 <span class="text-primary">@투표자수@</span>명이 투표에 참여했어요!
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