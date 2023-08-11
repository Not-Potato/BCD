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
			<!-- 이미지 출력부  -->
<c:choose>
	<c:when test= "${member.profilePath == null}">				
                <div class="ms-3 mb-3" style= "border-radius: 50%; width: 200px; height:200px; overflow:hidden" id="changeProfileImg">          
              	  <img src="" style="font-size: 120px; object-fit:cover; width: 100%; height: 100%;"> <!-- aws 기본 url -->						               	
               </div>
     </c:when>
     <c:otherwise>				
                <div class="ms-3 mb-3" style= "border-radius: 50%; width: 200px; height:200px; overflow:hidden" id="changeProfileImg">          
              	  <img src="${ member.profilePath }" style="font-size: 120px; object-fit:cover; width: 100%; height: 100%;"> <!-- aws 기본 url -->						               	
               </div>
     </c:otherwise>
</c:choose>               
            <!-- 파일 업로드 디렉토리 -->   
                <div class="d-flex gap-2">
					<div class="d-none">	                	
	                	<input type="file" name="file"  accept="image/*" id="file" />				
	                	<input type="hidden" name="profilePath" />				
	                </div>
	        <!-- 버튼 (파일 업로드 디렉토리)  -->      
	        		<input type="button" class="btn-check"  id="pic">
                	<!-- <label class="btn btn-outline-primary" for="pic" onClick="openFileInput()">이미지 업로드</label> -->
                	<label class="btn btn-outline-primary" for="file">이미지 업로드</label>
	                	
                	
                	<input type="button" class="btn-check" name="" id="deleteProfileImg">
                    <label class="btn btn-outline-danger" for="deleteProfileImg">이미지 삭제</label>                 
                </div>
              
            <hr>
     </div>

      
	<div class="mb-5">
        <div class= "row pt-4 mb-5">    
         	<label for="settingNickname"><h3 class="col-5 fw-bold">닉네임</h3></label>  
         	<input type="text" class="form-control" id="settingNickname" name="nickname" placeholder="${member.nickname}"  value="${member.nickname}" style="margin: 0 auto;"> 
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
      		<input type="password" class="form-control" id="settingPw" name="pwd" placeholder="비밀번호를 입력해주세요." style="margin: 0 auto;">       
      		<p class="invalid-feedback m-0" id="pwdValidationStatusForSetting" style="display:hidden"></p>
        </div>
       
       <div class= "row pt-4 mb-2">
            <label for="settingPw2"><h3 class="col-5 fw-bold">비밀번호 확인</h3></label>
             <input type="password" class="form-control" id="settingPw2" name="pwdChk" placeholder="비밀번호를 확인해주세요." style="margin: 0 auto;"> 	    
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
<c:choose>
<c:when test= "${empty member.getSnsType()}">
         <div class="col-1 p-0">  
             <label class="btn btn-primary" id= "updateSettingBtn1" for="btn-check-2" onclick= "return submitUpdateSetting1()">완료</label>
         </div>  
</c:when>    
<c:otherwise>
         <div class="col-1 p-0">  
             <label class="btn btn-primary" id= "updateSettingBtn2" for="btn-check-2" onclick= "return submitUpdateSetting2()">완료</label>
         </div>  
</c:otherwise>    
</c:choose>        
         <div class="col-1 p-0" style="white-space: nowrap;"> 
             <input type="checkbox" class="btn-check" id="btn-check-2" checked autocomplete="off">
             <label class="btn btn-danger" for="btn-check-2" onclick="withdraw()">회원탈퇴</label>
         </div>
     </div>
     
</main>            
</div>
<%@ include file="../common/footer.jsp" %>

