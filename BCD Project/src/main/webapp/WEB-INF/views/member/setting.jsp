<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	/* 로그인 회원만 접근 가능 */
	Integer memberIdx = (Integer)session.getAttribute("memberIdx");
	if(memberIdx == null) {
		response.sendRedirect("/home"); 
		return;
	}	
%>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
</head>

<body>
	<%@ include file="../common/header.jsp" %>


<div class="container pt-5 pb-5" style="width: 850px;">
<main>
<form method="post" class="image-form" enctype="multipart/form-data"  id="updateProfileForm" action="/member/updateProfile.do">
  <div class="">
	<div class="mb-5">
		<h2 class="fw-bold">내 정보 수정</h2>
			
                <div class="ms-3 mb-3" style= "border-radius: 50%; width: 200px; height:200px; overflow:hidden">
                  <!--  <i class="bi bi-person-fill" style="font-size: 120px; object-fit:cover;"></i> -->
              	  <img src="../../resources/images/profile.svg" id="changeProfileImg" name="proflie" style="font-size: 120px; object-fit:cover; width: 100%; height: 100%;"> <!-- aws 기본 url -->						
               	
               </div>
                <div class="d-flex gap-2">
					<div class="d-none">	                	
	                	<input type="file" accept="image/*" id="file"  />				
	                </div>
	                
	        		<input type="button" class="btn-check"  id="pic">
                	<label class="btn btn-outline-primary" for="pic" onClick="openFileInput()">이미지 업로드</label>
	                	
                	
                	<input type="button" class="btn-check" name="" id="deleteProfileImg">
                    <label class="btn btn-outline-danger" for="deleteProfileImg">이미지 삭제</label>                 
                </div>
              
            <hr>
     </div>

      
	<div class="mb-5">
   <!--   <div class="row pt-4"> -->
        <div class= "row pt-4 mb-5">    
         	<label for="settingNickname"><h3 class="col-5 fw-bold">닉네임</h3></label>  
         	<input type="text" class="form-control" id="settingNickname" name="nickname" placeholder="${member.nickname}" style="margin: 0 auto;"> 
			<p class="invalid-feedback  m-0" id="nicknameValidationForSetting" style="display:none"></p><!-- 닉네임 유효성 체크 -->	   
		    <p class="invalid-feedback  m-0" id="nicknameStatusForSetting" style="display:hidden"></p><!-- 닉네임 중복 여부 체크 -->		              
		</div>  			
            <span style="color:gray;">BCD에서 사용되는 이름입니다.</span>
            <hr class="m-0">
  	 </div> 

<c:choose>
	<c:when test= "${empty member.getSnsType()}">
       <div class="">     
       	<div class= "row pt-4 mb-2">    
      	 	<label for="settingPw"><h3 class="col-5 fw-bold">비밀번호</h3></label>
      		<input type="password" class="form-control" id="settingPw" name="pwd" placeholder="" style="margin: 0 auto;">       
      		<p class="invalid-feedback m-0" id="pwdValidationStatusForSetting" style="display:hidden"></p>
        </div>
       
       <div class= "row pt-4 mb-2">
            <label for="settingPw2"><h3 class="col-5 fw-bold">비밀번호 확인</h3></label>
             <input type="password" class="form-control" id="settingPw2" name="pwdChk" placeholder="" style="margin: 0 auto;"> 	    
         	<p class="invalid-feedback m-0" id="pwdValidationStatusForSetting2" style="display:hidden"></p>       
       </div>
       
         	<br><br><br>
         	<hr>
     	</div> 
     </c:when>   
     <c:otherwise>
     </c:otherwise> 
</c:choose> 		        
            </div>
</form>
     <div class="row justify-content-center"> 
         <div class="col-1 p-0">  
             <label class="btn btn-primary" id= "updateSettingBtn" for="btn-check-2" onclick= "return submitUpdateSetting()" data-tooltip="">완료</label>
         </div>     
         <div class="col-1 p-0" style="white-space: nowrap;"> 
             <input type="checkbox" class="btn-check" id="btn-check-2" checked autocomplete="off">
             <label class="btn btn-danger" for="btn-check-2" onclick="withdraw()">회원탈퇴</label>
         </div>
     </div>
     
</main>            
</div>
<%@ include file="../common/footer.jsp" %>

