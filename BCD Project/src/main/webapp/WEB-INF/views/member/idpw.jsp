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
		       <!--  model로 받아온 이전단계 닉네임 -->
		       		<h1 class="fw-bold fs-2">닉네임님! BCD와 선택걱정 덜어내요! </h1>
            		<h1 class="fw-bold fs-2">거의 다왔어요!</h1>
		        </div>
        
        	 <div class="mt-10">
        	 	<form class="centered text-center">
                	<div class="row" style="width:600px;">
                	     			
                   		<div class="col-md mt-3 d-flex text-end">
                      		<label for="inputNickname" style="margin: 0;">
                        	<span class="fw-blod fs-5">아이디</span>
                      		</label>
                  		</div>
                  		
                  		<div class="col-md mt-3">
                    		<input type="text" class="form-control" id="inputID" name="id">
                  		</div>  
          		
                		<div class="col-md mt-3 d-flex text-end">
                   			<label for="inputID" style="margin: 0;">
                     			<span class="fw-blod fs-5">패스워드</span>
                   			</label>
               			</div>
                  		
                  		<div class="col-md mt-3">
                    		<input type="text" class="form-control" id="inputPwd" name="pwd">
                  		</div>
                  		    
                	</div>     
            	</form>
        	</div>    
        	
        	 <div class="text-center m-3">
        		<button type="button" class="btn btn-dark fs-5 pl-4 pr-4">가입완료</button>
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