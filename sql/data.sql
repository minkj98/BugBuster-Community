-- BugBuster-Community 초기 데이터 (프로그래밍 문제 시드)
-- 선행: sql/schema.sql 적용 후 실행
-- 적용: mysql -u <user> -p <database> < sql/data.sql

-- Python
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '두 수의 합',
           '두 정수 a와 b가 주어졌을 때, a와 b의 합을 반환하는 함수를 작성하세요.

제약조건
- -1000 ≤ a, b ≤ 1000

입력: 두 정수 a, b가 공백으로 구분되어 입력됩니다.
출력: a와 b의 합을 정수로 반환합니다.',
           '3 5',
           '8',
           'Easy',
           'Python'
       );
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '두 수의 곱',
           '두 정수 a와 b가 주어졌을 때, a와 b의 곱을 반환하는 함수를 작성하세요.

제약조건
- -1000 ≤ a, b ≤ 1000

입력: 두 정수 a, b가 공백으로 구분되어 입력됩니다.
출력: a와 b의 곱을 정수로 반환합니다.',
           '4 6',
           '24',
           'Easy',
           'Python'
       );

-- JavaScript
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '배열 뒤집기',
           '정수 배열이 주어졌을 때, 배열의 요소를 뒤집은 새 배열을 반환하는 함수를 작성하세요.

제약조건
- 배열 길이는 1 이상 1000 이하입니다.
- 배열의 요소는 -1000 이상 1000 이하의 정수입니다.

입력: 정수 배열이 JSON 형식의 문자열로 주어집니다.
출력: 뒤집힌 배열을 JSON 형식의 문자열로 반환합니다.',
           '[1, 2, 3, 4, 5]',
           '[5, 4, 3, 2, 1]',
           'Easy',
           'JavaScript'
       );

-- Java
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '두 수의 나눗셈',
           '두 정수 a와 b가 주어졌을 때, a를 b로 나눈 몫을 반환하는 함수를 작성하세요.

제약조건
- -1000 ≤ a, b ≤ 1000
- b ≠ 0

입력: 두 정수 a, b가 공백으로 구분되어 입력됩니다.
출력: a를 b로 나눈 몫을 정수로 반환합니다.',
           '10 3',
           '3',
           'Easy',
           'Java'
       );

-- C++
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '두 수의 차',
           '두 정수 a와 b가 주어졌을 때, a와 b의 차(a-b)를 반환하는 함수를 작성하세요.

제약조건
- -1000 ≤ a, b ≤ 1000

입력: 두 정수 a, b가 공백으로 구분되어 입력됩니다.
출력: a와 b의 차를 정수로 반환합니다.',
           '10 4',
           '6',
           'Easy',
           'C++'
       );

-- C
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '두 수의 합',
           '두 정수 a와 b가 주어졌을 때, a와 b의 합을 반환하는 함수를 작성하세요.

제약조건
- -1000 ≤ a, b ≤ 1000

입력: 두 정수 a, b가 공백으로 구분되어 입력됩니다.
출력: a와 b의 합을 정수로 반환합니다.',
           '3 5',
           '8',
           'Easy',
           'C'
       );

-- C#
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '팰린드롬 확인',
           '문자열이 주어졌을 때, 해당 문자열이 팰린드롬인지 확인하는 함수를 작성하세요. 대소문자를 구분하지 않습니다.

제약조건
- 문자열 길이는 1 이상 100 이하입니다.
- 문자열은 알파벳과 숫자로만 구성됩니다.

입력: 문자열
출력: 팰린드롬이면 true, 아니면 false',
           'Racecar',
           'true',
           'Medium',
           'C#'
       );

-- TypeScript
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '배열의 합',
           '정수 배열이 주어졌을 때, 배열의 모든 요소의 합을 구하는 함수를 작성하세요.

제약조건
- 배열 길이는 1 이상 1000 이하입니다.
- 배열 요소는 -1000 이상 1000 이하입니다.

입력: 정수 배열 (JSON 형식 문자열)
출력: 배열 요소의 합',
           '[1, 2, 3, 4, 5]',
           '15',
           'Easy',
           'TypeScript'
       );

