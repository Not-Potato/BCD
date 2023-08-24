<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">
<head>
	<%@ include file="../common/head.jsp" %>
	<!-- card css -->
	<link rel="stylesheet" href="../../resources/css/common/card.css" />
	<style>
	    body {
	    	height:100%;
	    }
		.container{
			height:70%;
		}
		.hidden {
			display: none;
		}
		
	</style>
</head>
<body>
	<%@ include file="../common/header.jsp" %>

	<div class="container">
		
		<hr class="mt-5 mb-4" style="color:#a1acb7">
		<div class="mb-5 mt-5 h3 ">
			<i class="bi bi-file-earmark-text"></i>
			내가 무슨 글을 썼더라...?
		</div>

		<!-- board list -->
		<main>
			<div class="row" id=cardContainer>
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
				<div class="col-xl-3 col-sm-6 post" role="button" onclick="location.href='/board/detail.do?idx=${item.idx}';">
				    <div class="card-shadow card">
				        <div class="card-body">
				            <div class="mb-2">
				            	<input type="hidden" value="${ item.createDate }" class="createDate">
				            	<input type="hidden" value="${ item.deadline }" class="deadline">
				            	<input type="hidden" value="${ item.status }" class="status">
				            	<input type="hidden" value="${ item.review eq null ? 'no' : 'yes' }" class="review">
				                <div class="badge bg-primary text-wrap rounded p-2 me-1 d-none new-label">
				                    ✨New!
				                </div>
				                <div class="badge bg-primary bg-opacity-75 text-wrap rounded p-2 me-1 d-none ing-label">
				                    ing
				                </div>	                
				                <div class="badge bg-danger bg-opacity-75 text-wrap rounded p-2 me-1 d-none deadline-label">
				                    final
				                </div>
				                <div class="badge bg-secondary bg-opacity-75 text-wrap rounded p-2 me-1 d-none close-label">
				                    closed
				                </div>	                
				                <div class="badge bg-secondary bg-opacity-75 text-wrap rounded p-2 me-1 d-none early-close-label">
				                    early closed
				                </div>	                
				                <div class="badge bg-dark bg-opacity-75 text-wrap rounded p-2 me-1 d-none review-label">
				                    review
				                </div>	                
				            </div>
				
				            <div class="fs-6 text-secondary mb-2">
				                마감일 | <span>${ item.deadline }</span>
				            </div>
				
				            <div class="fw-bold fs-5 mb-2 col-12 d-inline-block text-truncate">
				                ${ item.title }
				            </div>
				
				            <div class="badge border border-primary border-opacity-50 text-dark text-wrap rounded p-2 me-2 mb-2">
				                ${ item.subCategory }
				            </div>
				
				            <div class="d-flex  mb-2">
				                <div class="d-flex align-items-center me-3">
				                    <img src="${ item.profile }" class="rounded-circle" style="width: 28px;">
				                    <span class="ms-2">${ item.writer }</span>
				                </div>
				
				                <div class="d-flex align-items-center">
				                    <i class="bi bi-chat-right-dots-fill"></i>
				                    <span class="ms-2">${ item.commentCount }</span>
				                </div>
				
				            </div>
				
				            <div class="" style="font-size: 14px;">
				                현재 <span class="text-primary fw-bold">${ item.voteCount }</span>명이 투표에 참여했어요!
				            </div>
				        </div>
				    </div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>			
			</div>
		</main>
		<div class="mb-3 d-flex justify-content-center">
   	        <button type="button" class="btn btn-link" id="nextMyListBtn">더보기</button> 
        	<input type="hidden" value="${pi.endPage}" id="endPage">
	    </div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
	
<script>
		// 날짜 포매팅
		function getToday(){
			var date = new Date();
			var year = date.getFullYear();
			var month = ("0" + (1 + date.getMonth())).slice(-2);
			var day = ("0" + date.getDate()).slice(-2);
			
			return year + "-" + month + "-" + day;
		}
		
	// 최초에 화면 로드 시
	$(document).ready(function() {
		// 인기 카테고리 중복 건 삭제
		const duplicateElements = {};
		
		const allElements = $('#smallCategories a');
		
		allElements.each(function() {
			const text = $(this).text(); // 요소의 내용 가져오기
			if (duplicateElements[text]) {
				// 중복된 요소가 이미 있는 경우 삭제
				$(this).remove();
			} else {
				// 중복되지 않은 경우 객체에 추가
				duplicateElements[text] = true;
			}
		});
		
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
		
		// 더보기 버튼
		const nextMyListBtn = $("#nextMyListBtn");
		   
		let	myPage = 1;
		let	myEndPage = 1;
		
		 $.ajax({
		        url: "/board/myList.do?cpage=" + (myPage + 1), // 다음 페이지로 요청을 보냅니다.
		        method: "GET",
		        success: function(response){
		            myEndPage = $(response).find("#endPage").val();
		            
		            if (myEndPage <= myPage) {
		                nextMyListBtn.hide(); // 첫 페이지에서는 버튼을 숨깁니다.
		            } else {
		                nextMyListBtn.show(); // 첫 페이지에서는 다음 페이지가 있으므로 버튼을 표시합니다.
		            }
		        },
		        error: function() {
		            nextMyListBtn.hide();
		        }
		    });

		
		nextMyListBtn.click(function(){
			myPage++;
			console.log("myPage"+myPage);
			
			$.ajax({
				url:"/board/myList.do?cpage="+myPage,
				method:"GET",
				success: function(response){
					//page++;
					const content = $(response).find("#cardContainer").html();
				    myEndPage = $(response).find("#endPage").val();
				 	console.log("myEndPage:"+myEndPage);
					if(myEndPage <= myPage){
						nextMyListBtn.hide();
					}
					$("#cardContainer").append(content);
					
					// 각 데이터를 처리하는 함수를 호출합니다.
					$('.post').each(function() {
						const createDate = $(this).find('.createDate').val();
						const deadline = $(this).find('.deadline').val();
						const status = $(this).find('.status').val();
						const review = $(this).find('.review').val();
						
						console.log(createDate, deadline, status, review);
						
						processPost.call(this, createDate, deadline, status, review);
					});
				}
			})
		});
	});
	
	</script>
</body>
</html>