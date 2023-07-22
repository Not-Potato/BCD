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
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
					</button>
				</div>
            </div>

			<!-- MENU -->
            <ul class="nav justify-content-center mb-md-0 ">
				<li class="me-3">
					<a href="/post/write.do" class="d-flex align-items-center btn btn-outline-primary" >
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
							<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
							<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
						</svg>
						<span class="ms-1">새 글 쓰기</span>
					</a>
                </li>
                <li>
<<<<<<< HEAD
					<button type="button" id="phoneRegisterBtn">로그인</button>
=======
					<a href="#" class="d-flex align-items-center btn btn-primary">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-door-open" viewBox="0 0 16 16">
							<path d="M8.5 10c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1z"/>
							<path d="M10.828.122A.5.5 0 0 1 11 .5V1h.5A1.5 1.5 0 0 1 13 2.5V15h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V1.5a.5.5 0 0 1 .43-.495l7-1a.5.5 0 0 1 .398.117zM11.5 2H11v13h1V2.5a.5.5 0 0 0-.5-.5zM4 1.934V15h6V1.077l-6 .857z"/>
						</svg>
						<span class="ms-1">로그인</span>
					</a>
>>>>>>> branch 'master' of https://github.com/Not-Potato/BCD-BACK.git
                </li>
            </ul>
        </div>
    </div>
    <%@ include file="../member/register.jsp" %>
  	
 
</header>