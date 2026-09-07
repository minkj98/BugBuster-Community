<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- jQuery는 하나만 불러오도록 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">


<style>
body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background-color: #fafbfc;
    margin: 0;
    padding: 30px 0;
    display: flex;
    justify-content: center;
    align-items: flex-start;
}

#signUpForm {
    background-color: #fff;
    padding: 35px 40px;
    border-radius: 6px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    width: 500px;
    border: 1px solid #e1e5e9;
}

#signUp td {
    padding: 10px 0;
    vertical-align: top;
}

#signUp label {
    display: block;
    font-weight: 600;
    margin-bottom: 6px;
    color: #24292f;
    font-size: 14px;
}

#signUp input[type="text"], 
#signUp input[type="password"], 
#signUp input[type="email"],
#signUp select {
    width: calc(100% - 22px);
    padding: 9px 11px;
    font-size: 14px;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    transition: border-color 0.15s ease-in-out;
    font-family: inherit;
}

#signUp input:focus {
    outline: none;
    border-color: #0969da;
    box-shadow: inset 0 1px 0 rgba(208, 215, 222, 0.2);
}

#signUp input[readonly] {
    background-color: #f6f8fa;
    color: #656d76;
    cursor: not-allowed;
}

/* 버튼들 - 통일감 있게 수정 */
.button-group {
    display: flex;
    gap: 12px;
    margin-top: 20px;
    justify-content: center;
}

#signUp button[type="submit"] {
    padding: 10px 20px;
    background-color: #1f2328;
    color: white;
    border: 1px solid #1f2328;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s ease;
}

#signUp button[type="submit"]:hover {
    background-color: #32383f;
}

#cancelBtn {
    padding: 10px 20px;
    background-color: #f6f8fa;
    color: #24292f;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s ease;
}

#cancelBtn:hover {
    background-color: #f3f4f6;
    border-color: #afb8c1;
}

#idCheckBtn {
    padding: 8px 14px;
    background-color: #f6f8fa;
    color: #24292f;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    font-weight: 500;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.2s ease;
    white-space: nowrap;
    min-width: 85px;
}

#idCheckBtn:hover {
    background-color: #f3f4f6;
    border-color: #afb8c1;
}

.zipcode-btn {
    padding: 8px 14px !important;
    background-color: #f6f8fa !important;
    color: #24292f !important;
    border: 1px solid #d0d7de !important;
    border-radius: 6px !important;
    font-weight: 500 !important;
    cursor: pointer !important;
    font-size: 13px !important;
    transition: background-color 0.2s ease !important;
}

.zipcode-btn:hover {
    background-color: #f3f4f6 !important;
    border-color: #afb8c1 !important;
}

/* 컨테이너들 */
.id-check-container, .zipcode-container {
    display: flex;
    align-items: center;
    gap: 10px;
}

/* 이메일 그룹 - 제공된 HTML 구조에 맞춤 */
.email-group {
    display: flex;
    align-items: center;
    gap: 8px;
    width: 100%;
}

.email-group input[type="text"] {
    flex: 1;
    min-width: 140px;
    width: auto !important;
    padding: 9px 11px;
    font-size: 14px;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    transition: border-color 0.15s ease-in-out;
    font-family: inherit;
}

.email-group input[type="text"]:focus {
    outline: none;
    border-color: #0969da;
    box-shadow: inset 0 1px 0 rgba(208, 215, 222, 0.2);
}

.email-group span {
    font-weight: 500;
    color: #656d76;
    font-size: 16px;
    flex-shrink: 0;
    margin: 0 2px;
}

.email-group select {
    flex-shrink: 0;
    width: auto !important;
    min-width: 130px;
    max-width: 160px;
    padding: 9px 11px;
    font-size: 14px;
    border: 1px solid #d0d7de;
    border-radius: 6px;
    transition: border-color 0.15s ease-in-out;
    font-family: inherit;
    background-color: #fff;
}

.email-group select:focus {
    outline: none;
    border-color: #0969da;
    box-shadow: inset 0 1px 0 rgba(208, 215, 222, 0.2);
}

/* 반응형에서 이메일 필드 처리 */
@media (max-width: 768px) {
    .email-group {
        flex-wrap: wrap;
        gap: 6px;
    }
    
    .email-group input[type="text"] {
        min-width: 120px;
        flex: 1 1 auto;
    }
    
    .email-group select {
        min-width: 110px;
        flex: 1 1 auto;
    }
    
    .email-group span {
        flex-shrink: 0;
        order: 1;
    }
}


