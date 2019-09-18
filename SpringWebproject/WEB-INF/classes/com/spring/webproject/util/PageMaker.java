package com.spring.webproject.util;

public class PageMaker {
	
	private int totalDataCount;
	private int startPage;
	private int endPage;
	private boolean pre;
	private boolean nex;
	
	private int displayPageNum;
	
	private Criteria cri;
	
	public PageMaker(Criteria cri) {
		this.cri = cri;
		this.displayPageNum = 10;
	}
	
	public void setTotalDataCount(int totalDataCount) {
		this.totalDataCount = totalDataCount;
		this.calc();
	}
	
	private void calc() {
		this.endPage = ((int)Math.ceil(cri.getPage()/(double)displayPageNum))*this.displayPageNum;
		this.startPage = (this.endPage-displayPageNum)+1;
		
		int tempEndPage = (int)Math.ceil(totalDataCount/(double)cri.getNumPerPage());
		if(tempEndPage<endPage) {
			this.endPage = tempEndPage;
		}
		
		this.pre = startPage==1 ? false:true;
		this.nex = endPage*cri.getNumPerPage()<totalDataCount ? true:false;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPre() {
		return pre;
	}

	public void setPre(boolean pre) {
		this.pre = pre;
	}

	public boolean isNex() {
		return nex;
	}

	public void setNex(boolean nex) {
		this.nex = nex;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public int getTotalDataCount() {
		return totalDataCount;
	}

	

	
	

}
