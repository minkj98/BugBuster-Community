<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
@charset "UTF-8";

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
}

.container {
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

#middle {
    display: flex;
    width: 100%;
    max-width: 1280px;
    margin: 40px auto;
    padding: 24px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    gap: 20px;
}

.profile-attach-content {
    width: 100px;
    height: 100px;
    border-radius: 8px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #f6f8fa;
    border: 1px solid #d0d7de;
}

.profile-attach-content img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    border-radius: 6px;
}

#my {
    border: 1px solid #dee2e6;
    width: 200px;
    height: 200px;
    text-align: center;
    border-radius: 6px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    gap: 12px;
}

#name {
    margin-top: 8px;
    display: block;
    font-size: 16px;
    font-weight: bold;
    color: #343a40;
}

#update {
    margin-top: 8px;
    width: 150px;
    padding: 8px 16px;
    background-color: #28a745;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}

#update:hover {
    background-color: #218838;
}

#scrap {
    border: 1px solid #dee2e6;
    flex: 1;
    padding: 20px;
    border-radius: 8px;
    background-color: #fff;
    display: flex;
    flex-direction: column;
    gap: 15px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

#scraptext {
    font-size: 18px;
    font-weight: 600;
    color: #007bff;
    border-bottom: 2px solid #007bff;
    padding-bottom: 8px;
    margin-bottom: 10px;
}

#data {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
}

#data th, #data td {
    padding: 12px 15px;
    border: 1px solid #e9ecef;
    text-align: left;
    font-size: 14px;
    border:none;
}

#data th {
    background-color: #007bff;
    color: #fff;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

#data td {
    color: #495057;
}

#data tr {
    transition: background-color 0.2s ease;
}

#data tr:hover {
    background-color: #f1f3f5;
}

#data td a {
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
}

#data td a:hover {
    text-decoration: underline;
    color: #0056b3;
}

.empty-message {
    text-align: center;
    color: #6c757d;
    font-style: italic;
    padding: 20px;
}

.pagination {
    margin-top: 20px;
    text-align: center;
    display: flex;
    justify-content: center;
    gap: 8px;
}

.pagination a, .pagination span {
    display: inline-block;
    padding: 8px 14px;
    text-decoration: none;
    font-size: 14px;
    border-radius: 4px;
    transition: background-color 0.2s, color 0.2s;
}

.pagination a {
    background-color: #007bff;
    color: #fff;
    border: 1px solid #007bff;
}

.pagination a:hover {
    background-color: #0056b3;
    border-color: #0056b3;
}

.pagination span {
    background-color: #e9ecef;
    color: #343a40;
    font-weight: 600;
    border: 1px solid #dee2e6;
}

#dawn {
    display: flex;
    width: 100%;
    max-width: 1280px;
    margin: 0 auto 40px;
    padding: 0 24px;
    gap: 20px;
}

#setting {
    width: 200px;
    padding: 8px 16px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}

#setting:hover {
    background-color: #0056b3;
}

#dash {
    border: 1px solid #dee2e6;
    flex: 1;
    padding: 16px;
    border-radius: 6px;
    text-align: center;
    font-size: 16px;
    color: #343a40;
}

.footer {
    background-color: #343a40;
    color: #fff;
    padding: 20px 0;
    text-align: center;
    margin-top: 40px;
    width: 100%;
}

.footer-links a {
    color: #adb5bd;
    margin: 0 12px;
    text-decoration: none;
    font-size: 14px;
}

.footer-links a:hover {
    color: #fff;
}

.footer p {
    font-size: 13px;
    margin-top: 8px;
    color: #adb5bd;
}

@media (max-width: 900px) {
    .container {
        flex-direction: column;
    }
    #middle {
        flex-direction: column;
        margin: 20px auto;
        padding: 20px;
    }
    #my, #scrap, #dash {
        width: 100%;
        margin-left: 0;
    }
    #dawn {
        flex-direction: column;
        margin: 0 auto 20px;
        padding: 0 20px;
    }
    #setting {
        width: 100%;
    }
}
</style>
</head>
<body>
<%@ include file="./common/top.jsp"%>
<div id="middle">
    <div id="my">
        <c:if test="${not empty profileAttachList}">
            <div class="profile-attach-content">
                <c:forEach var="item" items="${profileAttachList}">
                    <img src="${pageContext.request.contextPath}/tmp/${item}" alt="프로필 이미지">
                </c:forEach>
            </div>
        </c:if>
        <span id="name"><strong>${sessionScope.loginUser.userId}</strong>님</span>
        <a href="${pageContext.request.contextPath}/profileOptions"><button id="update">프로필 수정</button></a>
    </div>
    <div id="scrap">
        <span id="scraptext">${sessionScope.loginUser.userId}님의 좋아요</span>
        <div id="data">
            <table id="boardTable">
                <tbody>
                    <c:if test="${empty likesdata}">
                        <tr>
                            <td colspan="4" class="empty-message">좋아요한 게시글이 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="item" items="${likesdata}" varStatus="status">
                      
                            <td><a href="${pageContext.request.contextPath}/textview?postNum=${item.postNum}"><c:out value="${item.title}" /></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <c:if test="${paginglike.page > 1}">
                    <a href="${pageContext.request.contextPath}/mypage?page=${paginglike.page - 1}">[이전]</a>
                </c:if>
                <c:if test="${paginglike.page <= 1}">
                    <span>[이전]</span>
                </c:if>
                <c:forEach begin="${paginglike.startPage}" end="${paginglike.endPage}" var="i" step="1">
                    <c:if test="${i > 0}">
                        <c:choose>
                            <c:when test="${i eq paginglike.page}">
                                <span>${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/mypage?page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <c:if test="${paginglike.page < paginglike.maxPage}">
                    <a href="${pageContext.request.contextPath}/mypage?page=${paginglike.page + 1}">[다음]</a>
                </c:if>
                <c:if test="${paginglike.page >= paginglike.maxPage}">
                    <span>[다음]</span>
                </c:if>
            </div>
        </div>
    </div>
</div>
<div id="dawn">
    <a href="${pageContext.request.contextPath}/userdelete"><button id="setting">회원 탈퇴</button></a>
    <div id="dash">
        <span>총 받은 조회수: ${totalview != null ? totalview : 0}, 받은 좋아요 수: ${totallikes != null ? totallikes : 0}</span>
    </div>
</div>
<footer class="footer">
    <div class="footer-links">
        <a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
    </div>
    <p>© 2025 커뮤니티. All rights reserved.</p>
</footer>
</body>
</html>