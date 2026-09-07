<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<title>댓글 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commentSection.css">
</head>
<body>
<div id="commentSection">
    <c:forEach var="comment" items="${commentList}">
        <c:if test="${comment.parentCommentId == null}">
            <!-- 부모 댓글 -->
            <div class="comment" id="comment${comment.commentId}">
                <!-- 프로필 이미지 -->
                <c:choose>
                    <c:when test="${not empty comment.profileImg}">
                        <img class="avatar" src="${pageContext.request.contextPath}/tmp/${comment.profileImg}" alt="프로필">
                    </c:when>
                    <c:otherwise>
                        <img class="avatar" src="${pageContext.request.contextPath}/resources/img/default.png" alt="기본 프로필">
                    </c:otherwise>
                </c:choose>
                
                <!-- 댓글 내용 영역 -->
                <div class="comment-body">
                    <div class="comment-header">
                        <b class="comment-author">${fn:escapeXml(comment.userId)}</b>
                        <span class="comment-date">
                            <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul" />
                        </span>
                    </div>
                    
                    <div class="comment-content" id="commentContent${comment.commentId}">
                        ${fn:escapeXml(comment.content)}
                    </div>
                    
                    <div class="comment-actions">
                        <c:if test="${!comment.deleted && !empty sessionScope.loginUser}">
                            <button type="button" class="replyCommentBtn" data-comment-id="${comment.commentId}">답글</button>
                        </c:if>
                        <c:if test="${sessionScope.loginUser.userId eq comment.userId && !comment.deleted}">
                            <button type="button" class="updateCommentBtn" data-comment-id="${comment.commentId}">수정</button>
                            <button type="button" class="deleteCommentBtn" data-comment-id="${comment.commentId}">삭제</button>
                        </c:if>
                    </div>
                    
                    <!-- 댓글 수정 폼 -->
                    <c:if test="${sessionScope.loginUser.userId eq comment.userId && !comment.deleted}">
                        <div class="update-form" id="updateForm${comment.commentId}" style="display: none;">
                            <textarea id="updateContent${comment.commentId}">${fn:escapeXml(comment.content)}</textarea>
                            <button type="button" class="submit-update update-action-btn" onclick="submitUpdateForm(${comment.commentId}, ${comment.depth })">수정 완료</button>
                            <button type="button" class="cancel-update update-action-btn" onclick="hideUpdateForm(${comment.commentId})">취소</button>
                        </div>
                    </c:if>
                    
                    <!-- 대댓글 작성 폼 -->
                    <c:if test="${!empty sessionScope.loginUser}">
                        <div class="reply-form" id="replyForm${comment.commentId}" style="display: none;">
                            <textarea id="replyContent${comment.commentId}" placeholder="대댓글을 입력하세요."></textarea>
                            <button type="button" class="submit-reply reply-action-btn" onclick="submitReplyComment(${comment.commentId}, '${not empty post ? post.postNum : ''}')">답글 등록</button>
                            <button type="button" class="cancel-reply reply-action-btn" onclick="hideReplyCommentForm(${comment.commentId})">취소</button>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <!-- 대댓글 출력 -->
            <c:forEach var="reply" items="${commentList}">
                <c:if test="${reply.parentCommentId == comment.commentId}">
                    <div class="comment reply" id="comment${reply.commentId}">
                        <!-- 프로필 이미지 -->
                        <c:choose>
                            <c:when test="${not empty reply.profileImg}">
                                <img class="avatar" src="${pageContext.request.contextPath}/tmp/${reply.profileImg}" alt="프로필">
                            </c:when>
                            <c:otherwise>
                                <img class="avatar" src="${pageContext.request.contextPath}/resources/img/default.png" alt="기본 프로필">
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- 대댓글 내용 영역 -->
                        <div class="comment-body">
                            <div class="comment-header">
                                <b class="comment-author">${fn:escapeXml(reply.userId)}</b>
                                <span class="comment-date">
                                    <fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd HH:mm" timeZone="Asia/Seoul" />
                                </span>
                                <span class="reply-label">답글</span>
                            </div>
                            
                            <div class="comment-content" id="commentContent${reply.commentId}">
                                ${fn:escapeXml(reply.content)}
                            </div>
                            
                            <div class="comment-actions">
                                <c:if test="${sessionScope.loginUser.userId eq reply.userId && !reply.deleted}">
                                    <button type="button" class="updateCommentBtn" data-comment-id="${reply.commentId}">수정</button>
                                    <button type="button" class="deleteCommentBtn" data-comment-id="${reply.commentId}">삭제</button>
                                </c:if>
                            </div>
                            
                            <!-- 대댓글 수정 폼 -->
                            <c:if test="${sessionScope.loginUser.userId eq reply.userId && !reply.deleted}">
                                <div class="update-form" id="updateForm${reply.commentId}" style="display: none;">
                                    <textarea id="updateContent${reply.commentId}">${fn:escapeXml(reply.content)}</textarea>
                                    <button type="button" class="submit-update update-action-btn" onclick="submitUpdateForm(${reply.commentId}, ${reply.depth})">수정 완료</button>
                                    <button type="button" class="cancel-update update-action-btn" onclick="hideUpdateForm(${reply.commentId})">취소</button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </c:forEach>
</div>
</body>
</html>
