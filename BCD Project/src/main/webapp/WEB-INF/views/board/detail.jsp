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
		.small-font {
			font-size: 12px;
			
		}
		.picked-label {
			line-height: 20px;
		}
		.modal-body p {
			margin-bottom: 0;
			line-height: 24px;
		}
	</style>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
</head>
<body>
	<%@ include file="../common/header.jsp" %>

	<div class="container d-flex justify-content-center mt-5 mb-5">
		<div class="w-75 mt-5">
			<!-- history.back -->
			<div class="d-flex justify-content-between">
				<button type="button" class="mb-3" style="border: none; background: none;" data-tooltip="뒤로 가기" onclick="location.href='${ referer }'">
					<i class="bi bi-chevron-left fs-2"></i>
				</button>
				
				<div>
					<button type="button" class="mb-3 ${ post.myPost == 'yes' ? '' : 'd-none'}" style="border: none; background: none;" onclick="location.href='/post/goEdit.do?idx=${ post.idx }'" data-tooltip="수정하기">
						<i class="bi bi-eraser-fill fs-2"></i>
					</button>
					<button type="button" class="mb-3 ${ post.myPost == 'yes' ? '' : 'd-none'}" style="border: none; background: none;" onclick="location.href='/post/delete.do?idx=${ post.idx }'" data-tooltip="삭제하기">
						<i class="bi bi-trash-fill fs-2 ms-3"></i>
					</button>
				</div>
			</div>
			
			<!-- post -->
			<div>
				<!-- 제목, 게시글 정보(작성자, 작성일, 조회수) -->
				<div class="border-bottom">
					<h1 class="fw-bold fs-1 mt-5">${ post.title }</h1>
					<h3 class="fs-6 mt-5 mb-5">
						<span>@@프사@@</span>
						<span class="me-3">${ post.writer }</span>
						
						<span class="me-3">${ post.createDate }</span>
						<span>${ post.views }</span>
					</h3>
				</div>
				
				<!-- 내용 (투표, 글 내용, 후기) -->
				<div>
					<!-- 
					1. 진행중 -> a. 작성자 / b. 참여자-참여전 / c. 참여자-참여후
					2. 마감
					네 가지 케이스로 분기하기 
					-->
					<!-- 투표 -->
					<div style="margin-top: 100px; margin-bottom: 150px;">
						<div class="border-bottom mb-5">
							<p class="fs-4 fw-bold d-flex align-items-center">
			                    <i class="bi bi-check2-square"></i>
			                    <span class="ms-2">Please pick one!</span>
		                	</p>
						</div>
						
						<form action="${vote == null ? '/vote/voted.do' : '/vote/cancle.do'}" method="post" id="voteForm">
							<div class="d-flex flex-column">
<c:if test="${ post.img1URL != null || post.img2URL != null }">
								<div class="w-75 m-auto p-1 d-flex justify-content-between align-items-end mb-5">
									<div class="" style="width: 40%"  data-tooltip="${ post.vote1ST }">
										<img src="${ post.img1URL }" class="float-start img-fluid img-thumbnail rounded">
									</div>
									<div class="" style="width: 40%" data-tooltip="${ post.vote2ND }">
										<img src="${ post.img2URL }" class="float-end img-fluid img-thumbnail rounded">
									</div>
								</div>
</c:if>
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
								
						
								<div class="border d-flex justify-content-between align-items-stretch w-75 m-auto" >
									<div id="voteA" class="d-flex p-4 bg-primary bg-opacity-25 ${vote.seleted == 'A' ? 'bg-opacity-50' : ''}" style="width: ${ post.probA == 0 && post.probB == 0 ? '50' : post.probA  }%;" data-tooltip="pick!" role="button">
										<p>
											<span class="picked-label border p-1 rounded bg-light ${vote.seleted == 'A' ? '' : 'd-none'}" style="font-size: 11px;">${vote.seleted == 'A' ? 'my pick!' : ''}</span>
											<br>
											${ post.vote1ST }
											<br>
											<span class="small-font">${ post.probA }%</span>
										</p>
									</div>
									<div id="voteB" class="text-end d-flex p-4 bg-warning bg-opacity-25 justify-content-end ${vote.seleted == 'B' ? 'bg-opacity-50' : ''}" style="width: ${ post.probA == 0 && post.probB == 0 ? '50' : post.probB }%;" data-tooltip="pick!" role="button">
										<p>
											<span class="picked-label text-end border p-1 rounded bg-light ${vote.seleted == 'B' ? '' : 'd-none'}" style="font-size: 11px;">${vote.seleted == 'B' ? 'my pick!' : ''}</span>
											<br>
											${ post.vote2ND }
											<br>
											<span class="small-font">${ post.probB }%</span>
										</p>
									</div>							
								</div>
								
								
								<input type="hidden" name="postIdx" value="${ post.idx }">
								<!-- TODO: 현재 접속자 idx from session -->
								<input type="hidden" name="memIdx" value="2">
								<!-- TODO: 게시글 작성자 idx from post (조기 마감 신청 시 현재 접속자 == 게시자 확인용) --> 
								<input type="hidden" name="writerIdx" value="${ post.memIdx }">
								<input type="hidden" name="seleted" id="selected" value="">
								
								<div class="btn-group w-75 m-auto rounded-bottom" role="group">
									<button type="button" id="voted" style="border-top-left-radius: 0; border-top-right-radius: 0;" 
											class="btn btn-primary p-3" ${ post.status == 'A' ? '' : ' disabled' }>${ post.status != 'A' ? '마감된 투표입니다.' : vote == null ? 'PICK IT!' : 'RETRY'}</button>
