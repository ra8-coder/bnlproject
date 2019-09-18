package com.spring.webproject.dto;

public class AdminShipmentsDTO {
	
	private String orderId;
	private String shipmentsId;
	private String userId;//orders table
	private String status;//shipmentsStatus
	private String expectedDate;
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getShipmentsId() {
		return shipmentsId;
	}
	public void setShipmentsId(String shipmentsId) {
		this.shipmentsId = shipmentsId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getExpectedDate() {
		return expectedDate;
	}
	public void setExpectedDate(String expectedDate) {
		this.expectedDate = expectedDate;
	}
	
	
	
}
