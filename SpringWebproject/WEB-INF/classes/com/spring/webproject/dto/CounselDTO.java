package com.spring.webproject.dto;

public class CounselDTO {
	//consultId, userName, email, subject, contents, consultationDate, typeId
	private int consultId;
	private String userId;
	private String userName;
	private String email;
	private String subject;
	private String contents;
	private String consultationDate;
	private String answerCheck;	
	private String typeId;
	private String parentsTypeId;
	

	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getParentsTypeId() {
		return parentsTypeId;
	}
	public void setParentsTypeId(String parentsTypeId) {
		this.parentsTypeId = parentsTypeId;
	}
	public int getConsultId() {
		return consultId;
	}
	public void setConsultId(int consultId) {
		this.consultId = consultId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	
	
}