-- Go
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '피보나치 수열',
           'n번째 피보나치 수를 구하는 함수를 작성하세요. 피보나치 수열은 F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)로 정의됩니다.

제약조건
- 0 ≤ n ≤ 30

입력: 정수 n
출력: n번째 피보나치 수',
           '7',
           '13',
           'Medium',
           'Go'
       );

-- Rust
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '중복 제거',
           '정수 배열에서 중복된 요소를 제거한 새 배열을 반환하는 함수를 작성하세요.

제약조건
- 배열 길이는 1 이상 1000 이하입니다.
- 배열 요소는 -1000 이상 1000 이하입니다.

입력: 정수 배열
출력: 중복이 제거된 배열 (순서 유지)',
           '[1, 2, 2, 3, 3, 4]',
           '[1, 2, 3, 4]',
           'Medium',
           'Rust'
       );

-- Swift
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '소수 판별',
           '주어진 정수 n이 소수인지 판별하는 함수를 작성하세요. 소수는 1보다 큰 정수로, 1과 자신만을 약수로 가집니다.

제약조건
- 1 ≤ n ≤ 1000000

입력: 정수 n
출력: 소수이면 true, 아니면 false',
           '17',
           'true',
           'Easy',
           'Swift'
       );

-- Kotlin
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '문자열 분리',
           '문자열과 구분자를 입력받아 구분자로 문자열을 분리한 배열을 반환하는 함수를 작성하세요.

제약조건
- 문자열 길이는 1 이상 100 이하입니다.
- 구분자는 단일 문자입니다.

입력: 문자열과 구분자 (공백으로 구분)
출력: 분리된 문자열 배열 (JSON 형식)',
           'hello,world ,',
           '[hello, world]',
           'Medium',
           'Kotlin'
       );

-- PHP
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '배열의 최대값',
           '정수 배열이 주어졌을 때, 배열에서 가장 큰 값을 반환하는 함수를 작성하세요.

제약조건
- 배열 길이는 1 이상 1000 이하입니다.
- 배열 요소는 -1000 이상 1000 이하입니다.

입력: 정수 배열 (공백으로 구분)
출력: 최대값',
           '3 5 2 8 1',
           '8',
           'Easy',
           'PHP'
       );

-- Ruby
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '팩토리얼 계산',
           '정수 n이 주어졌을 때, n의 팩토리얼을 계산하는 함수를 작성하세요.

제약조건
- 0 ≤ n ≤ 12

입력: 정수 n
출력: n의 팩토리얼',
           '5',
           '120',
           'Easy',
           'Ruby'
       );

-- Dart
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '문자열 반복',
           '문자열과 반복 횟수 n을 입력받아 문자열을 n번 반복한 결과를 반환하는 함수를 작성하세요.

제약조건
- 문자열 길이는 1 이상 100 이하입니다.
- 1 ≤ n ≤ 10

입력: 문자열과 정수 n (공백으로 구분)
출력: 반복된 문자열',
           'abc 3',
           'abcabcabc',
           'Medium',
           'Dart'
       );

-- R
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '평균 계산',
           '정수 배열이 주어졌을 때, 배열 요소의 평균을 계산하는 함수를 작성하세요.

제약조건
- 배열 길이는 1 이상 1000 이하입니다.
- 배열 요소는 -1000 이상 1000 이하입니다.

입력: 정수 배열 (공백으로 구분)
출력: 평균값 (소수점 둘째 자리까지)',
           '1 2 3 4 5',
           '3.00',
           'Easy',
           'R'
       );

-- Julia
INSERT INTO problems (title, description, sampleInput, sampleOutput, difficulty, language)
VALUES (
           '삼각수 계산',
           'n번째 삼각수를 계산하는 함수를 작성하세요. 삼각수는 1부터 n까지의 합입니다.

제약조건
- 1 ≤ n ≤ 1000

입력: 정수 n
출력: n번째 삼각수',
           '5',
           '15',
           'Medium',
           'Julia'
       );

COMMIT;
