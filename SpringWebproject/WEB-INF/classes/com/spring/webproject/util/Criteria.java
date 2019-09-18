package com.spring.webproject.util;

public class Criteria {
	
	private int page;
	private int numPerPage;
	
	public Criteria() {
		this.page = 1;
		this.numPerPage = 10;
	}
	
	public void setPage(int page) {
		if(page<=0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public int getPage() {
		return this.page;
	}
	
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getNumPerPage() {
		return this.numPerPage;
	}
	
	//for myBatis
	public int getStart() {
		return (this.page-1)*this.numPerPage+1;
	}
	
	public int getEnd() {
		return (this.page)*this.numPerPage;
	}
	
}