<c:if test="${ (post.myPost == 'yes') && (post.status == 'A') }">
									<button type="button" id="closed" style="border-top-left-radius: 0; border-top-right-radius: 0;" class="btn btn-outline-danger">즉시 마감</button>
</c:if>
								</div>
							</div>
						</form>

<c:if test="${ post.status != 'A' }">
						<div class="mt-5">
							<div class="w-75 m-auto p-4 border rounded d-flex align-items-center" id="resultMsg">
								<p class="fw-bold d-flex align-items-center mb-0">
									<span class="ms-2">
										최종 선택
									</span>
									<i class="bi bi-heart-arrow fs-4 ms-2 me-2 text-primary "></i>
									<span class="text-dark fw-light">
										${ ((post.probA == 0) && (post.probB == 0)) || ((post.probA == 50) && (post.probB == 50)) ? '결과 도출에 실패했어요.' : post.probA > 50 ? post.vote1ST : post.vote2ND }
									</span>
								</p>
							</div>
						</div>
</c:if>					
						
					</div>

					<!-- 글 내용 -->
					<div class="mt-5" style="margin-bottom: 150px;">
						<div class="border-bottom mb-5">
							<p class="fs-4 fw-bold d-flex align-items-center">
			                    <i class="bi bi-body-text"></i>
			                    <span class="ms-2">About the vote</span>
		                	</p>
						</div>
	                	
	                	<div>
							<p class="lh-lg p-3 m-0 text-break">
								${ post.content }
							</p>
	                	</div>
					</div>
					
<c:if test="${ post.status != 'A' }">
					<!-- 후기 -->
					<div class="mt-5" style="margin-bottom: 150px;">
						<div class="w-75 m-auto p-4 border rounded d-flex align-items-center justify-content-between">
	<c:choose>
		<c:when test="${ post.review == '' || post.review == null }">
							<p class="text-danger fw-bold d-flex align-items-center mb-0">
								<i class="bi bi-emoji-wink-fill fs-4"></i>
								<span class="ms-2">아직 작성된 후기가 존재하지 않아요!</span>
							</p>
			<c:if test="${ post.myPost == 'yes' }">
							<div>
								<button class="btn" data-tooltip="후기 작성하기!"  data-bs-toggle="modal" data-bs-target="#reviewModal">
									<i class="bi bi-pencil-square"></i>
								</button>
							</div>
			</c:if>	
		</c:when>
		<c:otherwise>
							<p class="d-flex align-items-center mb-0">
								<i class="bi bi-emoji-wink-fill fs-4 text-primary fw-bold"></i>
								<span class="ms-2 me-2 text-primary fw-bold">한 줄 후기 :</span>
								<span>${ post.review }</span>
							</p>
			<c:if test="${ post.myPost == 'yes' }">
							<div class="btn-group">
								<button class="btn" data-tooltip="후기 수정" data-bs-toggle="modal" data-bs-target="#reviewModal" id="reviewEditBtn">
									<i class="bi bi-eraser-fill"></i>
								</button>
								<button class="btn" data-tooltip="후기 삭제" id="reviewDelBtn" type="button">
									<i class="bi bi-trash-fill"></i>
								</button>
							</div>
			</c:if>	
		</c:otherwise>
	</c:choose>
						</div>
					</div>
