<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../resources/css/chat/chatRoom.css" />
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
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search...">
                    <div class="input-group-prepend">
                        <button class="input-group-text"><i class="bi bi-search"></i></button>
                    </div>
                </div>
	                <ul class="list-unstyled chat-list mt-2 mb-0 ">
	                    <li class="d-flex">
	                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
	                        <div class="about">
	                            <div class="name fs-3 mt-1">${memberNickname }</div>
	                        </div>
	                    </li>
	                    <li class="d-flex">
	                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
	                        <div class="about">
	                            <div class="name fs-3 mt-1">${memberNickname }</div>
	                        </div>
	                    </li>
	                </ul>
            </div>
	            
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
	                                <small>참여자 ${participantsSize}명 : ${result.participants }</small>
	</c:otherwise>
</c:choose>	                                
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="chat-history">
	                    <ul class="m-b-0">
<c:choose>
	
	<c:when test="${memberNickname == 'Nickname 3'}">
							<li class="clearfix">
	                            <div class="message-data" style="display: flex; justify-content: flex-end;">
	                                <span class="message-data-time" id="messageTime"></span>
	                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
	                            </div>
	                            <div class="message other-message float-right" id="messageArea"></div>
	                        </li>
	</c:when>
	<c:otherwise>
							<li class="clearfix">
								<div class="message-data">
	                                <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="avatar">
	                                <span class="message-data-time" id="messageTime"></span>
	                            </div>
	                            <div class="message my-message" id="messageArea"></div>                                    
							</li>
	</c:otherwise>
</c:choose>	                 
	                    </ul>
	                </div>
	                <div class="chat-message clearfix">
	                    <div class="input-group mb-0">
	                        <input type="text" class="form-control" placeholder="Enter text here..." id="messageInput">                                    
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

<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">
	
	const baseUrl = "http://localhost:8080";
	const socket = new WebSocket(`${baseUrl}/chat/enter.do?idx=${idx}`);
	socket.setRequestHeader("Upgrade", "websocket");
	console.log(baseUrl);
	console.log(`${baseUrl}?idx=${result.idx}`);
	
	
	socket.onopen = function(event){
		console.log("연결됐니 연결 좀 시켜주라 WebSocket connected");
	};
	
	socket.onmessage = function(event){
		const msg = event.data;
		showMessage(msg);
	};
	
	socket.onclose = function(event){
		console.log("WebSocket disconnected");
	};
	
	
	function showMessage(message){
		const messageArea = document.getElementById("messageArea");
		messageArea.innerHTML += message;
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
	
	
</script>
</html>