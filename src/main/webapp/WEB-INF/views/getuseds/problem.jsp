<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문제 풀기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/theme/dracula.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/javascript/javascript.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/clike/clike.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/python/python.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/php/php.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/ruby/ruby.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/go/go.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/rust/rust.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/swift/swift.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/dart/dart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/r/r.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.2/mode/julia/julia.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Noto Sans KR', Arial, sans-serif; background-color: #f8f9fa; color: #343a40; line-height: 1.6; }
        .container { max-width: 1280px; margin: 0 auto; padding: 0 20px; display: flex; flex-wrap: wrap; gap: 20px; }
        .problem-container { background-color: #fff; padding: 30px 40px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); width: 100%; max-width: 900px; margin: 40px auto; }
        h1 { text-align: center; color: #343a40; margin-bottom: 20px; font-size: 28px; font-weight: 700; }
        .problem-description { margin-bottom: 20px; font-size: 16px; }
        .CodeMirror { border: 2px solid #e9ecef; border-radius: 8px; height: 350px; }
        .btn-submit { padding: 12px 30px; background: linear-gradient(135deg, #007bff, #0056b3); color: #fff; border: none; border-radius: 8px; font-size: 15px; cursor: pointer; margin-top: 20px; }
        .btn-submit:hover { background: linear-gradient(135deg, #0056b3, #003d80); }
        .feedback { margin-top: 20px; padding: 15px; border-radius: 8px; }
        .correct { background-color: #d4edda; color: #155724; }
        .incorrect { background-color: #f8d7da; color: #721c24; }
        .language-info { margin-bottom: 20px; font-size: 16px; color: #495057; }
        .error-message { color: #dc3545; font-weight: 600; margin-bottom: 20px; }
        .language-select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            font-family: inherit;
            background-color: #fff;
            color: #495057;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path fill="%23495057" d="M8 11L3 6h10l-5 5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 18px;
            cursor: pointer;
            min-height: 55px;
        }
        .language-select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }
        .language-section { margin-bottom: 20px; }
        .form-label { display: block; margin-bottom: 8px; font-weight: 600; color: #495057; font-size: 16px; }
    </style>
</head>
<body>
    <div class="container">
    	<%@ include file="../common/top.jsp" %>
        
        <div class="problem-container">
            <h1>${problem.title}</h1>
            <div class="problem-description">${problem.description}</div>
            <div class="language-info">언어: ${problem.language}</div>
            <form action="${pageContext.request.contextPath}/submitSolution" method="post" id="solutionForm">
                <input type="hidden" name="problemId" value="${problem.problemId}">
                <div class="language-section">
                    <label for="programmingLanguage" class="form-label">프로그래밍 언어</label>
                    <select id="programmingLanguage" name="language" class="language-select" required>
                        <option value="">언어를 선택하세요</option>
                        <optgroup label="프로그래밍 언어">
                            <option value="Python" ${problem.language == 'Python' ? 'selected' : ''}>Python</option>
                            <option value="JavaScript" ${problem.language == 'JavaScript' ? 'selected' : ''}>JavaScript</option>
                            <option value="Java" ${problem.language == 'Java' ? 'selected' : ''}>Java</option>
                            <option value="C++" ${problem.language == 'C++' ? 'selected' : ''}>C++</option>
                            <option value="C" ${problem.language == 'C' ? 'selected' : ''}>C</option>
                            <option value="C#" ${problem.language == 'C#' ? 'selected' : ''}>C#</option>
                            <option value="TypeScript" ${problem.language == 'TypeScript' ? 'selected' : ''}>TypeScript</option>
                            <option value="Go" ${problem.language == 'Go' ? 'selected' : ''}>Go</option>
                            <option value="Rust" ${problem.language == 'Rust' ? 'selected' : ''}>Rust</option>
                            <option value="Swift" ${problem.language == 'Swift' ? 'selected' : ''}>Swift</option>
                            <option value="Kotlin" ${problem.language == 'Kotlin' ? 'selected' : ''}>Kotlin</option>
                            <option value="PHP" ${problem.language == 'PHP' ? 'selected' : ''}>PHP</option>
                            <option value="Ruby" ${problem.language == 'Ruby' ? 'selected' : ''}>Ruby</option>
                            <option value="Dart" ${problem.language == 'Dart' ? 'selected' : ''}>Dart</option>
                            <option value="R" ${problem.language == 'R' ? 'selected' : ''}>R</option>
                            <option value="Julia" ${problem.language == 'Julia' ? 'selected' : ''}>Julia</option>
                        </optgroup>
                    </select>
                </div>
                <textarea id="codeEditor" name="code">${submittedCode}</textarea>
                <button type="submit" class="btn-submit">제출</button>
            </form>
            <c:if test="${not empty feedback}">
                <div class="feedback ${isCorrect ? 'correct' : 'incorrect'}">
                    <h2>피드백</h2>
                    <p>${feedback}</p>
                    <p>${isCorrect ? '정답입니다!' : '오답입니다.'}</p>
                </div>
            </c:if>
        </div>
    </div>
    <script>
        const languageModeMap = {
            'Python': 'text/x-python',
            'JavaScript': 'javascript',
            'Java': 'text/x-java',
            'C++': 'text/x-c++src',
            'C': 'text/x-csrc',
            'C#': 'text/x-csharp',
            'TypeScript': 'text/typescript',
            'Go': 'text/x-go',
            'Rust': 'text/x-rustsrc',
            'Swift': 'text/x-swift',
            'Kotlin': 'text/x-kotlin',
            'PHP': 'application/x-httpd-php',
            'Ruby': 'text/x-ruby',
            'Dart': 'application/dart',
            'R': 'text/x-rsrc',
            'Julia': 'text/x-julia'
        };

        var editor = CodeMirror.fromTextArea(document.getElementById("codeEditor"), {
            lineNumbers: true,
            mode: languageModeMap['${problem.language}'] || 'text/plain',
            theme: "dracula",
            indentUnit: 4,
            lineWrapping: true,
            autoCloseBrackets: true,
            matchBrackets: true,
            foldGutter: true,
            gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });

        $('#programmingLanguage').on('change', function() {
            const selectedLanguage = $(this).val();
            const mode = languageModeMap[selectedLanguage] || 'text/plain';
            editor.setOption("mode", mode);
        });

        $('#solutionForm').on('submit', function() {
            $('#codeEditor').val(editor.getValue());
        });
    </script>
</body>
</html>