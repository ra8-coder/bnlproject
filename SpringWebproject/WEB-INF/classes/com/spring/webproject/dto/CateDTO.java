package com.spring.webproject.dto;

public class CateDTO {

	private int categoryId;
	private String categoryName;
	private int parentsId;

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getParentsId() {
		return parentsId;
	}

	public void setParendtsId(int parendtsId) {
		this.parentsId = parendtsId;
	}

}
