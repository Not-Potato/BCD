<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>	
		document.addEventListener("DOMContentLoaded", function() {	
			const snsLogin = "${snsLogin}"; 
			const modalNickname = document.getElementById("modalNickname");
			const welcomeModal = "${welcomeModal}"; 
			const modalWelcome = document.getElementById("modalWelcome"); 
			
			// 소설로그인 회원인증 후 BCD 사이트 돌아와 회원가입 마무리(nickname만 쓰면 회원가입 마무리임) 			
			if (snsLogin !== "") {
				modalNickname.classList.remove("d-none"); // 모달 열기
			} 		
			    
			// 소셜로그인 성공모달 	
			if (welcomeModal !== "") {
				modalWelcome.classList.remove("d-none"); // 모달 열기
			} 	 
		}); 
</script>

<header>
	<div class="container mt-3 mb-4 ">
		<div class="row d-flex align-items-center">
		
			<!-- LOGO -->
			<a href="/" class="col-md-3 col-12 text-center text-md-left mb-3 mb-md-0">
				<img src="../../../resources/images/logo.svg" alt="BCD LOGO" style="width: 130px;" />
			</a>

			<!-- SEARCH -->
<!--             <form class="col-4">
				<input type="search" class="form-control" placeholder="검색어를 입력해 주세요!">
            </form> -->
            <div class="col-md-5 col-12 text-md-center text-center mb-3 mb-md-0">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="검색어를 입력해 주세요!" id="searchInput">
					<button class="btn btn-outline-secondary d-flex align-items-center " type="button" id="searchBtn">
						<i class="bi bi-search"></i>
					</button>
				</div>
            </div>

			<!-- MENU -->
            <ul class="col-md-4 col-12 d-flex justify-content-center justify-content-md-end align-items-center mb-0">
				<li class="me-2">
					<button type="button" onclick="location.href='/post/write.do'" class="d-flex align-items-center btn btn-outline-primary" >
						<i class="bi bi-pencil-square"></i>
						<span class="ms-1">새 글</span>
					</button>
                </li>
<c:choose>     
	<c:when test="${ !empty memberIdx}">     
		<!-- 로그인 상태일때 -->      
				<li>
		           <div class="dropdown-center">
		  				<button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			   				<i class="bi bi-door-closed-fill"></i>
			   				<span class="ms-1">내 정보</span>
		  				</button>
						  <ul class="dropdown-menu">
						    <li><a class="dropdown-item" href="/board/myList.do">활동내역</a></li>
						    <li><a class="dropdown-item" href="/member/mypage.do">마이페이지</a></li>
						    <li><a class="dropdown-item" href="/member/logout.do">로그아웃</a></li>
						  </ul>
					</div>			
				</li>		
    </c:when>
    <c:otherwise>      
    	<!-- 비로그인 상태일때 -->            
				<li>
					<button type="button" class="d-flex align-items-center btn btn-primary" id="loginBtn">
						<i class="bi bi-door-open"></i>
						<span class="ms-1">로그인</span>		
					</button>
                </li>
    </c:otherwise>
</c:choose>                
            </ul>
        </div>
    </div>

    <%@ include file="../member/loginModal.jsp" %> 
    <%@ include file="../member/welcomeModal.jsp" %>


