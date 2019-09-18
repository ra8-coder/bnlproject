package com.spring.webproject.dto;

public class QuestionDTO {
	
	private int num;
	private int questionId;
	private int parentsTypeId;
	private String parentsTypeName;
	private int typeId;	
	private String typeName;
	private String subject;
	private String content;
	private int hitCount;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getParentsTypeId() {
		return parentsTypeId;
	}
	public void setParentsTypeId(int parentsTypeId) {
		this.parentsTypeId = parentsTypeId;
	}
	public String getParentsTypeName() {
		return parentsTypeName;
	}
	public void setParentsTypeName(String parentsTypeName) {
		this.parentsTypeName = parentsTypeName;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
}
