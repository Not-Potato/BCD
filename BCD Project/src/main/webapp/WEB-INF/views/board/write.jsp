<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="../common/head.jsp" %>
	<style>
		#voteA, #voteB {
			min-width: 30%; /* 최소 너비 값으로 원하는 크기를 지정합니다. */
		}
		#voteA p, #voteB p {
			margin-bottom: 0;
		}
	</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	
	<div class="container d-flex justify-content-center mt-5 mb-5">
        <div class="w-75 mt-5">
        	<form action=${ post.idx == null || post.idx == "" ? '/post/insert.do' : '/post/update.do' } method="post" id="postForm" >
	            <div class="mb-5">
	                <p class="fs-4 fw-bold d-flex align-items-center">
	                    <i class="bi bi-1-square-fill"></i>
	                    <span class="ms-2">
	                    	${ post.idx == null || post.idx == "" ? '투표 기본 정보를 입력해 주세요' : '기존 투표 정보를 조회합니다' }
	                    </span>
	                </p>
	                <hr>
	                
<c:choose>
	<c:when test="${ not empty post }">
							<input type="hidden" name="idx" value="${ post.idx }">
							<div class="d-flex flex-column mt-5 mb-5">
								<div class="w-75 m-auto p-1 d-flex justify-content-between">
									<p class="mb-0 text-muted">현재까지 <span class="text-primary fw-bold">${ post.voteCount } 명</span>이 투표에 참여했어요!</p>
		<c:choose>
			<c:when test="${ post.status == 'C' }">
									<p class="mb-0 text-muted text-decoration-line-through" data-tooltip="사용자의 요청으로 조기 마감되었습니다!">${ post.deadline }까지</p>
			</c:when>
			<c:otherwise>
									<p class="mb-0 text-muted" >${ post.deadline }까지</p>
			</c:otherwise>
		</c:choose>
								</div>
								<div class="border border-bottom-0 rounded-top d-flex justify-content-between align-items-center w-75 m-auto" style="height: 50px; padding: 10px;" >
									<p class="fs-4 fw-bold mb-0">${ post.voteTitle }</p>
									<p class="mb-0">${ post.subCategory }</p>
								</div>
								
						
								<div class="border d-flex justify-content-between align-items-stretch w-75 m-auto rounded-bottom" >
									<div id="voteA" class="d-flex p-4 bg-primary bg-opacity-25 ${vote.seleted == 'A' ? 'bg-opacity-50' : ''}" style="width: ${ post.probA == 0 && post.probB == 0 ? '50' : post.probA  }%;" >
										<p>
											<span class="picked-label border p-1 rounded bg-light ${vote.seleted == 'A' ? '' : 'd-none'}" style="font-size: 11px;">${vote.seleted == 'A' ? 'my pick!' : ''}</span>
											<br>
											${ post.vote1ST }
											<br>
											<span class="small-font">${ post.probA }%</span>
										</p>
									</div>
									<div id="voteB" class="text-end d-flex p-4 bg-warning bg-opacity-25 justify-content-end ${vote.seleted == 'B' ? 'bg-opacity-50' : ''}" style="width: ${ post.probA == 0 && post.probB == 0 ? '50' : post.probB }%;">
										<p>
											<span class="picked-label text-end border p-1 rounded bg-light ${vote.seleted == 'B' ? '' : 'd-none'}" style="font-size: 11px;">${vote.seleted == 'B' ? 'my pick!' : ''}</span>
											<br>
											${ post.vote2ND }
											<br>
											<span class="small-font">${ post.probB }%</span>
										</p>
									</div>							
								</div>
								
								<p class="w-75 m-auto text-center fs-5 text-danger mt-2">
									※ ${ post.status == 'A' ? '투표는 수정할 수 없습니다.' : '이미 마감된 투표입니다.' } 
								</p>
							</div>
	</c:when>
	
	<c:otherwise>
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
		
	</c:otherwise>
</c:choose>
	                
	            </div>
	
	
	            <div>
	                <p class="fs-4 fw-bold d-flex align-items-center">
	                    <i class="bi bi-2-square-fill"></i>
	                    <span class="ms-2">투표에 대해 설명해 주세요!</span>
	                </p>
	                <hr>
	
	                <div class="form-floating mb-3">
	                    <input name="title" type="text" class="form-control" id="title" placeholder="제목" value="${ post.title }">
	                    <label for="title">제목</label>
	                </div>
	
	                <div class="form-floating">
	                    <textarea name="content" class="form-control" placeholder="내용을 입력해 주세요" id="content" style="height: 400px; resize: none;">${ post.content }</textarea>
	                    <label for="floatingTextarea2">내용</label>
	                </div>
	            </div>
	
	            <div class="mt-3 d-flex justify-content-center">
	                <button class="btn btn-outline-danger me-2 ps-3 pe-3" type="button" onclick="location.href='${ referer }'">취소</button>
	                <button class="btn btn-primary ps-3 pe-3" type="button" id="submitButton">${ post.idx == null || post.idx == "" ? '작성' : '수정' }</button>
	            </div>
	    	</form>
        </div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
	<script>
