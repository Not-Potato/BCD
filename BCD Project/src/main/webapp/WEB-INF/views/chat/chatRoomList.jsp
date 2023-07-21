<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<title>Chat</title>
	<style>
		    .backdrop {
    background-color: rgba(0, 0, 0, 0.5); 
    z-index: 1050;
    }


    .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      user-select: none;
    }

    @media (min-width: 768px) {
      .bd-placeholder-img-lg {
        font-size: 3.5rem;
      }
    }

    .b-example-divider {
      height: 3rem;
      background-color: rgba(0, 0, 0, .1);
      border: solid rgba(0, 0, 0, .15);
      border-width: 1px 0;
      box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
    }

    .b-example-vr {
      flex-shrink: 0;
      width: 1.5rem;
      height: 100vh;
    }

    .bi {
      vertical-align: -.125em;
      fill: currentColor;
    }

    .nav-scroller {
      position: relative;
      z-index: 2;
      height: 2.75rem;
      overflow-y: hidden;
    }

    .nav-scroller .nav {
      display: flex;
      flex-wrap: nowrap;
      padding-bottom: 1rem;
      margin-top: -1px;
      overflow-x: auto;
      text-align: center;
      white-space: nowrap;
      -webkit-overflow-scrolling: touch;
    }
	</style>
</head>
	<body>
	
	
      	<div class="modal modal-signin position-fixed d-block bg-opacity-20 py-5 backdrop" tabindex="-1" role="dialog" id="CreateRoom" >
		  <div class="modal-dialog modal-dialog-centered " role="document">
		    <div class="modal-content rounded-4 shadow">
		        <div class="modal-header pl-1 pb-2 pt-2 pr-1 pt-0">
			        <h5 class="fw-bold mb-0 fs-4">BCD LOGO</h5>
       				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="closeModal()"></button> 
       				<hr>
      				</div>
		      	<div class="modal-body p-5 pt-0">
			        <h1 class="fw-bold mt-5 mb-5 fs-2 text-center">채팅방 만들기</h1>
			        <form class="">
				        <div class="form-floating mb-3">
				            <input type="text" class="form-control rounded-3" id="floatingInput" placeholder="ff">
				            <label for="floatingInput">채팅방 이름</label>
				        </div>
			          	<h2 class="fs-5 mb-3 text-center">어떤 주제로 얘기하고 싶나요?</h2>
				         <div class="form-floating mb-3">
				            <select class="form-control rounded-3">
				                <option value="value1">큰 분류</option>
				                <option value="value1">무거운 주제</option>
				                <option value="value2">가벼운 주제</option>
				            </select>
				            <select class="form-control rounded-3 mt-2">
				                <option value="value1">세세한 분류</option>
				                <option value="value1">음식</option>
				                <option value="value2">옷</option>
				            </select>
				          </div>
			          	  <hr class="my-4">
			              <button class="w-100 mb-2 btn btn-lg rounded-3 btn-primary">입장하기</button>
		        	</form>
		      </div>
		    </div>
		  </div>
		</div>
	    <div class="container">
	        <div class="row">
	            <div class="col-xl-3 col-sm-6">
	                <div class="card">
	                    <div class="card-body">
	                        <div class="dropdown float-end">
	                            <a class="text-muted dropdown-toggle font-size-16" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true"><i class="bx bx-dots-horizontal-rounded"></i></a>
	                            <div class="dropdown-menu dropdown-menu-end"><a class="dropdown-item" href="#">Edit</a><a class="dropdown-item" href="#">Action</a><a class="dropdown-item" href="#">Remove</a></div>
	                        </div>
	                        <div class="d-flex align-items-center">
	                            <div><img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" class="avatar-md rounded-circle img-thumbnail" /></div>
	                            <div class="flex-1 ms-3">
	                                <h5 class="font-size-16 mb-1"><a href="#" class="text-dark">Phyllis Gatlin</a></h5>
	                                <span class="badge badge-soft-success mb-0">Full Stack Developer</span>
	                            </div>
	                        </div>
	                        <div class="mt-3 pt-1">
	                            <p class="text-muted mb-0"><i class="mdi mdi-phone font-size-15 align-middle pe-2 text-primary"></i> 070 2860 5375</p>
	                            <p class="text-muted mb-0 mt-2"><i class="mdi mdi-email font-size-15 align-middle pe-2 text-primary"></i> PhyllisGatlin@spy.com</p>
	                            <p class="text-muted mb-0 mt-2"><i class="mdi mdi-google-maps font-size-15 align-middle pe-2 text-primary"></i> 52 Ilchester MYBSTER 9WX</p>
	                        </div>
	                        <div class="d-flex gap-2 pt-4">
	                            <button type="button" class="btn btn-soft-primary btn-sm w-50"><i class="bx bx-user me-1"></i> Profile</button>
	                            <button type="button" class="btn btn-primary btn-sm w-50"><i class="bx bx-message-square-dots me-1"></i> Contact</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="mb-3" style="text-align: right;">
	            <button class="btn btn-primary" data-toggle="modal" onclick="openModal()">방 만들기</button>
	        </div>
    	</div>
 <script>

	const createRoom=document.getElementById("CreateRoom");
	createRoom.style.display = "none";
	
	function openModal(){
		createRoom.style.display = "block";
	}

	function closeModal(){
		// 모달을 숨기는 코드
		createRoom.style.display = "none";
	}
		
</script>
	</body>
</html>


		