<script>
	<!--로그인 유무 확인 후 로그인 버튼 기능-->
  	const loginBtn = document.getElementById("loginBtn"); 
  	 if (loginBtn) {	
	  	loginBtn.addEventListener("click", function() {
	  		modalSignin.classList.remove("d-none"); //modalSignin 열기
    	}); 
  	 }
  	 
  	 <!-- search -->
  	 
  	$(document).ready(function(){
  	 const searchInput = $("#searchInput");
  	 const searchBtn = $("#searchBtn");
  	 const searchNextPageBtn = $("#searchNextPageBtn");
  	 const nextPageBtn = $("#nextPageBtn");
  	 

  	  let searchPage = 1;
  	  let searchEndPage = 1; // endPage 초기화

  	
  	 
  	 //엔터 검색
  	 searchInput.on("keydown", (event)=>{
  		 if(event.key == "Enter"){
  			 searchPage = 1;
  			 search();
  			 
  		 }
  	 })
  	 //버튼 검색 
  	  searchBtn.click (function(){
  	    searchPage = 1;
  	 	search();
  	 	
  	 	
  	  });
  	 
  	  //더보기 버튼
	  searchNextPageBtn.click(function(){
		 searchPage++;
		 search();
		 
	 }); 
  	 
  	 
  	function search(){
  		
  		nextPageBtn.hide();
  		
  		
  		const searchTxt = searchInput.val().toUpperCase();
  		//page = 1;
  		if(searchTxt == "" || searchTxt == null ){
  			return;
  		}
  		//현재 경로 가져오기
  		let searchUrl; // 변수선언
  		const currentUrl = window.location.href;
  		
  		//chat에서 검색
  		if(currentUrl.includes("/chat/")){ 
  			
  			searchUrl = "http://localhost:8080/chat/list.do";
  				
		//board에서 검색
  		}else if (currentUrl.includes("/board/") || currentUrl === "http://localhost:8080/"){
  			
  			searchUrl = "http://localhost:8080/board/list.do";
  			
  		} 
  		if(!currentUrl.endsWith("/list.do")) {
				location.href = searchUrl+"?searchTxt="+searchTxt;
			//	window.location.assign(searchUrl + "?searchTxt=" + searchTxt);
		} 
  		
  		$.ajax({
  			url : searchUrl,
  			method:"GET",
  			data:{searchTxt : searchTxt,
  				  cpage : searchPage},
  			success:function(response){
  				
  				console.log("url:"+window.location.href);
  				console.log(searchPage+"searchPage");
  			//	if(!currentUrl.endsWith("/list.do")) {
  	  		//		location.href = searchUrl+"?searchTxt="+searchTxt;
  				//	window.location.assign(searchUrl + "?searchTxt=" + searchTxt);
  	  		//	} 
  				console.log("진짜:"+searchUrl+"?searchTxt="+searchTxt);
  				const searchEndPage = $(response).find("#endPage").val();
  				const searchContent = $(response).find("#cardContainer").html();
  				
  				if(searchPage==1){
	  				$("#cardContainer").empty();
  				} 
  				
  				console.log("aaaaaaaaaaaaaaaa"+searchEndPage);
  				console.log("aaaaaaaaaaaaaaaa"+searchPage);
  				console.log("IF"+searchEndPage<=searchPage);
  				
  				
				if(searchEndPage<=searchPage){
	 				searchNextPageBtn.hide(); 
	 			} else {
	 				console.log("else")
	 				searchNextPageBtn.show(); // 다음 페이지가 있을 때는 더보기 버튼을 보여줌
	 					
 				}
 				$("#cardContainer").append(searchContent);
 				console.log("ajaxendPage:"+searchEndPage);
 				console.log("ajaxpage:"+searchPage);
	 				
	 		//검색결과 뱃지 	
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
 				
 				// 각 데이터를 처리하는 함수를 호출합니다.
				$('.post').each(function() {
					const createDate = $(this).find('.createDate').val();
					const deadline = $(this).find('.deadline').val();
					const status = $(this).find('.status').val();
					const review = $(this).find('.review').val();
					
					console.log(createDate, deadline, status, review);
					
					processPost.call(this, createDate, deadline, status, review);
				}); 
 				
				/* if(!currentUrl.endsWith("/list.do")) {
		  			location.href = searchUrl+"?searchTxt="+searchTxt;
					//	window.location.assign(searchUrl + "?searchTxt=" + searchTxt);
		  			
		 		}  */
	 			
			}
  			
  		});
  		  
  	 };
  	
  	 
  	});
  	 
  	 
</script>
 
</header>