/* 		// error - sweetAlert 함수 선언
		function errorAlert(message) {
			Swal.fire({
				icon: 'error',
				title: 'error',
				text: message
			});
		} */
		
		// SweetAlert 함수 선언
		function showAlert(icon, title, message) {
			Swal.fire({
				icon: icon,
				title: title,
				text: message
			});
		}
		
		// 사용자 입력값과 제한 글자수를 체크하는 함수
		function validateInput(inputValue, maxLength, fieldName) {
			// 입력값이 null 또는 빈 문자열인 경우
			if (!inputValue) {
				showAlert('error', 'Error', fieldName + '을(를) 입력해 주세요.');
				return false;
			}
		
			// 입력값의 글자수가 최대 글자수를 초과하는 경우
			if (inputValue.length > maxLength) {
				showAlert('error', 'Error', fieldName + '은(는) 최대 ' + maxLength + '자까지 입력 가능합니다!');
				return false;
			}
		
			// 유효한 입력값인 경우
			return true;
		}

		
		$(document).ready(function() {
			// submitButton 변수에 할당
			const $submitButton = $("#submitButton");
			
			// 폼 제출 시
			$submitButton.click(function() {
				let mainCategory = $("#mainCategorySelect").val();
				let subCategory = $("#subCategorySelect").val();
				let voteTitle = $("#voteTitle").val();
				let deadline = $("#datetime-local").val();
				let vote1ST = $("#vote1ST").val();
				let vote2ND = $("#vote2ND").val();
				let title = $("#title").val();
				let content = $("#content").val();
			
				// '작성'인 경우에만 투표 관련 필드 체크
				if ($submitButton.text() === '작성') {
					if (!validateInput(mainCategory, 100, '대분류')) return;
					if (!validateInput(subCategory, 100, '소분류')) return;
					if (!validateInput(voteTitle, 100, '투표 제목')) return;
					if (!validateInput(deadline, 100, '마감일')) return;
					if (!validateInput(vote1ST, 30, '선택지 1번 항목')) return;
					if (!validateInput(vote2ND, 30, '선택지 2번 항목')) return;
				}
			
				// title과 content 체크
				if (!validateInput(title, 100, '제목')) return;
				if (!validateInput(content, 3000, '내용')) return;
			
				// 모든 필드가 유효하면 폼 제출
				$("#postForm").submit();
			});
		});
		
		
/* 		// 폼 제출 시
		$("#submitButton").click(function() {
			const $submitButton = $("#submitButton");
			
			let mainCategory = $("#mainCategorySelect").val();
			let subCategory = $("#subCategorySelect").val();
			let voteTitle = $("#voteTitle").val();
			let deadline = $("#datetime-local").val();
			let vote1ST = $("#vote1ST").val();
			let vote2ND = $("#vote2ND").val();
			let title = $("#title").val();
			let content = $("#content").val();
			
			// '작성'인 경우에만 투표 관련 필드 체크
			if ($submitButton.text() === '작성') {
				if (!mainCategory) {
					errorAlert("대분류를 선택해 주세요.");
					return;
				}
				
				if (!subCategory) {
					errorAlert("소분류를 선택해 주세요.");
					return;
				}
				
				if (!voteTitle) {
					errorAlert("투표 제목을 입력해 주세요.");
					return;
				}
				
				if (!deadline) {
					errorAlert("마감일을 입력해 주세요.");
					return;
				}
				
				if (!vote1ST) {
					errorAlert("선택지 1을 입력해 주세요.");
					return;
				}
				
				if (!vote2ND) {
					errorAlert("선택지 2를 입력해 주세요.");
					return;
				}
			}

			// title과 content 체크
			if (!title) {
				errorAlert("제목을 입력해 주세요.");
				return;
			}
			
			if (!content) {
				errorAlert("내용을 입력해 주세요.");
				return;
			}
			
			// 모든 필드가 유효하면 폼 제출
			$("#postForm").submit();
		}); */
	</script>
</body>
</html>