/* 프로필 사진 */
.profile-upload {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    margin: 12px 0;
}

.profile-photo {
    width: 120px;
    height: 120px;
    border-radius: 8px;
    border: 1px solid #d0d7de;
    background: #f6f8fa;
    object-fit: cover;
}

input[type=file]::file-selector-button {
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

input[type=file]::file-selector-button:hover {
    background-color: #f3f4f6;
    border-color: #afb8c1;
}

/* 관심 태그 - 단조롭게 */
.tag-container {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-top: 10px;
}

.tag-label {
    display: flex;
    align-items: center;
    padding: 6px 12px;
    background-color: #f6f8fa;
    color: #24292f;
    border: 1px solid #d0d7de;
    border-radius: 16px;
    font-size: 13px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.15s ease;
    user-select: none;
}

.tag-label:hover {
    background-color: #f3f4f6;
    border-color: #afb8c1;
}

.tag-label:has(input[type="checkbox"]:checked) {
    background-color: #dbeafe;
    color: #1e40af;
    border-color: #93c5fd;
}

/* 비밀번호 컨테이너 */
.password-container {
    position: relative;
}

.password-container input {
    padding-right: 35px !important;
}

.password-container .toggle-eye {
    position: absolute;
    top: 50%;
    right: 10px;
    transform: translateY(-50%);
    cursor: pointer;
    color: #656d76;
    transition: color 0.2s ease;
}

.password-container .toggle-eye:hover {
    color: #24292f;
}

/* 헤더 */
h2 {
    text-align: center;
    color: #1f2328;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 24px;
}

h5 {
    color: #656d76;
    text-align: center;
    font-weight: 400;
    line-height: 1.5;
    margin-bottom: 8px;
}

/* 날짜 입력 */
input[type="date"] {
    padding: 9px 11px !important;
    border: 1px solid #d0d7de !important;
    border-radius: 6px !important;
    font-size: 14px !important;
    transition: border-color 0.15s ease-in-out !important;
}

input[type="date"]:focus {
    border-color: #0969da !important;
    box-shadow: inset 0 1px 0 rgba(208, 215, 222, 0.2) !important;
}

/* 로고 */
.logo-section {
    display: flex;
    justify-content: center;
    margin: 10px 0 20px;
}

/* 구분선 */
hr {
    border: none;
    height: 1px;
    background-color: #d0d7de;
    margin: 20px 0;
}

/* 반응형 */
@media (max-width: 768px) {
    #signUpForm {
        width: 90%;
        padding: 25px 20px;
        margin: 10px auto;
    }
    
    .button-group {
        flex-direction: column;
        gap: 8px;
    }
    
    .id-check-container, .zipcode-container {
        flex-direction: column;
        align-items: stretch;
        gap: 8px;
    }
}
</style>

