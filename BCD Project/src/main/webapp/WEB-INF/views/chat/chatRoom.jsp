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
		        <h1 class="fw-bold mt-5 mb-5 fs-2 text-center">채팅방 수정</h1>
		        <form class="modifyChatRoomForm" onsubmit="return modifyChatRoom()" action="/chat/modify.do" method="post">
			        <div class="form-floating mb-3">
			            <input type="text" class="form-control rounded-3" id="floatingInput" placeholder="ff" name="title" value=${result.title}>
			            <label for="floatingInput">${result.title }</label>
			            <input type="hidden" name="idx" value="${result.idx }">
			        </div>
		          	<h2 class="fs-5 mb-3 text-center">어떤 주제로 얘기하고 싶나요?</h2>
			         <div class="form-floating mb-3">
			            <select class="form-select" id="floatingSelectGrid" name="bigCategory" onchange="changeCategoryOptions()">
			                <option value="basis" disabled selected>Venti Size</option>
			                <option value="value1" ${result.category == '연애/결혼' || result.category == '가족/친구' || result.category == '학교/직장'|| result.category == '사회/이슈'? 'selected' : ''}>Venti Size</option>
			                <option value="value2" ${result.category == '점메추' || result.category == '깻잎논쟁' || result.category == '할까말까' || result.category == '최애픽'? 'selected' : ''}>Tall Size</option>
			            </select>
			            <label for="floatingSelectGrid">✧˳⁺⁎₊✧˚˳⁺⁎₊𝙋𝙡𝙚𝙖𝙨𝙚 𝙘𝙝𝙤𝙤𝙨𝙚₊⁎⁺˳˚✧₊⁎⁺˳✧</label>
			         </div>
			         <div class="form-floating mb-3">
			          	<select class="form-select" id="smallSelectGrid" name="category">
			               <option value="${result.category}">${result.category}</option>
			               
			            </select>
			            <label for="smallSelectGrid">✧˳⁺⁎₊✧˚˳⁺⁎₊𝙋𝙡𝙚𝙖𝙨𝙚 𝙘𝙝𝙤𝙤𝙨𝙚₊⁎⁺˳˚✧₊⁎⁺˳✧</label>
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
			<c:forEach var="profile" items="${profileMap}" varStatus="loop">        
	                    <li class="d-flex align-items-center">
	                        <img src="${profile.value}" alt="프로필">
	                   <!-- <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">-->
	                        <div class="about">
	                            <div class="name fs-7">${profile.key}</div>
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
								<div class="d-none" id="preChatListDiv"></div>
								<div class="text-center d-none" id ="preChatDiv"></div>
						
								
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
			//console.log("WebSocket connected");
		};
		//서버로부터 받은 메시지(string타입) json형식으로 바꾸기
		let preChatBtnCreated = false;
		socket.onmessage = function(event){
			let message = JSON.parse(event.data);
		//이전 메시지 지금 보이나?
			let isChatVisible = false;
		//메시지가 배열형식이라면	
			if(Array.isArray(message)){
				//입장메시지 포함 배열이니까 1이상
				if(message.length>1 && !preChatBtnCreated){
					preChatBtnCreated = true;
					//이전 메시지 출력할 div
					const preChatListDiv = document.getElementById("preChatListDiv");
					//이전 메시지 버튼 
					const preChatDiv = document.getElementById("preChatDiv");
					preChatDiv.classList.remove("d-none");
					const preChatBtn = document.createElement("button");
					preChatBtn.classList.add("btn", "btn-link");
					preChatBtn.innerText = "이전 대화 보기"; 
					preChatDiv.appendChild(preChatBtn);
					
					for(const chatMsg of message) {
						if(chatMsg.senderIdx == -1){
							continue;
						}else {
							const dbTime = chatMsg.sendDate;
							const formattedDbTime = convertDbTime(dbTime);
							chatMsg.sendDate = formattedDbTime;
							showMessage(chatMsg, "이전메시지" , preChatListDiv);
						}
					
					}
					preChatBtn.addEventListener("click",function(){
						
						if(isChatVisible){
							preChatListDiv.classList.add("d-none");
							isChatVisible=false;
							
						}else {
							preChatListDiv.classList.remove("d-none");
							isChatVisible=true;
						}
						
					});
					
					
				}
				//입장 메시지 출력 (배열에 묶어서 받음)
				for (const chatMsg of message) {
	                if (chatMsg.senderIdx === -1) {
	                    showMessage(chatMsg,  "입장 메시지");
	                }
	            }
				
				
			}
		/*	if(Array.isArray(message.senderNicknameList)){
			message.senderNicknameList.forEach(function(senderNickname) {
				console.log("foreach 실행, showMessage 호출");
				console.log("senderNickname : "+senderNickname);
				showMessage(senderNickname, "보낸 사람");
				});
				/* for(const senderNickname of message.senderNicknameList) {
					//console.log("닉네임 뭐야??: "+senderNickname );
					showMessage(senderNickname);	
				} 
			}*/
		//   if(message.enterMessage){
		//			showMessage(message.enterMessage, "입장 메시지");
		//	}
			
		else{
	        showMessage(message, "실시간 채팅 메시지");	
		}
			
		};
		
		socket.onclose = function(event){
			//console.log("WebSocket disconnected");
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
		function showMessage(message, status){
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
				console.log("입장")
				messageLiTag.appendChild(centerDiv);
				centerDiv.textContent=message.content;
			}
			//퇴장메시지
			else if (message.senderIdx == -2){
				console.log("퇴장")
				messageLiTag.appendChild(centerDiv);
				centerDiv.textContent=message.content;
			}
			//이전메시지
			else if (status == "이전메시지"){
				const preChatListDiv = document.getElementById("preChatListDiv");
				//내가 보낸 메시지 
					if(message.senderIdx == "${memberIdx}"){
						console.log("내가보낸거")
						if(preSenderIdx != message.senderIdx){
							preChatListDiv.appendChild(sendDiv);
							sendDiv.appendChild(sendInfo);
							sendDiv.appendChild(sendMsgDiv);
								sendInfo.appendChild(sendNickname);
									sendNickname.textContent=message.senderNickname;
								sendInfo.appendChild(sendImg);
									sendImg.setAttribute("src", message.memberProfile);
									sendImg.setAttribute("alt", "profile");
								
						}else {
							preChatListDiv.appendChild(sendDiv);
							sendDiv.appendChild(sendMsgDiv);
						}
								sendMsgDiv.appendChild(sendTime);
									sendTime.textContent = message.sendDate;
								sendMsgDiv.appendChild(sendMsg);
									sendMsg.textContent = message.content;
					
					
					//다른 사람이 보낸 메시지	
					}else {
						if(preSenderIdx != message.senderIdx){
							preChatListDiv.appendChild(receiveDiv);
							receiveDiv.appendChild(receiveInfo);
							receiveDiv.appendChild(receiveMsgDiv);
								receiveInfo.appendChild(receiveImg);
									receiveImg.setAttribute("src", message.memberProfile);
									receiveImg.setAttribute("alt", "profile");
								receiveInfo.appendChild(receiveNickname);
									console.log("보낸사람 닉네임 : " + message);
									console.log("상태 : " + status);
									receiveNickname.textContent=message.senderNickname;
						}else {
							console.log("else")
							preChatListDiv.appendChild(receiveDiv);
							receiveDiv.appendChild(receiveMsgDiv);
						}
							receiveMsgDiv.appendChild(receiveMsg);
								receiveMsg.textContent = message.content;
							receiveMsgDiv.appendChild(receiveTime);
								receiveTime.textContent = message.sendDate;
						
					}
					preSenderIdx = message.senderIdx;
				
			}
			//내가 보낸 메시지 
			else if(message.senderIdx == "${memberIdx}"){
				console.log("내가보낸거")
				if(preSenderIdx != message.senderIdx){
					messageLiTag.appendChild(sendDiv);
					sendDiv.appendChild(sendInfo);
					sendDiv.appendChild(sendMsgDiv);
						sendInfo.appendChild(sendNickname);
							sendNickname.textContent=message.senderNickname;
						sendInfo.appendChild(sendImg);
							sendImg.setAttribute("src", message.memberProfile);
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
							receiveImg.setAttribute("src", message.memberProfile);
							receiveImg.setAttribute("alt", "profile");
						receiveInfo.appendChild(receiveNickname);
							console.log("보낸사람 닉네임 : " + message);
							console.log("상태 : " + status);
							receiveNickname.textContent=message.senderNickname;
				}else {
					console.log("else")
					messageLiTag.appendChild(receiveDiv);
					receiveDiv.appendChild(receiveMsgDiv);
				}
					receiveMsgDiv.appendChild(receiveMsg);
						receiveMsg.textContent = message.content;
					receiveMsgDiv.appendChild(receiveTime);
						receiveTime.textContent = message.sendDate;
				
			}
		//	console.log("전:"+preSenderIdx);
			preSenderIdx = message.senderIdx;
		//	console.log("후:"+preSenderIdx);
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
			if("${result.participants}"=="${memberNickname}"){
				const chatRoomClose = confirm ("*당신은 마지막 멤버* \n지금 나가시면 채팅방이 삭제됩니다. \n정말 나가시겠습니까?");
				if(chatRoomClose) {
					socket.onclose;
					location.href="/chat/list.do";
				}
				
				
			}else{
				
				const exitConfirm = confirm("채팅방을 나가시겠습니까?");
				
				if(exitConfirm) {
					socket.onclose;
					location.href="/chat/list.do";
				}
			}
		});
		
	
		
	}
		
 		/*  모달창  */ 
   		const modifyBtn = document.getElementById("modifyBtn");
		const closeModalBtn3 = document.getElementById("closeModalBtn3");
		modifyBtn.addEventListener("click", function() {
			if("${memberNickname}"== "${roomOwner}"){
				modifyModal.classList.remove("d-none");
			}else {
				alert("채팅방은 방장만 수정 가능합니다.");
			}
		});
		closeModalBtn3.addEventListener("click", function() {
			modifyBtn.classList.add("d-none");
		     location.reload();
		});
		
		//모달폼
		const modifyChatRoomForm = document.querySelector(".modifyChatRoomForm"); 
		function modifyChatRoom(){
			
			event.preventDefault();
			console.log("모달에 들어왔니??");
			//모달폼에서 입력한 값
			let title = modifyChatRoomForm.title.value;
			console.log("input title:"+title);
			//let bigCategory = modifyChatRoomForm.bigCategory.value;
			let category = modifyChatRoomForm.category.value;
			console.log("input 카테:"+category);
			//DB 저장된 값
			let originTitle = "${result.title}";
			let originCategory = "${result.category}";
			console.log("origin카테 : "+ originTitle);
			console.log("origin타이틀 : "+ originCategory);
			
	
			if(category === "basis"){
				category = originCategory;
			} 
			
			let isTitleChange = (title != originTitle);
			let isCategoryChange = (category != originCategory);
			
			console.log(" title:"+title);
			console.log(" category:"+category);
			console.log("타이틀 바뀌었나??"+isTitleChange);
			console.log("타이틀 바뀌었나??"+isCategoryChange);
			
			
			if(!isTitleChange && !isCategoryChange) {
				alert("변경된 내용이 없습니다.");
				return;
			} 
		
			
				console.log(" 제출전title:"+title);
				console.log(" 제출전category:"+category);
				console.log("폼 : "+modifyChatRoomForm.title.value);
				console.log("폼 : "+modifyChatRoomForm.category.value);
				modifyChatRoomForm.submit();
			
			
		}
		
		function changeCategoryOptions(){
			const bigCategorySelect = document.getElementById("floatingSelectGrid");
			const smallCategorySelect = document.getElementById("smallSelectGrid");
			const selectedCategory = "${result.category}";
			
			
			if(bigCategorySelect.value == "basis" || bigCategorySelect.value == "" || bigCategorySelect.value == null ){
				//console.log(bigCategorySelect.value);
				smallCategorySelect.innerHTML = `
		            <option value="basis" disabled>${result.category}</option>
		        `;
			}
			
			 if(bigCategorySelect.value == "value1") {
				//console.log(bigCategorySelect.value);
				smallCategorySelect.innerHTML = `
					<option value="basis" >세세한 분류</option>
	                <option value="연애/결혼">연애/결혼</option>
	                <option value="가족/친구">가족/친구</option>
	                <option value="학교/직장">학교/직장</option>
	                <option value="사회/이슈">사회/이슈</option>
	            `;
			}
			else if(bigCategorySelect.value == "value2") {
				smallCategorySelect.innerHTML = `
					<option value="basis">세세한 분류</option>
	                <option value="점메추">점메추</option>
	                <option value="깻잎논쟁">깻잎논쟁</option>
	                <option value="할까말까">할까말까</option>
	                <option value="최애픽">최애픽</option>
	            `;
			}
			
		}
		
		
		/*  모달창 끝 */
		
		
	

		
		
		
	
</script>
</html>
