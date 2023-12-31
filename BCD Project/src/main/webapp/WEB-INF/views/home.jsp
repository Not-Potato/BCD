<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="./common/head.jsp" %>
	<!-- 제발 . . -->
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
		<div class="inner">
			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="../../resources/images/main-banner-1.png"></div>
					<div class="swiper-slide"><img src="../../resources/images/main-banner-2.png"></div>
					<div class="swiper-slide"><img src="../../resources/images/main-banner-3.png"></div>
				</div>
				<div class="swiper-pagination"></div>
			</div>
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
							<a class="nav-link text-dark"  id="ventiTab">Venti Size</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark"  id="tallTab">Tall Size</a>
						</li>
						<li class="nav-item">
							<a class="nav-link text-dark"  id="allCategoryTab">All</a>
						</li>
					</ul>
				</div>
				<div class="card-body ps-0">
				 	<!-- 소분류 -->
					<div class="mb-2 d-flex gap-1" id="smallCategories">
<c:choose>
	<c:when test="${empty popular}">
						<a class="btn btn-outline-primary popular" data-category="Venti Size"  data-popular="yes" id="popular1">사회/이슈</a>
						<a class="btn btn-outline-primary popular" data-category="Venti Size"  data-popular="yes" id="popular2">연애/결혼</a>
						<a class="btn btn-outline-primary popular" data-category="Tall Size"  data-popular="yes" id="popular3">점메추</a>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${ popular }" varStatus="status">
						<a class="btn btn-outline-primary popular" data-category="${ item.value }" data-popular="yes" id="popular${ status.count }">${ item.key }</a>
		</c:forEach>
	</c:otherwise>
</c:choose>						
						<a class="btn btn-outline-primary d-none" data-category="Venti Size" id="ventiSize1">연애/결혼</a>
						<a class="btn btn-outline-primary d-none" data-category="Venti Size" id="ventiSize2">가족/친구</a>
						<a class="btn btn-outline-primary d-none" data-category="Venti Size" id="ventiSize3">학교/직장</a>
						<a class="btn btn-outline-primary d-none" data-category="Venti Size" id="ventiSize4">사회/이슈</a>
						
						<a class="btn btn-outline-primary d-none" data-category="Tall Size" id="tallSize1">점메추</a>
						<a class="btn btn-outline-primary d-none" data-category="Tall Size" id="tallSize2">깻잎논쟁</a>
						<a class="btn btn-outline-primary d-none" data-category="Tall Size" id="tallSize3">할까말까</a>
						<a class="btn btn-outline-primary d-none" data-category="Tall Size" id="tallSize4">최애픽</a>
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
							<a class="fs-4 text-decoration-none text-dark" role="button">
								<i class="bi bi-check-all"></i>
								전체
							</a>
						</li>
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark" role="button">
								<i class="bi bi-check"></i>
								골라줘!
							</a>
						</li>
						<li class="me-3">
							<a class="fs-4 text-decoration-none text-dark" role="button">
								<i class="bi bi-check"></i>
								골랐어!
							</a>
						</li>
					</ul>
				</div>
				
