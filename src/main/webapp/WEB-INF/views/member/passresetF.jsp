<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 재설정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    max-width: 500px;
    width: 100%;
    padding: 0 20px;
    margin: 0 auto;
}

form {
    background-color: #fff;
    padding: 35px 40px;
    border-radius: 6px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    border: 1px solid #d0d7de;
}

h1 {
    text-align: center;
    color: #1f2328;
    font-weight: 600;
    margin-bottom: 20px;
    font-size: 24px;
}

label {
    display: block;
    font-weight: 600;
    margin-bottom: 6px;
    color: #24292f;
    font-size: 14px;
}

input[type="text"],
input[type="password"] {
    width: calc(100% - 22px);
    padding: 9px 11px;
    font-size: 14px;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    transition: border-color 0.15s ease-in-out;
    font-family: inherit;
}

input:focus {
    outline: none;
    border-color: #0969da;
    box-shadow: inset 0 1px 0 rgba(208, 215, 222, 0.2);
}

input[readonly] {
    background-color: #f6f8fa;
    color: #656d76;
    cursor: not-allowed;
}

button[type="submit"] {
    width: 100%;
    padding: 10px 20px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s ease;
    margin-top: 20px;
}

button[type="submit"]:hover {
    background-color: #218838;
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

.error, .success, .feedback {
    font-size: 14px;
    margin-top: 5px;
}

.error {
    color: red;
}

.success {
    color: green;
}

@media (max-width: 768px) {
    .container {
        padding: 0 15px;
    }

    form {
        padding: 25px 20px;
        width: 90%;
    }
}
</style>
</head>
<body>
<div class="container">
    <button class="back-button" onclick="history.back()"><i class="fas fa-arrow-left"></i> 이전 페이지로 돌아가기</button>
    <h1>비밀번호 재설정</h1>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/resetPassword" method="post" id="resetPasswordForm">
        <label for="userid"><i class="fa-solid fa-user"></i> 유저 아이디:</label>
        <input type="text" name="userid" id="userid" value="${sessionScope.loginUser.userId}" required readonly />
        <label for="oldPassword"><i class="fa-solid fa-lock"></i> 이전 비밀번호:</label>
        <input type="password" id="oldPassword" name="oldPassword" required>
        <label for="newPassword"><i class="fa-solid fa-lock"></i> 새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" pattern=".{8,}" required>
        <div id="passwordFeedback1" class="feedback"></div>
        <label for="confirmPassword"><i class="fa-solid fa-lock"></i> 새 비밀번호 확인:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" pattern=".{8,}" required>
        <div id="passwordFeedback2" class="feedback"></div>
        <button type="submit" onclick="return validateForm()"><i class="fa-solid fa-check"></i> 비밀번호 재설정</button>
    </form>
</div>

<script>
$(document).ready(function() {
    $('#newPassword').on('keyup', function() {
        let password = $(this).val();
        if (password === '') {
            $('#passwordFeedback1').html('<b style="color:red;">[사용할 비밀번호를 입력하세요]</b>');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/checkPassword',
            data: { password: password },
            success: function(response) {
                if (response.valid) {
                    $('#passwordFeedback1').html('<b style="color:green;">[사용 가능한 비밀번호입니다.]</b>');
                } else {
                    $('#passwordFeedback1').html('<b style="color:red;">[비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.]</b>');
                }
            },
            error: function() {
                $('#passwordFeedback1').html('<b style="color:red;">[서버 오류가 발생했습니다.]</b>');
            }
        });
    });

    $('#confirmPassword').on('keyup', function() {
        let confirmPwd = $(this).val();
        let pwd = $('#newPassword').val();

        if (confirmPwd === '') {
            $('#passwordFeedback2').html('<b style="color:blue;">[비밀번호 확인은 필수 정보입니다.]</b>');
        } else if (confirmPwd !== pwd) {
            $('#passwordFeedback2').html('<b style="color:red;">[입력한 비밀번호가 일치하지 않습니다.]</b>');
        } else {
            $('#passwordFeedback2').html('<b style="color:green;">[비밀번호가 일치합니다.]</b>');
        }
    });

    $('#resetPasswordForm').on('submit', function(event) {
        let oldPassword = $('#oldPassword').val();
        let newPassword = $('#newPassword').val();
        let confirmPassword = $('#confirmPassword').val();

        if (!newPassword.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/)) {
            alert('비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.');
            event.preventDefault();
            return false;
        }
        if (newPassword !== confirmPassword) {
            alert('새 비밀번호와 확인 비밀번호가 일치해야 합니다.');
            event.preventDefault();
            return false;
        }
        if (oldPassword === newPassword) {
            alert('새 비밀번호는 이전 비밀번호와 같을 수 없습니다.');
            event.preventDefault();
            return false;
        }
        return true;
    });
});

function validateForm() {
    let oldPassword = document.getElementById('oldPassword').value;
    let newPassword = document.getElementById('newPassword').value;
    let confirmPassword = document.getElementById('confirmPassword').value;

    if (newPassword !== confirmPassword) {
        alert('새 비밀번호는 확인 비밀번호와 일치해야 합니다.');
        return false;
    }
    if (oldPassword === newPassword) {
        alert('새 비밀번호는 이전 비밀번호와 같을 수 없습니다.');
        return false;
    }
    return true;
}
</script>
</body>
</html>