<script>
    $(document).ready(function() {
      // 우편번호 검색
      window.searchZipcode = function() {
        new daum.Postcode({
          oncomplete: function(data) {
            var fullAddress = data.address;
            var extraAddress = '';
            if (data.addressType === 'R') {
              if (data.bname !== '') extraAddress += data.bname;
              if (data.buildingName !== '') extraAddress += (extraAddress !== '' ? ', ' + data.buildingName : data.buildingName);
              if (extraAddress !== '') fullAddress += ' (' + extraAddress + ')';
            }
            $('#zipCode').val(data.zonecode);
            $('#address').val(fullAddress);
            $('#detailAddress').focus();
            $('#fullAddress').val(fullAddress + ' ' + $('#detailAddress').val());
          }
        }).open();
      };

      // 상세 주소 입력 시 fullAddress 갱신
      $('#detailAddress').on('input', function() {
        const full = $('#address').val() + ' ' + $(this).val();
        $('#fullAddress').val(full.trim());
      });

      // 아이디 중복 체크
      $("#idCheckBtn").click(function() {
        var userId = $("#userId").val().trim();
        if (userId === "") {
          alert("사용할 아이디를 입력하세요");
          return;
        }
        $.ajax({
          type: "POST",
          url: "${pageContext.request.contextPath}/userIdCheck",
          data: { userId: userId },
          success: function(data) {
            if (data.count === 0) {
              $("#idCheckStatus").text("사용 가능한 아이디입니다.").css("color", "green");
            } else {
              $("#idCheckStatus").text("이미 사용 중인 아이디입니다.").css("color", "red");
            }
          },
          error: function() {
            alert("서버와 통신 중 오류가 발생했습니다.");
          }
        });
      });

      // 비밀번호 유효성 검사 및 확인
      $('#userPassword').keyup(function() {
        let password = $(this).val();
        if (password === '') {
          $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[사용할 비밀번호를 입력하세요]</b>');
          return;
        }
        $.ajax({
          type: 'POST',
          url: '${pageContext.request.contextPath}/checkPassword',
          data: { password: password },
          success: function(response) {
            if (response.valid) {
              $('#passwordCheck1').html('<b style="font-size:14px; color:green;">[사용 가능한 비밀번호입니다.]</b>');
            } else {
              $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.]</b>');
            }
          },
          error: function() {
            $('#passwordCheck1').html('<b style="font-size:14px; color:red;">[서버 오류가 발생했습니다.]</b>');
          }
        });
      });

      $('#userPasswordConfirm').keyup(function() {
        let confirmPwd = $(this).val();
        let pwd = $('#userPassword').val();
        if (confirmPwd === '') {
          $('#passwordCheck2').html('<b style="font-size:14px; color:blue;">[비밀번호 확인은 필수 정보입니다.]</b>');
        } else if (confirmPwd !== pwd) {
          $('#passwordCheck2').html('<b style="font-size:14px; color:red;">[입력한 비밀번호가 일치하지 않습니다.]</b>');
        } else {
          $('#passwordCheck2').html('<b style="font-size:14px; color:green;">[비밀번호가 일치합니다.]</b>');
        }
      });

      // 폼 제출 시 검증
      $('#signUpForm').submit(function(event) {
        let password = $('#userPassword').val();
        let confirmPwd = $('#userPasswordConfirm').val();
        if (!password.match(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/)) {
          alert('비밀번호는 영문, 숫자, 특수문자를 포함해 8자 이상이어야 합니다.');
          event.preventDefault();
          return false;
        }
        if (password !== confirmPwd) {
          alert('비밀번호가 일치하지 않습니다.');
          event.preventDefault();
          return false;
        }
      });

      // 휴대폰 번호 숫자만 허용
      $('input[name="userPhoneNum"]').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
      });

      // 이메일 처리
      $('#email_domain').on('change', function() {
        const selectedValue = this.value;
        $('#email_domain_input').val(selectedValue);
      });
      $('#email_id').on('input', function() {
        const emailId = this.value;
        const emailDomain = $('#email_domain_input').val();
        $('#fullEmail').val(emailId + '@' + emailDomain);
      });

      // 프로필 사진 업로드
      let photo_path = $('#photoPreview').attr('src');
      $('#profileImg').on('change', function() {
        let myPhoto = this.files[0];
        if (!myPhoto) {
          $('#photoPreview').attr('src', photo_path);
          return;
        }
        if (myPhoto.size > 1024 * 1024) {
          $('#photoPreview').attr('src', photo_path);
          $(this).val('');
          return;
        }
        let reader = new FileReader();
        reader.readAsDataURL(myPhoto);
        reader.onload = function() {
          $('#photoPreview').attr('src', reader.result).show();
        };
      });
    });
    
    document.addEventListener('DOMContentLoaded', () => {
        const CHECKLIMIT = 5; // 최대 선택 가능 개수
        const checkboxes = document.querySelectorAll('.interest-checkbox');
        const checkboxCheck = document.getElementById('checkboxCheck');
        const signUpForm = document.getElementById('signUpForm');

       
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', () => {
                const checkedCheckboxes = document.querySelectorAll('.interest-checkbox:checked');

                // 최대 5개 제한
                if (checkedCheckboxes.length > CHECKLIMIT) {
                    checkboxCheck.innerHTML = '<b style="font-size:14px; color:red;">[선택 가능한 관심태그는 최대 5개입니다.]</b>';
                    checkbox.checked = false;
                } else {
                    checkboxCheck.innerHTML = '';
                }
            });
        });

        // 폼 제출 시 최소 1개 검증
        signUpForm.addEventListener('submit', (event) => {
            const checkedCheckboxes = document.querySelectorAll('.interest-checkbox:checked');
            if (checkedCheckboxes.length === 0) {
                event.preventDefault(); 
                checkboxCheck.innerHTML = '<b style="font-size:14px; color:red;">[관심 태그는 최소 1개 이상 선택해야 합니다.]</b>';
                return false;
            }
        });
    });
    
    $(document).ready(function() {
    	  $('.toggle-eye').on('click', function() {
    	    const $input = $(this).prev('input');
    	    const showing = $input.attr('type') === 'text';
    	    $input.attr('type', showing ? 'password' : 'text');
    	    $(this).toggleClass('fa-eye fa-eye-slash');
    	  });
    	});

  </script>
