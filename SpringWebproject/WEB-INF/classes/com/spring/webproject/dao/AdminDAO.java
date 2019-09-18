package com.spring.webproject.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.webproject.dto.AdminAuthorDTO;
import com.spring.webproject.dto.AdminBooksDTO;
import com.spring.webproject.dto.AdminCategoryDTO;
import com.spring.webproject.dto.AdminCounsultationDTO;
import com.spring.webproject.dto.AdminOrderDTO;
import com.spring.webproject.dto.AdminQuantityDTO;
import com.spring.webproject.dto.AdminShipmentsDTO;
import com.spring.webproject.dto.AdminTranslatorDTO;
import com.spring.webproject.dto.AdminUsersDTO;
import com.spring.webproject.dto.AdminWarehouseDTO;
import com.spring.webproject.util.SearchCriteria;
import com.spring.webproject.util.SearchDateCriteria;

@Repository
public class AdminDAO {

	@Inject
	private SqlSession sessionTemplate;

	// users
	public List<AdminUsersDTO> getUserList(SearchCriteria cri) {

		List<AdminUsersDTO> list = sessionTemplate.selectList("adminMapper.selectAll", cri);

		return list;
	}

	public void delUser(String userId) {

		sessionTemplate.delete("adminMapper.deleteUser", userId);

	}

	public int getUserTotalCount(SearchCriteria cri) {

		return sessionTemplate.selectOne("adminMapper.getUserTotalCount", cri);
	}

	// author
	public int getAuthorTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getAuthorTotalCount", cri);
	}

	public List<AdminAuthorDTO> getAuthorList(SearchCriteria cri) {
		List<AdminAuthorDTO> list = sessionTemplate.selectList("adminMapper.authorList", cri);
		return list;
	}
	
	public void insertAuthor(AdminAuthorDTO dto) {
		sessionTemplate.insert("adminMapper.insertAuthor", dto);
	}

	// translator
	public int getTranslatorTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getTranslatorTotalCount", cri);
	}

	public List<AdminTranslatorDTO> getTranslatorList(SearchCriteria cri) {
		List<AdminTranslatorDTO> list = sessionTemplate.selectList("adminMapper.translatorList", cri);
		return list;
	}
	
	public void insertTranslator(AdminTranslatorDTO dto) {
		sessionTemplate.insert("adminMapper.insertTranslator", dto);
	}

	// warehouse
	public int getWarehouseTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getWarehouseTotalCount", cri);
	}

	public List<AdminWarehouseDTO> getWarehouseList(SearchCriteria cri) {
		List<AdminWarehouseDTO> list = sessionTemplate.selectList("adminMapper.warehouseList", cri);
		return list;
	}
	
	public void insertWarehouse(AdminWarehouseDTO dto) {
		sessionTemplate.insert("adminMapper.insertWarehouse", dto);
	}
	
	public void insertQuantity(AdminBooksDTO dto) {
		sessionTemplate.insert("adminMapper.insertBooksAtWarehouse", dto);
	}
	
	
	//quantity
	public List<AdminQuantityDTO> getQuantityList(SearchCriteria cri){
		List<AdminQuantityDTO> list = sessionTemplate.selectList("adminMapper.getQuantityList", cri);
		return list;
	}
	
	public int getQuantityTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getQuantityTotalCount", cri);
	}
	
	
	
	//category
	
	public List<AdminCategoryDTO> getCategoryList(AdminCategoryDTO dto){
		List<AdminCategoryDTO> list = sessionTemplate.selectList("adminMapper.categoryList", dto);
		return list;
	}
	
	public int getCategoryTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getCategoryTotalCount", cri);
	}
	
	public List<AdminCategoryDTO> CategoryList(SearchCriteria cri){
		List<AdminCategoryDTO> list = sessionTemplate.selectList("adminMapper.getCategoryList", cri);
		return list;
	}
	
	//books
	
	public void insertBook(AdminBooksDTO dto) {
		sessionTemplate.insert("adminMapper.insertBook", dto);
	}
	
	public List<AdminBooksDTO> getBooklist(SearchCriteria cri){
		List<AdminBooksDTO> list = sessionTemplate.selectList("adminMapper.getbookList", cri);
		return list;
	}
	
	public int getbooksTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getTotalBooksCount", cri);
	}
	
	//bookSpecial
	public void insertBookSpecial(AdminBooksDTO dto) {
		sessionTemplate.insert("adminMapper.insertbookSpecial", dto);
	}
	
	//bookCategory
	public void insertBookCategory(AdminBooksDTO dto) {
		sessionTemplate.insert("adminMapper.insertBookCategory", dto);
	}
	
	public void insertCategory(AdminCategoryDTO dto) {
		sessionTemplate.insert("adminMapper.insertCategory", dto);
	}
	
	//bookImage
	public void insertBookImage(AdminBooksDTO dto) {
		sessionTemplate.insert("adminMapper.insertBookImage", dto);
	}
	
	//consultation
	public int getCounsultationTotalCount(SearchDateCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getConsultationTotalCount", cri);
	}
	
	public List<AdminCounsultationDTO> getCounsultationList(SearchDateCriteria cri){
		List<AdminCounsultationDTO> list = sessionTemplate.selectList("adminMapper.getCounsultationList", cri);
		return list;
	}
	
	//order
	public int getOrderTotalCount(SearchDateCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getOrdersTotalcount", cri);
	}
	
	public List<AdminOrderDTO> getOrderList(SearchDateCriteria cri){
		List<AdminOrderDTO> list = sessionTemplate.selectList("adminMapper.getOrderList", cri);
		return list;
	}
	
	//shipments
	
	public int getShipmentsTotalCount(SearchCriteria cri) {
		return sessionTemplate.selectOne("adminMapper.getShipmentsTotalCount", cri);
	}
	
	public List<AdminShipmentsDTO> getShipmentsList(SearchCriteria cri){
		List<AdminShipmentsDTO> list = sessionTemplate.selectList("adminMapper.getShipmentList", cri);
		return list;
	}
}





