<script>

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
	
   /* 공통  */
   var isImgExist = true; 
   var isNicknameExist = true; 
   
   /* 일반 회원 only  */
    var isPwdExist = true; 
    var isPwdExist2 = true; 
  
    
    /* 유효성 검사(아무것도 입력안하면..) */
	var isValidNicknameForSetting = true; //정규식 컨트롤
	var isDuplicateNicknameForSetting = true; //중복 컨트롤
	
	var isValidPwdForSetting = false // pwd 유효성검사	
	var isValidPwd2ForSetting = false
	
	var settingNicknameElement = document.getElementById("settingNickname"); //닉네임 들어왔나?
	var pwdForSettingElement = document.getElementById("settingPw"); // 비밀번호 유효성 검사
	var pwd2ForSettingElement = document.getElementById("settingPw2"); // 비밀번호 유효성 검사 
	
	
	//닉네임 변경 시
	document.getElementById('settingNickname').addEventListener('input', function() {		
		var nicknameForSetting = $(this).val();
		var nicknameValidationForSetting = $("#nicknameValidationForSetting"); // 닉네임 유효성 메시지 요소
		var nicknameStatusForSetting = $("#nicknameStatusForSetting"); // 닉네임 중복 여부
		
		isValidNicknameForSetting = false; //정규식 컨트롤
		isDuplicateNicknameForSetting = false; //중복 컨트롤
	

	 	if (settingNicknameElement) {	
	 			 //$("#settingNickname").on("input", function() {

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
									 nicknameStatusForSetting.text("사용가능한 닉네임입니다.");
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
		
		           	}// end of if-else !regexForSetting.test(nicknameForSetting) 
	
		        } else {
		        	nicknameValidationForSetting.css("display", "block"); // 유효성 메시지 숨기기
		        	nicknameValidationForSetting.text("닉네임을 입력해주세요.");
		        	nicknameValidationForSetting.css("color", "red");
		            isValidNicknameForSetting = false;        
		        } // end of nicknameForSetting !== ""
	 	} // end of settingNicknameElement	
						
	});
	
	 			 
	// 사용자에게 닉네임 중복여부메시지를 숨기는 함수 (정규식 검사 먼저)
	function hideNicknameStatusForSetting() {
		var nicknameStatusForSetting = $("#nicknameStatusForSetting");
		nicknameStatusForSetting.css("display", "none");
		
	}	
	
	//일반 회원의 경우	
		//document.getElementById('settingPw').addEventListener('change', function() {		
		//	var pwdForSetting = $("#settingPw").val();
		$(document).ready(function() {
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
						 		pwdValidationStatusForSetting.text("비밀번호를 입력해주세요.");
						 		pwdValidationStatusForSetting.css("color", "red");
						 		isValidPwdForSetting = false;
							}
					});//end of inputEvent			
				});// end of ready document		
			}
		});
		//}); //end of settingPw 	
			
			
			
			//document.getElementById('settingPw2').addEventListener('change', function() {			
			//	var pwd2ForSetting = $("#settingPw2").val();
			$(document).ready(function() {
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
			});		
			//});

	
	//-------------------Post write insert.do 이미지 부분 ----------------------
		// 파일 업로드 시 파일명 가져오기 + 썸네일
		function updateFileNameAndPre(fileInput, hiddenInputName, imgPre) {
			$(fileInput).on("change", function() {
				const file = this.files[0];
				
				if (file) {
					const maxSize = 1048576; // 1MB
					if (file.size > maxSize) {
						Swal.fire({
							icon: 'error',
							title: 'error',
							text: '최대 1MB까지만 허용됩니다!'
						}).then(() => {
							this.value = '';
							$(imgPre).children('img').attr('src', '');
							console.log($('input[name="' + hiddenInputName + '"]').val());
							$('input[name="' + hiddenInputName + '"]').val('');
							console.log($('input[name="' + hiddenInputName + '"]').val());
						});
						return;
					}
				}
				
				var fileName = $(this).val().split("\\").pop();
				$('input[name="' + hiddenInputName + '"]').val(fileName);
							console.log($('input[name="' + hiddenInputName + '"]').val());
				
				if (this.files && this.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$(imgPre).children('img').attr('src', e.target.result);
						$(imgPre).removeClass('d-none');
					}
					reader.readAsDataURL(this.files[0]);
				} else {
					$(imgPre).children('img').attr('src', '');
					$(imgPre).addClass('d-none');
				}
			});
				
		}
		
		// 함수 호출	
		updateFileNameAndPre("#file","profilePath","#changeProfileImg");		

	
	//-----------------------end of insert.do--------------------------

    //취소버튼 클릭 
	document.getElementById("deleteProfileImg").addEventListener("click", function(){
	    changeProfileImg.src = null;
	});
	
	//완료 버튼 (일반회원)
		function submitUpdateSetting1() {
			 if (!isValidNicknameForSetting || !isDuplicateNicknameForSetting || !isValidPwdForSetting || !isValidPwd2ForSetting ) {
				 var updateSettingBtn1 = document.getElementById("updateSettingBtn1"); // 버튼 요소 가져오기
				 updateSettingBtn1.setAttribute("data-tooltip", "닉네임 혹은 비밀번호를 확인해주세요.");
				 return false;
			 } else {
				 document.getElementById("updateProfileForm").submit();	
			 }
		}
	

		//완료 버튼 (sns)
		function submitUpdateSetting2() {
			 if (!isValidNicknameForSetting || !isDuplicateNicknameForSetting) {
				 var updateSettingBtn2= document.getElementById("updateSettingBtn2"); // 버튼 요소 가져오기
				 updateSettingBtn2.setAttribute("data-tooltip", "닉네임을 확인해주세요.");
				 return false;
			 } else {
				 document.getElementById("updateProfileForm").submit();	
			 }
		} //완료
	
	
	
	
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