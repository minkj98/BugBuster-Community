<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', Arial, sans-serif;
    background-color: #f8f9fa;
    color: #343a40;
    line-height: 1.6;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 30px 0;
}

.container {
    max-width: 600px;
    width: 100%;
    padding: 0 20px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 6px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    border: 1px solid #d0d7de;
    padding: 35px 40px;
}

h2 {
    text-align: center;
    color: #1f2328;
    font-weight: 600;
    margin-bottom: 20px;
    font-size: 24px;
}

.info-group {
    margin-bottom: 15px;
    padding: 10px 0;
    border-bottom: 1px solid #e9ecef;
}

.info-label {
    font-weight: 600;
    color: #24292f;
    margin-bottom: 5px;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 6px;
}

.info-value {
    color: #656d76;
    font-size: 14px;
}

.back-button {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 9px 18px;
    background-color: #dc3545;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s, filter 0.2s;
    margin-bottom: 20px;
}

.back-button:hover {
    background-color: #c82333;
    filter: brightness(95%);
}

@media (max-width: 768px) {
    .container {
        width: 90%;
        padding: 25px 20px;
    }
}
</style>
</head>
<body>
<div class="container">
    <button class="back-button" onclick="history.back()"><i class="fas fa-arrow-left"></i> 이전 페이지로 돌아가기</button>
    <h2>회원 정보</h2>
    
    <div class="info-group">
        <div class="info-label"><i class="fa-solid fa-user"></i> 아이디</div>
        <div class="info-value">${member.userId}</div>
    </div>
    
    <div class="info-group">
        <div class="info-label"><i class="fa-solid fa-signature"></i> 이름</div>
        <div class="info-value">${member.userName}</div>
    </div>
    
    <div class="info-group">
        <div class="info-label"><i class="fa-solid fa-envelope"></i> 이메일</div>
        <div class="info-value">${member.userEmail}</div>
    </div>
    
    <div class="info-group">
        <div class="info-label"><i class="fa-solid fa-phone"></i> 전화번호</div>
        <div class="info-value">
            <c:set var="phone" value="${member.userPhoneNum}" />
            <c:if test="${fn:length(phone) eq 11}">
                ${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}
            </c:if>
        </div>
    </div>
    
    <div class="info-group">
        <div class="info-label"><i class="fa-solid fa-cake-candles"></i> 생년월일</div>
        <div class="info-value">
            <c:choose>
                <c:when test="${not empty member.birthdate}">
                    <c:set var="formattedDate">
                        <fmt:formatDate value="${member.birthdate}" pattern="yyyy-MM-dd"/>
                    </c:set>
                    ${formattedDate}
                </c:when>
                <c:otherwise>
                    <c:set var="formattedDate" value="정보 없음"/>
                    ${formattedDate}
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="info-group">
        <div class="info-label"><i class="fa-solid fa-house"></i> 주소</div>
        <div class="info-value">
            (${member.zipCode}) ${member.address} ${member.detailAddress}
        </div>
    </div>
</div>
</body>
</html>