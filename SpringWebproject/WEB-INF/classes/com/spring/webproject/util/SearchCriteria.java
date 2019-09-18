package com.spring.webproject.util;

public class SearchCriteria extends Criteria{
	
	private String searchKey;
	private String searchValue;
	
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
	@Override
	public String toString() {
		return "SearchCriteria [searchKey=" + searchKey + ", searchValue=" + searchValue + "]";
	}
	
	
	
}
