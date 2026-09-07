<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 수정</title>
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

#resetForm {
    max-width: 500px;
    width: 100%;
    background-color: #fff;
    padding: 35px 40px;
    border-radius: 6px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    border: 1px solid #d0d7de;
    margin: 0 auto;
}

#resetTable td {
    padding: 10px 0;
    vertical-align: top;
}

#resetTable label {
    display: block;
    font-weight: 600;
    margin-bottom: 6px;
    color: #24292f;
    font-size: 14px;
}

#resetTable input[type="text"],
#resetTable input[type="date"],
#resetTable select {
    width: calc(100% - 22px);
    padding: 9px 11px;
    font-size: 14px;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    transition: border-color 0.15s ease-in-out;
    font-family: inherit;
}

#resetTable input:focus,
#resetTable select:focus {
    outline: none;
    border-color: #0969da;
    box-shadow: inset 0 1px 0 rgba(208, 215, 222, 0.2);
}

#resetTable input[readonly] {
    background-color: #f6f8fa;
    color: #656d76;
    cursor: not-allowed;
}

.reset-button-group {
    display: flex;
    gap: 12px;
    margin-top: 20px;
    justify-content: center;
}

#resetTable button[type="submit"] {
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s ease;
}

#resetTable button[type="submit"]:hover {
    background-color: #0056b3;
}

#resetTable button[type="reset"] {
    padding: 10px 20px;
    background-color: #dc3545;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s ease;
}

#resetTable button[type="reset"]:hover {
    background-color: #c82333;
}

.reset-zipcode-btn {
    padding: 8px 14px;
    background-color: #f6f8fa;
    color: #24292f;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    font-weight: 500;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.2s ease;
}

.reset-zipcode-btn:hover {
    background-color: #f3f4f6;
    border-color: #afb8c1;
}

.reset-email-group {
    display: flex;
    align-items: center;
    gap: 8px;
    width: 100%;
}

.reset-email-group input[type="text"] {
    flex: 1;
    min-width: 120px;
    width: auto !important;
}

.reset-email-group select {
    flex-shrink: 0;
    min-width: 130px;
    max-width: 160px;
    width: auto !important;
}

.reset-email-group span {
    font-weight: 500;
    color: #656d76;
    font-size: 16px;
    flex-shrink: 0;
}



input[type="file"]::file-selector-button {
    padding: 6px 12px;
    background-color: #f6f8fa;
    color: #24292f;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    font-weight: 500;
    cursor: pointer;
    font-size: 12px;
    transition: background-color 0.2s ease;
}

input[type="file"]::file-selector-button:hover {
    background-color: #f3f4f6;
    border-color: #afb8c1;
}

@media (max-width: 768px) {
    #resetForm {
        width: 90%;
        padding: 25px 20px;
    }

    .reset-button-group {
        flex-direction: column;
        gap: 8px;
    }

    .reset-email-group {
        flex-wrap: wrap;
        gap: 6px;
    }

    .reset-email-group input[type="text"],
    .reset-email-group select {
        min-width: 110px;
        flex: 1 1 auto;
    }
}
</style>
</head>
<body>
<form id="resetForm" method="post" action="${pageContext.request.contextPath}/memberresertd" enctype="multipart/form-data">
    <table id="resetTable">
        <tr>
            <td><label for="newUserName"><i class="fa-solid fa-signature"></i> 이름</label>
                <input type="text" name="newUserName" id="newUserName" placeholder="이름을 입력하세요" required>
            </td>
        </tr>
        <tr>
            <td><label for="newZipCode"><i class="fa-solid fa-house"></i> 우편번호</label>
                <input type="text" name="newZipCode" id="newZipCode" placeholder="우편번호" readonly required>
                <button type="button" class="reset-zipcode-btn" onclick="searchZipcode()">우편번호 검색</button>
            </td>
        </tr>
        <tr>
            <td><label for="newAddress"><i class="fa-solid fa-house"></i> 주소</label>
                <input type="text" id="newAddress" placeholder="주소를 입력하세요" readonly required>
                <input type="text" name="newDetailAddress" id="newDetailAddress" placeholder="상세 주소를 입력하세요" required>
                <input type="hidden" name="newAddress" id="newFullAddress">
            </td>
        </tr>
        <tr>
            <td><label for="newUserEmail"><i class="fa-solid fa-envelope"></i> 이메일</label>
                <div class="reset-email-group">
                    <input type="text" name="newEmailId" id="newEmailId" placeholder="이메일 아이디" required>
                    <span>@</span>
                    <select name="newEmailDomain" id="newEmailDomain" required>
                        <option value="naver.com" selected>naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="daum.net">daum.net</option>
                    </select>
                    <input type="hidden" name="newFullEmail" id="newFullEmail">
                </div>
            </td>
        </tr>
        <tr>
            <td><label for="newPhoneNum"><i class="fa-solid fa-phone"></i> 휴대폰번호</label>
                <input type="text" id="newPhoneNum" name="newUserPhoneNum" maxlength="11" placeholder="숫자만 입력" required>
            </td>
        </tr>
        <tr>
            <td><label for="newBirthdate"><i class="fa-solid fa-cake-candles"></i> 생년월일</label>
                <input type="date" name="newBirthdate" id="newBirthdate" required>
            </td>
        </tr>
        
        <tr>
            <td>
                <div class="reset-button-group">
                    <button type="submit"><i class="fa-solid fa-check"></i> 수정</button>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/profileOptions'" type="reset"><i class="fa-solid fa-xmark"></i> 취소</button>
                </div>
            </td>
        </tr>
    </table>
</form>

<script>
function searchZipcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullAddress = data.address;
            document.getElementById('newZipCode').value = data.zonecode;
            document.getElementById('newAddress').value = fullAddress;
            document.getElementById('newDetailAddress').focus();
            document.getElementById('newFullAddress').value = fullAddress + ' ' + (document.getElementById('newDetailAddress').value || '');
        }
    }).open();
}

document.getElementById('newDetailAddress').addEventListener('input', function() {
    const full = document.getElementById('newAddress').value + ' ' + this.value;
    document.getElementById('newFullAddress').value = full.trim();
});

$('input[name="newUserPhoneNum"]').on('input', function() {
    this.value = this.value.replace(/[^0-9]/g, '');
});

document.getElementById('newEmailDomain').addEventListener('change', function() {
    const selectedValue = this.value;
    document.getElementById('newFullEmail').value = document.getElementById('newEmailId').value + '@' + selectedValue;
});
document.getElementById('newEmailId').addEventListener('input', function() {
    const emailId = this.value;
    const emailDomain = document.getElementById('newEmailDomain').value;
    document.getElementById('newFullEmail').value = emailId + '@' + emailDomain;
});

$('#newProfileImg').on('change', function() {
    var file = this.files[0];
    if (file) {
        if (file.size > 1024 * 1024) {
            alert('파일 크기는 1MB를 초과할 수 없습니다.');
            $('#newPhotoPreview').attr('src', 'resources/images/img_add.png');
            $(this).val('');
            return;
        }
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#newPhotoPreview').attr('src', e.target.result).show();
        };
        reader.readAsDataURL(file);
    } else {
        $('#newPhotoPreview').attr('src', 'resources/images/img_add.png');
    }
});
</script>
</body>
</html>