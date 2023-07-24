<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="../common/head.jsp" %>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<div class="container d-flex justify-content-center mt-5 mb-5">
        <div class="w-75 mt-5">
        	<form action="insert.do" method="post">
	            <div class="mb-5">
	                <p class="fs-4 fw-bold d-flex align-items-center">
	                    <i class="bi bi-1-square-fill"></i>
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
	                            <label class="position-absolute end-0 bottom-0 pe-3 text-black-50" style="cursor: pointer;" for="upload1">
	                                <i class="bi bi-image fs-1"></i>
	                            </label>
	                            <input type="file" class="form-control d-none" id="upload1">
	                        </div>
	                    </div>
	
	                    <div class="form-floating mb-3">
	                        <input name="vote2ND" type="text" class="form-control" id="vote2ND" placeholder="선택지 2">
	                        <label for="vote2ND">선택지 2</label>
	
	                        <div class="input-group">
	                            <label class="position-absolute end-0 bottom-0 pe-3 text-black-50" style="cursor: pointer;" for="upload2">
	                                <i class="bi bi-image fs-1"></i>
	                            </label>
	                            <input type="file" class="form-control d-none" id="upload2">
	                        </div>
	                    </div>
	
	                </div>
	            </div>
	
	
	            <div>
	                <p class="fs-4 fw-bold d-flex align-items-center">
	                    <i class="bi bi-2-square-fill"></i>
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
	                <button class="btn btn-outline-danger me-2 ps-3 pe-3" type="button" onclick="location.href='${ referer }'">취소</button>
	                <button class="btn btn-primary ps-3 pe-3" type="submit" >작성</button>
	            </div>
	    	</form>
        </div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
</body>
</html>