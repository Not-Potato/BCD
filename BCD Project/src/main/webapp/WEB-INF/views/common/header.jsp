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
	<div class="container mt-3 mb-4">
		<div class="d-flex flex-wrap align-items-center justify-content-between">
		
			<!-- LOGO -->
			<a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				<img src="../../../resources/images/logo.svg" alt="BCD LOGO" style="width: 130px;" />
			</a>

			<!-- SEARCH -->
<!--             <form class="col-4">
				<input type="search" class="form-control" placeholder="검색어를 입력해 주세요!">
            </form> -->
            <div class="col-4">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="검색어를 입력해 주세요!" id="searchInput">
					<button class="btn btn-outline-secondary d-flex align-items-center " type="button" id="searchBtn">
						<i class="bi bi-search"></i>
					</button>
				</div>
            </div>

			<!-- MENU -->
            <ul class="nav justify-content-center mb-md-0 ">
				<li class="me-3">
					<button type="button" onclick="location.href='/post/write.do'" class="d-flex align-items-center btn btn-outline-primary" >
						<i class="bi bi-pencil-square"></i>
						<span class="ms-1">새 글 쓰기</span>
					</button>
                </li>
<c:choose>     
	<c:when test="${ !empty memberIdx}">     
		<!-- 로그인 상태일때 -->      
           <div class="dropdown-center">
  				<button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
	   				<i class="bi bi-door-closed-fill"></i>
	   				<span class="ms-1">내 정보</span>
  				</button>
				  <ul class="dropdown-menu">
				    <li><a class="dropdown-item" href="#">활동내역</a></li>
				    <li><a class="dropdown-item" href="/member/mypage.do">마이페이지</a></li>
				    <li><a class="dropdown-item" href="/member/logout.do">로그아웃</a></li>
				  </ul>
				</div>			
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
  	 
  	 searchBtn.click(function(){
  		 console.log("search버튼 ");
  		 
  		const searchTxt = searchInput.val();
  		console.log("txt:"+searchTxt);

  		
  		if(searchTxt == "" || searchTxt == null ){
  			return;
  		}
  		
  		let url;
  		const currentUrl = window.location.href;
  		console.log("currentUrl:"+currentUrl);
  		console.log("currentUrl??:"+currentUrl.includes("/chat/"));
  		
  		
  		if(currentUrl.includes("/chat/")){
  			url = "http://localhost:8080//chat/list.do?searchTxt="
  					console.log("url:"+url+searchTxt);
  		}else {
  			url = "http://localhost:8080//board/list.do?searchTxt="
  		}
  		
  		$.ajax({
  			url : url+searchTxt,
  			method:"GET",
  			
  			success:function(response){
  				console.log("성공");
  				$("#cardContainer").empty();
  				const searchContent = $(response).find("#cardContainer").html();
  				console.log(searchContent);
  				$("#cardContainer").append(searchContent);
  			}
  		});
  		 
  		 
  	 });
  	 
  	});
  	 
  	 
  	 
  	 
  	 
  	 
  	 
  	 
  	 
  	 
  	 
</script>
 
</header>