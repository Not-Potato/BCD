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
	<style>
		.hidden {
			display: none;
		}
	</style>
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
				<div class="card-header bg-transparent" id="bigCategories">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item">
							<a class="nav-link active text-primary" aria-current="true"  id=popularTab>인기항목</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark"  id="bigWorryTab">큰고민</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark"  id="smallWorryTab">작은고민</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark"  id="allCategoryTab">모두보기</a>
						</li>
					</ul>
				</div>
				<div class="card-body ps-0">
				 	<!-- 소분류 -->
					<div class="mb-2 d-flex gap-1" id="smallCategories">
						
						<a class="btn btn-outline-primary" data-category="popular" id="popular1">카테고리1</a>
						<a class="btn btn-outline-primary" data-category="popular" id="popular2">카테고리2</a>
						<a class="btn btn-outline-primary" data-category="popular" id="popular3">카테고리3</a>
						
						<a class="btn btn-outline-primary" data-category="bigWorry" id="bigWorry1">카테고리4</a>
						<a class="btn btn-outline-primary" data-category="bigWorry" id="bigWorry2">카테고리5</a>
						<a class="btn btn-outline-primary" data-category="bigWorry" id="bigWorry3">카테고리6</a>
					
					
						<a class="btn btn-outline-primary" data-category="smallWorry" id="smallWorry1">카테고리7</a>
						<a class="btn btn-outline-primary" data-category="smallWorry" id="smallWorry2">카테고리8</a>
						<a class="btn btn-outline-primary" data-category="smallWorry" id="smallWorry3">카테고리9</a>
						
					</div>
					
					<!-- 적용된 필터 -->
					<div class="mb-2 d-flex gap-1 d-flex align-items-center mt-3" style="height: 38px;">
						<div class="selectedBtn d-flex gap-1">
						  <!-- 선택된 버튼 들어갈 자리 -->
		
						</div>
						<a role="button" id="resetBtn" class="text-secondary d-none">
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
				<div class="col-xl-3 col-sm-6" role="button" onclick="location.href='/board/detail.do?idx=${item.idx}';">
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
		
		/*  카테고리  */
		const popularTab = document.getElementById("popularTab");
		const bigWorryTab = document.getElementById("bigWorryTab");
		const smallWorryTab = document.getElementById("smallWorryTab");
		const allCategoryTab = document.getElementById("allCategoryTab");
		const bigCategories= document.getElementById("bigCategories").getElementsByTagName("a");
		const smallCategories= document.getElementById("smallCategories").getElementsByTagName("a");
		const selectedBtnTag= document.querySelector(".selectedBtn").getElementsByTagName("a");
		
		let selectedCount = 0;
		
		//active class 없애기
		function removeActive(){
			console.log("removeActive() 실행됨");
			for(const activeClass of bigCategories) {
				activeClass.classList.remove("active");
			}
		}
		
		popularTab.addEventListener("click", function() {
			removeActive();
			popularTab.classList.add("active");
			selectedCategory = "popular"
			showCategories(selectedCategory);
		});
		bigWorryTab.addEventListener("click", function() {
			removeActive();
			bigWorryTab.classList.add("active");
			selectedCategory = "bigWorry"
			showCategories(selectedCategory);
		});
		smallWorryTab.addEventListener("click", function() {
			removeActive();
			smallWorryTab.classList.add("active");
			selectedCategory = "smallWorry"
			showCategories(selectedCategory);
		});
		allCategoryTab.addEventListener("click", function() {
			removeActive();
			allCategoryTab.classList.add("active");
			for(const category of smallCategories){
	      		category.style.display = "block"; 
			}
		});
		
		window.onload = function() {
			popularTab.click();
	    };
		
		//대분류에 맞는 카테고리 가져오기
		function showCategories(selectedCategory){
			for(const category of smallCategories){
				if (category.getAttribute("data-category") == selectedCategory) {
	      			category.style.display = "block"; 
				}else {
					category.style.display = "none"; 
				}
				console.log("카테고리 : "+category.getAttribute("data-category"));
			}
		}	
		
		//선택된 카테고리 표시
		
		//중복 허용 안되는 배열 만들기
		const selectedBtnIds = new Set();
	    //클릭된 버튼 넣을 자리
		const selectedBtnSection = document.querySelector(".selectedBtn");
	    
		function selectBtn(){
			
			for(const btn of smallCategories){
				btn.addEventListener("click", function(){
					//클릭된 버튼 아이디 가져오는
					const btnId = this.getAttribute("id");
					//클릭하면 버튼 색깔 변경되는
					let isOutline = this.classList.contains("btn-outline-primary");
					 if (isOutline) {
						this.classList.replace("btn-outline-primary", "btn-primary");
					 } else {
						 this.classList.replace("btn-primary", "btn-outline-primary");
					 }
					//클릭된 버튼아이디로 버튼 자체 가져오기
					const selectedBtn = document.getElementById(btnId);
					//배열에 선택된 버튼이 존재하는지 확인
					const selected = selectedBtnIds.has(btnId);
					//선택된 버튼 보여주는 복제 버튼 만들기
					const cloneBtn = selectedBtn.cloneNode(true);
					//복제된 버튼의 id 변경
					cloneBtn.setAttribute("id",btnId+"-cloned");
					if(selected) { //배열에 카테고리 존재한다면??
						selectedBtnSection.removeChild(document.getElementById(btnId+'-cloned'));
						console.log("삭제전 :"+Array.from(selectedBtnIds));	
						selectedBtnIds.delete(btnId);
						console.log("삭제 :"+Array.from(selectedBtnIds));
						selectedCount--;
						resetBtnShow();
					}else { //존재하지 않는다면 버튼 넣기
						selectedBtnSection.appendChild(cloneBtn);
						cloneBtn.classList.remove("btn", "btn-primary");
						cloneBtn.classList.add("bg-secondary", "p-2", "bg-opacity-10", "text-dark", "rounded");
						console.log("추가전 :"+Array.from(selectedBtnIds));
						selectedBtnIds.add(btnId);
						console.log("추가  :"+Array.from(selectedBtnIds));
						selectedCount++;
						resetBtnShow();
					}
				});
			}
		}
		selectBtn();
		
		//초기화 버튼
		const resetBtn = document.getElementById("resetBtn");
		
		function resetBtnShow() {
			if (selectedCount > 0) {
				resetBtn.classList.remove('d-none');
			} else {
				resetBtn.classList.add('d-none');
			}
		}
		
		resetBtn.addEventListener("click", function(){
			for(const btnId of selectedBtnIds){
				selectedBtnSection.removeChild(document.getElementById(btnId+'-cloned'));
			}
			
			for (const btn of smallCategories){
				btn.classList.replace("btn-primary", "btn-outline-primary");
				
			}
			selectedBtnIds.clear();
			selectedCount = 0;
			resetBtnShow();
		}) 
			
		/*  카테고리 끝*/
	</script>
</body>
</html>