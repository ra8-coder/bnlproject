package com.spring.webproject.dto;

import java.util.ArrayList;
import java.util.List;

public class CateDTO2 {

	private int categoryId;
	private String categoryName;
	private int parendtsId;

	private List<CateDTO> lastNode;

	public CateDTO2() {
		this.lastNode = new ArrayList<CateDTO>();
	}

	public List<CateDTO> getLastNode() {
		return lastNode;
	}

	public void setLastNode(CateDTO dto) {

		this.lastNode.add(dto);
	}

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

	public int getParendtsId() {
		return parendtsId;
	}

	public void setParendtsId(int parendtsId) {
		this.parendtsId = parendtsId;
	}

}
