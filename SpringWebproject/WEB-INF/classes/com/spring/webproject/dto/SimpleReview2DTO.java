package com.spring.webproject.dto;

public class SimpleReview2DTO {
	private String userId;
	private int reviewId;
	private String thumbup;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public String getThumbup() {
		return thumbup;
	}

	public void setThumbup(String thumbup) {
		this.thumbup = thumbup;
	}

}
