package com.spring.webproject.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.spring.webproject.dto.BookSectionsDTO;
import com.spring.webproject.dto.OrderBooksDTO;
import com.spring.webproject.dto.OrdersDTO;


public class BookSectionsDAO {

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}

	//전체 데이터 from bnlBSList
	public List<BookSectionsDTO> getListMain(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.getLists", params);

		return lists;
	}
	
	//sort1 //전체 데이터 from bnlBSList
	public List<BookSectionsDTO> getListSort1(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.getListsSort1", params);

		return lists;
	}
	
	//sort2 //전체 데이터 from bnlBSList
	public List<BookSectionsDTO> getListSort2(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.getListsSort2", params);

		return lists;
	}
	
	//sort3 //전체 데이터 from bnlBSList
	public List<BookSectionsDTO> getListSort3(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.getListsSort3", params);

		return lists;
	}
	
	//sort4 //전체 데이터 from bnlBSList
	public List<BookSectionsDTO> getListSort4(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.getListsSort4", params);

		return lists;
	}
	
	//전체 데이터 갯수 
	public int getDataCount() {
		
		int allDataCount = 0;
		
		allDataCount = sessionTemplate.selectOne("bookSectionsMapper.getDataCount");
		
		return allDataCount;
	}
	
	//신간 도서 from bnlNewBookList
	public List<BookSectionsDTO> getBooksOfTheMonth(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.booksOfTheMonth", params);

		return lists;
	}
	
	//sort1 신간 도서 from bnlNewBookList
	public List<BookSectionsDTO> getBooksOfTheMonthSort1(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.booksOfTheMonthSort1", params);

		return lists;
	}
	
	//sort2 신간 도서 from bnlNewBookList
	public List<BookSectionsDTO> getBooksOfTheMonthSort2(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.booksOfTheMonthSort2", params);

		return lists;
	}
	
	//sort3 신간 도서 from bnlNewBookList
	public List<BookSectionsDTO> getBooksOfTheMonthSort3(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.booksOfTheMonthSort3", params);

		return lists;
	}
	
	//sort4 신간 도서 from bnlNewBookList
	public List<BookSectionsDTO> getBooksOfTheMonthSort4(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.booksOfTheMonthSort4", params);

		return lists;
	}
	
	//신간 전체 데이터 도서
		public int getDataCountForNewBooks() {
			
			int allDataCount = 0;
			
			allDataCount = sessionTemplate.selectOne("bookSectionsMapper.getDataCountForNewBooks");
			
			return allDataCount;
		}

	//신간 도서 from bnlNewBookList
	public List<BookSectionsDTO> getSlideAd(int sort1st, int sort2nd, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.slideAd", params);

		return lists;
	}
	
	//정가할인도서 6개 슬라이드 입력값이 없으니 hashmap 삭제
	public List<BookSectionsDTO> getDcSixSlide(){
		
		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcSixSlide");

		return lists;
	}
	
	//정가할인도서 분야별 rnum=1 추출
	public List<BookSectionsDTO> getDcRnumSlide(int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		
		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcRnumSlide", params);

		return lists;
	}
	
	//정가할인도서 분야별 rnum=1 총 데이터
		public int getDataCountForEachRnum(){
			
		int allDataCount = 0;
			
		allDataCount = sessionTemplate.selectOne("bookSectionsMapper.getDataCountForEachRnum");

		return allDataCount;
	}
		
	//이달의 정가할인도서 8개 슬라이드 입력값이 없으니 hashmap 삭제
	public List<BookSectionsDTO> getDcOfTheMonth(){
		
		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcOfTheMonth");

		return lists;
	}
	
	//베스트셀러 top10 제목만
	public List<BookSectionsDTO> getBestSellerTop10(){
		
		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.bestSellerTop10");

		return lists;
	}
	
	//분야별 전체 할인 도서
	public List<BookSectionsDTO> getDcLists(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcLists", params);

		return lists;
	}
	
	//분야별 sort1 할인 도서
	public List<BookSectionsDTO> getDcListsSort1(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsSort1", params);

		return lists;
	}
	//분야별 sort2 할인 도서
	public List<BookSectionsDTO> getDcListsSort2(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsSort2", params);

		return lists;
	}
	//분야별 sort3 할인 도서
	public List<BookSectionsDTO> getDcListsSort3(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsSort3", params);

		return lists;
	}
	//분야별 sort4 할인 도서
	public List<BookSectionsDTO> getDcListsSort4(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsSort4", params);

		return lists;
	}
	
	//정가할인도서 분야별 총 데이터
	public int getDcDataCount(int sort1st, int sort2nd, int fromDiscount, int toDiscount){
		
	int allDataCount = 0;
	
	HashMap<String, Object> params = new HashMap<String, Object>();
	
	params.put("sort1st", sort1st);
	params.put("sort2nd", sort2nd);
	params.put("fromDiscount", fromDiscount);
	params.put("toDiscount", toDiscount);
		
	allDataCount = sessionTemplate.selectOne("bookSectionsMapper.dcDataCount", params);

	return allDataCount;
}
	
	//이번달 할인 도서
	public List<BookSectionsDTO> getDcListsOfTheMonth(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsOfTheMonth", params);

		return lists;
	}
	
	//이번달 할인 도서 sort1
	public List<BookSectionsDTO> getDcListsOfTheMonthSort1(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsOfTheMonthSort1", params);

		return lists;
	}
	
	//이번달 할인 도서 sort2
	public List<BookSectionsDTO> getDcListsOfTheMonthSort2(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsOfTheMonthSort2", params);

		return lists;
	}
	
	//이번달 할인 도서 sort3
	public List<BookSectionsDTO> getDcListsOfTheMonthSort3(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsOfTheMonthSort3", params);

		return lists;
	}
	
	//이번달 할인 도서 sort4
	public List<BookSectionsDTO> getDcListsOfTheMonthSort4(int sort1st, int sort2nd, int fromDiscount, int toDiscount, int start, int end){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("sort1st", sort1st);
		params.put("sort2nd", sort2nd);
		params.put("fromDiscount", fromDiscount);
		params.put("toDiscount", toDiscount);
		params.put("start", start);
		params.put("end", end);

		List<BookSectionsDTO> lists = sessionTemplate.selectList("bookSectionsMapper.dcListsOfTheMonthSort4", params);

		return lists;
	}
	
	//이번달 정가할인도서 총 데이터
	public int getDcDataCountOfTheMonth(int sort1st, int sort2nd, int fromDiscount, int toDiscount){
		
	int allDataCount = 0;
	
	HashMap<String, Object> params = new HashMap<String, Object>();
	
	params.put("sort1st", sort1st);
	params.put("sort2nd", sort2nd);
	params.put("fromDiscount", fromDiscount);
	params.put("toDiscount", toDiscount);
		
	allDataCount = sessionTemplate.selectOne("bookSectionsMapper.dcDataCountOfTheMonth", params);

	return allDataCount;
}
	
    /*=================*//*=================*/	/*=================*/	/*=================*/	/*=================*/	/*=================*/	/*=================*/
	/*=================*//*=================*/	/*=================*/	/*=================*/	/*=================*/	/*=================*/	/*=================*/
	/*=================*//*=================*/	/*=================*/	/*=================*/	/*=================*/	/*=================*/	/*=================*/
	
	
	/* 샵 앤 오더 */
	//오늘 본 상품
	public List<BookSectionsDTO> cartList(String ck,String ckC){
		
		List<BookSectionsDTO> lst = new ArrayList<BookSectionsDTO>();
		
		String[] isbn = ck.split(",");
		String[] orderCount = ckC.split(",");

		for(int i=0;i<isbn.length;i++) {
			
			BookSectionsDTO dto = sessionTemplate.selectOne("shopAndOrderMapper.cartLists",isbn[i]);
			dto.setOrderCount(orderCount[i]);
			int seqNum = 1000+i;
			dto.setSeqNum(seqNum);
			
			
			lst.add(dto);
		}
		return lst;
	}
	
	//order 쿠키리스트 출력
	public BookSectionsDTO getBookSection(String isbn) {
		
		return sessionTemplate.selectOne("shopAndOrderMapper.cartLists", isbn);
	}
	
	public int  getLeftPoint(String userId) {
		return sessionTemplate.selectOne("shopAndOrderMapper.leftPoint", userId);
	}
	
	//maxOrderId(for orders 테이블
	public int getMaxOrderId(){
		
		int maxOrderId = 0;
		
		maxOrderId = sessionTemplate.selectOne("shopAndOrderMapper.maxOrderId");
		
		return maxOrderId;
		
	}
	
	//order table insert
	public void getOrdersInsertData(OrdersDTO dto){
		
		sessionTemplate.insert("shopAndOrderMapper.ordersInsertData", dto);

	}
	
	//orderbooks table insert
	public void getOrderBooksInsertData(OrderBooksDTO dto) {
		sessionTemplate.insert("shopAndOrderMapper.orderBooksInsertData", dto);
	}
	
	//update booksatwarehouse 책 구입 후 최대수량 업데이트
	public void getUpdateBookQuantity(String isbn, int OrderCount) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("isbn", isbn);
		params.put("OrderCount", OrderCount);
		
		sessionTemplate.update("shopAndOrderMapper.updateBookQuantity", params);
	}
	
	//select Quantity 책 총수량 warehouse=1
	public int getSelectBookQuantity(String isbn) {
		
		return sessionTemplate.selectOne("shopAndOrderMapper.selectBookQuantity", isbn);
	}
}