</head>

<body>



	<form action="${pageContext.request.contextPath}/join" method="post"
		enctype="multipart/form-data" id="signUpForm">
		<div class="logo-section">
			<img id="bugbuster-logo" src="resources/images/BugBusterLogoV2.png"
				alt="로고" class="logo-img" width="150" height="150" />
		</div>
		<h2>BugBuster에 오신것을 환영합니다.</h2>
		<h5>BugBuster는 개발자의 모든 순간을 함께하는 커뮤니티입니다.</h5>
		<hr>
		<h5>회원가입을 위해 아래 기본 정보들을 입력해주세요</h5>
		<table id="signUp">

			<tr>
				<td><label for="userId"><i class="fa-solid fa-user"></i>&nbsp;아이디</label>
					<div class="id-check-container">
						<input type="text" name="userId" id="userId"
							placeholder="아이디를 입력하세요" onfocus="this.placeholder=''"
							onblur="this.placeholder='아이디를 입력하세요'" required>
						<button type="button" id="idCheckBtn">중복체크</button>
						<div>
							<font id="idCheckStatus" size="2"></font>
						</div>
					</div></td>
			</tr>
			<tr>
				<td><label for="userPassword"><i
						class="fa-solid fa-lock"></i>&nbsp;비밀번호</label>
					<div class="password-container">
						<input type="password" name="userPassword" id="userPassword"
							placeholder="비밀번호를 입력하세요" onfocus="this.placeholder=''"
							onblur="this.placeholder='비밀번호를 입력하세요'" required> <i
							class="fa-solid fa-eye toggle-eye"></i>
					</div>
					<div id="passwordCheck1"></div></td>
			</tr>
			<tr>
				<td><label for="userPasswordConfirm"><i
						class="fa-solid fa-lock"></i>&nbsp;비밀번호 확인</label>
					<div class="password-container">
						<input type="password" name="userPasswordConfirm"
							id="userPasswordConfirm" placeholder="비밀번호를 한 번 더 입력하세요"
							onfocus="this.placeholder=''"
							onblur="this.placeholder='비밀번호를 입력하세요'" required> <i
							class="fa-solid fa-eye toggle-eye"></i>
					</div>
					<div id="passwordCheck2"></div></td>
			</tr>


			<tr>
				<td><label for="userName"><i
						class="fa-solid fa-signature"></i>&nbsp;이름</label> <input type="text"
					name="userName" id="userName" placeholder="이름을 입력하세요"
					onfocus="this.placeholder=''" onblur="this.placeholder='이름을 입력하세요'"
					required></td>
			</tr>
			<tr>
				<td>
					<div class="tag-group">
						<label for="InterestsTag" class="form-label"><i
							class="fa-solid fa-tag"></i>&nbsp;관심 태그</label>
						<p class="interest-tag-info">관심 태그는 최소 1개에서 최대 5개를 선택할 수 있습니다.</p>
						<div class="tag-container">
							<label class="tag-label"> <input type="checkbox"
								name="interest" value="backend" class="interest-checkbox"
								id="backend"><span>백엔드</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="frontend" class="interest-checkbox"
								id="frontend"><span>프런트엔드</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="webdevelopment" class="interest-checkbox"
								id="webdevelopment"><span>웹 개발</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="gamedevelopment"
								class="interest-checkbox" id="gamedevelopment"><span>게임
									개발</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="appdevelopment" class="interest-checkbox"
								id="appdevelopment"><span>앱 개발</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="framework" class="interest-checkbox"
								id="framework"><span>프레임워크</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="cloud" class="interest-checkbox"
								id="cloud"><span>클라우드</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="devops" class="interest-checkbox"
								id="devops"><span>devops</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="sql" class="interest-checkbox" id="sql">
								<span>sql</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="security" class="interest-checkbox"
								id="security"><span>보안</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="hardware" class="interest-checkbox"
								id="hardware"><span>하드웨어</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="network" class="interest-checkbox"
								id="network"><span>네트워크</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="metaverse" class="interest-checkbox"
								id="metaverse"><span>메타버스</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="blockchain" class="interest-checkbox"
								id="blockchain"><span>블록체인</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="web3" class="interest-checkbox" id="web3">
								<span>web3</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="developerEvent" class="interest-checkbox"
								id="developerEvent"><span>개발자 이벤트</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="domesticTechnologyAndPolicy"
								class="interest-checkbox" id="domesticTechnologyAndPolicy">
								<span>국내 기술 및 정책</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="robot" class="interest-checkbox"
								id="robot"><span>로봇</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="automation" class="interest-checkbox"
								id="automation"><span>자동화</span>
							</label> <label class="tag-label"> <input type="checkbox"
								name="interest" value="developmentEcosystem"
								class="interest-checkbox" id="developmentEcosystem"> <span>개발
									생태계</span>
							</label>
							<div id="checkboxCheck"></div>

						</div>

					</div>
				</td>
			</tr>
			<tr>

				<td><label for="zipCode"><i class="fa-solid fa-house"></i>&nbsp;우편번호</label>
					<div class="zipcode-container">
						<input type="text" name="zipCode" id="zipCode" placeholder="우편번호"
							readonly required>
						<button type="button" class="zipcode-btn"
							onclick="searchZipcode()">검색</button>
					</div></td>

			</tr>
			<tr>
				<td><label for="address"><i class="fa-solid fa-house"></i>&nbsp;주소</label>
					<input type="text" id="address" placeholder="주소를 입력하세요" readonly
					required> <input type="text" name="detailAddress"
					id="detailAddress" placeholder="상세 주소를 입력하세요"
					onfocus="this.placeholder=''"
					onblur="this.placeholder='상세 주소를 입력하세요'" required> <input
					type="hidden" name="address" id="fullAddress"></td>
			</tr>
			<tr>
				<td><label for="userEmail"><i
						class="fa-solid fa-envelope"></i>&nbsp;이메일</label>
					<div class="email-group">
						<input type="text" name="email_id" id="email_id"
							placeholder="이메일 아이디를 입력하세요" onfocus="this.placeholder=''"
							onblur="this.placeholder='이메일 아이디를 입력하세요'" required> <span>@</span>
						<input type="hidden" name="email_domain" id="email_domain_input"
							value="naver.com" required /> <select name="emailDomain"
							id="email_domain" required>
							<option value="naver.com" selected>naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
						</select> <input type="hidden" name="fullEmail" id="fullEmail">
					</div></td>
			</tr>

			<tr>
				<td><label for="phoneNum"><i class="fa-solid fa-phone"></i>&nbsp;휴대폰번호</label>
					<input type="text" id="phoneNum" name="userPhoneNum" maxlength="11"
					placeholder="휴대폰 번호를 입력하세요" onfocus="this.placeholder=''"
					onblur="this.placeholder='휴대폰 번호를 입력하세요'" required></td>
			</tr>

			<tr>
				<td><label for="birthdate"><i
						class="fa-solid fa-cake-candles"></i>&nbsp;생년월일</label> <input type="date"
					name="birthdate" id="birthdate" required /></td>
			</tr>

			<tr>
				<td><label for="profileImg"><i
						class="fa-solid fa-id-card"></i>&nbsp;프로필 사진 업로드</label><br>
					<div class="profile-upload">
						<img id="photoPreview" src="resources/images/img_add.png"
							alt="프로필 미리보기" class="profile-photo" width="150" height="150" />
						<input type="file" id="profileImg" name="profileImg"
							accept=".jpg,.png" style="margin-top: 10px;">
					</div>
			</tr>

			<tr>
				<td>
					<div class="button-group">
						<button type="submit">
							<i class="fa-solid fa-check"></i>&nbsp;가입
						</button>
						<button type="reset" id="cancelBtn">
							<i class="fa-solid fa-xmark"></i>&nbsp;취소
						</button>
					</div>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
