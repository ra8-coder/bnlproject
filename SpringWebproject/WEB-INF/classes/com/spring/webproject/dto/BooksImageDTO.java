package com.spring.webproject.dto;

public class BooksImageDTO {
	private String isbn; // 책 표준번호
	private String bookImage; // 책 이미지 url 주소
	private int rnum; // 순서

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getBookImage() {
		return bookImage;
	}

	public void setBookImage(String bookImage) {
		this.bookImage = bookImage;
	}

}
