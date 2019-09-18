package com.spring.webproject.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.spring.webproject.dto.CounselDTO;
import com.spring.webproject.dto.MainDTO;
import com.spring.webproject.dto.MyReviewDTO;
import com.spring.webproject.dto.OrderDetailDTO;
import com.spring.webproject.dto.OrderListDTO;
import com.spring.webproject.dto.PointDTO;
import com.spring.webproject.dto.UserDTO;

public class MyShoppingDAO {

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}

	public String getUserPwd(String userId) {

		return sessionTemplate.selectOne("myShopping.getUserPwd",userId);

	}

	public void updateUserInfo(UserDTO dto) {

		sessionTemplate.update("myShopping.updateUserInfo",dto);

	}

	public UserDTO getUserInfo(String userId) {

		UserDTO dto = sessionTemplate.selectOne("myShopping.getUserInfo",userId);

		return dto;
	}

	public void updatePwd(String userId, String userPwd) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("userPwd",userPwd);

		sessionTemplate.update("myShopping.updatePwd",hMap);
	}

	public int checkOrderStatus(String userId) {

		return sessionTemplate.selectOne("myShopping.checkOrderStatus",userId);
	}


	public void deleteUser(String userId) {

		sessionTemplate.delete("myShopping.memberOut", userId);

	}

	public int getCountOrderListNormal(String userId) {

		return sessionTemplate.selectOne("myShopping.getCountOrderListNormal", userId);
	}

	public List<OrderListDTO> getOrderList (Map<String, Object> map){

		List<OrderListDTO> lists = sessionTemplate.selectList("myShopping.getOrderList",map);

		return lists;
	}

	public int getCountOrderListByDate(String userId, String fromDate, String toDate) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("fromDate",fromDate);
		hMap.put("toDate",toDate);

		return sessionTemplate.selectOne("myShopping.getCountOrderListByDate", hMap);
	}

	public List<OrderListDTO> getOrderListByDate (Map<String, Object> map){

		List<OrderListDTO> lists = sessionTemplate.selectList("myShopping.getOrderListByDate",map);

		return lists;
	}

	public int getCountOrderListByName(String userId, String searchValue) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("searchValue",searchValue);

		return sessionTemplate.selectOne("myShopping.getCountOrderListByName", hMap);
	}

	public List<OrderListDTO> getOrderListByName (Map<String, Object> map){

		List<OrderListDTO> lists = sessionTemplate.selectList("myShopping.getOrderListByName",map);

		return lists;
	}

	public int getCountRetListNormal(String userId) {

		return sessionTemplate.selectOne("myShopping.getCountRetListNormal", userId);
	}

	public List<OrderListDTO> getRetList (Map<String, Object> map){

		List<OrderListDTO> lists = sessionTemplate.selectList("myShopping.getRetList",map);

		return lists;
	}

	public int getCountRetListByDate(String userId, String fromDate, String toDate) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("fromDate",fromDate);
		hMap.put("toDate",toDate);

		return sessionTemplate.selectOne("myShopping.getCountRetListByDate", hMap);
	}

	public List<OrderListDTO> getRetListByDate (Map<String, Object> map){

		List<OrderListDTO> lists = sessionTemplate.selectList("myShopping.getRetListByDate",map);

		return lists;
	}

	public int getExPoint(String userId) {

		return sessionTemplate.selectOne("myShopping.getExPoint", userId);
	}

	public int getCountPointList(String userId) {

		return sessionTemplate.selectOne("myShopping.getCountPointList", userId);
	}

	public List<PointDTO> getTotalPointList (Map<String, Object> map){

		List<PointDTO> lists = sessionTemplate.selectList("myShopping.getTotalPointList",map);

		return lists;
	}

	public int getCountPointListByDate(String userId, String fromDate, String toDate) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("fromDate",fromDate);
		hMap.put("toDate",toDate);

		return sessionTemplate.selectOne("myShopping.getCountPointListByDate", hMap);
	}

	public List<PointDTO> getPointListByDate (Map<String, Object> map){

		List<PointDTO> lists = sessionTemplate.selectList("myShopping.getPointListByDate",map);

		return lists;
	}

	public int getCountSavePoint(String userId, String fromDate, String toDate) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("fromDate",fromDate);
		hMap.put("toDate",toDate);

		return sessionTemplate.selectOne("myShopping.getCountSavePoint", hMap);
	}

	public int getCountUsePoint(String userId, String fromDate, String toDate) {

		HashMap<String, Object> hMap = new HashMap<String, Object>();

		hMap.put("userId", userId);
		hMap.put("fromDate",fromDate);
		hMap.put("toDate",toDate);

		return sessionTemplate.selectOne("myShopping.getCountUsePoint", hMap);
	}

	public List<PointDTO> getSavePointList (Map<String, Object> map){

		List<PointDTO> lists = sessionTemplate.selectList("myShopping.getSavePointList",map);

		return lists;
	}

	public List<PointDTO> getUsePointList (Map<String, Object> map){

		List<PointDTO> lists = sessionTemplate.selectList("myShopping.getUsePointList",map);

		return lists;
	}

	public int getWishCount(String userId) {

		return sessionTemplate.selectOne("myShopping.getWishCount",userId);
	}

	public int getRecentCount(String userId) {

		return sessionTemplate.selectOne("myShopping.getRecentCount",userId);
	}

	public List<OrderDetailDTO> getOrderDetailList(String orderId){

		List<OrderDetailDTO> lists = sessionTemplate.selectList("myShopping.getOrderDetailList",orderId);

		return lists;
	}

	public OrderListDTO getOrderDetailInfo(String orderId) {

		OrderListDTO dto = sessionTemplate.selectOne("myShopping.getOrderDetailInfo", orderId);

		return dto;
	}

	public void cancelOrder(String orderId) {

		sessionTemplate.update("myShopping.cancelOrder",orderId);

	}

	public void returnOrder(String orderId) {

		sessionTemplate.update("myShopping.returnOrder",orderId);

	}

	public void confirmOrder(String orderId) {

		sessionTemplate.update("myShopping.confirmOrder",orderId);

	}

	public void exchangeOrder(String orderId) {

		sessionTemplate.update("myShopping.exchangeOrder",orderId);

	}

	public int expPointCount(String userId) {

		return sessionTemplate.selectOne("myShopping.expPointCount",userId);

	}


	public List<PointDTO> expPointList(Map<String, Object> map){

		List<PointDTO> lists = sessionTemplate.selectList("myShopping.expPointList",map);

		return lists;

	}

	public int readyReviewCount(String userId) {

		return sessionTemplate.selectOne("myShopping.readyReviewCount",userId);

	}

	public List<MyReviewDTO> readyReviewList (Map<String, Object> map) {

		List<MyReviewDTO> lists = sessionTemplate.selectList("myShopping.readyReviewList",map);

		return lists;

	}

	public int LatesBooksCount(String userId) {

		return sessionTemplate.selectOne("myShopping.LatesBooksCount",userId);

	}

	public List<MainDTO> LatesBooksList (Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.LatesBooksList",map);

		return lists;
	}

	public void deleteLatesBooks(List<String> delList, String userId) {

		String isbn = "";

		Iterator<String> it = delList.iterator();

		while(it.hasNext()) {
			isbn = it.next();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("isbn", isbn);
			map.put("userId", userId);
			sessionTemplate.delete("myShopping.deleteLatesBooks",map);
			map.clear();
		}

	}

	public int myReviewCount(String userId) {

		return sessionTemplate.selectOne("myShopping.myReviewCount",userId);

	}

	public List<MyReviewDTO> myReviewList(Map<String, Object> map){

		List<MyReviewDTO> lists = sessionTemplate.selectList("myShopping.myReviewList",map);

		return lists;
	}

	public List<MainDTO> getWishListDefault(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListDefault",map);

		return lists;

	}

	public List<MainDTO> getWishListOld(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListOld",map);

		return lists;

	}

	public List<MainDTO> getWishListName(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListName",map);

		return lists;

	}

	public List<MainDTO> getWishListHighPrice(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListHighPrice",map);

		return lists;

	}
	public List<MainDTO> getWishListBuy(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListBuy",map);

		return lists;

	}

	public List<MainDTO> getWishListNoBuy(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListNoBuy",map);

		return lists;

	}

	public List<MainDTO> getWishListLowPrice(Map<String, Object> map){

		List<MainDTO> lists = sessionTemplate.selectList("myShopping.getWishListLowPrice",map);

		return lists;

	}

	public int getWishBuyCount(String userId) {

		return sessionTemplate.selectOne("myShopping.getWishBuyCount",userId);
	}

	public int getWishNoBuyCount(String userId) {

		return sessionTemplate.selectOne("myShopping.getWishNoBuyCount",userId);
	}

	public String wishOverlapCheck(Map<String, Object> map) {

		return sessionTemplate.selectOne("myShopping.wishOverlapCheck",map);
	}

	public void addWishList(List<String> goWish, String userId) {

		String isbn = "";
		Iterator<String> it = goWish.iterator();

		while(it.hasNext()) {
			isbn = it.next();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("isbn", isbn);
			map.put("userId", userId);
			sessionTemplate.insert("myShopping.addWish",map);
		}

	}

	public void deleteWish(List<String> delList, String userId) {

		String isbn = "";

		Iterator<String> it = delList.iterator();

		while(it.hasNext()) {
			isbn = it.next();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("isbn", isbn);
			map.put("userId", userId);
			sessionTemplate.delete("myShopping.deleteWish",map);
			map.clear();
		}

	}

	public void deleteReview(int reviewId) {

		sessionTemplate.delete("myShopping.deleteReview",reviewId);

	}

	public int sentenceCount(String userId) {

		return sessionTemplate.selectOne("myShopping.sentenceCount",userId);
	}

	public List<MyReviewDTO> getSentenceList(Map<String, Object> map){

		List<MyReviewDTO> lists = sessionTemplate.selectList("myShopping.getSentenceList",map);

		return lists;
	}

	public MyReviewDTO getReviewArticle(int reviewId) {

		MyReviewDTO dto = sessionTemplate.selectOne("myShopping.getReviewArticle",reviewId);

		return dto;
	}

	public void reviewUpdate(Map<String, Object> map) {

		sessionTemplate.update("myShopping.reviewUpdate",map);

	}

	public MyReviewDTO readBook(String isbn) {

		MyReviewDTO dto = sessionTemplate.selectOne("myShopping.readBook",isbn);

		return dto;

	}

	public int getReviewId() {

		return sessionTemplate.selectOne("myShopping.getReviewId");

	}

	public void createSentence(Map<String, Object> map) {

		sessionTemplate.insert("myShopping.createSentence",map);
	}

	public void updateSentence(int reviewId, String sentence) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewId", reviewId);
		map.put("sentence", sentence);

		sessionTemplate.update("myShopping.updateSentence",map);

	}

	////////////////////////포인트
	public HashMap<String,Object> getLeftPoint(String userId){

		HashMap<String,Object> resultMap = sessionTemplate.selectOne("myShopping.getLeftPoint",userId);

		return resultMap;
	}

	public void pointUseUpdate(int pointId, int leftValue) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pointId", pointId);
		map.put("leftValue", leftValue);
		System.out.println("DAO pointId" +pointId);
		System.out.println("DAO leftValue"+leftValue);

		sessionTemplate.update("myShopping.pointUseUpdate",map);


	}

	public void usedPointInsert(Map<String, Object> map) {

		sessionTemplate.insert("myShopping.usedPointInsert",map);

	}

	public int getAllCounselCount(String userId) {

		return sessionTemplate.selectOne("myShopping.getAllCounselCount",userId);

	}

	public List<CounselDTO> getAllCounselList(Map<String, Object> map){

		List<CounselDTO> lists = sessionTemplate.selectList("myShopping.getAllCounselList",map);

		return lists;
	}

	public int getCounselCountByDate(String userId, String fromDate, String toDate) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId",userId);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);

		return sessionTemplate.selectOne("myShopping.getCounselCountByDate",map);

	}

	public List<CounselDTO> getCounselListByDate(Map<String, Object> map){

		List<CounselDTO> lists = sessionTemplate.selectList("myShopping.getCounselListByDate",map);

		return lists;

	}

	public int getCounselCountYes(String userId, String fromDate, String toDate) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId",userId);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);

		return sessionTemplate.selectOne("myShopping.getCounselCountYes",map);

	}
	
	public List<CounselDTO> getCounselListYes(Map<String, Object> map){

		List<CounselDTO> lists = sessionTemplate.selectList("myShopping.getCounselListYes",map);

		return lists;

	}

	public int getCounselCountNo(String userId, String fromDate, String toDate) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId",userId);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);

		return sessionTemplate.selectOne("myShopping.getCounselCountNo",map);

	}
	
	public List<CounselDTO> getCounselListNo(Map<String, Object> map){

		List<CounselDTO> lists = sessionTemplate.selectList("myShopping.getCounselListNo",map);

		return lists;
		
	}
	
	public void savePoint(Map<String, Object> map) {
		
		sessionTemplate.insert("myShopping.savePoint",map);
		
	}
	
	public CounselDTO getCounselContents(int consultId) {
		
		CounselDTO dto = sessionTemplate.selectOne("myShopping.getCounselContents",consultId);
		
		return dto;
		
	}
	//maxPointId(for orders 테이블
	public int getMaxPointId(){
		int maxPointId = 0;
		
		
		maxPointId = sessionTemplate.selectOne("myShopping.maxPointId");
		
		return maxPointId;
		
	}
	
	//도서 구입후 포인트 입력 in point
	public void getPurchasingPoint(String userId, int pointId, String orderId, int value, int leftValue) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		params.put("pointId",pointId);
		params.put("orderId", orderId);
		params.put("value", value);
		params.put("leftValue", leftValue);
		
		sessionTemplate.insert("myShopping.purchasingPoint",params);
		
	}
	
	public int getMaxShipmentsId(){
		
		int maxShipmentsId = 0;
		
		maxShipmentsId = sessionTemplate.selectOne("myShopping.maxShipmentsId");
		
		return maxShipmentsId;
		
	}
	
	//도서 구입후 포인트 입력 in point
	public void getShipmentsStatus (int shipmentsId, int orderId) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("shipmentsId", shipmentsId);
		params.put("orderId",orderId);

		sessionTemplate.insert("myShopping.shipmentsStatus",params);
		
	}
	
	public int getPointValue(String userId) {
		return sessionTemplate.selectOne("myShopping.getPointValue",userId);
	}
	
	public int getSavePointId(String orderId) {
		return sessionTemplate.selectOne("myShopping.getSavePointId",orderId);
	}
	
	public HashMap<String,Object> getUsedPointId(String orderId) {
		
		HashMap<String,Object> resultMap = sessionTemplate.selectOne("myShopping.getUsedPointId",orderId);

		return resultMap;
	}
	
	public void canceledOrderPoint(Map<String, Object> map) {
		sessionTemplate.insert("myShopping.canceledOrderPoint",map);
	}
	
	public void updateLeftValue(int pointId, int value) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		sessionTemplate.update("myShopping.updateLeftValue",params);
	}
	
	public void reSavePoint(Map<String, Object> map) {
		
		sessionTemplate.insert("myShopping.reSavePoint",map);
		
	}
	
}
