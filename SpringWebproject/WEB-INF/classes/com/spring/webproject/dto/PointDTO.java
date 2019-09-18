package com.spring.webproject.dto;

public class PointDTO {

	private String savingDate;
	private String expirationDate;
	private int orderId;
	private int value;
	private int leftValue;
	private String pointItem;
	
	public String getSavingDate() {
		return savingDate;
	}
	public void setSavingDate(String savingDate) {
		this.savingDate = savingDate;
	}
	public String getExpirationDate() {
		return expirationDate;
	}
	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public int getLeftValue() {
		return leftValue;
	}
	public void setLeftValue(int leftValue) {
		this.leftValue = leftValue;
	}
	public String getPointItem() {
		return pointItem;
	}
	public void setPointItem(String pointItem) {
		this.pointItem = pointItem;
	}
	
}
