<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">

<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>

<body>
<!--ID/PWD  -- 3/3page-->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalIdPwLogin">
   	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">
		     
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalIdPwLogin"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		        <h1 class="fw-bold mt-5 mb-2 fs-2 text-center">어서오세요!</h1>
		        <h1 class="fw-bold mb-2 fs-2 text-center"> BCD 이용을 위해 로그인 해주세요! </h1>
            
            
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 	<form method="post" class="centered text-center form-floating" style="width: 75%;" id="idPwFormLogin" action="/member/phoneLogin.do" >
	        	 		<div class="form-floating mb-3">	
	                    	<input type="text" class="form-control" id="inputIdLogin" name="id" placeholder="ID" style="margin: 0 auto;"> 
	                    	<label for="inputIdLogin">ID</label>
	                    	 <p class="invalid-feedback text-center m-0" id="idValidationStatusLogin" style="display:none"></p><!--id 유효성검사-->	   	
   	
	                    
	                    </div>
	                   
	                    <div class="form-floating mb-3 mt-3">
	                    	<input type="password" class="form-control" id="inputPwLogin" name="pwd" placeholder="Password" style="margin: 0 auto;"> 
	                    	<label for="inputPw">Password</label>  
	                    	  <p class="invalid-feedback text-center m-0" id="pwdValidationStatusLogin" style="display:hidden"></p><!--pwd 유효성 검사 --> 
	                 	</div>	 
	                   	   		                   	                          		      
	        	  
	            	</form>
	        	</div> 
	        	
	        	  	   
	        	 <div class="text-center mt-5">
	        		<button type="button" id="loginFormSubmitBtn" class="btn btn-dark fs-5 pl-4 pr-4" onclick= "return submitIdpwLogin()">로그인</button>
	      		</div>	
			</div>
    		
		</div>
	</div>
</div>



<script>
//page.3 idpw  

	var idLogin = $("#inputIdLogin").val();
	var pwdLogin = $("#inputPwLogin").val();	
	var idValidationStatusLogin = $("#idValidationStatusLogin"); // 아이디 유효성 결과


	var isValidIdLogin = false; //id 유효성검사
	var isValidPwdLogin = false // pwd 유효성검사
	
	//엔터 제출 방지 
	function preventFormSubmission(event) {
	    if (event.key === "Enter") {
	        event.preventDefault();
	    }
	}
	document.getElementById("inputIdLogin").addEventListener("keydown", preventFormSubmission);
	document.getElementById("inputPwLogin").addEventListener("keydown", preventFormSubmission);
	//end of 엔터 제출 방지 
	
	
	// idpw 모달창 닫기 
	const closeModalIdPwLogin = document.getElementById("closeModalIdPwLogin");

	closeModalIdPwLogin.addEventListener("click", function() {
	   modalIdPwLogin.classList.add("d-none");// modalNickname 닫기
       location.reload();
	 });
 
	
		// id 검사
		$(document).ready(function() {
			$("#inputIdLogin").on("input", function() {
				idLogin = $(this).val();
					
				const idregLogin = /^(?=.*[a-zA-Z0-9])[a-zA-Z0-9]{2,16}$/; //2자 이상 16자 이하, 영어,숫자로 구성
				
				// id유효성 검사
				if (idLogin !== "") {		
						if (!idregLogin.test(idLogin)) {
							idValidationStatusLogin.css("display", "block");
							idValidationStatusLogin.text("2~16자 사이 영문,숫자로 구성해주세요.");
							idValidationStatusLogin.css("color", "red");
							isValidIdLogin = false;						
							
						} else {
							idValidationStatusLogin.css("display", "none"); // 유효성 메시지 숨기기
							isValidIdLogin = true;							
	
						 } 
				
				} else {
					idValidationStatusLogin.css("display", "block");
					idValidationStatusLogin.text("ID를 입력해주세요.");
					idValidationStatusLogin.css("color", "red");
					isValidIdLogin = false;
					return;
					}			
				});// end of on input	
			});// end of ready document
		
		
	// pwd 검사
		$(document).ready(function() {
			$("#inputPwLogin").on("input", function() {
						pwdLogin = $ (this).val();
					var pwdValidationStatusLogin = $("#pwdValidationStatus");
					const pwdregLogin = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/; //영문 숫자 특수기호 조합 8자리 이상
						
					 if (pwdLogin !== "") {
						 	if(!pwdregLogin.test(pwdLogin)) {
						 		pwdValidationStatusLogin.css("display", "block");
						 		pwdValidationStatusLogin.text("영문,숫자,특수문자 조합 8자리 이상으로 구성해주세요.");
						 		pwdValidationStatusLogin.css("color", "red");
						 		isValidPwdLogin = false;					 		
						 	} else {
						 		pwdValidationStatusLogin.css("display", "block");
						 		//pwdValidationStatusLogin.text("사용가능한 비밀번호입니다.");
						 		//pwdValidationStatusLogin.css("color", "green");
						 		isValidPwdLogin = true;	
						 	}
					 }
			});//end of inputEvent			
		});// end of ready document
	
	
		// 로그인 버튼
		function submitIdpwLogin() {
			 if (!isValidIdLogin || !isValidPwdLogin) {
					var loginFormSubmitBtn = document.getElementById("loginFormSubmitBtn"); // 버튼 요소 가져오기
					loginFormSubmitBtn.setAttribute("data-tooltip", "아이디 혹은 패스워드를 확인해주세요.");
		    	 
		    	 	 // 마우스가 버튼을 떼었을 때 툴팁을 숨김
		         	 loginFormSubmitBtn.addEventListener("mouseleave", function() {
		         	 loginFormSubmitBtn.setAttribute("data-tooltip", "");
		        	 });
		    	 	 
		    	 return false;
		    	 
			 } else {
				 document.getElementById("idPwFormLogin").submit();	
		    	 document.getElementById("modalIdPwLogin").classList.add("d-none"); // modalIdPwLogin 닫기
			 	
			 }
			
		}

	
</script>
</body>
</html>