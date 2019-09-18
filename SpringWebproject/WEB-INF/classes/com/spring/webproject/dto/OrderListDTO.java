package com.spring.webproject.dto;

public class OrderListDTO {
	
	private int orderId;
	private int orderPrice;
	private int point;
	private String shipmentsStatusCode;
	private String handlingDate;
	private String expectedDate;
	private String status;
	private String mainTitle;
	private String quantity;
	private String zipCode;
	private String address1;
	private String address2;
	private String recipientName;
	private int booksPrice;
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getShipmentsStatusCode() {
		return shipmentsStatusCode;
	}
	public void setShipmentsStatusCode(String shipmentsStatusCode) {
		this.shipmentsStatusCode = shipmentsStatusCode;
	}
	public String getHandlingDate() {
		return handlingDate;
	}
	public void setHandlingDate(String handlingDate) {
		this.handlingDate = handlingDate;
	}
	public String getExpectedDate() {
		return expectedDate;
	}
	public void setExpectedDate(String expectedDate) {
		this.expectedDate = expectedDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMainTitle() {
		return mainTitle;
	}
	public void setMainTitle(String mainTitle) {
		this.mainTitle = mainTitle;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getRecipientName() {
		return recipientName;
	}
	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}
	public int getBooksPrice() {
		return booksPrice;
	}
	public void setBooksPrice(int booksPrice) {
		this.booksPrice = booksPrice;
	}
	
}
