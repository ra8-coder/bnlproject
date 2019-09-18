package com.spring.webproject.dto;

public class AdminOrderBooksDTO {
	
	private String isbn;
	private String bookTitle;//book table
	private String orderId;
	private String userId;//orders table
	private String handlingDate;//orders table
	private String quantity;
	private String price;
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getHandlingDate() {
		return handlingDate;
	}
	public void setHandlingDate(String handlingDate) {
		this.handlingDate = handlingDate;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	
	
}
