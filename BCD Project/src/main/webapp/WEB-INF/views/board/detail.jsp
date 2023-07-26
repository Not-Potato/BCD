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
	</style>
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
			                    <span class="ms-2">골라 줘!</span>
		                	</p>
						</div>
						
						<form action="${vote == null ? '/vote/voted.do' : '/vote/cancle.do'}" method="post" id="voteForm">
							<div class="d-flex flex-column">
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
							<div class="w-75 m-auto p-4 border rounded d-flex align-items-center">
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
			                    <span class="ms-2">투표 소개</span>
		                	</p>
						</div>
	                	
	                	<div>
							<p class="lh-lg p-3 m-0 text-break">
								${ post.content }
							</p>
	                	</div>
					</div>
					

					<!-- 
					후기가
					1. 있는 경우 a. 작성자인 경우(수정/삭제) / b. 작성자가 아닌 경우(read only)
					2. 없는 경우 a. 작성자인 경우(작성) / b. 작성자가 아닌 경우(업습니다)
					네 가지 케이스로 분기하기 
					-->
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
								<button class="btn" data-tooltip="후기 작성하기!">
									<i class="bi bi-pencil-square"></i>
								</button>
							</div>
		</c:if>	
	</c:when>
	<c:otherwise>
							<p class="text-primary fw-bold d-flex align-items-center mb-0">
								<i class="bi bi-emoji-wink-fill fs-4"></i>
								<span class="ms-2">후기:</span>
								<span>${ post.review }</span>
							</p>
		<c:if test="${ post.myPost == 'yes' }">
							<div class="btn-group">
								<button class="btn" data-tooltip="후기 수정">
									<i class="bi bi-eraser-fill fs-2"></i>
								</button>
								<button class="btn" data-tooltip="후기 삭제">
									<i class="bi bi-trash-fill fs-2 ms-3"></i>
								</button>
							</div>
		</c:if>	
	</c:otherwise>
</c:choose>
							
						</div>
					</div>
				</div>
			</div>

			<!-- comment -->
			<div>
				<!-- 댓글 수 -->
				<div>
					<div class="border-bottom mb-5">
						<p class="fs-4 fw-bold d-flex align-items-center">
		                    <i class="bi bi-chat-right-dots-fill"></i>
		                    <span class="ms-2">${ post.commentCount }</span>
	                	</p>
					</div>
				</div>
				
				<!-- 댓글 입력 창 (본인 프로필 사진, 댓글 input, 등록 버튼 -->
				<div>
					<form id="commentWriteForm" action="/comment/insert.do" method="post" >
						<div class="input-group mb-3">
							<input type="hidden" name="postIdx" value="${ post.idx }">
							<textarea name="content" class="form-control p-3" style="height: 150px; resize: none;" placeholder="댓글을 입력해 주세요!"></textarea>
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
				<div class="mt-5 border-bottom pb-3">
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
							<a class="text-decoration-none me-2 pe-auto" href="#">
								수정
							</a>
							<a class="text-decoration-none pe-auto" href="#">
								삭제
							</a>
						</div>
						
					</div>
					
					<div class="mt-2">
						<p class="lh-lg m-0 text-break">
							${ item.content }
						</p>
					</div>
				</div>
		</c:forEach>
	</c:otherwise>
</c:choose>		
			</div>
		</div>
	</div>
	
	<%@ include file="../common/footer.jsp" %>
	
	<script>
		$(document).ready(function() {
			
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
			
			$("#commentWriteBtn").click(function() {
				$("#commentWriteForm").submit();
			});
		});
	</script>
</body>
</html>