<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<title>게시글 상세보기</title>
<!--   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/detailview.css"> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- CodeMirror 라이브러리 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/theme/darcula.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/addon/mode/simple.min.js"></script>

<!-- CodeMirror 언어 모드들 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/javascript/javascript.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/clike/clike.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/python/python.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/php/php.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/ruby/ruby.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/go/go.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/rust/rust.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/swift/swift.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/dart/dart.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/r/r.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/julia/julia.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/jsx/jsx.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/vue/vue.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/xml/xml.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/sql/sql.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/addon/mode/simple.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/dockerfile/dockerfile.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/yaml/yaml.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/detailview.css">
</head>
<body>
	<div class="container">
		<div class="post-container">
			<!-- 기술스택 태그 -->
			<c:if test="${not empty post.programmingLanguage}">
				<div class="language-tag">
					<i class="fas fa-code"></i> <span><c:out
							value="${post.programmingLanguage}" /></span>
				</div>
			</c:if>

			<div class="post-title">
				<c:out value="${post.title}" />
			</div>

			<div class="post-meta">
				<c:if test="${not empty profileAttachList}">
					<div class="profile-attach-content">
						<c:forEach var="item" items="${profileAttachList}" varStatus="s">

							<c:if test="${s.first}">
								<img class="avatar"
									src="${pageContext.request.contextPath}/tmp/${item}"
									alt="프로필 이미지">
							</c:if>
						</c:forEach>
					</div>
				</c:if>

				<!-- 업로드한 이미지가 하나도 없으면 기본 이미지 -->
				<c:if test="${empty profileAttachList}">
					<img class="avatar"
						src="${pageContext.request.contextPath}/resources/img/default.png"
						alt="기본 프로필">
				</c:if>
				<span><i class="fas fa-user"></i> 작성자: <c:out
						value="${post.writer}" /></span> <span><i class="fas fa-calendar"></i>
					작성일: <fmt:formatDate value="${post.createdAt}"
						pattern="yyyy-MM-dd HH:mm" /> </span> <span><i class="fas fa-eye"></i>
					조회수: <c:out value="${post.views}" /></span> <span id="likeCount"><i
					class="fas fa-heart"></i> 좋아요: ${totalLikeCount}</span>
			</div>

			<div class="post-content">
				<div style="white-space: pre-line;">
					<c:out value="${post.content}" />
				</div>


			</div>

			<c:if test="${not empty post.codeContent}">
				<div class="post-codeContent">
					<div class="post-codeContent-header">
						<span class="post-codeContent-label"> <i
							class="fas fa-code"></i> 코드 (${post.programmingLanguage})
						</span>

					</div>
					<div class="code-editor-container">
						<textarea id="viewCodeContent">${post.codeContent}</textarea>
					</div>
				</div>
			</c:if>



			<c:if test="${not empty attachList}">
				<div class="post-attach-content">
					<c:forEach var="item" items="${attachList}">
						<img src="${pageContext.request.contextPath}/tmp/${item}"
							alt="첨부 이미지">


					</c:forEach>
				</div>
			</c:if>

			<div class="actions">
				<c:if test="${sessionScope.loginUser.userId eq post.writer}">
					<a
						href="${pageContext.request.contextPath}/modify?postNum=${post.postNum}&writer=${post.writer}"
						class="btn btn-success"> <i class="fas fa-edit"></i> 수정
					</a>
					<a
						href="${pageContext.request.contextPath}/delete?postNum=${post.postNum}&writer=${post.writer}"
						class="btn btn-warning"> <i class="fas fa-trash"></i> 삭제
					</a>
				</c:if>

				<a href="${pageContext.request.contextPath}/backToList"
					class="btn btn-back"> <i class="fas fa-arrow-left"></i> 뒤로가기
				</a>
			</div>





			<div class="likebtn-inline">
				<c:if test="${!empty loginUser}">
					<button type="button" class="btn btn-postLike"
						data-post-num="${post.postNum}">
						<i class="fa-regular fa-thumbs-up" id="like"></i> 좋아요
					</button>
				</c:if>
			</div>

			<div class="comment-write">
				<form id="commentForm" method="post"
					action="${pageContext.request.contextPath}/commentWrite">

					<input type="hidden" name="postNum" value="${post.postNum}">
					<input type="hidden" name="parentCommentId" value="0"
						id="parentCommentId">

					<!-- textarea : 비로그인일 때 disabled -->
					<textarea name="content" id="commentContent" rows="3"
						placeholder="${empty loginUser
                               ? '로그인한 회원만 댓글 작성 가능합니다.'
                               : '댓글을 입력하세요'}"
						${empty loginUser ? 'disabled' : ''}></textarea>

					
					<button type="submit" class="btn btn-primary"
						${empty loginUser ? 'disabled' : ''}>
						<i class="fas fa-paper-plane"></i>댓글 등록
					</button>

				
					<c:if test="${empty loginUser}">
						<p class="need-login-msg">댓글 작성은 로그인 후 가능합니다.</p>
					</c:if>
				</form>
			</div>


			<div class="comment-section">
				<h3>
					<i class="fas fa-comments"></i>댓글
				</h3>
				<div id="commentSection">
					<%@ include file="/WEB-INF/views/getuseds/commentSection.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<footer class="footer">
		<div class="footer-links">
			<a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
		</div>
		<p>© 2025 커뮤니티. All rights reserved.</p>
	</footer>

	<script>
		$('#commentForm').submit(function(e) {
			e.preventDefault();
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/commentWrite",
				data : $(this).serialize(),
				dataType : "json",
				success : function(response) {
					if (response.success) {
						$('#commentContent').val("");
						$('#parentCommentId').val(0);
						loadComments();
					} else {
						alert(response.message || "댓글 등록 실패");
					}
				},
				error : function() {
					alert("댓글 등록 중 오류가 발생했습니다.");
				}
			});
		});

		function loadLikeStatus(postNum) {
			$.ajax({
				url : '${pageContext.request.contextPath}/getMyLikeStatus',
				type : 'POST',
				data : {
					postNum : postNum
				},
				dataType : 'json',
				success : function(data) {
					if (data.result === 'success') {
						$('#like').toggleClass('fa-regular',
								data.status !== 'like').toggleClass('fa-solid',
								data.status === 'like');
					} else if (data.reason === 'loginRequired') {
						alert('해당 기능은 로그인이 필요합니다.');
					}
				},
				error : function(xhr, status, error) {
					console.error('좋아요 상태 조회 실패:', xhr.responseText);
				}
			});

			$.ajax({
				url : '${pageContext.request.contextPath}/getTotalLikeCount',
				type : 'POST',
				data : {
					postNum : postNum
				},
				dataType : 'json',
				success : function(data) {
					if (data.result === 'success') {
						$('#likeCount').html(
								'<i class="fas fa-heart"></i> 좋아요: '
										+ data.totalLikeCount);
					}
				},
				error : function(xhr, status, error) {
					console.error('총 좋아요 수 조회 실패:', xhr.responseText);
				}
			});
		}

		$('.btn-postLike').click(function() {
		    let postNum = $(this).data('post-num');
		    $.ajax({
		        url: '${pageContext.request.contextPath}/postLike',
		        type: 'POST',
		        data: { postNum: postNum },
		        dataType: 'json',
		        success: function(data) {
		            if (data.result === 'success') {
		                $('#like')
		                    .toggleClass('fa-regular', data.status !== 'like')
		                    .toggleClass('fa-solid', data.status === 'like');

		                // 좋아요 총 개수 갱신
		                $.ajax({
		                    url: '${pageContext.request.contextPath}/getTotalLikeCount',
		                    type: 'POST',
		                    data: { postNum: postNum },
		                    dataType: 'json',
		                    success: function(data) {
		                        if (data.result === 'success') {
		                            $('#likeCount').html(
		                                '<i class="fas fa-heart"></i> 좋아요: ' + data.totalLikeCount
		                            );
		                        }
		                    }
		                });
		            } else if (data.reason === 'loginRequired') {
		                alert('로그인이 필요합니다.');
		            } else {
		                alert('좋아요 처리 중 오류가 발생했습니다.');
		            }
		        },
		        error: function(xhr, status, error) {
		            console.error('좋아요 처리 실패:', xhr.responseText);
		        }
		    });
		});


		let postNum = ${post.postNum};
		loadLikeStatus(postNum);

		function loadComments() {
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/commentSection",
				data : {
					postNum : "${post.postNum}"
				},
				success : function(html) {
					$('#commentSection').html(html);
				},
				error : function(xhr, status, error) {
					console.error("댓글 로드 실패:", xhr.responseText || error);
					alert('댓글 로드 중 오류가 발생했습니다.');
				}
			});
		}

		$(document).on('click', '.deleteCommentBtn', function() {
			var commentId = $(this).data('comment-id');
			if (confirm('정말 삭제하시겠습니까?')) {
				$.ajax({
					type : "POST",
					url : "${pageContext.request.contextPath}/deleteComment",
					data : {
						commentId : commentId
					},
					success : function(response) {
						if (response.success) {
							loadComments();
							alert('댓글이 삭제되었습니다.');
						} else {
							alert(response.message || "삭제 실패");
						}
					},
					error : function(xhr, status, error) {
						alert('댓글 삭제 중 오류가 발생했습니다.');
					}
				});
			}
		});

		function showUpdateForm(commentId) {
			$('#updateForm' + commentId).show();
			$('.update-form').not('#updateForm' + commentId).hide();
			$('.reply-form').hide();
		}

		function hideUpdateForm(commentId) {
			$('#updateForm' + commentId).hide();
		}

		$(document).on('click', '.replyCommentBtn', function() {
			var commentId = $(this).data('comment-id');
			showReplyCommentForm(commentId);
		});

		$(document).on('click', '.updateCommentBtn', function() {
			var commentId = $(this).data('comment-id');
			showUpdateForm(commentId);
		});

		function showReplyCommentForm(commentId) {
			console.log(commentId);
			$('#replyForm' + commentId).show();
			$('.reply-form').not('#replyForm' + commentId).hide();
			$('.update-form').hide();
			$('#replyContent' + commentId).focus();
		}

		function hideReplyCommentForm(commentId) {
			$('#replyForm' + commentId).hide();
		}

		function submitUpdateForm(commentId, depth) {
			var urlParams = new URLSearchParams(window.location.search);
			var postNum = urlParams.get('postNum');

			console.log('수정 요청 - commentId:', commentId, 'postNum:', postNum,
					'depth:', depth);
			var updateContent = $('#updateContent' + commentId).val();
			if (!updateContent.trim()) {
				alert('수정할 댓글 내용을 입력해주세요.');
				$('#updateContent' + commentId).focus();
				return false;
			}

			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/updateComment',
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				data : JSON.stringify({
					content : updateContent,
					commentId : commentId,
					postNum : postNum,
					depth : depth
				}),
				success : function(data) {
					if (data.success || data === 'UpdateSuccess') {
						alert('댓글이 수정되었습니다!');
						loadComments();
						hideUpdateForm(commentId);
					} else {
						alert('댓글 수정에 실패했습니다: ' + (data.message || ''));
					}
				},
				error : function(xhr, status, error) {
					console.error("수정 실패:", xhr.responseText || error);
					alert('통신 실패');
				}
			});

			return false;
		}

		function submitReplyComment(parentCommentId, postNum) {
			var replyContent = $('#replyContent' + parentCommentId).val();
			console.log("parentCommentId(JS):", parentCommentId);
			if (!replyContent.trim()) {
				alert('대댓글 내용을 입력해주세요.');
				$('#replyContent' + parentCommentId).focus();
				return false;
			}

			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/commentReply',
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				data : JSON.stringify({
					content : replyContent,
					parentCommentId : parentCommentId,
					postNum : postNum
				}),
				success : function(data) {
					if (data.success) {
						alert('대댓글이 등록되었습니다!');
						$('#replyContent' + parentCommentId).val('');
						loadComments();
						hideReplyCommentForm(parentCommentId);
					} else {
						alert('대댓글 등록에 실패했습니다: ' + (data.message || ''));
					}
				},
				error : function(xhr, status, error) {
					console.error("대댓글 등록 실패:", xhr.responseText || error);
					alert('통신 실패');
				}
			});

			return false;
		}

		// 저장된 프로그래밍 언어에 따라 모드 동적 설정
		const languageModeMap = {
			// 프로그래밍 언어
			'Python' : 'text/x-python',
			'JavaScript' : 'javascript',
			'Java' : 'text/x-java',
			'C++' : 'text/x-c++src',
			'C' : 'text/x-csrc',
			'C#' : 'text/x-csharp',
			'TypeScript' : 'text/typescript',
			'Go' : 'text/x-go',
			'Rust' : 'text/x-rustsrc',
			'Swift' : 'text/x-swift',
			'Kotlin' : 'text/x-kotlin',
			'PHP' : 'application/x-httpd-php',
			'Ruby' : 'text/x-ruby',
			'Dart' : 'application/dart',
			'R' : 'text/x-rsrc',
			'Julia' : 'text/x-julia',
			'Mojo' : 'text/x-python',
			'Zig' : 'text/x-csrc',

			// 프레임워크
			'React' : 'text/jsx',
			'Vue.js' : 'text/x-vue',
			'Angular' : 'text/typescript',
			'Svelte' : 'text/x-svelte',
			'Next.js' : 'text/jsx',
			'Nuxt.js' : 'text/x-vue',
			'Node.js' : 'javascript',
			'Express.js' : 'javascript',
			'Nest.js' : 'text/typescript',
			'SpringBoot' : 'text/x-java',
			'Django' : 'text/x-python',
			'Flask' : 'text/x-python',
			'FastAPI' : 'text/x-python',
			'Deno' : 'text/typescript',
			'Bun' : 'javascript',

			// 앱 개발
			'Flutter' : 'application/dart',
			'ReactNative' : 'text/jsx',

			// 게임 개발
			'Unity' : 'text/x-csharp',
			'UnrealEngine' : 'text/x-c++src',

			// 클라우드/DevOps
			'AWS' : 'text/x-yaml',
			'Azure' : 'text/x-yaml',
			'GCP' : 'text/x-yaml',
			'Docker' : 'dockerfile',
			'Kubernetes' : 'text/x-yaml',

			// SQL
			'MySQL' : 'text/x-mysql',
			'PostgreSQL' : 'text/x-pgsql',
			'MongoDB' : 'javascript',
			'Oracle' : 'text/x-plsql',
			'SQLServer' : 'text/x-mssql',
			'SQLite' : 'text/x-sqlite',
			'MariaDB' : 'text/x-mysql',

			// AI/ML (모두 Python)
			'GPT' : 'text/x-python',
			'BERT' : 'text/x-python',
			'YOLO' : 'text/x-python',
			'OpenCV' : 'text/x-python',
			'ScikitLearn' : 'text/x-python',
			'XGBoost' : 'text/x-python',
			'LightGBM' : 'text/x-python',
			'TensorFlow' : 'text/x-python',
			'PyTorch' : 'text/x-python',
			'Keras' : 'text/x-python'
		};

		$(document).ready(function() {
			const savedLanguage = "${post.programmingLanguage}";
			const mode = languageModeMap[savedLanguage];
			const textarea = document.getElementById("viewCodeContent");

			var viewCodeEditor = CodeMirror.fromTextArea(textarea, {
				lineNumbers : true,
				mode : mode,
				theme : "darcula",
				readOnly : "nocursor",
				lineWrapping : true,
				matchBrackets : true,
				indentUnit : 4
			});

		});
	</script>
</body>
</html>
