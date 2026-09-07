<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로필 옵션</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', Arial, sans-serif;
    background-color: #f8f9fa; /* main.jsp, top.jsp와 동일 */
    color: #343a40; /* main.jsp, top.jsp의 기본 텍스트 색상 */
    line-height: 1.6;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 30px 0; /* signup.jsp의 패딩 참고 */
}

.profile-container {
    max-width: 1280px; /* main.jsp, top.jsp의 컨테이너 너비 */
    width: 100%;
    padding: 0 20px;
    margin: 0 auto;
}

.profile-card {
    background: #fff; /* main.jsp의 .main-content, signup.jsp의 #signUpForm */
    padding: 24px; /* main.jsp의 .main-content 패딩 */
    border-radius: 6px; /* signup.jsp, main.jsp의 둥근 모서리 */
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08); /* signup.jsp의 그림자 */
    text-align: center;
    max-width: 500px; /* signup.jsp의 #signUpForm 너비 */
    margin: 0 auto;
    border: 1px solid #d0d7de; /* signup.jsp의 테두리 */
}

.user-name {
    margin-top: 10px;
    font-size: 18px; /* top.jsp의 .user-id 크기 참고 */
    font-weight: 600; /* top.jsp의 .user-id 굵기 */
    color: #24292f; /* signup.jsp의 라벨 색상 */
}

.button-group {
    margin-top: 20px; /* signup.jsp의 .button-group 마진 */
    display: grid;
    grid-template-columns: repeat(2, 1fr); /* 기존 그리드 유지 */
    gap: 12px; /* signup.jsp의 .button-group 간격 */
    max-width: 300px;
    margin-left: auto;
    margin-right: auto;
}

.button-group button {
    padding: 9px 18px; /* top.jsp의 .btn 패딩 */
    background-color: #007bff; /* top.jsp의 .btn-login 색상 */
    color: #fff;
    border: none;
    border-radius: 4px; /* top.jsp의 .btn 모서리 */
    font-size: 14px; /* top.jsp의 .btn 폰트 크기 */
    font-weight: 500; /* signup.jsp의 버튼 굵기 */
    cursor: pointer;
    transition: background-color 0.2s, filter 0.2s; /* top.jsp의 전환 효과 */
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px; /* top.jsp의 .btn 아이콘 간격 */
}

.button-group button:hover {
    background-color: #0056b3; /* top.jsp의 .btn-login 호버 */
    filter: brightness(95%);
}

.button-group button:nth-child(3) {
    grid-column: span 2; /* 기존 레이아웃 유지 */
    background-color: #28a745; /* top.jsp의 .btn-signup 색상 */
}

.button-group button:nth-child(3):hover {
    background-color: #218838; /* top.jsp의 .btn-signup 호버 */
}

.back-button {
    margin-top: 20px; /* signup.jsp의 .button-group 마진 */
    padding: 9px 18px; /* top.jsp의 .btn 패딩 */
    background-color: #dc3545; /* top.jsp의 .btn-logout 색상 */
    color: #fff;
    border: none;
    border-radius: 4px; /* top.jsp의 .btn 모서리 */
    font-size: 14px;
    font-weight: 500; /* signup.jsp의 버튼 굵기 */
    cursor: pointer;
    transition: background-color 0.2s, filter 0.2s; /* top.jsp의 전환 효과 */
    display: inline-flex;
    align-items: center;
    gap: 6px; /* top.jsp의 .btn 아이콘 간격 */
}

.back-button:hover {
    background-color: #c82333; /* top.jsp의 .btn-logout 호버 */
    filter: brightness(95%);
}

/* 반응형 디자인 */
@media (max-width: 900px) {
    .profile-container {
        padding: 0 15px; /* main.jsp의 반응형 패딩 */
    }

    .profile-card {
        padding: 20px; /* main.jsp의 반응형 패딩 */
        max-width: 90%; /* signup.jsp의 반응형 너비 */
    }

    .button-group {
        grid-template-columns: 1fr; /* main.jsp의 .trending-list 반응형 */
        max-width: 100%;
        gap: 8px; /* signup.jsp의 반응형 간격 */
    }

    .button-group button:nth-child(3) {
        grid-column: span 1; /* 기존 반응형 유지 */
    }

    .back-button {
        width: 100%; /* top.jsp의 반응형 버튼 */
    }
}
</style>
</head>
<body>
<div class="profile-container">
    <div class="profile-card">
        <span class="user-name"><strong>${sessionScope.loginUser.userId}</strong>님</span>
        <div class="button-group">
            <button onclick="window.location.href='${pageContext.request.contextPath}/passreset'"><i class="fas fa-lock"></i> 비번 재설정</button>
            <button onclick="window.location.href='${pageContext.request.contextPath}/memberreset'"><i class="fas fa-user-edit"></i> 회원정보수정</button>
            <button onclick="window.location.href='${pageContext.request.contextPath}/memberview'"><i class="fas fa-eye"></i> 내 정보 보기</button>
        </div>
        <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/mypage'"><i class="fas fa-arrow-left"></i> 마이페이지로 돌아가기</button>
    </div>
</div>
</body>
</html>