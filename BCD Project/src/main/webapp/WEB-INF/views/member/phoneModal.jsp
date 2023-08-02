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
   				<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalPhone"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		    <h1 class="fw-bold mt-5 mb-2 fs-2 text-center">안녕하세요. BCD입니다!</h1>
	        
            	<h1 class="fw-bold mb-5 fs-2 text-center">본인 확인을 위해 휴대전화번호를 입력해주세요. </h1>
       
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 	
		        	 	<form class="centered text-center form-floating" style="width:75%;" action="/member/phoneJoin.do"  id="PhoneForm">		                   
		                    	 <input type="tel" class="form-control" name="tel1" maxlength="3"/> -	
					 			 <input type="tel" class="form-control" name="tel2" maxlength="4"/> -	
					      		 <input type="tel" class="form-control" name="tel3" maxlength="4"/>				                    	  	                   
		            	</form>
		          </div>    	
		            	<div class="row">
		            		<p class="invalid-feedback text-center m-0" id="phoneValidation" style="display:none"></p><!--전화번호 유효성 -->	   
		           			      
		           		</div>
	            	


	        	 <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        		<button type="button" id="phoneNextBtn" class="btn btn-dark fs-5 pl-4 pr-4" onclick="return submitPhone()" data-tooltip="">다음</button>	      		
	      		</div>	      		

			</div>
   		
		</div>
	</div>
</div>

<script>
//전호번호 
	var isPhoneValidated = false;
	var tel1 = $("#tel1").val();
	var tel2 = $("#tel2").val();
	var tel3 = $("#tel3").val();

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

 	 closeModalNickname.addEventListener("click", function() {
	 	  modalNickname.classList.add("d-none");
	      location.reload(); 
	 });
  
		//전화번호 유효성 검사
		$(document).ready(function() {
		$("#tel1, #tel2, #tel3").on("input", function() {
        	 tel1 = $("#tel1").val();
        	 tel2 = $("#tel2").val();
        	 tel3 = $("#tel3").val();
        	var phoneValidation = $("#phoneValidation"); // 닉네임 유효성 메시지 요소
        
	        if (tel1 !== "" && tel2 !== "" && tel3 !== ""}) {
	        		
	            if (/^\d+$/.test(tel1) && /^\d+$/.test(tel2) && /^\d+$/.test(tel3)) {
	                // Check if the lengths of the inputs are correct (assumed to be 4 characters each)
	                if (tel1.length === 4 && tel2.length === 4 && tel3.length === 4) {
	                    phoneValidation.css("display", "none");
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
	        	

		 //다음버튼 클릭 시
		 function submitPhone() {		
    		 // 입력값이 비어있는 경우 서밋 막기
		     if (!isPhoneValidated) {		    	 
		    	 	var phoneNextBtn = document.getElementById("phoneNextBtn"); // 버튼 요소 가져오기
		    	 	phoneNextBtn.setAttribute("data-tooltip", "에러메세지를 확인해주세요");
		    	 
		    	 	 // 마우스가 버튼을 떼었을 때 툴팁을 숨김
		         	 phoneNextBtn.addEventListener("mouseleave", function() {
		         		phoneNextBtn.setAttribute("data-tooltip", "");
		        	 });
		    	 
		    	 return false; // 폼의 기본 제출 동작 막기
		    	 
		     } else {
		    	 
		    	 var phoneNumber = tel1.concat(tel2, tel3);//전화번화 하나로 합치기
		    	 submitPhone(phoneNumber); 
		    	 return true;
		     }
		}	 
		
		 
			function submitPhone(nickname) {
				 $.ajax({
					 type :"post",
					 async : true,
				     url: '/member/phoneCheck.do', 
				     data: { phoneNumber: phoneNumber }, 
				     success: function(result) {
				            if(result =="succeuss") {
				             document.getElementById("modalPhone").classList.add("d-none");  //휴대전화 모달창 닫기
				             document.getElementById("modalIdPw").classList.remove("d-none");  //IDPW 모달창 열기				             
				           
				            } else if (result =="failed") {
				            	
				            }
				        },
				        error: function(error) {
				            return false;
				        }
				    });
	    
			  	}



</script>



</body>
</html>