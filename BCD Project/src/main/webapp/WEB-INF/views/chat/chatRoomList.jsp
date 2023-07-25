<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<%@ include file="../common/head.jsp" %>
	<!-- card css -->
	<link rel="stylesheet" href="../../resources/css/common/card.css" />
	<title>Chat</title>
	<style>
    .backdrop {
    background-color: rgba(0, 0, 0, 0.5); 
    z-index: 1050;
    }
    .modal {
        z-index: 1060;
    }
	</style>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<body>
 <%@ include file="../common/header.jsp" %>
 
	
	<!-- 모달창 -->
   	<div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="createModal" >
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content rounded-4 shadow">
	    <!-- 모달 header -->
	        <div class="modal-header pl-1 pb-2 pt-2 pr-1 pt-0">
	        	<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>  
      			<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close" id="closeModalBtn2"></button> 
      			<hr>
     		</div>
     		<!-- 모달 body -->
	      	<div class="modal-body p-5 pt-0">
		        <h1 class="fw-bold mt-5 mb-5 fs-2 text-center">채팅방 만들기</h1>
		        <form class="chatModalForm" onsubmit="return createChatRoomForm()" action="/chat/create.do" method="post">
			        <div class="form-floating mb-3">
			            <input type="text" class="form-control rounded-3" id="floatingInput" placeholder="ff" name="title">
			            <label for="floatingInput">채팅방 이름</label>
			        </div>
		          	<h2 class="fs-5 mb-3 text-center">어떤 주제로 얘기하고 싶나요?</h2>
			         <div class="form-floating mb-3">
			            <select class="form-select" id="floatingSelectGrid" name="bigCategory" onchange="changeCategoryOptions()">
			                <option value="basis" selected>큰 분류</option>
			                <option value="value1">무거운 주제</option>
			                <option value="value2">가벼운 주제</option>
			            </select>
			            <label for="floatingSelectGrid">크게</label>
			         </div>
			         <div class="form-floating mb-3">
			          	<select class="form-select" id="smallSelectGrid" name="category">
			                <option value="basis" selected>세세한 분류</option>
			               
			            </select>
			            <label for="smallSelectGrid">작게</label>
			         </div>
		          	  <hr class="my-4">
		              <button class="w-100 mb-2 btn btn-lg rounded-3 btn-primary">입장하기</button>
	        	</form>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 끝 -->
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
					<div class="mb-2 d-flex gap-1">
						<div class="selectedBtn d-flex gap-1">
						  <!-- 선택된 버튼 들어갈 자리 -->
		
						</div>
						<a class="btn btn-outline-primary" id="resetBtn">
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
				<div class="mb-5 h3 ">
					<i class="bi bi-wechat"></i>
					다들 나만 빼고 재밌는 얘기 중...
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
				<div class="col-xl-3 col-sm-6" onclick="location.href='enter.do?idx=${item.idx}'">
				    <div class="card-shadow card">
				        <div class="card-body">
				        	<div class="fw-bold fs-5 mb-2 col-12 d-inline-block text-truncate">
				                ${ item.title }
				            </div>
				         
				            <div class="badge border text-dark border-success  rounded p-2 me-2 ps-3 pe-3 mb-2">
				                ${ item.category }
				            </div>
				
				            <div class="d-flex">
				                <div class="d-flex align-items-center me-3">
				                    <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
				                        <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
				                    </svg>
				                    <span class="ms-2">개설자 | ${memberNickname}</span>
				                </div>
				
				            </div>
				
				            <div class="" style="font-size: 14px;">
				                현재 <span class="text-primary">참여자수</span>명이 참여 중 이에요!
				            </div>
				        </div>
				    </div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>			
			</div>
		</main>
		
		<div class="mb-3" style="text-align: right;">
            <button class="btn btn-primary" data-bs-toggle="modal" id="createRoomBtn">방 만들기</button>
        </div>
	</div>
        
   <script>
		
   		/*  모달창  */ 
   		const createRoomBtn = document.getElementById("createRoomBtn");
		const closeModalBtn2 = document.getElementById("closeModalBtn2");
		createRoomBtn.addEventListener("click", function() {
			 createModal.classList.remove("d-none");
		});
		closeModalBtn2.addEventListener("click", function() {
		     createModal.classList.add("d-none");
		     location.reload();
		});
		
		//모달폼
		console.log("여기까진 왔니????");
		const chatModalForm = document.querySelector(".chatModalForm"); 
		function createChatRoomForm(){
			console.log("여기까진 왔니????");
			if(chatModalForm.title.value.length == 0){
				alert('채팅방 이름을 입력해 주세요.');
				//title창에 focus
				chatModalForm.title.focus();
				return false;
			} 
			if(chatModalForm.bigCategory.value.length == 0 || chatModalForm.bigCategory.value == "basis"){
				alert('큰 카테고리를 선택해 주세요.');
				//title창에 focus
				chatModalForm.bigCategory.focus();
				return false;
			}
			if(chatModalForm.smallCategory.value.length == 0 || chatModalForm.category.value == "basis"){
				alert('작은 카테고리를 선택해 주세요.');
				//title창에 focus
				chatModalForm.smallCategory.focus();
				return false;
			}
			
			chatModalForm.submit();
		}
		
		function changeCategoryOptions(){
			const bigCategorySelect = document.getElementById("floatingSelectGrid");
			const smallCategorySelect = document.getElementById("smallSelectGrid");
			
			if(bigCategorySelect.value == "basis" || bigCategorySelect.value == "" || bigCategorySelect.value == null ){
				console.log(bigCategorySelect.value);
				smallCategorySelect.innerHTML = `
		            <option value="basis" selected>세세한 분류</option>
		        `;
			}
			
			else if(bigCategorySelect.value == "value1") {
				console.log(bigCategorySelect.value);
				smallCategorySelect.innerHTML = `
					<option value="basis" selected>세세한 분류</option>
	                <option value="진로">진로</option>
	                <option value="돈">돈</option>
	            `;
			}
			else if(bigCategorySelect.value == "value2") {
				smallCategorySelect.innerHTML = `
					<option value="basis" selected>세세한 분류</option>
	                <option value="음식">음식</option>
	                <option value="옷">옷</option>
	            `;
			}
			
		}
		
		
		/*  모달창 끝 */
		
		/*  카테고리  */
		const popularTab = document.getElementById("popularTab");
		const bigWorryTab = document.getElementById("bigWorryTab");
		const smallWorryTab = document.getElementById("smallWorryTab");
		const allCategoryTab = document.getElementById("allCategoryTab");
		const bigCategories= document.getElementById("bigCategories").getElementsByTagName("a");
		const smallCategories= document.getElementById("smallCategories").getElementsByTagName("a");
		const selectedBtnTag= document.querySelector(".selectedBtn").getElementsByTagName("a");
		
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
					}else { //존재하지 않는다면 버튼 넣기
						selectedBtnSection.appendChild(cloneBtn);
						console.log("추가전 :"+Array.from(selectedBtnIds));
						selectedBtnIds.add(btnId);
						console.log("추가  :"+Array.from(selectedBtnIds));
					}
				});
			}
		}
		selectBtn();
		
		//초기화 버튼
		const resetBtn = document.getElementById("resetBtn");
		resetBtn.addEventListener("click", function(){
			for(const btnId of selectedBtnIds){
				selectedBtnSection.removeChild(document.getElementById(btnId+'-cloned'));
			}
			
			for (const btn of smallCategories){
				btn.classList.replace("btn-primary", "btn-outline-primary");
				
			}
			selectedBtnIds.clear();
			
		}) 
			
		/*  카테고리 끝*/
		
	</script>
	
	
	<%@ include file="../common/footer.jsp" %>
 
</body>
</html>
