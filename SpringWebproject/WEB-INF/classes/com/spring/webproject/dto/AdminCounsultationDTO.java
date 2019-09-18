package com.spring.webproject.dto;

public class AdminCounsultationDTO {
	
	private String consultId;
	private String userId;
	private String email;
	private String subject;
	private String contents;
	private String consultationDate;
	private String answerCheck;
	private String typeName;
	public String getConsultId() {
		return consultId;
	}
	public void setConsultId(String consultId) {
		this.consultId = consultId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getConsultationDate() {
		return consultationDate;
	}
	public void setConsultationDate(String consultationDate) {
		this.consultationDate = consultationDate;
	}
	public String getAnswerCheck() {
		return answerCheck;
	}
	public void setAnswerCheck(String answerCheck) {
		this.answerCheck = answerCheck;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	
	
}
