package com.spring.webproject.dto;

public class SearchDTO {
//isbn,booktitle, subtitle, publisher, publishDate, bookprice, authorName
  private String isbn;			//
  private String bookTitle;		//책제목
  private String subTitle;		//내용
  private String publisher;		//출판사
  private String publishDate;	//출판일
  private int bookPrice;		//책가격
  private String authorName;	//저자
  private String bookImage;		//책표지
  private String categoryName;
  private String categortCount;
  private String categoryId;	//카테고리Id
  
  
  
  
public String getCategoryId() {
	return categoryId;
}
public void setCategoryId(String categoryId) {
	this.categoryId = categoryId;
}
public String getCategoryName() {
	return categoryName;
}
public void setCategoryName(String categoryName) {
	this.categoryName = categoryName;
}
public String getCategortCount() {
	return categortCount;
}
public void setCategortCount(String categortCount) {
	this.categortCount = categortCount;
}
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
public String getSubTitle() {
	return subTitle;
}
public void setSubTitle(String subTitle) {
	this.subTitle = subTitle;
}
public String getPublisher() {
	return publisher;
}
public void setPublisher(String publisher) {
	this.publisher = publisher;
}
public String getPublishDate() {
	return publishDate;
}
public void setPublishDate(String publishDate) {
	this.publishDate = publishDate;
}
public int getBookPrice() {
	return bookPrice;
}
public void setBookPrice(int bookPrice) {
	this.bookPrice = bookPrice;
}
public String getAuthorName() {
	return authorName;
}
public void setAuthorName(String authorName) {
	this.authorName = authorName;
}
public String getBookImage() {
	return bookImage;
}
public void setBookImage(String bookImage) {
	this.bookImage = bookImage;
}
  
  
}
