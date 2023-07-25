<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="Team.애쓰지워너비">
<title>BCD Project</title>

<link href="../../../resources/css/common/reset.css" rel="stylesheet" >
<link href="/resources/css/common/custom.css" rel="stylesheet" >

<!-- JQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<!-- bootstrap icon font CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<!-- 파비콘 -->
<link rel="icon" href="../../../resources/images/favicon.svg">

<!-- tooltip css -->
<link rel="stylesheet" href="../../../resources/css/common/tooltip.css" />

<!-- sweetAlert2 CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script> 

<!-- login msg alert -->
<script src="/resources/js/common/alert.js"></script>
<script>
	const msg = '<%= request.getAttribute("msg") %>'
	const status = '<%= request.getAttribute("status") %>'
	if (msg !== "null" && msg !== null && status !== "null" && status !== null) {
		$(document).ready(function() {		// html은 위에서 아래로 읽어 내려가기 때문에 파싱 후에 코드 실행 (비동기)
			alertFunction(msg, status);		// 함수 안에 함수 => 콜백함수
		});	 
	}
</script>