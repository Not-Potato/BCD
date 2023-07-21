<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="modal modal-signin position-fixed d-block bg-opacity-30 py-5 backdrop" tabindex="-1" role="dialog" id="modalSignin">
  	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content rounded-4 shadow">
		<div class="modal-header pl-3 pr-3 pb-2 pt-2">
	 			<h5 class="fw-bold mb-0 fs-4">BCD LOGO</h5>
	 				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" @click=closeModal></button> 
	 				<hr>
		</div>

	<div class="container p-4 mt-3">
     	<div class=""> <!-- 뒤로가기 -->
        	<svg xmlns="http://www.w3.org/2000/svg" width="30px" height="30px" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
          	<path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
        	</svg>
      	</div>
      	
      	<div class="modal-body p-5 pt-0">
          	<div class="p-4 pb-4 border-bottom-0 text-center mt-3 mb-5">
            	<h1 class="fw-bold fs-2">BCD에 처음 오셨군요!</h1>
            	<h1 class="fw-bold fs-2">우선, 사용하실 닉네임을 설정해 볼까요?</h1>
          	</div>
        
         	<div class="mt-10">
            	<form class="centered text-center">
                	<div class="row" style="width:600px;">
                		<div class="col-md mt-3 d-flex text-end">
                   			<label for="inputID" style="margin: 0;">
                     		<span class="fw-blod fs-5">아이디</span>
                   			</label>
               			</div>
                  		<div class="col-md mt-3">
                    		<input type="text" class="form-control" id="inputID" name="id">
                  		</div>  
 
                   		<div class="col-md mt-3 d-flex text-end">
                      		<label for="inputNickname" style="margin: 0;">
                        	<span class="fw-blod fs-5">닉네임</span>
                      		</label>
                  		</div>
                  		<div class="col-md mt-3">
                    		<input type="text" class="form-control" id="inputNickname" name="nickname">
                  		</div>  
                	</div>     
            	</form>
        	</div>    
        </div>
        
        <div class="text-center m-3">
        	<button type="button" class="btn btn-dark fs-5 pl-4 pr-4">다음</button>
      	</div>
 	</div>
            
    </div>
    </div>
    </div>

</body>
</html>