</c:if>
					
				</div>
			</div>

			<!-- comment -->
			<div>
				<!-- 댓글 수 -->
				<div>
					<div class="border-bottom mb-5">
						<p class="fs-4 fw-bold d-flex align-items-center">
		                    <i class="bi bi-chat-right-dots-fill"></i>
		                    <span class="ms-2 commentTotal">${ post.commentCount }</span>
	                	</p>
					</div>
				</div>
				
				<!-- 댓글 입력 창 (본인 프로필 사진, 댓글 input, 등록 버튼 -->
				<div>
					<form id="commentWriteForm" action="/comment/insert.do" method="post" >
						<div class="input-group mb-3">
							<input type="hidden" name="postIdx" value="${ post.idx }">
							<textarea name="content" id="inputComment" class="form-control p-3" style="height: 150px; resize: none;" placeholder="댓글을 입력해 주세요!"></textarea>
							<button class="btn btn-outline-primary p-5" type="button" id="commentWriteBtn">작성</button>
						</div>
					</form>
				</div>

				<!-- 해당 글에 작성되어 있는 댓글 불러오기 (작성자 닉네임, 프로필 사진, 작성일, 댓글 내용 + 수정/삭제 버튼) -->

<c:choose>
	<c:when test="${empty comment}">
				<div class="mt-5 text-center">
					<p>등록된 댓글이 존재하지 않습니다.</p>
					<p><span class="fw-bold text-primary">첫 번째</span>로 댓글을 남겨 볼까요?</p>					
				</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${comment}">
				<div class="mt-5 border-bottom pb-3 comment">
					<div class="d-flex align-items-center justify-content-between">
						<div class="d-flex align-items-center">
							<img src="https://url.kr/rsihxp" class="rounded-circle" style="width: 50px;">
							<p class="m-0 fw-bold fs-5 lh-1 ms-2">
								${ item.nickname }
								<br>
								<span class="text-secondary fs-6 fw-light">${ item.createDate }</span>
							</p>
						</div>

						<div class="${ item.memIdx != memberIdx ? 'd-none' : '' }">
							<a class="text-decoration-none me-2 pe-auto commentEditBtn">
								수정
							</a>
							<a class="text-decoration-none pe-auto commentDelBtn">
								삭제
							</a>
						</div>
						
					</div>
					<input type="hidden" value="${ item.idx }" class="commentIdx">
					<div class="mt-2">
						<p class="lh-lg m-0 text-break commentContent">${ item.content }</p>
					</div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>		
			</div>
		</div>
	</div>
	
	<!-- 후기 작성 modal -->
	<div class="modal fade" tabindex="-1" id="reviewModal">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					 <img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/> 
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body" id="typingText">
					
					<div class="text-center mb-3">
						<p class="fs-3 fw-bold animate__animated animate__backInDown" >
							<span class="text-primary">${ post.writer }</span>님,
						</p>
						<p class="fw-bold animate__animated animate__backInDown mb-2" style="animation-delay: 0.7s;" >
							<span class="text-primary">${ post.subCategory }</span> 관련해서<br>
							<span class="text-primary fw-bold fs-5">" ${ post.voteTitle } "</span>에 대해 고민 중이셨군요!
						</p>
						
						<p class="animate__animated animate__backInDown" style="animation-delay: 1.3s;">
							<span class="text-primary fw-bold fs-5">${ post.writer }</span>님의 고민에 
						</p>

						<p class="animate__animated animate__backInDown mb-2" style="animation-delay: 2.0s;">
							무려 <span class="text-primary fw-bold fs-5">${ post.voteCount }</span>명이 동참해 주셨어요!
						</p>

						<p class="animate__animated animate__backInDown mb-2" style="animation-delay: 2.7s;">
							이제 투표 진행 <span class="text-primary">결과</span>를 말씀드릴게요.
						</p>
						
						<p class="animate__animated animate__backInDown" style="animation-delay: 3.2s;">
							과연..!!
						</p>

						<p class="animate__animated animate__bounceIn fs-5 mb-2" style="animation-delay: 4.5s;">
							두구두구..
						</p>

						<p class="animate__animated animate__bounceIn fw-bold fs-3 mb-2 text-primary" style="animation-delay: 5.2s;  animate-repeat: 5;">
							<i class="bi bi-heart-pulse"></i>
						</p>
						
						<div id="resultMsgInModal" class="m-auto p-2 border rounded d-flex align-items-center mb-2 mt-1 text-center 
								 animate__animated animate__zoomInUp" style="animation-delay: 6.0s;"></div>
						
						<p class="animate__animated animate__backInDown" style="animation-delay: 7.2s;">
							투표 결과는 <span class="text-primary">마음</span>에 드셨나요?
						</p>
						
						<p class="animate__animated animate__backInDown mb-2" style="animation-delay: 8.0s;">
							결과를 <span class="text-primary">참고</span>해서 <span class="text-primary fw-bold">좋은 선택</span>을 하실수 있었으면 좋겠어요!
						</p>
					</div>
					
					<div>	
						<form id="reviewForm" action="/post/review.do" method="post">
							<input type="hidden" name="idx" value="${ post.idx }">
							<input type="hidden" name="reviewMode" id="reviewMode" value="write">
							<textarea name="review" id="inputReview" class="form-control p-3  animate__animated animate__bounceInLeft" 
									  style="animation-delay: 9.2s; height: 150px; resize: none;" 
									  placeholder="간단한 후기를 입력해 주세요!"
									  >${ (post.review == "") || (post.review == null) ? "" : post.review }</textarea>
						</form>
					</div>
				</div>
				<div class="modal-footer animate__animated animate__bounceInRight" style="animation-delay: 9.2s;">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="reviewFormBtn">작성</button>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
	
	<script>
		<!-- 페이지 로드될 때 실행 -->
		$(document).ready(function() {
			
			<!-- 리뷰(modal) 관련 -->			
			// 모달 최초 접속 확인용 변수(애니메이션 유무 체크)
			let isFirstModalLoad = true;
			let isReviewEditMode = false;
			
			// 리뷰 삭제
			$("#reviewDelBtn").click(function() {
				// SweetAlert2 알림창 띄우기
				Swal.fire({
					icon: 'question',
					title: 'Really?',
					text: '정말 삭제하시겠습니까?',
					showCancelButton: true,
					confirmButtonText: '예',
					cancelButtonText: '아니오',
					confirmButtonColor: '#0d6efd',
					cancelButtonColor: '#d33',
				}).then((result) => {
					if (result.isConfirmed) {
				        // 폼 제출
				        $("#reviewMode").val("del");
						$("#reviewForm").submit();
					} else {
						// 사용자가 "아니오"를 눌렀을 때의 동작
						// TODO: 여기에 추가하고자 하는 동작을 추가
					}
				});
			});
			
			// 리뷰 수정
			// 모달 수정 창으로 재활용하기 위해 . . => 수정 버튼 클릭 시 애니메이션 제거 
			$("#reviewEditBtn").click(function() {
				isFirstModalLoad = false;
				$("#reviewFormBtn").text("수정");
				$("#reviewMode").val("edit");
			});
			
			// 모달 창 실행 시
			$("#reviewModal").on('shown.bs.modal', function() {
				console.log($(".animate__animated"));
				if (!isFirstModalLoad) {
					$(".animate__animated").removeClass("animate__backInDown");
					$(".animate__animated").removeClass("animate__zoomInUp");
					$(".animate__animated").removeClass("animate__bounceIn");
					$(".animate__animated").removeClass("animate__bounceInLeft");
					$(".animate__animated").removeClass("animate__bounceInRight");
				}
				isFirstModalLoad = false;
			})
			
			// 모달 창 안으로 투표 집계 결과 보내기
			let resultMsg =  $("#resultMsg").html();
			$("#resultMsgInModal").html(resultMsg);
			
			// modal 내 리뷰 form 전송 버튼
			$("#reviewFormBtn").click(function() {
				// 리뷰 내용 (#inputReview) null 체크
				let reviewContent = $("#inputReview").val();
		    	
		    	if (!reviewContent) {
		    		Swal.fire({
                		icon: 'error', 
                		title: 'error', 
                		text: '리뷰 내용을 입력해 주세요!'
                	});
		    		return;
		    	}
		    	
		    	// 글자수 제한 (최대 300 자)
		    	let maxReviewLength = 300;
		    	if (reviewContent.length > maxReviewLength) {
		    		Swal.fire({
                		icon: 'error', 
                		title: 'error', 
                		text: '리뷰는 최대 ' + maxReviewLength + '자까지 입력 가능합니다!'
                	});
		    		return;
		    	}
		    	
				$("#reviewForm").submit();
			});
			
			
	
			
			<!-- 투표 관련 -->
		    $("#voteA, #voteB").click(function() {
				if (!$(this).hasClass("bg-opacity-50")) {
					// 선택되지 않은 요소는 선택 상태로 변경
					$(this).addClass("bg-opacity-50").attr("data-tooltip", "selected");
					// 다른 요소는 선택되지 않은 상태로 변경
					$(this).siblings().removeClass("bg-opacity-50").attr("data-tooltip", "pick!");
					
	                // 선택한 값 설정
	                var selectedValue = $(this).attr("id") === "voteA" ? "A" : "B";
	                $("#selected").val(selectedValue);
				} else {
					// 이미 선택된 요소를 다시 클릭한 경우, 선택 해제
					$(this).removeClass("bg-opacity-50").attr("data-tooltip", "pick!");
					
					// 선택한 값 초기화
	                $("#selected").val("");
				}
		    });
		    
		    if ($("#voted").text() !== "PICK IT!") {
		        // "다시 하기" 버튼일 때 --> 클릭 이벤트 비활성화
		        $("#voteA, #voteB").off('click').removeAttr("data-tooltip").removeAttr("role");
		    }
		    
			$("#voted").click(function() {
				if ($("#voted").text() === "PICK IT!") {
		            if ($("#selected").val() === "") {
		                // 선택하지 않은 경우 알림창 띄우기
		                Swal.fire({
		                    icon: 'warning',
		                    title: 'Please choose',
		                    text: '투표 항목을 선택해 주세요!',
		                    confirmButtonText: '확인',
		                    confirmButtonColor: '#0d6efd',
						});
		            } else {
		                // 선택한 경우 폼 제출
		                $("#voteForm").submit();
		            }
				} else {
	                $("#voteForm").submit();					
				}
			});
			
			$("#closed").click(function() {
				// SweetAlert2 알림창 띄우기
				Swal.fire({
					icon: 'question',
					title: 'Really?',
					text: '정말 마감하시겠습니까?',
					showCancelButton: true,
					confirmButtonText: '예',
					cancelButtonText: '아니오',
					confirmButtonColor: '#0d6efd',
					cancelButtonColor: '#d33',
				}).then((result) => {
					if (result.isConfirmed) {
				        // 폼 제출
						document.getElementById("voteForm").action = "/post/earlyClosed.do";
						document.getElementById("voteForm").submit();
					} else {
						// 사용자가 "아니오"를 눌렀을 때의 동작
						// TODO: 여기에 추가하고자 하는 동작을 추가
					}
				});
			});
			
			
			// 수정 화면에서 취소 누르면 돌아가기 위해 기존 내용 저장할 변수 선언
		    let previousContent;

			// 댓글 작성
			$("#commentWriteBtn").click(function() {
				// 리뷰 내용 (#inputReview) null 체크
				let commentContent = $("#inputComment").val();
			    	
				if (!commentContent) {
					Swal.fire({
						icon: 'error', 
						title: 'error', 
						text: '댓글 내용을 입력해 주세요!'
					});
					return;
				}
			    	
				// 글자수 제한 (최대 300 자)
				let maxCommentLength = 300;
				if (commentContent.length > maxCommentLength) {
					Swal.fire({
						icon: 'error', 
						title: 'error', 
						text: '댓글은 최대 ' + maxCommentLength + '자까지 입력 가능합니다!'
					});
					return;
				}
				$("#commentWriteForm").submit();
			});

		    // 댓글 수정 창 내에서 저장 OR 취소 시 사용할 함수
		    let commentUpdate = function(action, inputElement) {
		        const commentDiv = inputElement.closest('.comment');
		        const inputGroup = commentDiv.find('.input-group');
		        const contentElement = $('<p class="lh-lg m-0 text-break commentContent"></p>');

		        if (action === "수정") {
		            // input과 버튼이 있는 그룹을 p 요소로 변경
		            contentElement.text(inputElement.val());
		        } else if (action === "취소") {
		            // 이전 댓글 내용으로 복원
		            contentElement.text(previousContent);
		        }

		        inputGroup.replaceWith(contentElement);

		        // 기존 수정/삭제 버튼들을 보여줌
		        commentDiv.find('.commentEditBtn, .commentDelBtn').show();
		    }

		    // 댓글 수정
			$(".commentEditBtn").on("click", function() {
				const commentDiv = $(this).closest('.comment');
		        const contentElement = commentDiv.find('.commentContent');

		        // 이전 댓글 내용 저장
		        previousContent = contentElement.text();

		        // 댓글 내용을 input 요소로 변경
		        const inputElement = $('<input type="text" class="edit-input form-control text-start" name="content" />');
		        inputElement.val(contentElement.text());

		        // 저장, 취소 버튼 추가
		        const saveButton = $('<button class="btn btn-outline-secondary updateCommentBtn" type="button">저장</button>');
		        const cancelButton = $('<button class="btn btn-outline-secondary updateCancelBtn" type="button">취소</button>');

		        // input과 버튼을 하나의 그룹으로 묶기 위해 div 요소 생성
		        const inputGroup = $('<div class="input-group mb-3"></div>');
		        inputGroup.append(inputElement);
		        inputGroup.append(saveButton);
		        inputGroup.append(cancelButton);

		        // p 요소를 input과 버튼이 있는 그룹으로 교체
		        contentElement.replaceWith(inputGroup);

		        // 기존 수정/삭제 버튼들을 숨김
		        commentDiv.find('.commentEditBtn, .commentDelBtn').hide();

		        // 댓글 수정 화면에서 "저장" 버튼 누른 경우
		        $('.updateCommentBtn').click(function() {
		            const commentContent = inputElement.val();
		            const commentDiv = $(this).closest('.comment');
		            const commentIdx = commentDiv.find('.commentIdx').val();
		            
					// 댓글 내용 (#inputElement) null 체크
		            	
		        	if (!commentContent) {
		        		Swal.fire({
		        			icon: 'error', 
		        			title: 'error', 
		        			text: '댓글 내용을 입력해 주세요!'
		        		});
		        		return;
		        	}
		            	
		        	// 글자수 제한 (최대 300 자)
		        	let maxCommentLength = 300;
		        	if (commentContent.length > maxCommentLength) {
		        		Swal.fire({
		        			icon: 'error', 
		        			title: 'error', 
		        			text: '댓글은 최대 ' + maxCommentLength + '자까지 입력 가능합니다!'
		        		});
		        		return;
		        	}

		            const commentData = {
		                idx: commentIdx,
		                content: commentContent
		            };

		            $.ajax({
		                type: 'POST',
		                url: '/comment/edit.do',
		                contentType: 'application/json',
		                data: JSON.stringify(commentData),
		                success: function(res) {
		                	if (res === 'success') {
		                		commentUpdate("수정", inputElement);
	                        }
		                	Swal.fire({
		                		icon: res, 
		                		title: res, 
		                		text: res == 'success' ? '성공적으로 수정되었습니다!' : '수정에 실패하였습니다.'
		                	});
		                },
		                error: function(error) {
		                    console.log("에러 발생");
		                }
		            });
		        });

		        // 댓글 수정 화면에서 "취소" 버튼 누른 경우
		        $('.updateCancelBtn').click(function() {
		            commentUpdate("취소", inputElement);
		        });
		    });
			
			$(".commentDelBtn").on("click", function() {
		        const commentDiv = $(this).closest('.comment');
		        const commentIdx = commentDiv.find('.commentIdx').val();

		        // SweetAlert로 확인창 생성
		        Swal.fire({
		            title: "댓글 삭제",
		            text: "정말 삭제하시겠습니까?",
		            icon: "warning",
		            showCancelButton: true,
		            confirmButtonColor: "#3085d6",
		            cancelButtonColor: "#d33",
		            confirmButtonText: "예",
		            cancelButtonText: "아니오"
		        }).then((result) => {
		            // 사용자가 확인 버튼을 눌렀을 경우
		            if (result.isConfirmed) {
		                // 서버로 댓글 삭제 요청 보내기
		                $.ajax({
		                    type: 'POST',
		                    url: '/comment/delete.do',
		                    data: {idx: parseInt(commentIdx)},
		                    success: function(res) {
		                        if (res === 'success') {
		                        	commentDiv.remove();
		                            // 댓글 삭제 후 댓글 토탈 카운트 갱신
		                            const commentTotalElement = $('.commentTotal'); // 댓글 토탈 카운트가 표시된 요소 선택
		                            const currentCount = parseInt(commentTotalElement.text());
		                            const updatedCount = currentCount - 1;
		                            commentTotalElement.text(updatedCount);
		                        }
		                        
			                	Swal.fire({
			                		icon: res, 
			                		title: res, 
			                		text: res == 'success' ? '성공적으로 삭제되었습니다!' : '댓글 삭제에 실패하였습니다.'
			                	});
			                	
		                    },
		                    error: function(error) {
		                        console.log("댓글 삭제 실패");
		                    }
		                });
		            }
		        });
		    });
		});
	</script>
</body>
</html>