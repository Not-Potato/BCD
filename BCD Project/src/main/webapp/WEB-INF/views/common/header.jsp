<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
					<input type="text" class="form-control" placeholder="검색어를 입력해 주세요!" >
					<button class="btn btn-outline-secondary d-flex align-items-center " type="button" id="button-addon2">
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
                <li>
	               <button type="button" class="d-flex align-items-center btn btn-primary" id="loginBtn">
	                  <i class="bi bi-door-open"></i>
	                  <span class="ms-1">로그인</span>
	               </button>
                </li>
            </ul>
        </div>
    </div>
    <%@ include file="../member/loginModal.jsp" %>
  	
 
</header>