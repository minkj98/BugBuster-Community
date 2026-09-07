package www.silver.vo;

import java.util.List;

public class BoardVO {
    private Long postNum; // 게시글 번호
    private String writer; // 작성자
    private String title; // 게시글 제목
    private String content; // 게시글 내용
    private String codeContent; // 코드 내용
    private java.sql.Timestamp createdAt; // 게시글 작성일시
    private Integer views; // 조회수
    private List<String> filename; // 첨부파일 이름
    private String programmingLanguage; // 프로그래밍 언어
    
    public String getCodeContent() {
        return codeContent;
    }
    public void setCodeContent(String codeContent) {
        this.codeContent = codeContent;
    }
    public Long getPostNum() {
        return postNum;
    }
    public void setPostNum(Long postNum) {
        this.postNum = postNum;
    }
    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    public Integer getViews() {
        return views;
    }
    public void setViews(Integer views) {
        this.views = views;
    }
    public List<String> getFilename() {
        return filename;
    }
    public void setFilename(List<String> filename) {
        this.filename = filename;
    }
    public String getProgrammingLanguage() {
        return programmingLanguage;
    }
    public void setProgrammingLanguage(String programmingLanguage) {
        this.programmingLanguage = programmingLanguage;
    }
}
