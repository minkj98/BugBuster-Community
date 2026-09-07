<%@ page isErrorPage="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>에러 발생 | BugBuster</title>
    <style>
        body {
            background: #f7fafc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #222;
            min-height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
        }
        .error-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .error-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            padding: 40px 32px 32px 32px;
            max-width: 400px;
            width: 90%;
            text-align: center;
        }
        .error-icon {
            font-size: 52px;
            color: #1976d2;
            margin-bottom: 16px;
        }
        .error-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 12px;
            color: #1976d2;
        }
        .error-details {
            background: #f2f6fc;
            border-radius: 10px;
            padding: 18px 16px;
            margin: 20px 0 24px 0;
            text-align: left;
            font-size: 15px;
            color: #333;
        }
        .error-details .label {
            color: #1976d2;
            font-weight: 600;
            width: 80px;
            display: inline-block;
        }
        .home-btn {
            display: inline-block;
            background: #1976d2;
            color: #fff;
            border: none;
            border-radius: 24px;
            padding: 12px 32px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            box-shadow: 0 2px 8px rgba(25, 118, 210, 0.10);
            transition: background 0.2s;
            margin-top: 10px;
        }
        .home-btn:hover {
            background: #145ea8;
            color: #fff;
        }
        .unknown-error {
            color: #888;
            background: #f2f6fc;
            border-radius: 10px;
            padding: 18px 16px;
            margin: 20px 0 24px 0;
            font-size: 15px;
        }
        @media (max-width: 600px) {
            .error-card { padding: 28px 10px 24px 10px; }
            .error-title { font-size: 20px; }
            .error-icon { font-size: 40px; }
        }
        footer {
            text-align: center;
            color: #aaa;
            font-size: 14px;
            padding: 24px 0 12px 0;
            letter-spacing: 0.02em;
        }
    </style>
</head>
<body>
    <div class="error-wrapper">
        <div class="error-card">
            <div class="error-icon">⚠️</div>
            <div class="error-title">문제가 발생했습니다</div>
            <c:if test="${not empty exception}">
                <div class="error-details">
                    <div><span class="label">에러 코드</span> <c:out value="${exception.errorCode.code}"/></div>
                    <div><span class="label">상태</span> <c:out value="${exception.errorCode.status}"/></div>
                    <div><span class="label">메시지</span> <c:out value="${exception.errorCode.message}"/></div>
                    <div><span class="label">상세</span> <c:out value="${exception.detailMessage}"/></div>
                </div>
            </c:if>
            <c:if test="${empty exception}">
                <div class="unknown-error">알 수 없는 에러가 발생했습니다.</div>
            </c:if>
            <a href="${pageContext.request.contextPath}/" class="home-btn">홈으로 이동</a>
        </div>
    </div>
    <footer>
        © 2025 BugBuster. All rights reserved.
    </footer>
</body>
</html>
