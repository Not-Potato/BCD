<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>
<body>

<div class="container">
<div class="modal modal-signin position-fixed d-block bg-opacity-30 py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalRegister">
  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    	<div class="modal-content rounded-4 shadow">
		     <!-- 모달 header -->
		     <div class="modal-header pl-3 pr-3 pb-2 pt-2">
		     	<img src="../../resources/images/logo.svg" alt="Logo" class="w-100 me-1" style="height:30px; width:40px;"/>  
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalBtn"></button> 
		        <hr>
		     </div>
		     
		    <!-- 모달 바디 -->
		    <div class="modal-body p-5 pt-0">
		        <div class="p-5 pb-5 border-bottom-0 text-center mb-5">
		       		<h1 class="fw-bold fs-2">BCD에 처음 오셨군요!</h1>
            		<h1 class="fw-bold fs-2">우선, 사용하실 닉네임을 설정해 볼까요?</h1>
		        </div>
        
        	 <div class="mt-10 w-75">
        	 	<form class="centered text-center form-floating">
                    	<input type="text" class="form-control" id="inputNickname" name="nickname" placeholder="Nickname"> 
                    	<label for="floatingInputGrid">Nickname</label>               		      
            	</form>
        	</div>    
        	
        	 <div class="text-center m-3">
        		<button type="button" class="btn btn-dark fs-5 pl-4 pr-4">다음</button>
      		</div>
		</div>       
 		</div> 
    </div>
</div>
</div>

<script>
      const registerbtn = document.getElementById("phoneRegisterBtn");
      const closeModalBtn = document.getElementById("closeModalBtn");
      
      registerbtn.addEventListener("click", function() {
    	  
    	  modalRegister.classList.remove("d-none");
      });
      
      closeModalBtn.addEventListener("click", function() {
    	  modalRegister.classList.add("d-none");
          location.reload();
      }); 
</script>

</body>
</html>