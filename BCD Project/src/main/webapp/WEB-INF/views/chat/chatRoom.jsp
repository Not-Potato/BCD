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
    <script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
    <%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/header.jsp" %>
<div class="container">
	<div class="row clearfix mt-5">
	    <div class="col-lg-12">
	        <div class="card chat-app">
	            <div id="plist" class="people-list">
	                <div class="input-group">
	                    <input type="text" class="form-control" placeholder="Search...">
	                    <div class="input-group-prepend">
	                        <span class="input-group-text"><i class="fa fa-search"></i></span>
	                    </div>
	                </div>
	                <ul class="list-unstyled chat-list mt-2 mb-0">
	                    <li class="clearfix">
	                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
	                        <div class="about">
	                            <div class="name">${memberNickname }</div>
	                            <div class="status"> <i class="fa fa-circle offline"></i> left 7 mins ago </div>                                            
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
	<c:when test="${empty chatRoom }">
									<h3 class="m-b-0">bcd</h3>
	                                <small>참여자 : a,b,c</small>
	</c:when>
	<c:otherwise>
	                                <h3 class="m-b-0">${chatRoom.title }</h3>
	                                <small>${chatRoom.participants }</small>
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
	                                <span class="message-data-time">10:10 AM, Today</span>
	                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
	                            </div>
	                            <div class="message other-message float-right" id="messageArea"></div>
	                        </li>
	</c:when>
	<c:otherwise>
							<li class="clearfix">
								<div class="message-data">
	                                <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="avatar">
	                                <span class="message-data-time">10:12 AM, Today</span>
	                            </div>
	                            <div class="message my-message" id="messageArea"></div>                                    
							</li>
	</c:otherwise>
</c:choose>	                 
	                    </ul>
	                </div>
	                <div class="chat-message clearfix">
	                    <div class="input-group mb-0">
	                        <input type="text" class="form-control" placeholder="Enter text here...">                                    
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
	$("#sendBtn").click(function(){
		sendMessage();
		$('#message').val('');
	});
	
	let sock = new SockJS("http://localhost:8080/chat/create.do/");
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	
	function sendMessage(){
		sock.send($("message").val());
	}
	function onMessage(msg){
		var data = msg.data;
		$("#messageArea").append(data + "<br/>");
	}
	function onClose(){
		$("#messageArea").append("퇴장");
	}
</script>
</html>