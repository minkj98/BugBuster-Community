-- BugBuster-Community 스키마
-- 적용: mysql -u <user> -p <database> < sql/schema.sql

-- 회원 테이블
CREATE TABLE member
(
    user_id           varchar(50) primary key,
    user_password     varchar(100) DEFAULT NULL,
    user_name         varchar(100) DEFAULT NULL,
    zipcode           varchar(5)   DEFAULT NULL,
    address           varchar(100) DEFAULT NULL,
    user_email        varchar(100) DEFAULT NULL,
    user_phone_number varchar(20)  DEFAULT NULL,
    birth_date        DATE         DEFAULT NULL,
    detailAddress     varchar(100) DEFAULT NULL
);

-- 프로필 파일 테이블
CREATE TABLE profile_attach (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                user_id varchar(50),
                                filename VARCHAR(40),
                                createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                CONSTRAINT uq_profile_attach_user UNIQUE (user_id),
                                CONSTRAINT fk_profile_attach_userID
                                    FOREIGN KEY (user_id)
                                        REFERENCES member(user_id)
                                        ON DELETE CASCADE
);

-- 회원 관심태그 테이블
CREATE TABLE member_interest (
                                 user_id VARCHAR(50),    -- 회원 ID
                                 interest varchar(20),
                                 PRIMARY KEY (user_id, interest), -- 복합 기본 키
                                 FOREIGN KEY (user_id) REFERENCES member(user_id) ON DELETE CASCADE
);

-- 게시글 테이블
CREATE TABLE board (
                       postNum INT AUTO_INCREMENT PRIMARY KEY, -- 글 번호
                       writer VARCHAR(50), -- 작성자
                       title VARCHAR(100), -- 글 제목
                       content TEXT, -- 글 내용
                       codeContent TEXT, -- 코드
                       createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 작성일자
                       views INT NOT NULL DEFAULT 0,  -- 조회수
                       programmingLanguage VARCHAR(50), -- 기술스택
                       CONSTRAINT fk_board_writer
                           FOREIGN KEY (writer)
                               REFERENCES member(user_id)
                               ON DELETE CASCADE
);

-- 게시글 첨부파일 테이블
CREATE TABLE board_attach (
                              id INT AUTO_INCREMENT PRIMARY KEY,
                              postNum INT,
                              filename VARCHAR(40),
                              createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              CONSTRAINT fk_board_attach_postnum
                                  FOREIGN KEY (postNum)
                                      REFERENCES board(postNum)
                                      ON DELETE CASCADE
);

-- 좋아요 테이블
CREATE TABLE likes (
                       likeNum INT AUTO_INCREMENT PRIMARY KEY,
                       user_id VARCHAR(50),
                       postNum INT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       CONSTRAINT fk_likes_user
                           FOREIGN KEY (user_id)
                               REFERENCES member(user_id)
                               ON DELETE CASCADE,
                       CONSTRAINT fk_likes_post
                           FOREIGN KEY (postNum)
                               REFERENCES board(postNum)
                               ON DELETE CASCADE,
                       UNIQUE KEY unique_user_post (user_id, postNum)
);

-- 댓글/대댓글 테이블
CREATE TABLE comment (
                         commentId int AUTO_INCREMENT PRIMARY KEY,         -- 댓글대댓글 고유 ID
                         postNum int NOT NULL,                             -- 소속 게시글 ID
                         userId varchar(50) NOT NULL,                      -- 작성자 ID
                         content text NOT NULL,                            -- 댓글 내용
                         parentCommentId int DEFAULT NULL,                 -- 부모 댓글 ID (최상위 댓글이면 NULL)
                         depth INT DEFAULT 0,                              -- 계층(0 댓글, 1 이상 대댓글)
                         isDeleted BOOLEAN DEFAULT FALSE,                  -- 삭제 여부
                         createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,     -- 작성 시각
                         updateAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 수정 시각
                         CONSTRAINT fk_comment_post
                             FOREIGN KEY (postNum)
                                 REFERENCES board(postNum)
                                 ON DELETE CASCADE,
                         CONSTRAINT fk_comment_user
                             FOREIGN KEY (userId)
                                 REFERENCES member(user_id)
                                 ON DELETE CASCADE, -- 유저 삭제 시 댓글대댓글 삭제
                         CONSTRAINT fk_comment_parent
                             FOREIGN KEY (parentCommentId)
                                 REFERENCES comment(commentId)
                                 ON DELETE CASCADE
);

-- 뉴스 테이블
CREATE TABLE news (
                      newsId INT AUTO_INCREMENT PRIMARY KEY, -- 뉴스 번호
                      title TEXT NOT NULL,                   -- 뉴스 기사 제목
                      originallink TEXT NOT NULL,            -- 뉴스 기사 원래 출처
                      link TEXT NOT NULL,                    -- 네이버에서 제공하는 뉴스url
                      description TEXT NOT NULL,             -- 뉴스 기사 본문
                      pubDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 뉴스 기사가 게시된 날짜 및 시간
                      query VARCHAR(50),                     -- 뉴스 데이터 가져올 때 사용된 검색 키워드
                      category VARCHAR(50),                  -- 뉴스 기사의 주제 분류
                      UNIQUE KEY unique_link (link(255))     -- 중복 방지 네이버 뉴스 URL 기준
);

-- 프로그래밍 문제 테이블
CREATE TABLE problems (
                          problemId INT AUTO_INCREMENT PRIMARY KEY,
                          title VARCHAR(255) NOT NULL,
                          description TEXT NOT NULL,
                          sampleInput TEXT,
                          sampleOutput TEXT,
                          difficulty VARCHAR(50),
                          language VARCHAR(50),
                          createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 사용자 제출 코드 테이블
CREATE TABLE submissions (
                             submissionId INT AUTO_INCREMENT PRIMARY KEY,
                             userId VARCHAR(50) NOT NULL,
                             problemId INT NOT NULL,
                             code TEXT NOT NULL,
                             language VARCHAR(50),
                             submittedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             isCorrect BOOLEAN DEFAULT FALSE,
                             feedback TEXT,
                             CONSTRAINT fk_submissions_user
                                 FOREIGN KEY (userId)
                                     REFERENCES member(user_id)
                                     ON DELETE CASCADE,
                             CONSTRAINT fk_submissions_problem
                                 FOREIGN KEY (problemId)
                                     REFERENCES problems(problemId)
                                     ON DELETE CASCADE
);
