<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />	

<!DOCTYPE html>
<html lang="ko" class="h-100">

<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>

<body>
<!-- 전화인증 page -->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalPhone">
   	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">
		     
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/BCD.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalPhone"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		    <h1 class="fw-bold mt-5 mb-2 fs-2 text-center">환영합니다!</h1>
	        
            	<h1 class="fw-bold mb-5 fs-2 text-center" id="phoneMessage">본인 확인을 위해 휴대전화번호를 입력해주세요. </h1>
       
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 			                    
		        	 	<form class="text-center form-floating" style="width:75%;" action="/member/phoneJoin.do"  id="PhoneForm">		                   
		                  <div class="row g-2">
		                    <div class="col-md">
		                    	 <input type="tel" class="form-control" id="tel1" maxlength="3"/>	
					 		</div>	
					 		<div class="col-md">
					 			 <input type="tel" class="form-control" id="tel2" maxlength="4"/>	
					      	</div>
					      	<div class="col-md">	 
					      		 <input type="tel" class="form-control" id="tel3" maxlength="4"/>		      		 			                    	  	                   
		            		</div>		            	
		         		  </div>
		         		  
		         		  <div class="row g-2 justify-content-center">
		         		     <div class="col-md">
		         		      <input type="tel" class="form-control d-none" id="verificationSection" name="code" placeholder="문자인증번호를 입력해주세요." maxlength="4"/> 		         			
		         		    </div>
		         		  </div>
		         		    
		            	</form>	            	
		            
		          </div>    	
		            	<div class="row">
		            		<p class="invalid-feedback text-center m-0" id="phoneValidation" style="display:none;"></p><!--전화번호 유효성 -->	   		      
		           		</div>
	            	


	        	 <div class="d-flex justify-content-center mt-5" id="phoneNextBtnDiv" style="width: 100%;">
	        		<button type="button" id="phoneNextBtn" class="btn btn-dark fs-5 pl-4 pr-4" onclick="submitPhone()" data-tooltip="">확인</button>	      		
	      		</div>	      		

 				<div class="d-flex justify-content-center mt-5 " style="width: 100%;">
	        		<button type="button" id="smsCodeCheck" class="btn btn-dark fs-5 pl-4 pr-4 d-none"  data-tooltip="">인증하기</button>	      		
	      		</div>	 

			</div>
   		
		</div>
	</div>
</div>

<%@ include file="../member/idpwLoginModal.jsp" %>

<script>
//전호번호 
var isPhoneValidated = false;
var tel1;
var tel2;
var tel3;
var phoneNumber;
//엔터 제출 방지 	     
function preventFormSubmission(event) {
    if (event.key === "Enter") {
        event.preventDefault();
    }
}
document.getElementById("tel1").addEventListener("keydown", preventFormSubmission);
document.getElementById("tel2").addEventListener("keydown", preventFormSubmission);
document.getElementById("tel3").addEventListener("keydown", preventFormSubmission);

//end of 엔터 제출 방지 


//폰모달창 닫기
const closeModalPhone = document.getElementById("closeModalPhone");

closeModalPhone.addEventListener("click", function() {
	closeModalPhone.classList.add("d-none");
	 location.reload();
 });

//전화번호 유효성 검사
$(document).ready(function() {
	$("#tel1, #tel2, #tel3").on("input", function() {
		tel1 = $("#tel1").val();
		tel2 = $("#tel2").val();
		tel3 = $("#tel3").val();
		var phoneValidation = $("#phoneValidation"); // 닉네임 유효성 메시지 요소
		// 전화번호 합치기
        
		if (tel1 !== "" && tel2 !== "" && tel3 !== "") {
			if (/^\d+$/.test(tel1) && /^\d+$/.test(tel2) && /^\d+$/.test(tel3)) {
				if (tel1.length === 3 && tel2.length === 4 && tel3.length === 4) {
					phoneValidation.css("display", "none");
					phoneNumber = tel1 + "-" + tel2 + "-" + tel3;
					isPhoneValidated = true;
				} else {
					phoneValidation.css("display", "block");
					phoneValidation.text("전화번호를 확인해주세요.");
					phoneValidation.css("color", "red");
					isPhoneValidated = false;
				}
			} else {
				phoneValidation.css("display", "block");
				phoneValidation.text("전화번호를 확인해주세요.");
				phoneValidation.css("color", "red");
				isPhoneValidated = false;
			}
		} else {
			phoneValidation.css("display", "block");
			phoneValidation.text("전화번호를 입력해주세요.");
			phoneValidation.css("color", "red");
			isPhoneValidated = false;
		}
	});
});

