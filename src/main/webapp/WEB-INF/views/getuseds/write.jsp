<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 작성/수정</title>

<!-- jQuery 및 기본 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	defer></script>

<!-- CodeMirror 라이브러리 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/theme/dracula.min.css">
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
	href="${pageContext.request.contextPath}/resources/css/write.css">
</head>
<body>
	<div class="container">
		<div class="write-form-container">
			<h2>
				<c:choose>
					<c:when test="${not empty boardVO}">
						<i class="fas fa-edit"></i> 게시글 수정
                </c:when>
					<c:otherwise>
						<i class="fas fa-pen"></i> 질문 게시글 작성
                </c:otherwise>
				</c:choose>
			</h2>

			<form
				action="${pageContext.request.contextPath}${not empty boardVO ? '/modify' : '/insertContent'}"
				method="post" id="frm" enctype="multipart/form-data">

				<c:if test="${not empty boardVO}">
					<input type="hidden" name="postNum" value="${boardVO.postNum}" />
				</c:if>

				<table>
					<tr>
						<td><label for="programmingLanguage"
							class="form-label required"> <i class="fas fa-code"></i>
								프로그래밍 언어
						</label> <select id="programmingLanguage" name="programmingLanguage"
							class="language-select" required>
								<option value="">질문할 원하는 기술스택을 선택하세요</option>

								<optgroup label="프로그래밍 언어">
									<option value="Python"
										${boardVO.programmingLanguage == 'Python' ? 'selected' : ''}>Python</option>
									<option value="JavaScript"
										${boardVO.programmingLanguage == 'JavaScript' ? 'selected' : ''}>JavaScript</option>
									<option value="Java"
										${boardVO.programmingLanguage == 'Java' ? 'selected' : ''}>Java</option>
									<option value="C++"
										${boardVO.programmingLanguage == 'C++' ? 'selected' : ''}>C++</option>
									<option value="C"
										${boardVO.programmingLanguage == 'C' ? 'selected' : ''}>C</option>
									<option value="C#"
										${boardVO.programmingLanguage == 'C#' ? 'selected' : ''}>C#</option>
									<option value="TypeScript"
										${boardVO.programmingLanguage == 'TypeScript' ? 'selected' : ''}>TypeScript</option>
									<option value="Go"
										${boardVO.programmingLanguage == 'Go' ? 'selected' : ''}>Go</option>
									<option value="Rust"
										${boardVO.programmingLanguage == 'Rust' ? 'selected' : ''}>Rust</option>
									<option value="Swift"
										${boardVO.programmingLanguage == 'Swift' ? 'selected' : ''}>Swift</option>
									<option value="Kotlin"
										${boardVO.programmingLanguage == 'Kotlin' ? 'selected' : ''}>Kotlin</option>
									<option value="PHP"
										${boardVO.programmingLanguage == 'PHP' ? 'selected' : ''}>PHP</option>
									<option value="Ruby"
										${boardVO.programmingLanguage == 'Ruby' ? 'selected' : ''}>Ruby</option>
									<option value="Dart"
										${boardVO.programmingLanguage == 'Dart' ? 'selected' : ''}>Dart</option>
									<option value="R"
										${boardVO.programmingLanguage == 'R' ? 'selected' : ''}>R</option>
									<option value="Julia"
										${boardVO.programmingLanguage == 'Julia' ? 'selected' : ''}>Julia</option>
									<option value="Mojo"
										${boardVO.programmingLanguage == 'Mojo' ? 'selected' : ''}>Mojo</option>
									<option value="Zig"
										${boardVO.programmingLanguage == 'Zig' ? 'selected' : ''}>Zig</option>
								</optgroup>

								<optgroup label="프레임워크">
									<option value="React"
										${boardVO.programmingLanguage == 'React' ? 'selected' : ''}>React</option>
									<option value="Vue.js"
										${boardVO.programmingLanguage == 'Vue.js' ? 'selected' : ''}>Vue.js</option>
									<option value="Angular"
										${boardVO.programmingLanguage == 'Angular' ? 'selected' : ''}>Angular</option>
									<option value="Svelte"
										${boardVO.programmingLanguage == 'Svelte' ? 'selected' : ''}>Svelte</option>
									<option value="Next.js"
										${boardVO.programmingLanguage == 'Next.js' ? 'selected' : ''}>Next.js</option>
									<option value="Nuxt.js"
										${boardVO.programmingLanguage == 'Nuxt.js' ? 'selected' : ''}>Nuxt.js</option>
									<option value="Node.js"
										${boardVO.programmingLanguage == 'Node.js' ? 'selected' : ''}>Node.js</option>
									<option value="Express.js"
										${boardVO.programmingLanguage == 'Express.js' ? 'selected' : ''}>Express.js</option>
									<option value="Nest.js"
										${boardVO.programmingLanguage == 'Nest.js' ? 'selected' : ''}>Nest.js</option>
									<option value="SpringBoot"
										${boardVO.programmingLanguage == 'SpringBoot' ? 'selected' : ''}>SpringBoot</option>
									<option value="Django"
										${boardVO.programmingLanguage == 'Django' ? 'selected' : ''}>Django</option>
									<option value="Flask"
										${boardVO.programmingLanguage == 'Flask' ? 'selected' : ''}>Flask</option>
									<option value="FastAPI"
										${boardVO.programmingLanguage == 'FastAPI' ? 'selected' : ''}>FastAPI</option>
									<option value="Deno"
										${boardVO.programmingLanguage == 'Deno' ? 'selected' : ''}>Deno</option>
									<option value="Bun"
										${boardVO.programmingLanguage == 'Bun' ? 'selected' : ''}>Bun</option>
								</optgroup>


								<optgroup label="앱 개발">
									<option value="Flutter"
										${boardVO.programmingLanguage == 'Flutter' ? 'selected' : ''}>Flutter</option>
									<option value="ReactNative"
										${boardVO.programmingLanguage == 'ReactNative' ? 'selected' : ''}>React
										Native</option>
								</optgroup>

								<optgroup label="게임 개발">
									<option value="Unity"
										${boardVO.programmingLanguage == 'Unity' ? 'selected' : ''}>Unity</option>
									<option value="UnrealEngine"
										${boardVO.programmingLanguage == 'UnrealEngine' ? 'selected' : ''}>Unreal
										Engine</option>
								</optgroup>

								<optgroup label="클라우드">
									<option value="AWS"
										${boardVO.programmingLanguage == 'AWS' ? 'selected' : ''}>AWS</option>
									<option value="Azure"
										${boardVO.programmingLanguage == 'Azure' ? 'selected' : ''}>Azure</option>
									<option value="GCP"
										${boardVO.programmingLanguage == 'GCP' ? 'selected' : ''}>Google
										Cloud Platform</option>
								</optgroup>

								<optgroup label="Devops">
									<option value="Docker"
										${boardVO.programmingLanguage == 'Docker' ? 'selected' : ''}>Docker</option>
									<option value="Kubernetes"
										${boardVO.programmingLanguage == 'Kubernetes' ? 'selected' : ''}>Kubernetes</option>
								</optgroup>

								<optgroup label="SQL">
									<option value="MySQL"
										${boardVO.programmingLanguage == 'MySQL' ? 'selected' : ''}>MySQL</option>
									<option value="PostgreSQL"
										${boardVO.programmingLanguage == 'PostgreSQL' ? 'selected' : ''}>PostgreSQL</option>
									<option value="MongoDB"
										${boardVO.programmingLanguage == 'MongoDB' ? 'selected' : ''}>MongoDB</option>
									<option value="Oracle"
										${boardVO.programmingLanguage == 'Oracle' ? 'selected' : ''}>Oracle</option>
									<option value="SQLServer"
										${boardVO.programmingLanguage == 'SQLServer' ? 'selected' : ''}>SQL
										Server</option>
									<option value="SQLite"
										${boardVO.programmingLanguage == 'SQLite' ? 'selected' : ''}>SQLite</option>
									<option value="MariaDB"
										${boardVO.programmingLanguage == 'MariaDB' ? 'selected' : ''}>MariaDB</option>
								</optgroup>

								<optgroup label="AI">
									<option value="GPT"
										${boardVO.programmingLanguage == 'GPT' ? 'selected' : ''}>GPT</option>
									<option value="BERT"
										${boardVO.programmingLanguage == 'BERT' ? 'selected' : ''}>BERT</option>
									<option value="YOLO"
										${boardVO.programmingLanguage == 'YOLO' ? 'selected' : ''}>YOLO</option>
									<option value="OpenCV"
										${boardVO.programmingLanguage == 'OpenCV' ? 'selected' : ''}>OpenCV</option>
								</optgroup>

								<optgroup label="머신러닝/딥러닝">
									<option value="ScikitLearn"
										${boardVO.programmingLanguage == 'ScikitLearn' ? 'selected' : ''}>Scikit-learn</option>
									<option value="XGBoost"
										${boardVO.programmingLanguage == 'XGBoost' ? 'selected' : ''}>XGBoost</option>
									<option value="LightGBM"
										${boardVO.programmingLanguage == 'LightGBM' ? 'selected' : ''}>LightGBM</option>
									<option value="TensorFlow"
										${boardVO.programmingLanguage == 'TensorFlow' ? 'selected' : ''}>TensorFlow</option>
									<option value="PyTorch"
										${boardVO.programmingLanguage == 'PyTorch' ? 'selected' : ''}>PyTorch</option>
									<option value="Keras"
										${boardVO.programmingLanguage == 'Keras' ? 'selected' : ''}>Keras</option>
								</optgroup>
						</select></td>
					</tr>

					<tr>
						<td><label for="title" class="form-label required"> <i
								class="fas fa-heading"></i> 제목
						</label> <input type="text" id="title" name="title"
							placeholder="제목을 입력하세요"
							value="${boardVO.title != null ? boardVO.title : ''}"
							onfocus="this.placeholder=''"
							onblur="this.placeholder='제목을 입력하세요'" required></td>
					</tr>

					<tr>
						<td><label for="content" class="form-label required">
								<i class="fas fa-align-left"></i> 질문 내용
						</label> <textarea id="content" name="content"
								placeholder="질문 내용을 자세히 입력해주세요" onfocus="this.placeholder=''"
								onblur="this.placeholder='질문 내용을 자세히 입력해주세요'" required rows="12">${boardVO.content != null ? boardVO.content : ''}</textarea>
						</td>
					</tr>

					<tr class="code-section">
						<td><label for="codeContent" class="form-label"> <i
								class="fas fa-code"></i>코드 입력
						</label> <textarea id="codeContent" name="codeContent"
								placeholder="문제가 생긴 부분의 코드를 올려주세요&#10;- 일부 코드가 아닌 전체 코드를 올려주세요&#10;- 정확히 어떤 문제가 생긴건지 질문내용에 등록해주세요"
								rows="15">${boardVO.codeContent != null ? boardVO.codeContent : ''}</textarea>
						</td>
					</tr>


					<tr>
						<td><input type="file" name="file"> <c:if
								test="${not empty boardVO.filename}">
								<p>현재 업로드된 파일: ${boardVO.filename}</p>
							</c:if></td>
					</tr>
				</table>
				<div class="btn-container">
					<button type="submit" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-primary"
						style="background: #6c757d;">취소</button>
				</div>

			</form>

		</div>

		<footer class="footer">
			<div class="footer-links">
				<a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">고객센터</a>
			</div>
			<p>© 2025 커뮤니티. All rights reserved.</p>
		</footer>

		<script>
			// 폼 제출 전 유효성 검사
			document
					.getElementById('frm')
					.addEventListener(
							'submit',
							function(e) {
								const language = document
										.getElementById('programmingLanguage').value;
								const title = document.getElementById('title').value
										.trim();
								const content = document
										.getElementById('content').value.trim();

								if (!language) {
									alert('프로그래밍 언어를 선택해주세요.');
									// 프로그래밍 언어 미선택시 폼 제출 방지
									e.preventDefault();
									return false;
								}

								if (!title) {
									alert('제목을 입력해주세요.');
									// 제목 미입력시 폼 제출 방지
									e.preventDefault();
									return false;
								}

								if (!content) {
									alert('질문 내용을 입력해주세요.');
									// 질문 내용 미입력시 폼 제출 방지
									e.preventDefault();
									return false;
								}

								if (title.length < 5) {
									alert('제목은 5자 이상 입력해주세요.');
									e.preventDefault();
									return false;
								}

								if (content.length < 10) {
									alert('질문 내용은 10자 이상 입력해주세요.');
									e.preventDefault();
									return false;
								}
							});

			// 기술 스택과 CodeMirror 모드 매핑
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

			var codeEditor;

			$(document).ready(
					function() {

						const savedLanguage = "${post.programmingLanguage}";
						const mode = languageModeMap[savedLanguage];

						// 페이지 로드 시 즉시 CodeMirror 초기화
						var textarea = document.getElementById("codeContent");
						codeEditor = CodeMirror.fromTextArea(textarea, {
							lineNumbers : true, // 줄번호
							mode : mode, // 기본 모드
							theme : "dracula", // 드라큘라 테마
							indentUnit : 4, // 들여쓰기 단위
							lineWrapping : true, // 줄바꿈
							autoCloseBrackets : true, // 태그 자동 닫기
							matchBrackets : true, // 태그 매칭
							foldGutter : true, // 오타 수정: flodGutter → foldGutter
							height : "300px",
							gutters : [ "CodeMirror-linenumbers",
									"CodeMirror-foldgutter" ]
						});

						// 기술 스택 선택 시 모드 변경
						$('#programmingLanguage').on('change', function() {
							const selectedTech = $(this).val();
							const mode = languageModeMap[selectedTech];
							codeEditor.setOption("mode", mode);
						});

						// 폼 제출 시 CodeMirror 내용을 textarea에 동기화
						$('#frm').on('submit', function() {
							$('#codeContent').val(codeEditor.getValue());
						});
					});
		</script>
</body>
</html>