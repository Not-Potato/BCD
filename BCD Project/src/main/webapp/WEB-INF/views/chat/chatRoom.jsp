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

	<!-- 모달창 -->
   	<div class="modal modal-signin position-fixed d-block py-5 backdrop d-none" tabindex="-1" role="dialog" id="modifyModal" >
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content rounded-4 shadow">
	    <!-- 모달 header -->
	        <div class="modal-header pl-1 pb-2 pt-2 pr-1 pt-0">
		        <img src="../../resources/images/logo.svg" alt="Logo" style="height:30px; width:60px;"/>   
      			<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close" id="closeModalBtn3"></button> 
      			<hr>
     		</div>
     		<!-- 모달 body -->
	      	<div class="modal-body p-5 pt-0">
		        <h1 class="fw-bold mt-5 mb-5 fs-2 text-center">채팅방 만들기</h1>
		        <form class="modifyChatRoomForm" onsubmit="return modifyChatRoom()" action="/chat/modify.do" method="post">
			        <div class="form-floating mb-3">
			            <input type="text" class="form-control rounded-3" id="floatingInput" placeholder="ff" name="title">
			            <label for="floatingInput">${result.title }</label>
			        </div>
		          	<h2 class="fs-5 mb-3 text-center">어떤 주제로 얘기하고 싶나요?</h2>
			         <div class="form-floating mb-3">
			            <select class="form-select" id="floatingSelectGrid" name="bigCategory" onchange="changeCategoryOptions()">
			                <option value="basis" selected>큰 분류</option>
			                <option value="value1">무거운 주제</option>
			                <option value="value2">가벼운 주제</option>
			            </select>
			            <label for="floatingSelectGrid">크게</label>
			         </div>
			         <div class="form-floating mb-3">
			          	<select class="form-select" id="smallSelectGrid" name="category">
			                <option value="basis" selected>세세한 분류</option>
			               
			            </select>
			            <label for="smallSelectGrid">작게</label>
			         </div>
		          	  <hr class="my-4">
		              <button class="w-100 mb-2 btn btn-lg rounded-3 btn-primary">수정하기</button>
	        	</form>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 끝 -->

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
	                <ul class="list-unstyled chat-list me-0 mb-0">
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
	                <div class="d-flex align-items-end">
	                	 <button class="btn btn-outline-secondary" id="exitBtn"><i class="bi bi-escape"></i> 나가기</button>
	                </div>
            </div>
	          <div> 
	            <div class="chat">
	                	<button class="input-group-text float-end mt-0 me-0" id="modifyBtn"><i class="bi bi-eraser-fill me-1"></i> 채팅방 수정</button>
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
	                <div class="chat-history">
	                    <ul class="m-b-0" >
							<li class="clearfix" id="messageLiTag">
								
								
								<!-- 메시지 공간 -->
								
								
							</li>
				        </ul>
	                </div>
	 				
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
		const exitBtn = document.getElementById("exitBtn");
	
		socket.onopen = function(event){
			console.log("WebSocket connected");
		};
		//서버로부터 받은 메시지(string타입) json형식으로 바꾸기
		socket.onmessage = function(event){
			let message = JSON.parse(event.data);
			if(Array.isArray(message)){
				for(const msg of message) {
					const dbTime = msg.sendDate;
					const formattedDbTime = convertDbTime(dbTime);
					
					msg.sendDate = formattedDbTime;
					showMessage(msg);	
				}
			}else {
				console.log("Received WebSocket message:", message);
				showMessage(message);	
			}
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
	        const formattedMinutes = minutes < 10 ? '0' + minutes 
	        : minutes;
	        return month + "월" + day + "일" +" "+ formattedHours + ':' + formattedMinutes + ' ' + ampm;
	    };
	    
	    function convertDbTime(timeStr) {
	        const serverTime = new Date(timeStr);
	        const month = serverTime.getMonth() + 1;
	        const day = serverTime.getDate();
	        const hours = serverTime.getHours();
	        const minutes = serverTime.getMinutes();
	        const ampm = hours >= 12 ? 'PM' : 'AM';
	        const formattedHours = hours % 12 === 0 ? 12 : hours % 12;
	        const formattedMinutes = minutes < 10 ? '0' + minutes : minutes;
	        return month + "월 " + day + "일 " + formattedHours + ':' + formattedMinutes + ' ' + ampm;
	    };
	    
		
		//메시지 출력
	    let preSenderIdx = null;
		function showMessage(message){
			scrollLatest();
			//appendchild할 공간
			const messageLiTag = document.getElementById("messageLiTag");
			//입장 메시지 공간
			const centerDiv = document.createElement("div");
			centerDiv.classList.add("text-center");
			//발신 
			const sendDiv = document.createElement("div");
			sendDiv.classList.add("d-flex", "align-items-end", "flex-column" , "mb-1");
				//닉네임,사진
				const sendInfo = document.createElement("div");
				sendInfo.classList.add("d-flex", "message-data", "align-items-center", "mb-1");
					const sendNickname = document.createElement("p");
					sendNickname.classList.add("name", "mb-0");
					const sendImg = document.createElement("img");
				//메시지
				const sendMsgDiv = document.createElement("div");
				sendMsgDiv.classList.add("d-flex", "align-items-end");
					const sendTime = document.createElement("div");
					sendTime.classList.add("message-data-time", "mb-0", "me-3");
					const sendMsg = document.createElement("div");
					sendMsg.classList.add("message", "my-message");
			
			//수신  
			const receiveDiv = document.createElement("div");
			receiveDiv.classList.add("d-flex", "align-items-start", "flex-column", "mb-1");
				//닉네임,사진
				const receiveInfo = document.createElement("div");
				receiveInfo.classList.add("d-flex", "message-data", "align-items-center", "mb-1");
					const receiveImg = document.createElement("img");
					const receiveNickname = document.createElement("p");
					receiveNickname.classList.add("name", "mb-0","me-2");
				//메시지
				const receiveMsgDiv = document.createElement("div");
				receiveMsgDiv.classList.add("d-flex", "align-items-end");
					const receiveMsg = document.createElement("div");
					receiveMsg.classList.add("message", "other-message");
					const receiveTime = document.createElement("div");
					receiveTime.classList.add("message-data-time", "mb-0", "me-3");
			
			
			//입장메시지
			if(message.senderIdx == -1){
				messageLiTag.appendChild(centerDiv);
				centerDiv.textContent=message.content;
			}
			//퇴장메시지
			else if (message.senderIdx == -2){
				messageLiTag.appendChild(centerDiv);
				centerDiv.textContent=message.content;
			}
			//내가 보낸 메시지 
			else if(message.senderIdx == "${memberIdx}"){
				if(preSenderIdx != message.senderIdx){
					messageLiTag.appendChild(sendDiv);
					sendDiv.appendChild(sendInfo);
					sendDiv.appendChild(sendMsgDiv);
						sendInfo.appendChild(sendNickname);
							sendNickname.textContent="${memberNickname}";
						sendInfo.appendChild(sendImg);
							sendImg.setAttribute("src", "https://bootdey.com/img/Content/avatar/avatar7.png");
							sendImg.setAttribute("alt", "profile");
						
				}else {
					messageLiTag.appendChild(sendDiv);
					sendDiv.appendChild(sendMsgDiv);
				}
						sendMsgDiv.appendChild(sendTime);
							sendTime.textContent = message.sendDate;
						sendMsgDiv.appendChild(sendMsg);
							sendMsg.textContent = message.content;
				
				
			//다른 사람이 보낸 메시지	
			}else {
				if(preSenderIdx != message.senderIdx){
					messageLiTag.appendChild(receiveDiv);
					receiveDiv.appendChild(receiveInfo);
					receiveDiv.appendChild(receiveMsgDiv);
						receiveInfo.appendChild(receiveImg);
							receiveImg.setAttribute("src", "https://bootdey.com/img/Content/avatar/avatar7.png");
							receiveImg.setAttribute("alt", "profile");
						receiveInfo.appendChild(receiveNickname);
							receiveNickname.textContent="${memberNickname}";
				}else {
					messageLiTag.appendChild(receiveDiv);
					receiveDiv.appendChild(receiveMsgDiv);
				}
					receiveMsgDiv.appendChild(receiveMsg);
						receiveMsg.textContent = message.content;
					receiveMsgDiv.appendChild(receiveTime);
						receiveTime.textContent = message.sendDate;
				
			}
			console.log("전:"+preSenderIdx);
			preSenderIdx = message.senderIdx;
			console.log("후:"+preSenderIdx);
		}
		
		function sendMessage(){
			
			const messageInput = document.getElementById("messageInput");
			const senderIdx = "${memberIdx}";
			const roomIdx = "${result.idx}";
			const content = messageInput.value;
			const sendDate = getCurrentTime();
			
			const message = {
					roomIdx : roomIdx,
					senderIdx : senderIdx,
					content : content,
					sendDate : sendDate
			};
			//js객체를 JSON형식의 문자열로 변환해서 handler로 보냄
			const jsonMessage = JSON.stringify(message);
			
			socket.send(jsonMessage);
			messageInput.value = "";
			
		}
		
		//버튼 누르면 전송 
		document.getElementById("sendBtn").addEventListener("click", function(){
		    sendMessage();
		});
		//엔터 누르면 전송
		messageInput.addEventListener("keydown", (event) => {
			if (event.key == "Enter") {
				sendMessage();
			}
		});
		//스크롤 최신 메시지 
		function scrollLatest(){
			const chatHistory = document.querySelector(".chat-history");
			chatHistory.scrollTop = chatHistory.scrollHeight;
		};
		
		
		exitBtn.addEventListener("click", function(){
			const exitConfirm = confirm("채팅방을 나가시겠습니까?");
			
			if(exitConfirm) {
				socket.onclose;
				console.log("연결해제");
				location.href="/chat/list.do";
			}
		});
		
		
 		/*  모달창  */ 
   		const modifyBtn = document.getElementById("modifyBtn");
		const closeModalBtn3 = document.getElementById("closeModalBtn3");
		modifyBtn.addEventListener("click", function() {
			modifyModal.classList.remove("d-none");
		});
		closeModalBtn3.addEventListener("click", function() {
			modifyBtn.classList.add("d-none");
		     location.reload();
		});
		
		//모달폼
		const modifyChatRoomForm = document.querySelector(".modifyChatRoomForm"); 
		function modifyChatRoom(){
			//모달폼에서 입력한 값
			const title = modifyChatRoomForm.title.value;
			const bigCategory = modifyChatRoomForm.bigCategory.value;
			const smallCategory = modifyChatRoomForm.smallCategory.value;
			//DB 저장된 값
			const originTitle = "${result.title}";
			const originCategory = "${result.category}";
			
			const isTitleChange = (title != originTitle);
			const isCategoryChange = (category != originCategory);
			
			if(!isTitleChange && !isCategoryChange) {
				alert("변경된 내용이 없습니다.");
				return;
			} 
			if(!isTitleChange || title == "" || title == null){
				title = originTitle;
			}
			if(!isCategoryChange || category == "" || category == null){
				category = originCategory;
			}
			
			modifyChatRoomForm.submit();
		}
		
		function changeCategoryOptions(){
			const bigCategorySelect = document.getElementById("floatingSelectGrid");
			const smallCategorySelect = document.getElementById("smallSelectGrid");
			
			if(bigCategorySelect.value == "basis" || bigCategorySelect.value == "" || bigCategorySelect.value == null ){
				console.log(bigCategorySelect.value);
				smallCategorySelect.innerHTML = `
		            <option value="basis" selected>세세한 분류</option>
		        `;
			}
			
			else if(bigCategorySelect.value == "value1") {
				console.log(bigCategorySelect.value);
				smallCategorySelect.innerHTML = `
					<option value="basis" selected>세세한 분류</option>
	                <option value="진로">진로</option>
	                <option value="돈">돈</option>
	            `;
			}
			else if(bigCategorySelect.value == "value2") {
				smallCategorySelect.innerHTML = `
					<option value="basis" selected>세세한 분류</option>
	                <option value="음식">음식</option>
	                <option value="옷">옷</option>
	            `;
			}
			
		}
		
		
		/*  모달창 끝 */
		
		
	}

		
		
		
	
</script>
</html>
