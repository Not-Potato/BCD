<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 네이버 로그인 정보 : naverLogin.jsp 를 import하는 법은 없을까 -->
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!-- 현재 URL 가져오기 -->
<%
    // 현재 URL 가져오기
    String currentUrl = request.getRequestURL().toString();
    // 세션에 현재 URL 저장
    session.setAttribute("currentUrl", currentUrl);
%>


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../../resources/css/common/modal.css" />

</head>
<body>
<!-- 네이버 로그인 정보  -->
 <%
    String clientId = "VH0vES0K33odVfIDgWKi";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/member/loginResult", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    //session.setAttribute("state", state);
 %>


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
	                        	<button class="py-2 btn btn-outline-dark rounded-3" type="submit" id="phoneRegisterBtn" style="height:70px; width:300px;">
	                            	휴대전화 로그인
	                        	</button>
	                    	</div>    
	                    </div>
	                    <div class="row mt-3">
	                    	<div class="col-md mb-3">
	                          <%--   <a href="<%=apiURL%>"><img  src="../../resources/images/btnG.png" alt="Naver" id="naverLoginBtn" style="height:70px; width:366px;" /></a>  --%>
	                             <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG" /></a>  
	                    	</div> 
	                    </div>
	                    
	                    <div class="row mt-3">
	                    	<div class="col-md mb-3">
	                            <a href="https://kauth.kakao.com/oauth/authorize?client_id=0a1b520b1d14379b7230e168bd69de63&redirect_uri=http://localhost:8080/member/kakaoLogin&response_type=code&scope=account_email">
	                            <img src="../../resources/images/kakaoM.png" alt="Kakao" id="kakaoLoginBtn"/></a>   	                        
	                        </div>                
	        			</div>  
        			</div>
    		</div>
    		
		</div>
	</div>
</div>

<%@ include file="../member/nicknameModal.jsp" %>

<script>

//page.1 로그인 형태 (phone vs naver vs kakao ) 
 // const loginBtn = document.getElementById("loginBtn");
  const closeModalSignin = document.getElementById("closeModalSignin");
  const phoneRegisterBtn = document.getElementById("phoneRegisterBtn");
  /* loginBtn.addEventListener("click", function() {
	  modalSignin.classList.remove("d-none"); //modalSignin 열기
  }); */
  
  closeModalSignin.addEventListener("click", function() {
	  modalSignin.classList.add("d-none"); //modalSignin 닫기
     // location.reload();
  });
  
  
  phoneRegisterBtn.addEventListener("click", function() {
	 	modalSignin.classList.add("d-none"); //modalSignin 닫기
	 	modalNickname.classList.remove("d-none"); // modalNickname 열기
	 	});
//end of page.1 로그인 형태 (phone vs naver vs kakao )       


</script>

</body>
</html>