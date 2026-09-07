<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Community Header</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html, body {
    margin: 0;
    padding: 0;
    width: 100%;
    overflow-x: hidden;
}

body {
    font-family: 'Noto Sans KR', Arial, sans-serif;
    background-color: #f8f9fa;
    color: #343a40;
    line-height: 1.6;
}

/* 헤더 스타일 - 수정 후 */
.header {
    background-color: #fff;
    padding: 0;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 100;
    width: 100vw;
    margin: 0;
    margin-left: calc(-50vw + 50%);
    margin-right: calc(-50vw + 50%);
    margin-bottom: 4px
}


.header-inner {
    max-width: 1200px;
    width: 100%;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 20px 18px 20px; /* 하단 18px만 추가 */
    min-height: 50px;
    position: relative;
}

/* 네비게이션 스타일 - 간격 완전히 제거 */
.nav {
    background-color: #fff;
    padding: 0; /* 4px 0에서 0으로 완전히 제거 */
    border-bottom: 1px solid #e9ecef;
    width: 100vw;
    margin: 0;
    margin-left: calc(-50vw + 50%);
    margin-right: calc(-50vw + 50%);
    border-top: none;
}

.nav-inner {
    max-width: 1200px;
    width: 100%;
    margin: 0 auto;
    padding: 8px 20px; /* 상하 패딩만 여기서 관리 */
}

.nav-menu {
    list-style: none;
    display: flex;
    gap: 24px;
    justify-content: center;
    margin: 0;
    padding: 0;
}

.nav-menu li a {
    text-decoration: none;
    color: #495057;
    font-size: 16px;
    font-weight: 500;
    transition: color 0.2s;
    padding: 0; /* 6px 0에서 0으로 제거 */
}

.nav-menu li a:hover {
    color: #007bff;
}

/* 로고 스타일 */
.logo-box {
    display: flex;
    align-items: center;
    gap: 16px;
}

.logo {
    display: flex;
    align-items: center;
    text-decoration: none;
    gap: 16px;
}

.logo-img {
    width: 64px;
    height: 64px;
    object-fit: contain;
    display: block;
    flex-shrink: 0;
}

.logo-title {
    font-size: 36px;
    font-weight: bold;
    color: #42464d;
    margin: 0;
    text-decoration: none;
    line-height: 1;
    display: block;
    white-space: nowrap;
}

/* 로그인 영역 - 완전히 오른쪽으로 이동 */
.login-area {
    display: flex;
    align-items: center;
    margin-left: auto;
    padding-left: 60px; /* 40px에서 60px로 증가 */
    padding-right: 0; /* 오른쪽 패딩 제거 */
}

/* 로그인 폼 */
.login-form {
    display: flex;
    align-items: center;
    gap: 8px;
    background: #fff;
    border-radius: 6px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.07);
    padding: 8px 16px;
}

.login-form .input-field {
    width: 120px;
    padding: 8px 10px;
    font-size: 14px;
    border: 1.5px solid #ced4da;
    border-radius: 4px;
    background: #f6f8fa;
    transition: border-color 0.2s, box-shadow 0.2s;
    color: #222;
}

.login-form .input-field:focus {
    border-color: #007bff;
    background: #fff;
    outline: none;
    box-shadow: 0 0 4px rgba(0, 123, 255, 0.12);
}

.login-form .input-field::placeholder {
    color: #b0b8c1;
    font-size: 13px;
    opacity: 1;
}

.btn-login {
    background-color: #007bff;
    color: #fff;
    padding: 8px 14px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background 0.2s, filter 0.2s;
    margin-left: 4px;
}

.btn-login:hover {
    background-color: #0056b3;
    filter: brightness(95%);
}

.btn-signup {
    background-color: #28a745;
    color: #fff;
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    margin-left: 4px;
    transition: background 0.2s, filter 0.2s;
}

.btn-signup:hover {
    background-color: #218838;
    filter: brightness(95%);
}

.user-info {
    display: flex;
    align-items: center;
    gap: 12px;
    font-size: 14px;
}

.btn {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    font-size: 13px;
    cursor: pointer;
    text-decoration: none;
    color: #fff;
    display: inline-flex;
    align-items: center;
    gap: 4px;
    transition: background-color 0.2s;
}

.btn-login, .btn-search, .btn-success {
    background-color: #007bff;
}

.btn-signup, .btn-mypage {
    background-color: #28a745;
}

