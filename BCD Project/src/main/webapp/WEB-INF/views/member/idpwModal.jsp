<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko" class="h-100">

<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>

<body>
<!--ID/PWD  -- 3/3page-->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalIdPw">
   	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">
		     
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/BCD.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalIdPw"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		        <h1 class="fw-bold mt-5 mb-2 fs-2 text-center"><span id="nicknamePlaceholder"></span> 님,</h1>
		        <h1 class="fw-bold mb-2 fs-2 text-center"> BDC와  선택고민 없는 세상으로 가실 준비됐나요?  </h1>
            
            
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 	<form method="post" class="centered text-center form-floating" style="width: 75%;" id="idPwForm" action="/member/phoneJoin.do" >
	        	 		<div class="form-floating mb-3">	
	                    	<input type="text" class="form-control" id="inputId" name="id" placeholder="ID" style="margin: 0 auto;"> 
	                    	<label for="inputId">ID</label>
	                    	 <p class="invalid-feedback text-center m-0" id="idValidationStatus" style="display:none"></p><!--id 유효성검사-->	   	
	                    	 <p class="invalid-feedback text-center m-0" id="idDuplicationStatus" style="display:hidden"></p><!--id 중복체크 -->	   	
	                    
	                    </div>
	                   
	                    <div class="form-floating mb-3 mt-3">
	                    	<input type="password" class="form-control" id="inputPw" name="pwd" placeholder="Password" style="margin: 0 auto;"> 
	                    	<label for="inputPw">Password</label>  
	                    	  <p class="invalid-feedback text-center m-0" id="pwdValidationStatus" style="display:hidden"></p><!--pwd 유효성 검사 --> 
	                 	</div>	 
	                   	   	
	                     
	                     <input type="hidden" id="passNickname" name="nickname" value=""/>	  
	                     <input type="hidden" id="passPhone" name="phone" value=""/>	                              		      
	            	</form>
	        	</div> 
	        	
	        	  	   
	        	 <div class="text-center mt-5">
	        		<button type="button" id="completeRegisterBtn" class="btn btn-dark fs-5 pl-4 pr-4" onclick= "return submitIdpw()">가입완료</button>
	      		</div>	
			</div>
    		
		</div>
	</div>
</div>



<script>
//page.3 idpw  

	var id = $("#inputId").val();
	var pwd = $("#inputPw").val();	
	var idValidationStatus = $("#idValidationStatus"); // 아이디 유효성 결과
	var idDuplicationStatus = $("#idDuplicationStatus"); // 아이디 중복 결과

	var isValidId = false; //id 유효성검사
	var isDuplicateId = false; // id중복검사
	var isValidPwd = false // pwd 유효성검사
	
	//엔터 제출 방지 
	function preventFormSubmission(event) {
	    if (event.key === "Enter") {
	        event.preventDefault();
	    }
	}
	document.getElementById("inputId").addEventListener("keydown", preventFormSubmission);
	document.getElementById("inputPw").addEventListener("keydown", preventFormSubmission);
	//end of 엔터 제출 방지 
	
	
	// idpw 모달창 닫기 
	const closeModalIdPw = document.getElementById("closeModalIdPw");

	closeModalIdPw.addEventListener("click", function() {
	   modalIdPw.classList.add("d-none");// modalNickname 닫기
       location.reload();
	 });
 
	
		// id 검사
		$(document).ready(function() {
			$("#inputId").on("input", function() {
				id = $(this).val();
					
				const idreg = /^(?=.*[a-zA-Z0-9])[a-zA-Z0-9]{2,16}$/; //2자 이상 16자 이하, 영어,숫자로 구성
				
				// id유효성 검사
				if (id !== "") {		
						if (!idreg.test(id)) {
							idValidationStatus.css("display", "block");
							idValidationStatus.text("2~16자 사이 영문,숫자로 구성해주세요.");
							idValidationStatus.css("color", "red");
							isValidId = false;
					hideIdDuplicationStatus()
							
						} else {
							idValidationStatus.css("display", "none"); // 유효성 메시지 숨기기
							isValidId = true;							
							
							// id 중복검사
							$.ajax({
								type :"post",
								async : true,
								url : "/member/idCheck.do",	
								data : {
									id : id
								},
								success : function(result) {
									var resultNumber = parseInt(result); 
									if(result == "success"){
										idDuplicationStatus.css("display", "block");
										idDuplicationStatus.text("사용 가능한 ID입니다.");
										idDuplicationStatus.css("color", "green");
										isDuplicateId = true;
										return;
									} else if (result == "failed"){
										idDuplicationStatus.css("display", "block");
										idDuplicationStatus.text("이미 사용 중인 ID입니다. 다른 닉네임을 입력해주세요.");
										idDuplicationStatus.css("color", "red");
										isDuplicateId = false;
			                      		return;	
									} else {
										idDuplicationStatus.css("display", "none");	
										isDuplicateId = false;
				            			return;
									}							
								},
								error : function (result) {
									alert("오류가 발생했습니다! 처음부터 다시 진행해주세요!");
									hideIdDuplicationStatus()
									return false; //폼의 기본 제출 동작 막기
								}
							});// end of ajax -> id 중복검사
						
						  } //end of else
				
					} else {
						idValidationStatus.css("display", "block");
						idValidationStatus.text("ID를 입력해주세요.");
						idValidationStatus.css("color", "red");
						isValidId = false;
						return;
					}			
				});// end of on input	
			});// end of ready document
		
			
		// 사용자에게 닉네임 상태 메시지를 숨기는 함수
		function hideIdDuplicationStatus() {			
			idDuplicationStatus.css("display", "none");
			}
		
	// pwd 검사
		$(document).ready(function() {
			$("#inputPw").on("input", function() {
						pwd = $ (this).val();
					var pwdValidationStatus = $("#pwdValidationStatus");
					const pwdreg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/; //영문 숫자 특수기호 조합 8자리 이상
						
					 if (pwd !== "") {
						 	if(!pwdreg.test(pwd)) {
						 		pwdValidationStatus.css("display", "block");
						 		pwdValidationStatus.text("영문,숫자,특수문자 조합 8자리 이상으로 구성해주세요.");
						 		pwdValidationStatus.css("color", "red");
						 		isValidPwd = false;					 		
						 	} else {
						 		pwdValidationStatus.css("display", "block");
						 		pwdValidationStatus.text("사용가능한 비밀번호입니다.");
						 		pwdValidationStatus.css("color", "green");
						 		isValidPwd = true;	
						 	}
					 }
			});//end of inputEvent			
		});// end of ready document
	
	
	
	
		// 가입완료 버튼
		function submitIdpw() {
			 if (!isValidId || !isDuplicateId || !isValidPwd) {
					var completeRegisterBtn = document.getElementById("completeRegisterBtn"); // 버튼 요소 가져오기
					completeRegisterBtn.setAttribute("data-tooltip", "에러메세지를 확인해주세요");
		    	 
		    	 	 // 마우스가 버튼을 떼었을 때 툴팁을 숨김
		         	 completeRegisterBtn.addEventListener("mouseleave", function() {
		         	 completeRegisterBtn.setAttribute("data-tooltip", "");
		        	 });
		    	 	 
		    	 return false;
		    	 
			 } else {
				 document.getElementById("idPwForm").submit();	
		    	 document.getElementById("modalIdPw").classList.add("d-none"); // modalIdPw 닫기
			 }
			
		}

	
</script>
</body>
</html>