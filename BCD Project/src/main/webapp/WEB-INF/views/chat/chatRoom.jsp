<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../resources/css/chat/chatRoom.css" />
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
	                            <div class="name">Vincent Porter</div>
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
	                                <h3 class="m-b-0">bcd</h3>
	                                <small>참여자 : a,b,c</small>
	                            </div>
	                        </div>
	                        <!-- <div class="col-lg-6 hidden-sm text-right">
	                            <a href="javascript:void(0);" class="btn btn-outline-secondary"><i class="fa fa-camera"></i></a>
	                            <a href="javascript:void(0);" class="btn btn-outline-primary"><i class="fa fa-image"></i></a>
	                            <a href="javascript:void(0);" class="btn btn-outline-info"><i class="fa fa-cogs"></i></a>
	                            <a href="javascript:void(0);" class="btn btn-outline-warning"><i class="fa fa-question"></i></a>
	                        </div> -->
	                    </div>
	                </div>
	                <div class="chat-history">
	                    <ul class="m-b-0">
	                        <li class="clearfix">
	                            <div class="message-data" style="display: flex; justify-content: flex-end;">
	                                <span class="message-data-time">10:10 AM, Today</span>
	                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
	                            </div>
	                            <div class="message other-message float-right"> Hi Aiden, how are you? How is the project coming along? </div>
	                        </li>
	                        <li class="clearfix">
	                            <div class="message-data">
	                                <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="avatar">
	                                <span class="message-data-time">10:12 AM, Today</span>
	                            </div>
	                            <div class="message my-message">Are we meeting today?</div>                                    
	                        </li>                               
	                        <li class="clearfix">
	                            <div class="message-data text-right">
	                                <img src="https://bootdey.com/img/Content/avatar/avatar5.png" alt="avatar">
	                                <span class="message-data-time">10:15 AM, Today</span>
	                            </div>
	                            <div class="message my-message">Project has been already finished and I have results to show you.</div>
	                        </li>
	                    </ul>
	                </div>
	                <div class="chat-message clearfix">
	                    <div class="input-group mb-0">
	                        <input type="text" class="form-control" placeholder="Enter text here...">                                    
	                        <div class="input-group-prepend">
	                            <span class="input-group-text"><i class="fa fa-send"></i></span>
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
</html>