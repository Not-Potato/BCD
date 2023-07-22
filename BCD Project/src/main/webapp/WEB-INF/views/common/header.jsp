<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header>
	<div class="container mt-3 mb-4">
		<div class="d-flex flex-wrap align-items-center justify-content-between">
		
			<!-- LOGO -->
			<a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
				<img src="../../../resources/images/logo.svg" alt="BCD LOGO" style="width: 130px;" />
			</a>

			<!-- SEARCH -->
            <form class="col-4">
				<input type="search" class="form-control" placeholder="검색어를 입력해 주세요!">
            </form>

			<!-- MENU -->
            <ul class="nav justify-content-center mb-md-0">
				<li class="me-3">
					<a>새 글 쓰기</a>
                </li>
                <li>
					<button type="button" id="phoneRegisterBtn">로그인</button>
                </li>
            </ul>
        </div>
    </div>
    <%@ include file="../member/register.jsp" %>
  	
 
</header>