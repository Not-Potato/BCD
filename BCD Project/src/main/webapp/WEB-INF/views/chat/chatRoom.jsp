<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../resources/css/chat/chatRoom.css" />
    <link rel="stylesheet" href="../../resources/css/common/reset.css" />
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row clearfix">
    <div class="col-lg-12">
        <div class="card chat-app">
            <div id="plist" class="people-list">
                <div class="text-center">
	                <h3 class="mb-0">
	                	<i class="bi bi-people-fill"></i> 이야기 메이트
	                </h3>
	                <hr class="mb-0">
                </div>
	                <ul class="list-unstyled chat-list me-0">
<c:choose>
	<c:when test="${not empty participantsList}">
			<c:forEach var="item" items="${participantsList}" varStatus="loop">        
	                    <li class="d-flex align-items-center">
	                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
	                        <div class="about">
	                            <div class="name fs-7">${item}</div>
	                        </div>
	                    </li>
	         </c:forEach>      
	</c:when>			
	<c:otherwise>
						<li class="d-flex align-items-center">
	                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
	                        <div class="about">
	                            <div class="name fs-7">${memberNickname}</div>
	                        </div>
	                    </li>
	</c:otherwise>
</c:choose>	        
	                </ul>
            </div>
	          <div> 
	            <div class="chat">
	                <div class="chat-header clearfix">
	                    <div class="row">
	                        <div class="col-lg-6">
	                            <div class="chat-about">
<c:choose>
	<c:when test="${empty result }">
									<h3 class="m-b-0">bcd</h3>
	                                <small>참여자 : a,b,c</small>
	</c:when>
	<c:otherwise>
	                                <h3 class="m-b-0">${result.title }</h3>
	                                <small>참여자 ${participantsSize}명</small>
	</c:otherwise>
</c:choose>	                                
	                            </div>
	                        </div>
	                    </div>
	                </div>
<c:choose>
	<c:when test="${memberNickname == 'Nickname 3'}">
	                <div class="chat-history">
	                    <ul class="m-b-0" >
							<li class="clearfix">
								<div class="d-flex align-items-end flex-column" id="myMessage">
									<div class="d-flex message-data align-items-center mb-1">
										<p class ="name mb-0">${ memberNickname }</p>
										<img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
									</div>
									<div class="d-flex align-items-end">
										<div><p class="message-data-time mb-0 me-3" id="messageTime"></p></div>
										<div class="message my-message" id="messageArea"></div>
									</div>
								</div>
	                        </li>
					    </ul>
	                </div>
	</c:when>
	<c:otherwise>
	 				<div class="chat-history">
	                    <ul class="m-b-0" >
							  <li class="clearfix">
								<div class="d-flex align-items-start flex-column" id="otherMessage">
									<div class="d-flex message-data align-items-center mb-1">
										<img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
										<p class ="name mb-0 me-2">${memberNickname }</p>
									</div>
									<div class="d-flex align-items-end">
										<div class="message other-message" id="messageArea"></div>
										<div><p class="message-data-time mb-0 me-3" id="messageTime"></p></div>
									</div>
								</div>
							</li>
				        </ul>
	                </div>
	</c:otherwise>
</c:choose>	                 
	                <div class="chat-message mb-0">
	                    <div class="input-group">
	                        <input type="text" class="form-control align-items-end" placeholder="Enter text here..." id="messageInput">                                    
	                        <div class="input-group-prepend">
	                            <button class="input-group-text" id="sendBtn"><i class="bi bi-chat-fill"></i></button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            </div> 
	        </div>
	    </div>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">
	
	//채팅방 입장시 서버연결
	connect();
	
	function connect(){
		const socket = new WebSocket("ws://localhost:8080/chatMsg/${result.idx}");
	
		socket.onopen = function(event){
			console.log("WebSocket connected");
		};
		
		socket.onmessage = function(event){
			const msg = event.data;
			showMessage(msg);
		};
		
		socket.onclose = function(event){
			console.log("WebSocket disconnected");
		};
		
		 function getCurrentTime() {
		        const now = new Date();
		        const month = now.getMonth()+1;
		        const day = now.getDate();
		        const hours = now.getHours();
		        const minutes = now.getMinutes();
		        const ampm = hours >= 12 ? 'PM' : 'AM';
		        const formattedHours = hours % 12 === 0 ? 12 : hours % 12;
		        const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;
		        return month + "월" + day + "일" +" "+ formattedHours + ':' + formattedMinutes + ' ' + ampm;
		    };
		
		
		
		//메시지 출력
		function showMessage(message){
			const messageArea = document.getElementById("messageArea");
			messageArea.innerHTML += message;
			
			const messageTime = document.getElementById("messageTime");
			messageTime.textContent += getCurrentTime();
		}
		function sendMessage(){
			const messageInput = document.getElementById("messageInput");
			const message = messageInput.value;
			socket.send(message);
			messageInput.value = "";
		}
		
		
		document.getElementById("sendBtn").addEventListener("click", function(){
		    sendMessage();
		});
	
	}
</script>
</html>