package com.spring.webproject.dto;

public class SimpleReviewDTO {

	private String userName;
	private String sentence;
	private int thumbUp;
	private int reviewId;

	private String isbn;
	private String userId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getReviewId() {
		return reviewId;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSentence() {
		return sentence;
	}

	public void setSentence(String sentence) {
		this.sentence = sentence;
	}

	public int getThumbUp() {
		return thumbUp;
	}

	public void setThumbUp(int thumbUp) {
		this.thumbUp = thumbUp;
	}

}
