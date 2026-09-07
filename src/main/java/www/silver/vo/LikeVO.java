package www.silver.vo;

public class LikeVO {
    private int likeNum;   // 좋아요 고유 번호
    private String userId; // 좋아요를 누른 사용자의 ID
    private int postNum;   // 좋아요가 달린 게시글의 번호 (게시글 ID)
    
    public int getLikeNum() {
        return likeNum;
    }
    public void setLikeNum(int likeNum) {
        this.likeNum = likeNum;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public int getPostNum() {
        return postNum;
    }
    public void setPostNum(int postNum) {
        this.postNum = postNum;
    }
}
