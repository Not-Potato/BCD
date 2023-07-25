<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />
</head>
<body>

<!-- 로그인 모달 page.1 -->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalSignin">
   	<div class="modal-dialog modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">

		  
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalSignin"></button> 
    			<hr>
 		   </div>
		    <div class="modal-body p-5 pt-0">
		        <h1 class="fw-bold mt-5 mb-5 fs-2 text-center">BCD에 오신 것을 환영합니다!</h1>
		        
	        	 	<div class="centered text-center mt-5">
	                	<div class="row mt-3">
	                    	<div class="col-md mb-3 ">
	                        	<button class="py-2 btn btn-outline-dark rounded-3" type="submit" id="phoneRegisterBtn" style="height:58.59px; width:300px;">
	                            	휴대전화 로그인
	                        	</button>
	                    	</div>    
	                    </div>
	                    <div class="row mt-3">
	                    	<div class="col-md mb-3">
	                            <img src="../../resources/images/btnG.png" alt="Naver" id="naverLoginBtn" style="height:58.59px; width:300px;"/>   
	                    	</div> 
	                    </div>
	                    
	                    <div class="row mt-3">
	                    	<div class="col-md mb-3">
	                            <img src="../../resources/images/btnK.png" alt="Kakao" id="naverLoginBtn" style="height:58.59px; width:300px;"/>   
	                        </div>                
	        			</div>  
        			</div>
    		</div>
    		
		</div>
	</div>
</div>

<!-- 닉네임 2/3page -->
 <div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modalNickname">
   	<div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    	<div class="modal-content rounded-4 shadow">
		     
		   <div class="modal-header pb-2 pt-2">
   				<img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>    
    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="closeModalNickname"></button> 
    			<hr>
 		   </div>

		    <div class="modal-body p-5 pt-0 mt-4">
		        <h1 class="fw-bold mt-5 mb-2 fs-2 text-center">BCD에 처음 오셨군요!</h1>
            	<h1 class="fw-bold mb-5 fs-2 text-center">우선, 사용하실 닉네임을 설정해 볼까요?</h1>
            
            
	            <div class="d-flex justify-content-center mt-5" style="width: 100%;">
	        	 	<form class="centered text-center form-floating" style="width: 75%;">
	                    	<input type="text" class="form-control" id="inputNickname" name="nickname" placeholder="Nickname" style="margin: 0 auto;" pattern="[A-Za-z0-9ㄱ-ㅎㅏ-ㅣ가-힣]+";> 
	                    	<label for="inputNickname">Nickname</label>   	                   
	                    	<span class="invalid-feedback" id="nicknameValidation" style="display:none"></span><!-- 닉네임 유효성 체크 -->
	                    	<span class="invalid-feedback" id="nicknameStatus" style="display:none"></span><!-- 닉네임 중복 여부 체크 -->            		      
	            	</form>
	            	
	        	</div> 
	        	  	   
	        	 <div class="text-center mt-5">
	        		<button type="button" class="btn btn-dark fs-5 pl-4 pr-4" onclick="return submitNickname()">다음</button>
	      		</div>	
			</div>
    		
		</div>
	</div>
</div>



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
		        <h1 class="fw-bold mb-2 fs-2 text-center"> BDC와  선택걱정없는 세상으로 가실 준비됐나요?  </h1>
            
            
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

// 엔터 제출 방지 
	function preventFormSubmission(event) {
	    if (event.key === "Enter") {
	        event.preventDefault();
	    }
	}
	document.getElementById("inputNickname").addEventListener("keydown", preventFormSubmission);
    document.getElementById("inputId").addEventListener("keydown", preventFormSubmission);
    document.getElementById("inputPw").addEventListener("keydown", preventFormSubmission);
// end of 엔터 제출 방지 	
// page.1 로그인 형태 (phone vs naver vs kakao ) 
      const loginBtn = document.getElementById("loginBtn");
      const closeModalSignin = document.getElementById("closeModalSignin");
      
      loginBtn.addEventListener("click", function() {
    	  modalSignin.classList.remove("d-none"); //modalSignin 열기
      });
      
      closeModalSignin.addEventListener("click", function() {
    	  modalSignin.classList.add("d-none"); //modalSignin 닫기
          location.reload();
      });
