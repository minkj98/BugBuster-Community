<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>문제 목록</title>
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
}

.container {
	max-width: 1280px;
	margin: 0 auto;
	padding: 0 20px;
}

.problem-list-container {
	background-color: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	margin: 40px auto;
}

h1 {
	text-align: center;
	color: #343a40;
	margin-bottom: 20px;
	font-size: 28px;
	font-weight: 700;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #e9ecef;
}

th {
	background-color: #f1f3f5;
	font-weight: 600;
}

td a {
	color: #007bff;
	text-decoration: none;
}

td a:hover {
	text-decoration: underline;
}

.language-filter {
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.language-select, .difficulty-select {
	width: 200px;
	padding: 10px 15px;
	border: 2px solid #e9ecef;
	border-radius: 8px;
	font-size: 14px;
	font-family: inherit;
	background-color: #fff;
	color: #495057;
	transition: all 0.3s ease;
	appearance: none;
	background-image:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="%23495057" d="M8 11L3 6h10l-5 5z"/></svg>');
	background-repeat: no-repeat;
	background-position: right 10px center;
	background-size: 16px;
	cursor: pointer;
}

.language-select:focus, .difficulty-select:focus {
	outline: none;
	border-color: #007bff;
	box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
}
</style>
</head>
<body>
	<div class="container">
		<%@ include file="../common/top.jsp"%>
		<div class="problem-list-container">
			<h1>문제 목록</h1>
			<div class="language-filter">
				<label for="languageFilter">언어 필터:</label> <select
					id="languageFilter" class="language-select"
					onchange="filterProblems()">
					<option value=""
						${param.language == null || param.language == '' ? 'selected' : ''}>전체</option>
					<option value="Python"
						${param.language == 'Python' ? 'selected' : ''}>Python</option>
					<option value="JavaScript"
						${param.language == 'JavaScript' ? 'selected' : ''}>JavaScript</option>
					<option value="Java" ${param.language == 'Java' ? 'selected' : ''}>Java</option>
					<option value="C++" ${param.language == 'C++' ? 'selected' : ''}>C++</option>
					<option value="C" ${param.language == 'C' ? 'selected' : ''}>C</option>
					<option value="C#" ${param.language == 'C#' ? 'selected' : ''}>C#</option>
					<option value="TypeScript"
						${param.language == 'TypeScript' ? 'selected' : ''}>TypeScript</option>
					<option value="Go" ${param.language == 'Go' ? 'selected' : ''}>Go</option>
					<option value="Rust" ${param.language == 'Rust' ? 'selected' : ''}>Rust</option>
					<option value="Swift"
						${param.language == 'Swift' ? 'selected' : ''}>Swift</option>
					<option value="Kotlin"
						${param.language == 'Kotlin' ? 'selected' : ''}>Kotlin</option>
					<option value="PHP" ${param.language == 'PHP' ? 'selected' : ''}>PHP</option>
					<option value="Ruby" ${param.language == 'Ruby' ? 'selected' : ''}>Ruby</option>
					<option value="Dart" ${param.language == 'Dart' ? 'selected' : ''}>Dart</option>
					<option value="R" ${param.language == 'R' ? 'selected' : ''}>R</option>
					<option value="Julia"
						${param.language == 'Julia' ? 'selected' : ''}>Julia</option>
				</select> <label for="difficultyFilter">난이도 필터:</label> <select
					id="difficultyFilter" class="difficulty-select"
					onchange="filterProblems()">
					<option value=""
						${param.difficulty == null || param.difficulty == '' ? 'selected' : ''}>전체</option>
					<option value="Easy"
						${param.difficulty == 'Easy' ? 'selected' : ''}>Easy</option>
					<option value="Medium"
						${param.difficulty == 'Medium' ? 'selected' : ''}>Medium</option>
					<option value="Hard"
						${param.difficulty == 'Hard' ? 'selected' : ''}>Hard</option>
				</select>
			</div>
			<table>
				<thead>
					<tr>
						<th>문제 번호</th>
						<th>제목</th>
						<th>난이도</th>
						<th>언어</th>
						<th>생성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="problem" items="${problemList}">
						<tr>
							<td>${problem.problemId}</td>
							<td><a
								href="${pageContext.request.contextPath}/problem?id=${problem.problemId}">${problem.title}</a></td>
							<td>${problem.difficulty}</td>
							<td>${problem.language}</td>
							<td><fmt:formatDate value="${problem.createdAt}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		function filterProblems() {
			const language = document.getElementById("languageFilter").value;
			const difficulty = document.getElementById("difficultyFilter").value;
			const url = "${pageContext.request.contextPath}/problems?language="
					+ encodeURIComponent(language) + "&difficulty="
					+ encodeURIComponent(difficulty);
			window.location.href = url;
		}
	</script>
</body>
</html>