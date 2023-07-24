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

<<<<<<< HEAD
					<button type="button" id="loginBtn">로그인</button>
					<a href="#" class="d-flex align-items-center btn btn-primary">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-door-open" viewBox="0 0 16 16">
							<path d="M8.5 10c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1z"/>
							<path d="M10.828.122A.5.5 0 0 1 11 .5V1h.5A1.5 1.5 0 0 1 13 2.5V15h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V1.5a.5.5 0 0 1 .43-.495l7-1a.5.5 0 0 1 .398.117zM11.5 2H11v13h1V2.5a.5.5 0 0 0-.5-.5zM4 1.934V15h6V1.077l-6 .857z"/>
						</svg>
=======
					<!-- <button type="button" id="phoneRegisterBtn">로그인</button> -->

					<button type="button" class="d-flex align-items-center btn btn-primary" id="phoneRegisterBtn">
						<i class="bi bi-door-open"></i>
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git
						<span class="ms-1">로그인</span>
<<<<<<< HEAD
					</a>

=======
					</button>
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git
                </li>
            </ul>
        </div>
    </div>
    <%@ include file="../member/loginModal.jsp" %>
  	
 
</header>