.btn-logout, .btn-warning {
    background-color: #dc3545;
}

.btn:hover {
    filter: brightness(90%);
}

/* 반응형 디자인 */
@media (max-width: 900px) {
    .header-inner, .nav-inner {
        padding: 6px 20px; /* 모바일에서 약간의 패딩 유지 */
    }
    
    .header-inner {
        min-height: 45px;
        flex-direction: column;
        gap: 6px;
    }
    
    .login-area {
        margin-left: 0;
        padding-left: 0;
    }
    
    .login-form {
        flex-direction: column;
        align-items: stretch;
        gap: 6px;
        padding: 6px 12px;
    }
    
    .login-form .input-field, .login-form .btn {
        width: 100%;
    }
    
    .nav-menu {
        flex-wrap: wrap;
        gap: 16px;
    }
    
    .logo-title {
        font-size: 28px;
    }
    
    .logo-img {
        width: 48px;
        height: 48px;
    }
    
    .logo-box, .logo {
        gap: 12px;
    }
}

</style>
<script>
<c:if test="${not empty message}">
    alert('${message}');
</c:if>
$(document).ready(function() {
    const contextPath = "${pageContext.request.contextPath}";
    $('#loginBtn').click(function() {
        const userId = $('#userId').val();
        const userPassword = $('#userPassword').val();
        $.ajax({
            type: 'POST',
            url: contextPath + '/loginAccount',
            data: { userId, userPassword },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert('로그인 성공');
                    location.reload();
                } else {
                    alert('로그인 실패: 아이디 또는 비밀번호를 확인하세요.');
                }
            },
            error: function(xhr, status, error) {
                alert('로그인 중 오류가 발생했습니다: ' + error);
            }
        });
    });
});

$(document).ready(function() {
    const contextPath = "${pageContext.request.contextPath}";
    $('#logoutBtn').click(function(e) {
        e.preventDefault(); // a 태그의 기본 이동 동작 막기
        $.ajax({
            type: 'POST',
            url: contextPath + '/logout',
            success: function(response) {
                if(response.success){
                    alert("로그아웃");
                    location.reload();
                }
            },
            error: function(xhr, status, error) {
                alert('로그아웃 중 오류가 발생했습니다: ' + error);
            }
        });
    });
});

</script>
</head>
<body>
	<header class="header">
		<div class="header-inner">
			<div class="logo-box">
				<a href="${pageContext.request.contextPath}/" class="logo"> <img
					id="bugbuster-logo" src="resources/images/BugBusterLogoV2.png"
					alt="로고" class="logo-img" width="48" height="48" /> <span
					class="logo-title">BugBuster</span>
				</a>
			</div>

			<div class="login-area">
				<c:choose>
					<c:when test="${not empty sessionScope.loginUser}">

						<div class="user-info">
							<span class="user-id"><strong>${sessionScope.loginUser.userId}</strong>님</span>
							<a href="${pageContext.request.contextPath}/mypage"
								class="btn btn-mypage"><i class="fas fa-user"></i> 마이페이지</a> <a
								href="${pageContext.request.contextPath}/logout" id="logoutBtn"
								class="btn btn-logout"><i class="fas fa-sign-out-alt"></i>
								로그아웃</a>
						</div>
					</c:when>
					<c:otherwise>
						<form id="loginForm" class="login-form">
							<input type="text" id="userId" name="userId" placeholder="아이디"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '아이디'" class="input-field"> <input
								type="password" id="userPassword" name="userPassword"
								placeholder="비밀번호" onfocus="this.placeholder = ''"
								onblur="this.placeholder = '비밀번호'" class="input-field">
							<button type="button" class="btn btn-login" id="loginBtn">
								<i class="fas fa-sign-in-alt"></i> 로그인
							</button>
							<a href="${pageContext.request.contextPath}/signup"
								class="btn btn-signup"><i class="fas fa-user-plus"></i> 회원가입</a>
						</form>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>
	<nav class="nav">
		<div class="nav-inner">
			<ul class="nav-menu">
				<li><a href="${pageContext.request.contextPath}/itNews">IT뉴스</a></li>
				<li><a href="${pageContext.request.contextPath}/QABoard">Q&A</a></li>
				<li><a href="${pageContext.request.contextPath}/problems">문제풀기</a></li>
			</ul>
		</div>
	</nav>
</body>

</html>