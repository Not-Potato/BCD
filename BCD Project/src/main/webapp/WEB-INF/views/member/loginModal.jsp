<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>
<body>

	<div class="container">
<div class="modal modal-signin position-fixed d-block bg-opacity-30 py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalSignin">
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
		       		<h1 class="fw-bold fs-2">BCD에 오신 것을 환영합니다!</h1>
		        </div>
        
        	 <div class="mt-10">
        	 	<div class="centered text-center">
                	<div class="row">
                    	<div class="col-md mb-3">
                        	<button class="w-100 py-2 btn btn-outline-dark rounded-3" type="submit" id="phoneRegisterBtn" style="height: 58.59px; width:auto;">
                            	휴대전화 로그인
                        	</button>
                    	</div>    
                    
                    	<div class="col-md mb-3">
                            <img src="../../resources/images/btnG.png" alt="Naver" class="w-100 me-1" style="height:auto; width:100;" />   
                    	</div> 
                    
                    	<div class="col-md mb-3">
                            <img src="../../resources/images/btnK.png" alt="Kakao" class="w-100 me-1" style="height:auto; width:100;" />   
                    	</div> 
                	</div><!-- end of row -->            
            	</div>
        	</div>    
 <br><br>
 <hr>
            
        </div>
        </div>
    </div>
</div>
</div>

<script>
      const loginBtn = document.getElementById("loginBtn");
      const closeModalBtn = document.getElementById("closeModalBtn");
      
      loginBtn.addEventListener("click", function() {
    	  modalSignin.classList.remove("d-none");
      });
      
      closeModalBtn.addEventListener("click", function() {
    	  modalSignin.classList.add("d-none");
          location.reload();
      }); 
</script>

</body>
</html>