<script>
	var nicknameForSetting = $("#settingNickname").val();
	var nicknameValidationForSetting = $("#nicknameValidationForSetting"); // 닉네임 유효성 메시지 요소
	var nicknameStatusForSetting = $("#nicknameStatusForSetting"); // 닉네임 중복 여부
	
	var pwdForSetting = $("#settingPw").val();
	var pwd2ForSetting = $("#settingPw2").val();
	var pwdForSettingElement = document.getElementById("settingPw");
	var pwd2ForSettingElement = document.getElementById("settingPw2");
	
	var isValidNicknameForSetting = false; //정규식 컨트롤
	var isDuplicateNicknameForSetting = false; //중복 컨트롤
	var isValidPwdForSetting = false // pwd 유효성검사
	
	var isValidPwd2ForSetting = false
	
	//엔터 제출 방지 
	function preventFormSubmission(event) {
	    if (event.key === "Enter") {
	        event.preventDefault();
	    }
	}	
	document.getElementById("settingNickname").addEventListener("keydown", preventFormSubmission);
	
	if (pwdForSettingElement) {
		document.getElementById("settingPw").addEventListener("keydown", preventFormSubmission);
		document.getElementById("settingPw2").addEventListener("keydown", preventFormSubmission);
	}
	

	//닉네임 유효성 검사
	$(document).ready(function() {
	$("#settingNickname").on("input", function() {
    		nicknameForSetting = $(this).val();
 
    	const regexForSetting = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/; //2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성 (한글 초성 및 모음은 허가하지 않는다.)
       
    	// 닉네임 유효성 검사
        if (nicknameForSetting !== "") {
            if (!regexForSetting.test(nicknameForSetting)) {		  
                nicknameValidationForSetting.css("display", "block");
                nicknameValidationForSetting.text("2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성해주세요.");
                nicknameValidationForSetting.css("color", "red");
                isValidNicknameForSetting = false;
       			hideNicknameStatusForSetting(); // 중복 여부 문구 숨기기 
            } else {
                nicknameValidationForSetting.css("display", "none"); // 유효성 메시지 숨기기
                isValidNicknameForSetting = true;
                
                $.ajax({// 닉네임 중복 검사
					type :"post",
					async : true,
					url : "/member/nicknameCheck.do",	
					data : {
						nicknameForSetting : nicknameForSetting
					},
					success : function(result) {					
						if (result == "success") {	
							 nicknameStatusForSetting.css("display", "block");
							 nicknameStatusForSetting.text("사용 가능한 닉네임입니다.");
					         nicknameStatusForSetting.css("color", "green");
					         isDuplicateNicknameForSetting = true;
					  
						} else if (result == "failed") {
	                      	  	nicknameStatusForSetting.css("display", "block");
	                            nicknameStatusForSetting.text("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.");
	                            nicknameStatusForSetting.css("color", "red");
	                            isDuplicateNicknameForSetting = false;
	                      		return;
	              		
	            		} else {
	            			 nicknameStatusForSetting.css("display", "none");	
	            			 isDuplicateNicknameForSetting = false;
	            			return;
	            		}
						 
					},
					error : function(result)  {
						alert("오류가 발생했습니다! 처음부터 다시 진행해주세요!");
						hideNicknameStatusForSetting(); // 중복 여부 문구 숨기기
						return false; //폼의 기본 제출 동작 막기
					}
				});

           	}

        } else {
        	nicknameValidationForSetting.css("display", "block"); // 유효성 메시지 숨기기
        	nicknameValidationForSetting.text("닉네임을 입력해주세요.");
        	nicknameValidationForSetting.css("color", "red");
            isValidNicknameForSetting = false;        
        }        
        
	});
	});
	
	// 사용자에게 닉네임 중복여부메시지를 숨기는 함수 (정규식 검사 먼저)
	function hideNicknameStatusForSetting() {	   
	    nicknameStatusForSetting.css("display", "none");
	}

	
	// pwd 검사
	if (pwdForSettingElement) {	
		$(document).ready(function() {
			$("#settingPw").on("input", function() {
						pwdForSetting = $ (this).val();
					var pwdValidationStatusForSetting = $("#pwdValidationStatusForSetting");
					const pwdregForSetting = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/; //영문 숫자 특수기호 조합 8자리 이상
						
					 if (pwdForSetting !== "") {
					 	if(!pwdregForSetting.test(pwdForSetting)) {
					 		pwdValidationStatusForSetting.css("display", "block");
					 		pwdValidationStatusForSetting.text("영문,숫자,특수문자 조합 8자리 이상으로 구성해주세요.");
					 		pwdValidationStatusForSetting.css("color", "red");
					 		isValidPwdForSetting = false;					 		
					 	} else {
					 		pwdValidationStatusForSetting.css("display", "block");
					 		pwdValidationStatusForSetting.text("사용가능한 비밀번호입니다.");
					 		pwdValidationStatusForSetting.css("color", "green");
					 		isValidPwdForSetting= true;		
					 	}
					} else {
						pwdValidationStatusForSetting.css("display", "block");
				 		pwdValidationStatusForSetting.text("비밀전호를 입력해주세요.");
				 		pwdValidationStatusForSetting.css("color", "red");
				 		isValidPwdForSetting = false;
					}
			});//end of inputEvent			
		});// end of ready document
		
	}
	
	//pwd2 검사 
	if (pwd2ForSettingElement) {
		
		$(document).ready(function() {
		$("#settingPw2").on("input", function() {
					pwd2ForSetting = $ (this).val();
				var pwdValidationStatusForSetting2 = $("#pwdValidationStatusForSetting2");
			 if (pwdForSetting !== "") {	
				 if (pwdForSetting !== pwd2ForSetting) {			 	
					 pwdValidationStatusForSetting2.css("display", "block");
					 pwdValidationStatusForSetting2.text("비밀번호가 일치하지 않습니다.");
					 pwdValidationStatusForSetting2.css("color", "red");
				 	 isValidPwd2ForSetting = false;					 		
				 } else {
					 pwdValidationStatusForSetting2.css("display", "block");
					 pwdValidationStatusForSetting2.text("일치합니다.");
					 pwdValidationStatusForSetting2.css("color", "green");
			 		 isValidPwd2ForSetting = true;	
				 }
			 } else {
				 pwdValidationStatusForSetting2.css("display", "block"); // 유효성 메시지 숨기기
				 pwdValidationStatusForSetting2.text("비밀번호를 확인해주세요.");
				 pwdValidationStatusForSetting2.css("color", "red");
				 pwdValidationStatusForSetting2 = false;     
			 }	 
		});//end of inputEvent			
	});// end of ready document
		
	}
	
	//이미지 업로드 클릭  
	function openFileInput() {
		  const fileInput = document.getElementById('file');
		  fileInput.click();
		}
	
	
	//파일업로드 미리보기 
	var fileInput = document.getElementById('file');
    var changeProfileImg = document.getElementById('changeProfileImg');

    fileInput.addEventListener('change', function() {
      const file = fileInput.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function() {
        	changeProfileImg.src = reader.result;
        };
        reader.readAsDataURL(file);
      }
    });

    //취소버튼 클릭 
	document.getElementById("deleteProfileImg").addEventListener("click", function(){
	    var defaultImagePath = "../../resources/images/profile.svg";
	    changeProfileImg.src = defaultImagePath;
	});
	
	//완료 버튼
		function submitUpdateSetting() {
		 if (!isValidNicknameForSetting || !isDuplicateNicknameForSetting || !isValidPwdForSetting || !isValidPwd2ForSetting ) {
			 var updateSettingBtn = document.getElementById("updateSettingBtn"); // 버튼 요소 가져오기
			 updateSettingBtn.setAttribute("data-tooltip", "에러메세지를 확인해주세요");
			 return false;
		 } else {
			 document.getElementById("updateProfileForm").submit();	
		 }
	}

	//수정 완료
	
	
	
	
	//회원탈퇴 
	function withdraw() {
	  Swal.fire({
	    title: '정말 탈퇴하시겠습니까?',
	    text: '휴면계정으로 즉시 변경되며 30일 후 자동 탈퇴됩니다. ',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonText: '탈퇴',
	    cancelButtonText: '취소',
	    reverseButtons: true
	  }).then((result) => {
	    if (result.isConfirmed) {	      
	    	
	     	location.href = '/member/withdraw.do';     
	   
	    } else {
	    	location.href = '/member/mypage.do'; 
	    }
	  });
}
	
	
</script>
</body>
</html>