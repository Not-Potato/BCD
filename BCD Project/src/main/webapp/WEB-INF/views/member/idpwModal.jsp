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
   				<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalIdPw"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		        <h1 class="fw-bold mt-5 mb-2 fs-2 text-center"><span id="nicknamePlaceholder"></span>님,</h1>
		        <h1 class="fw-bold mb-2 fs-2 text-center"> BDC와  선택고민 없는 세상으로 가실 준비됐나요?  </h1>
            
            
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 	<form class="centered text-center form-floating" style="width: 75%;">
	        	 		<div class="form-floating mb-3">	
	                    	<input type="text" class="form-control" id="inputId" name="m_id" placeholder="ID" style="margin: 0 auto;"> 
	                    	<label for="inputId">ID</label>
	                    </div>	
	                    <div class="form-floating mb-3">
	                    	<input type="password" class="form-control" id="inputPw" name="m_pwd" placeholder="Password" style="margin: 0 auto;"> 
	                    	<label for="inputPw">Password</label>    
	                    </div>	            		      
	            	</form>
	        	</div> 
	        	  	   
	        	 <div class="text-center mt-5">
	        		<button type="button" class="btn btn-dark fs-5 pl-4 pr-4">가입완료</button>
	      		</div>	
			</div>
    		
		</div>
	</div>
</div>

<script>
//page.3 idpw  
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
 


</script>
</body>
</html>