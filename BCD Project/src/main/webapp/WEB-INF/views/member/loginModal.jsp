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
		     	<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>  
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
                            <img src="../../resources/images/btnG.png" alt="Naver" class="w-100 me-1" style="height:auto; width:100;" id="naverLoginBtn" />   
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
      

    	document.getElementById('naverLoginBtn').addEventListener('click', function() {
    	        // AJAX를 사용하여 백엔드로 네이버 인증 URL을 요청합니다.
    	        var xhr = new XMLHttpRequest();
    	        xhr.open('GET', '/member/naverLogin', true); // 백엔드의 네이버 인증 URL을 처리하는 URL로 변경해주세요.
    	        xhr.onreadystatechange = function() {
    	            if (xhr.readyState === XMLHttpRequest.DONE) {
    	                if (xhr.status === 200) {
    	                    var naverAuthUrl = xhr.responseText;
    	                    // 클라이언트에서 반환된 네이버 인증 URL로 리다이렉트하여 네이버 로그인 과정을 진행합니다.
    	                    window.location.href = naverAuthUrl;
    	                } else {
    	                    console.error('네이버 인증 URL을 가져오는 데 실패했습니다.');
    	                }
    	            }
    	        };
    	        xhr.send();
    	    });
      
</script>

</body>
</html>