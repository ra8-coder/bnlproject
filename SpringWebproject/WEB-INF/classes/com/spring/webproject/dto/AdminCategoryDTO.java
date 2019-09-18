package com.spring.webproject.dto;

public class AdminCategoryDTO {
	private String categoryId;
	private String categoryName;
	private String parentsId  ;
	
	public AdminCategoryDTO(){
		this.parentsId = null;
	}
	
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getParentsId() {
		return parentsId;
	}
	public void setParentsId(String parentsId) {
		this.parentsId = parentsId;
	}
	
	
}