<!-- 				<div>
					드롭다운 정렬
					<div class="btn-group">
						<button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							전체
						</button>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">최신순</a></li>
							<li><a class="dropdown-item" href="#">참여도순</a></li>
							<li><a class="dropdown-item" href="#">댓글 많은 순</a></li>
						</ul>
					</div>
				</div> -->
			</div>
			
			<div class="row" id="cardContainer">
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
				<div class="col-xl-3 col-sm-6 post" role="button" onclick="location.href='/board/detail.do?idx=${item.idx}';">
				    <div class="card-shadow card">
				        <div class="card-body">
				            <div class="mb-2">
				            	<input type="hidden" value="${ item.createDate }" class="createDate">
				            	<input type="hidden" value="${ item.deadline }" class="deadline">
				            	<input type="hidden" value="${ item.status }" class="status">
				            	<input type="hidden" value="${ item.review eq null ? 'no' : 'yes' }" class="review">
				                <div class="badge bg-primary text-wrap rounded p-2 me-1 d-none new-label">
				                    ✨New!
				                </div>
				                <div class="badge bg-primary bg-opacity-75 text-wrap rounded p-2 me-1 d-none ing-label">
				                    ing
				                </div>	                
				                <div class="badge bg-danger bg-opacity-75 text-wrap rounded p-2 me-1 d-none deadline-label">
				                    final
				                </div>
				                <div class="badge bg-secondary bg-opacity-75 text-wrap rounded p-2 me-1 d-none close-label">
				                    closed
				                </div>	                
				                <div class="badge bg-secondary bg-opacity-75 text-wrap rounded p-2 me-1 d-none early-close-label">
				                    early closed
				                </div>	                
				                <div class="badge bg-dark bg-opacity-75 text-wrap rounded p-2 me-1 d-none review-label">
				                    review
				                </div>	                
				            </div>
				
				            <div class="fs-6 text-secondary mb-2">
				                마감일 | <span>${ item.deadline }</span>
				            </div>
				
				            <div class="fw-bold fs-5 mb-2 col-12 d-inline-block text-truncate">
				                ${ item.title }
				            </div>
				
				            <div class="badge border border-primary border-opacity-50 text-dark text-wrap rounded p-2 me-2 mb-2">
				                ${ item.subCategory }
				            </div>
				
				            <div class="d-flex  mb-2">
				                <div class="d-flex align-items-center me-3">
				                    <img src="${ item.profile }" class="rounded-circle" style="width: 28px;">
				                    <span class="ms-2">${ item.writer }</span>
				                </div>
				
				                <div class="d-flex align-items-center">
				                    <i class="bi bi-chat-right-dots-fill"></i>
				                    <span class="ms-2">${ item.commentCount }</span>
				                </div>
				
				            </div>
				
				            <div class="" style="font-size: 14px;">
				                현재 <span class="text-primary fw-bold">${ item.voteCount }</span>명이 투표에 참여했어요!
				            </div>
				        </div>
				    </div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>			
				<div class="mb-3 d-flex justify-content-center">
		   	        <button type="button" class="btn btn-link" id="nextPageBtn">더보기</button> 
		        	<input type="hidden" value="${pi.endPage}" id="endPage">
			    </div>
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
		
		// 더보기 버튼
		function andContent() {			
			const nextPageBtn = $("#nextPageBtn");
			   
			let	page = 1;
			
			let endPage = $("#endPage").val();
			
			if (endPage == page) {
				nextPageBtn.hide();
			}
			
			nextPageBtn.click(function(){
				page++;
				console.log("page"+page);
				
				$.ajax({
					url:"/board/list.do",
					method:"GET",
					data: {
						 
						cpage: pageNum
					},
					success: function(response){
						//page++;
						const content = $(response).find("#cardContainer").html();
					 	console.log("endPage:"+endPage);
						if(endPage == page){
							nextPageBtn.hide();
						}
						$("#cardContainer").append(content);
						
						// 각 데이터를 처리하는 함수를 호출합니다.
						$('.post').each(function() {
							const createDate = $(this).find('.createDate').val();
							const deadline = $(this).find('.deadline').val();
							const status = $(this).find('.status').val();
							const review = $(this).find('.review').val();
							
							processPost.call(this, createDate, deadline, status, review);
						});
					}
				})
			});
		}
		
		/* 라벨링 */
		// 각 데이터를 처리하는 함수를 정의합니다.
		function processPost(createDate, deadline, status, review) {
			// createDate를 이용하여 처리하는 로직
			const today = getToday();
			
			// 오늘 작성된 글이라면
			if (today === createDate) {			    
				$(this).find('.new-label').removeClass('d-none'); // "오늘 마감" 라벨을 보이게 합니다.
			}
			
			// 투표 진행 상태에 따른 "진행 중" OR "마감" 라벨
			if (status === "A") {
				$(this).find('.ing-label').removeClass('d-none'); // "진행 중" 라벨을 보이게 합니다.				

				// 진행 중 && 오늘 마감될 투표라면
				if (deadline === today) {				
					$(this).find('.deadline-label').removeClass('d-none'); // "오늘 마감" 라벨을 보이게 합니다.
				}
			} else if (status === "B") {
				$(this).find('.close-label').removeClass('d-none'); // "마감" 라벨을 보이게 합니다.
			} else {
				$(this).find('.early-close-label').removeClass('d-none'); // "마감" 라벨을 보이게 합니다.				
			}
			
			// review가 존재한다면
			if (review === "yes") {
				$(this).find('.review-label').removeClass('d-none'); // "후기" 라벨을 보이게 합니다.
			}
		}
		
		/*  카테고리  */
		const popularTab = $("#popularTab");
		const ventiTab = $("#ventiTab");
		const tallTab = $("#tallTab");
		const allCategoryTab = $("#allCategoryTab");
		
		const popularCategories = $(".popular");
		const bigCategories=  $("#bigCategories a");
		const smallCategories = $("#smallCategories a");
		 
		const selectedBtnTag= $(".selectedBtn a");
		
		let selectedCount = 0;
		
		//active class 없애기
		function removeActive(){
			for(const activeClass of bigCategories) {
				activeClass.classList.remove("active");
			}
		}
		
		const categoryTabs = {
			'popularTab': 'popular',
			'ventiTab': 'Venti Size',
			'tallTab': 'Tall Size'
		};
		
		$('#allCategoryTab').click(function() {
			removeActive();
			$('#allCategoryTab').addClass('active');
			$('#smallCategories a').removeClass('d-none');
		});
		
		$.each(categoryTabs, function(tabId, category) {
			$('#' + tabId).click(function() {
				removeActive();
				$('#' + tabId).addClass('active');
				$('#smallCategories a').addClass('d-none');
				$('#smallCategories a[data-category="' + category + '"]').removeClass('d-none');
		    
				// 추가 기능: 인기 카테고리 탭일 때만 해당 내용 추가
				if (category === 'popular') {
					$('#smallCategories a[data-popular="yes"]').removeClass('d-none');
					$('#smallCategories a[data-popular!="yes"]').addClass('d-none');
				}
			});
		});
		
		// 필터 변동 시 사용할 함수 선언
		function sendAjaxRequest(selectedCategories) {
			selectedCategories = selectedCategories === null ? null : selectedCategories.join(",");
			console.log(selectedCategories);
			
			$.ajax({
				url: 'board/list.do',
				method: 'POST',
				data: {
					categories: selectedCategories,
					cpage: 1
				},
				dataType: 'html',
				success: function(res) {
				    endPage = $(res).find("#endPage").val();
				 	console.log("endPage:"+endPage);
				 	
					if (endPage == 1){
						nextPageBtn.hide();
					}
					
					const content = $(res).find("#cardContainer").html();
					$("#cardContainer").empty();
					$("#cardContainer").append(content);
					
					// 라벨링
					$('.post').each(function() {
						const createDate = $(this).find('.createDate').val();
						const deadline = $(this).find('.deadline').val();
						const status = $(this).find('.status').val();
						const review = $(this).find('.review').val();
						
						processPost.call(this, createDate, deadline, status, review);
					});
				},
				error: function(xhr, status, error) {
					console.log('ajax 요청 실패', status, error);
				}
			});
		}
		//선택된 카테고리 표시
		
		//중복 허용 안되는 배열 만들기
		const selectedBtnIds = new Set();
	    //클릭된 버튼 넣을 자리
		const selectedBtnSection = document.querySelector(".selectedBtn");
	    
		// 카테고리를 담을 배열
		const selectedCategories = new Set();
	    
		function selectBtn(){
			
			for(const btn of smallCategories){
				btn.addEventListener("click", function(){
					//클릭된 버튼 아이디 가져오는
					const btnId = this.getAttribute("id");
					// 선택된 카테고리의 text 저장
					const btnText = this.textContent;
					
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
					
					if (selected) { //배열에 카테고리 존재한다면??
						selectedBtnSection.removeChild(document.getElementById(btnId+'-cloned'));
						selectedBtnIds.delete(btnId);
						selectedCategories.delete(btnText);
						selectedCount--;
						resetBtnShow();
					} else { //존재하지 않는다면 버튼 넣기
						selectedBtnSection.appendChild(cloneBtn);
						cloneBtn.classList.remove("btn", "btn-primary");
						cloneBtn.classList.add("bg-secondary", "p-2", "bg-opacity-10", "text-dark", "rounded");
						selectedBtnIds.add(btnId);
						selectedCategories.add(btnText);
						selectedCount++;
						resetBtnShow();
					}
					
					const selectedCategoriesArray = Array.from(selectedCategories);
					console.log("선택된 카테고리: " + selectedCategoriesArray);
					sendAjaxRequest(selectedCategoriesArray);
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
			selectedCategories.clear();
			selectedCount = 0;
			resetBtnShow();
			console.log("선택된 카테고리: " + Array.from(selectedCategories));
		}) 
			
		/*  카테고리 끝*/
		
		// 날짜 포매팅
		function getToday(){
			var date = new Date();
			var year = date.getFullYear();
			var month = ("0" + (1 + date.getMonth())).slice(-2);
			var day = ("0" + date.getDate()).slice(-2);
			
			return year + "-" + month + "-" + day;
		}
		
	// 최초에 화면 로드 시
	$(document).ready(function() {
		// 인기 카테고리 중복 건 삭제
		const duplicateElements = {};
		
		const allElements = $('#smallCategories a');
		
		allElements.each(function() {
			const text = $(this).text(); // 요소의 내용 가져오기
			if (duplicateElements[text]) {
				// 중복된 요소가 이미 있는 경우 삭제
				$(this).remove();
			} else {
				// 중복되지 않은 경우 객체에 추가
				duplicateElements[text] = true;
			}
		});
		
		// 각 데이터를 처리하는 함수를 호출합니다.
		$('.post').each(function() {
			const createDate = $(this).find('.createDate').val();
			const deadline = $(this).find('.deadline').val();
			const status = $(this).find('.status').val();
			const review = $(this).find('.review').val();
			
			processPost.call(this, createDate, deadline, status, review);
		});
		
		andContent();
	});
	
	</script>
</body>
</html>