// 1. 확인버튼 클릭 시
function submitPhone() {		
	// 휴대전화input값이 비어있는 경우 서밋 막기
	if (!isPhoneValidated) {		    	 
		var phoneNextBtn = document.getElementById("phoneNextBtn"); // 버튼 요소 가져오기
		phoneNextBtn.setAttribute("data-tooltip", "번호를 입력해주세요.");
		 // 마우스가 버튼을 떼었을 때 툴팁을 숨김
		phoneNextBtn.addEventListener("mouseleave", function() {
			phoneNextBtn.setAttribute("data-tooltip", "");
		});
		return false; // 폼의 기본 제출 동작 막기
	} else {//유효성 검증된 전화번호 있음
		$.ajax({
			type: "post",
			async: true,
			url: '/member/phoneCheck.do', 
			data: { phoneNumber: phoneNumber }, 
			success: function(result) {
				if (result === "success") { // 기존 가입
					document.getElementById("modalPhone").classList.add("d-none");  // 휴대전화 모달창 닫기
					document.getElementById("modalIdPwLogin").classList.remove("d-none");  // IDPW 모달창 열기				             
					document.getElementById("passPhone").value = phoneNumber; // modalIdPwLogin에 전화번호 전달하기
				} else if (result === "failed") { // 신규 회원
					document.getElementById("phoneMessage").textContent = "가입을 위해 휴대폰인증을 진행해주세요!";
					document.getElementById("phoneNextBtn").textContent = "인증문자발송";
					document.getElementById("phoneNextBtn").removeEventListener("click", submitPhone);
					document.getElementById("phoneNextBtn").addEventListener("click", requestPhoneAuth);
				}
			},
			error: function(error) {
				return false;
			}
		});
	}
}

// 2. 인증문자 발송 버튼 클릭 시
function requestPhoneAuth() {
	$.ajax({
		type: "post",
		async: true,
		url: "/member/sendVerificationCode.do",
		data: { phoneNumber: phoneNumber },
		success: function(result) {
			if (result === "success") {
				alert("인증문자를 발송하였습니다. 인증번호를 입력해주세요.");
				document.getElementById("verificationSection").classList.remove("d-none");
				document.getElementById("tel1").classList.add("d-none");
				document.getElementById("tel2").classList.add("d-none");
				document.getElementById("tel3").classList.add("d-none");
				document.getElementById("phoneNextBtn").classList.add("d-none");
				document.getElementById("phoneNextBtnDiv").classList.add("d-none");
				document.getElementById("smsCodeCheck").classList.remove("d-none");
				document.getElementById("phoneNextBtn").removeEventListener("click", requestPhoneAuth);
				document.getElementById("smsCodeCheck").addEventListener("click", function () {
		          smsCheck();
			    });	     
		        
			} else {
				alert("인증문자 발송에 실패하였습니다. 다시 시도해주세요.");
			}
		},
		error: function(error) {
			alert("인증문자 인증에 실패하였습니다. 다시 시도해주세요.");
		}
	});
}

// 3. 인증하기 버튼 클릭 
function smsCheck() {
	var code = document.getElementById("verificationSection").value;				
	console.log(code);
	$.ajax({
		type: "post",
		async: true,
		url: '/msg/smsCheck.do',
		data: { code: code }, // 입력인증코드
		success: function(result) {
			console.log(result);
			if (result === "success") { // 인증 성공
				document.getElementById("passPhone").value = phoneNumber;
				document.getElementById("modalPhone").classList.add("d-none");
				document.getElementById("modalNickname").classList.remove("d-none");
				
			} else if (result === "failed") { // 인증 실패
				submitPhone(); // 휴대전화 인증으로 돌아가기
				document.getElementById("verificationSection").placeholder = "문자인증번호를 다시 확인해주세요.";
				//return false;
			}
		},
		error: function(error) {
			console.error("Error:", error);
		}
	});
}
</script>




</body>
</html>