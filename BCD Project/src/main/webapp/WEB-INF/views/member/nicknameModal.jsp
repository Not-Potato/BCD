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
	                    	<span class="invalid-feedback" id="nicknameValidation" style="display:none"></span><!-- 닉네임 유효성 체크 -->
	                    	<span class="invalid-feedback" id="nicknameStatus" style="display:none"></span><!-- 닉네임 중복 여부 체크 -->            		      
	            	</form>
	            	
	        	</div> 
	        	  	   
	        	 <div class="text-center mt-5">
	        		<button type="button" class="btn btn-dark fs-5 pl-4 pr-4" onclick="return submitNickname()">다음</button>
	      		</div>	
			</div>
    		
		</div>
	</div>
</div>

<%@ include file="../member/idpwModal.jsp" %>
<script>
//page.2 닉네임  
//엔터 제출 방지 
	function preventFormSubmission(event) {
	    if (event.key === "Enter") {
	        event.preventDefault();
	    }
	}
	document.getElementById("inputNickname").addEventListener("keydown", preventFormSubmission);
	document.getElementById("inputId").addEventListener("keydown", preventFormSubmission);
	document.getElementById("inputPw").addEventListener("keydown", preventFormSubmission);
//end of 엔터 제출 방지 


	// 닉네임 모달창 열기 
	const phoneRegisterBtn = document.getElementById("phoneRegisterBtn"); //변수명 변경하기
	const closeModalNickname = document.getElementById("closeModalNickname");

	phoneRegisterBtn.addEventListener("click", function() {
 	modalSignin.classList.add("d-none"); //modalSignin 닫기
 	modalNickname.classList.remove("d-none"); // modalNickname 열기
 });
   
 closeModalNickname.addEventListener("click", function() {
 	  modalNickname.classList.add("d-none");// modalNickname 닫기
       location.reload();
 });
 
		
		 var isValidNickname = true;
		
		//닉네임 유효성 검사
		$(document).ready(function() {
		$("#inputNickname").on("input", function() {
        	var nickname = $(this).val();
        	var nicknameValidation = $("#nicknameValidation"); // 닉네임 유효성 메시지 요소

	        // 닉네임 유효성 검사
	        if (nickname !== "") {
	            const regex = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/; //2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성 (한글 초성 및 모음은 허가하지 않는다.)
	            if (!regex.test(nickname)) {		  
	                nicknameValidation.css("display", "block");
	                nicknameValidation.text("2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성해주세요.");
	                nicknameValidation.css("color", "red");
	                isValidNickname = false;
	            } else {
	                nicknameValidation.css("display", "none"); // 유효성 메시지 숨기기
	                isValidNickname = true;
	            }
	        } else {
	            nicknameValidation.css("display", "block"); // 유효성 메시지 숨기기
                nicknameValidation.text("닉네임을 입력해주세요.");
                nicknameValidation.css("color", "red");
                isValidNickname = false;
	        }
		});
	});
				
		function submitNickname() {		
		 var nickname = $("#inputNickname").val();
	     var nicknameStatus = $("#nicknameStatus");
			     
	    		 // 입력값이 비어있는 경우 서밋 막기
			     if (nickname === "" || !isValidNickname) {
			         return false; // 폼의 기본 제출 동작 막기
			     }
			     
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
                  		  	
					         moveToNextPage(nickname);
                  			
				
						} else if(resultNumber > "0") {
	                      	  	nicknameStatus.css("display", "block");
	                            nicknameStatus.text("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.");
	                            nicknameStatus.css("color", "red");
	                      		return;
                  		
	            		} 
						 else {
	            			 nicknameStatus.css("display", "none");	
	            			return;
	            		}
						 
					},
					error : function(result)  {
						alert("오류가 발생했습니다! 처음부터 다시 진행해주세요!");
						
						return;
					}
				});	

				return false; //폼의 기본 제출 동작 막기
		}		
		
		function moveToNextPage(nickname) {
		    document.getElementById("nicknamePlaceholder").innerText = nickname;   
		    document.getElementById("modalNickname").classList.add("d-none"); // modalNickname 닫으면서
		    document.getElementById("modalIdPw").classList.remove("d-none"); // modalIdPw 열기
		}


</script>

</body>
</html>