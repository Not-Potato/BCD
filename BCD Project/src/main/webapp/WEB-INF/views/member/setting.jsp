<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> BCD | MyPage</title>
</head>

<body>
     <div class="container pt-5 pb-5" style="width: 850px;">

        <div class="mb-5">
            <h2 class="fw-bold mb-5">내 정보 수정</h2>
            <div class="">
                <div class="mb-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100px" height="100" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
                        <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
                    </svg>
               </div>
                <div class="d-flex gap-2 pt-4">
                    <input type="checkbox" class="btn-check" id="btn-check-outlined" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btn-check-outlined">이미지 선택</label><br>
                    <input type="radio" class="btn-check" name="options-outlined" id="danger-outlined" autocomplete="off">
                    <label class="btn btn-outline-danger" for="danger-outlined">이미지 제거</label>
                </div>
            </div>
        </div>

        <hr>

            <div class="row pt-4">
                <div class= "row pt-4 mb-5">
                    <h3 class="col-5 fw-bold">닉네임</h3>
                    <input class="col-7" type="text" placeholder="" style="height: 30px">
        
                </div>
                <span>BDC에서 사용되는 이름입니다.</span>
                <hr>
            </div> 

            
            <div class="row pt-4">
                <div class= "row pt-4 mb-2">
                    <h3 class="col-5 fw-bold">비밀번호</h3>
                    <input class="col-7" type="text" placeholder="" style="height: 30px">
                </div>
              <div class= "row pt-4 mb-5">
                    <h3 class="col-5 fw-bold">비밀번호 확인</h3>
                    <input class="col-7" type="text" placeholder="" style="height: 30px">
                </div>
                <br><br><br>
                <hr>
            </div> 

            <div class="row justify-content-end mt-4">
                <div class="col-1 p-0" style="white-space: nowrap;">
                    <input type="checkbox" class="btn-check" id="btn-check-2" checked autocomplete="off">
                    <label class="btn btn-primary" for="btn-check-2">완료</label>
                </div>
                <div class="col-1 p-0" style="white-space: nowrap;">
                    <input type="checkbox" class="btn-check" id="btn-check-2" checked autocomplete="off">
                    <label class="btn btn-danger" for="btn-check-2">회원탈퇴</label>
                </div>
            </div>
    </div>

</body>
</html>