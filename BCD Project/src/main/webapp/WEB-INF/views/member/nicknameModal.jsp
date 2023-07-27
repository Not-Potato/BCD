<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	

<!DOCTYPE html>
<html lang="ko" class="h-100">

<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>

<body>
<!-- 닉네임 2/3page -->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalNickname">
   	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">
		     
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalNickname"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		        <h1 class="fw-bold mt-5 mb-2 fs-2 text-center">BCD에 처음 오셨군요!</h1>
            	<h1 class="fw-bold mb-5 fs-2 text-center">우선, 사용하실 닉네임을 설정해 볼까요?</h1>
            
            
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 	
		        	 	<form class="centered text-center form-floating" style="width: 75%;">
		                    	<input type="text" class="form-control" id="inputNickname" name="nickname" placeholder="Nickname" style="margin: 0 auto;" pattern="[A-Za-z0-9ㄱ-ㅎㅏ-ㅣ가-힣]+";> 
		                    	<label for="inputNickname">Nickname</label>   	                   
		            	</form>
		          </div>    	
		            	<div class="row">
		            		<p class="invalid-feedback text-center m-0" id="nicknameValidation" style="display:none"></p><!-- 닉네임 유효성 체크 -->	   
		           			<p class="invalid-feedback text-center m-0" id="nicknameStatus" style="display:hidden"></p><!-- 닉네임 중복 여부 체크 -->		      
		           		</div>
	            	

	        	 <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        		<button type="button" id="nextBtn" class="btn btn-dark fs-5 pl-4 pr-4" onclick="return submitNickname()" data-tooltip="">다음</button>
	      		</div>	
	      		       	 
			</div>
   		
		</div>
	</div>
</div>

<script>
//page.2 닉네임  

	var nickname = $("#inputNickname").val();
    var nicknameStatus = $("#nicknameStatus");
	var isValidNickname = false; //정규식 컨트롤
	var isDuplicateNickname = false; //중복 컨트롤 

//엔터 제출 방지 	     
	function preventFormSubmission(event) {
	    if (event.key === "Enter") {
	        event.preventDefault();
	    }
	}
	document.getElementById("inputNickname").addEventListener("keydown", preventFormSubmission);
//end of 엔터 제출 방지 



	// 닉네임 모달창 열기 
//	const phoneRegisterBtn = document.getElementById("phoneRegisterBtn"); //변수명 변경하기
	const closeModalNickname = document.getElementById("closeModalNickname");

  /*   phoneRegisterBtn.addEventListener("click", function() {
 	modalSignin.classList.add("d-none"); //modalSignin 닫기
 	modalNickname.classList.remove("d-none"); // modalNickname 열기
 	});  */
   
 	 closeModalNickname.addEventListener("click", function() {
	 	  modalNickname.classList.add("d-none");// modalNickname 닫기
	       location.reload();
	 });
  

		//닉네임 유효성 검사
		$(document).ready(function() {
		$("#inputNickname").on("input", function() {
        		nickname = $(this).val();
        	var nicknameValidation = $("#nicknameValidation"); // 닉네임 유효성 메시지 요소

        	const regex = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/; //2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성 (한글 초성 및 모음은 허가하지 않는다.)
	       
        	// 닉네임 유효성 검사
	        if (nickname !== "") {
	            //const regex = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/; //2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성 (한글 초성 및 모음은 허가하지 않는다.)
	            if (!regex.test(nickname)) {		  
	                nicknameValidation.css("display", "block");
	                nicknameValidation.text("2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성해주세요.");
	                nicknameValidation.css("color", "red");
	                isValidNickname = false;
	       hideNicknameStatus(); // 중복 여부 문구 숨기기
	            } else {
	                nicknameValidation.css("display", "none"); // 유효성 메시지 숨기기
	                isValidNickname = true;
	                
	                $.ajax({// 닉네임 중복 검사
						type :"post",
						async : true,
						url : "/member/nicknameCheck.do",	
						data : {
							nickname : nickname
						},
						success : function(result) {
							console.log(result);
							  var resultNumber = parseInt(result);
							if(resultNumber === 0) {	
								 nicknameStatus.css("display", "block");
								 nicknameStatus.text("사용 가능한 닉네임입니다.");
						         nicknameStatus.css("color", "green");
						         isDuplicateNickname = true;
						  
							} else if(resultNumber > 0) {
		                      	  	nicknameStatus.css("display", "block");
		                            nicknameStatus.text("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.");
		                            nicknameStatus.css("color", "red");
		                            isDuplicateNickname = false;
		                      		return;
		              		
		            		} 
							 else {
		            			 nicknameStatus.css("display", "none");	
		            			 isDuplicateNickname = false;
		            			return;
		            		}
							 
						},
						error : function(result)  {
							alert("오류가 발생했습니다! 처음부터 다시 진행해주세요!");
							hideNicknameStatus(); // 중복 여부 문구 숨기기
							return false; //폼의 기본 제출 동작 막기
						}
					});
 
	           	}

	        } else {
	             nicknameValidation.css("display", "block"); // 유효성 메시지 숨기기
                nicknameValidation.text("닉네임을 입력해주세요.");
                nicknameValidation.css("color", "red");
                isValidNickname = false;        
	        }        
	        
		});
	});
		
		
		// 사용자에게 닉네임 상태 메시지를 숨기는 함수
		function hideNicknameStatus() {
		    var nicknameStatus = $("#nicknameStatus");
		    nicknameStatus.css("display", "none");
		}
		
		 //다음 버튼
		 function submitNickname() {		
    		 // 입력값이 비어있는 경우 서밋 막기
		     if (nickname == "" || !isValidNickname || !isDuplicateNickname) {
		
		    	 	var nextBtn = document.getElementById("nextBtn"); // 버튼 요소 가져오기
		    	 	nextBtn.setAttribute("data-tooltip", "에러메세지를 확인해주세요");
		    	 
		    	 	 // 마우스가 버튼을 떼었을 때 툴팁을 숨김
		         	 nextBtn.addEventListener("mouseleave", function() {
		             nextBtn.setAttribute("data-tooltip", "");
		        	 });
		    	 
		    	 return false; // 폼의 기본 제출 동작 막기
		    	 
		     } else {
		    	 
		    	 moveToNextPage(nickname); //다음 모달창으로 이동 
		    	 return true;
		     }
		}	 
		
			function moveToNextPage(nickname) {
	    		document.getElementById("nicknamePlaceholder").innerText = nickname;   
	    		document.getElementById("modalNickname").classList.add("d-none"); // modalNickname 닫으면서
	    		document.getElementById("modalIdPw").classList.remove("d-none"); // modalIdPw 열기
			}

</script>

<%@ include file="../member/idpwModal.jsp" %>

</body>
</html>