// end of page.1 로그인 형태 (phone vs naver vs kakao )       
  
 
      
      
// page.2 닉네임  
  	// 닉네임 모달창 열기 
 	const phoneRegisterBtn = document.getElementById("phoneRegisterBtn"); //변수명 변경하기
  	const closeModalNickname = document.getElementById("closeModalNickname");
 
  	 phoneRegisterBtn.addEventListener("click", function() {
     	modalSignin.classList.add("d-none"); //modalSignin 닫기
     	modalNickname.classList.remove("d-none"); // modalNickname 열기
     });
       
     closeModalNickname.addEventListener("click", function() {
     	  modalNickname.classList.add("d-none");// modalNickname 닫기
           location.reload();
     });
     
     
 
 		//null check  
/*  		var check1 = isEmpty(nickname); 
 		if(check1) {
 			nicknameValidation.style.display = "block"
	    	nicknameValidation.innerText = "Nickname은 필수입력 사항입니다."; 
	    	nicknameValidation.style.color = "red";	
 		} */
 		
 		
 		 var isValidNickname = true;
 		
 		//닉네임 유효성 검사
 		$(document).ready(function() {
    		$("#inputNickname").on("input", function() {
	        	var nickname = $(this).val();
	        	var nicknameValidation = $("#nicknameValidation"); // 닉네임 유효성 메시지 요소
	
		        // 닉네임 유효성 검사
		        if (nickname !== "") {
		            const regex = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/; //2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성 (한글 초성 및 모음은 허가하지 않는다.)
		            if (!regex.test(nickname)) {		  
		                nicknameValidation.css("display", "block");
		                nicknameValidation.text("2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성해주세요.");
		                nicknameValidation.css("color", "red");
		                isValidNickname = false;
		            } else {
		                nicknameValidation.css("display", "none"); // 유효성 메시지 숨기기
		                isValidNickname = true;
		            }
		        } else {
		            nicknameValidation.css("display", "block"); // 유효성 메시지 숨기기
	                nicknameValidation.text("닉네임을 입력해주세요.");
	                nicknameValidation.css("color", "red");
	                isValidNickname = false;
		        }
    		});
		});
 				
 		function submitNickname() {		
			 var nickname = $("#inputNickname").val();
		     var nicknameStatus = $("#nicknameStatus");
				     
		    		 // 입력값이 비어있는 경우 서밋 막기
				     if (nickname === "" || !isValidNickname) {
				         return false; // 폼의 기본 제출 동작 막기
				     }
				     
					$.ajax({// 닉네임 중복 검사
						type :"post",
						async : true,
						url : "/member/nicknameCheck.do",	
						data : {
							nickname : nickname
						},
						success : function(result) {
							console.log(result);
							  var resultNumber = parseInt(result);
							if(resultNumber === 0) {	
								 nicknameStatus.css("display", "block");
								 nicknameStatus.text("사용 가능한 닉네임입니다.");
						         nicknameStatus.css("color", "green");
	                  		  	
						         moveToNextPage(nickname);
	                  			
					
							} else if(resultNumber > "0") {
		                      	  	nicknameStatus.css("display", "block");
		                            nicknameStatus.text("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.");
		                            nicknameStatus.css("color", "red");
		                      		return;
	                  		
		            		} 
							 else {
		            			 nicknameStatus.css("display", "none");	
		            			return;
		            		}
							 
						},
						error : function(result)  {
							alert("오류가 발생했습니다! 처음부터 다시 진행해주세요!");
							
							return;
						}
					});	

					return false; //폼의 기본 제출 동작 막기
			}		
 		
 		function moveToNextPage(nickname) {
 		    document.getElementById("nicknamePlaceholder").innerText = nickname;   
 		    document.getElementById("modalNickname").classList.add("d-none"); // modalNickname 닫으면서
 		    document.getElementById("modalIdPw").classList.remove("d-none"); // modalIdPw 열기
 		}

 
/* page.3 ID/PWD */
 	 const nicknameBtn= document.getElementById("nicknameBtn");
	 const closeModalIdPw = document.getElementById("closeModalIdPw");

	      
	 closeModalIdPw.addEventListener("click", function() {
		 modalIdPw.classList.add("d-none");
		 location.reload();
	  });
      
</script>

</body>
</html>