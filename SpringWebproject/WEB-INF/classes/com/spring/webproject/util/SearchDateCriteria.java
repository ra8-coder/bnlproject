package com.spring.webproject.util;

public class SearchDateCriteria extends SearchCriteria{
	
	private String fromDate;
	private String toDate;
	private String answerCheck;
	
	
	
	public String getAnswerCheck() {
		return answerCheck;
	}
	public void setAnswerCheck(String answerCheck) {
		this.answerCheck = answerCheck;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	@Override
	public String toString() {
		return "ConsultationCriteria [fromDate=" + fromDate + ", toDate=" + toDate + ", answerCheck=" + answerCheck
				+ ", getSearchKey()=" + getSearchKey() + ", getSearchValue()=" + getSearchValue() + ", getPage()="
				+ getPage() + ", getNumPerPage()=" + getNumPerPage() + ", getStart()=" + getStart() + ", getEnd()="
				+ getEnd() + "]";
	}
	
}
