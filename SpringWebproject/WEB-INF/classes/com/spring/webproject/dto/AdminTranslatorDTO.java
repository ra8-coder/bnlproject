package com.spring.webproject.dto;

public class AdminTranslatorDTO {
	private String translatorId;
	private String translatorName;
	private String nationality;
	private String category;
	private String introduction;
	private String image;
	
	public String getTranslatorId() {
		return translatorId;
	}
	public void setTranslatorId(String translatorId) {
		this.translatorId = translatorId;
	}
	public String getTranslatorName() {
		return translatorName;
	}
	public void setTranslatorName(String translatorName) {
		this.translatorName = translatorName;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	
}
