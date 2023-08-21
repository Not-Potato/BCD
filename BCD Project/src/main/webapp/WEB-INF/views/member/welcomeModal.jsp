<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko" class="h-100"> 

<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>

<body>
<!--WelcomModal 0 page-->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalWelcome">
   	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">
		     
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/BCD.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalWelcome"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		        
		        <h1 class="fw-bold mb-2 fs-2 mb-3 text-center"> 축하드려요! 가입되었습니다.</h1>
		        <h5 class="fw-bold mb-2 fs-5 text-center"> 인생은 B(Birth)와 D(Death) 사이의 C(Choice)이다. </h5>
            
            
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        		<img src="../../resources/images/BCD.svg" alt="Logo" style="height:120px; width:390px;"/>    
	        	</div> 
	        	  	   
	        	 <div class="text-center mt-5">
	        		<button type="button" id="startBtn"class="btn btn-dark fs-5 pl-4 pr-4">시작하기</button>
	      		</div>	
			</div>
    		
		</div>
	</div>
</div>

<script>
//page.0 Welcome  

	// Welcome  모달창 닫기 
	const closeModalWelcome = document.getElementById("closeModalWelcome");

	closeModalWelcome.addEventListener("click", function() {
	   modalWelcome.classList.add("d-none");// modalWelcome 닫기
       //location.reload();
 	});
 
	const startBtn = document.getElementById("startBtn");

	startBtn.addEventListener("click", function() {
		   modalWelcome.classList.add("d-none");// modalWelcome 닫기
	       //location.reload();
	 });
	
</script>

</body>
</html>