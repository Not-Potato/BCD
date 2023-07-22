<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="../common/head.jsp" %>
	<style>
	    /* datetime-local 입력 창 내의 달력 아이콘 크기와 위치를 조절 */
	    input[type="datetime-local"]::-webkit-calendar-picker-indicator {
	        transform: scale(2.0); 
	        position: relative;
	        top: -6px;
	        right: 5px;
	    }
	</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<div class="container d-flex justify-content-center mt-5 mb-5">
        <div class="w-75 mt-5">
        	<form action="insert.do" method="post">
	            <div class="mb-5">
	                <p class="fs-4 fw-bold d-flex align-items-center">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-1-square-fill" viewBox="0 0 16 16">
	                        <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm7.283 4.002V12H7.971V5.338h-.065L6.072 6.656V5.385l1.899-1.383h1.312Z"/>
	                    </svg>
	                    <span class="ms-2">투표 기본 정보를 입력해 주세요</span>
	                </p>
	                <hr>
	                
	                <!-- 첫 번째 줄 ( 대분류 / 소분류 ) -->
	                <div class="row g-2 mb-3">
	                    <div class="col-md">
	                        <div class="form-floating">
	                            <select name="mainCategory" class="form-select" id="mainCategorySelect" aria-label="대분류 그룹">
	                                <option value="" selected disabled>✧˳⁺⁎₊✧˚˳⁺⁎₊𝙋𝙡𝙚𝙖𝙨𝙚 𝙘𝙝𝙤𝙤𝙨𝙚₊⁎⁺˳˚✧₊⁎⁺˳✧</option>
	                                <option value="메인카테고리1">One</option>
	                                <option value="메인카테고리2">Two</option>
	                                <option value="메인카테고리3">Three</option>
	                            </select>
	                            <label for="mainCategorySelect">대분류</label>
	                        </div>
	                    </div>
	
	                    <div class="col-md">
	                        <div class="form-floating">
	                            <select name="subCategory" class="form-select" id="subCategorySelect" aria-label="소분류 그룹">
	                                <option value="" selected disabled>✧˳⁺⁎₊✧˚˳⁺⁎₊𝙋𝙡𝙚𝙖𝙨𝙚 𝙘𝙝𝙤𝙤𝙨𝙚₊⁎⁺˳˚✧₊⁎⁺˳✧</option>
	                                <option value="서브카테고리1">One</option>
	                                <option value="서브카테고리2">Two</option>
	                                <option value="서브카테고리3">Three</option>
	                            </select>
	                            <label for="subCategorySelect">소분류</label>
	                        </div>
	                    </div>
	                </div>
	                
	                <!-- 두 번째 줄 ( 투표 제목 / 마감일 ) -->
	                <div class="row g-2">
	                    <div class="col-md">
	                        <div class="form-floating mb-3">
	                            <input name="voteTitle" type="text" class="form-control" id="voteTitle" placeholder="투표 제목을 입력해 주세요">
	                            <label for="voteTitle">투표 제목</label>
	                        </div>
	                    </div>
	
	                    <div class="col-md">
	                        <div class="form-floating mb-3">
	                            <input name="deadline" type="datetime-local" class="form-control" id="datetime-local" placeholder="마감일">
	                            <label for="datetime-local">마감일</label>
	                        </div>
	                    </div>
	                </div>
	
	                <!-- 세 번째 줄 ( 항목1 ) -->
	                <div class="div">
	                    <div class="form-floating mb-3 position-relative">
	                        <input name="vote1ST" type="text" class="form-control" id="vote1ST" placeholder="선택지 1">
	                        <label for="vote1ST">선택지 1</label>
	                        
	                        <div class="input-group">
	                            <label class="position-absolute end-0 bottom-0 pb-2 pe-3  text-black-50" style="cursor: pointer;" for="upload1">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
	                                    <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
	                                    <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
	                                </svg>
	                            </label>
	                            <input type="file" class="form-control d-none" id="upload1">
	                        </div>
	                    </div>
	
	                    <div class="form-floating mb-3">
	                        <input name="vote2ND" type="text" class="form-control" id="vote2ND" placeholder="선택지 2">
	                        <label for="vote2ND">선택지 2</label>
	
	                        <div class="input-group">
	                            <label class="position-absolute end-0 bottom-0 pb-2 pe-3 text-black-50" style="cursor: pointer;" for="upload2">
	                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
	                                    <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
	                                    <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
	                                </svg>
	                            </label>
	                            <input type="file" class="form-control d-none" id="upload2">
	                        </div>
	                    </div>
	
	                </div>
	            </div>
	
	
	            <div>
	                <p class="fs-4 fw-bold d-flex align-items-center">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-2-square-fill" viewBox="0 0 16 16">
	                        <path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2Zm4.646 6.24v.07H5.375v-.064c0-1.213.879-2.402 2.637-2.402 1.582 0 2.613.949 2.613 2.215 0 1.002-.6 1.667-1.287 2.43l-.096.107-1.974 2.22v.077h3.498V12H5.422v-.832l2.97-3.293c.434-.475.903-1.008.903-1.705 0-.744-.557-1.236-1.313-1.236-.843 0-1.336.615-1.336 1.306Z"/>
	                    </svg>
	                    <span class="ms-2">투표에 대해 설명해 주세요!</span>
	                </p>
	                <hr>
	
	                <div class="form-floating mb-3">
	                    <input name="title" type="text" class="form-control" id="title" placeholder="제목">
	                    <label for="title">제목</label>
	                </div>
	
	                <div class="form-floating">
	                    <textarea name="content" class="form-control" placeholder="Leave a comment here" id="floatingTextarea2" style="height: 400px; resize: none;"></textarea>
	                    <label for="floatingTextarea2">내용</label>
	                </div>
	            </div>
	
	            <div class="mt-3 d-flex justify-content-center">
	                <button class="btn btn-outline-danger me-2 ps-3 pe-3" onclick="history.back()">취소</button>
	                <button class="btn btn-primary ps-3 pe-3" type="submit" >작성</button>
	            </div>
	    	</form>
        </div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>