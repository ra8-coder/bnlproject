package com.spring.webproject.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.spring.webproject.dto.UserDTO;

public class LoginDAO {
	
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	public UserDTO idOverlapCheck(String userId) {
		
		UserDTO dto = sessionTemplate.selectOne("loginMapper.idOverlapCheck",userId);
		
		return dto;
		
	}
	
	public void joinMember(UserDTO dto) {
		
		dto.setMemberGrade("일반");
		
		sessionTemplate.insert("loginMapper.joinMember", dto);
		
	}
	
	public UserDTO login(String userId, String userPwd) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		params.put("userPwd", userPwd);
		
		UserDTO dto = sessionTemplate.selectOne("loginMapper.login",params);
		
		return dto;
	}
	
	public int getPointId() {
		
		return sessionTemplate.selectOne("loginMapper.getPointId");
		
	}
	
	public void joinPointSaving(String userId, int pointId) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("userId", userId);
		params.put("pointItem","신규회원 가입 적립금 지급 (30일 후 소멸)");
		params.put("pointId",pointId);
		
		sessionTemplate.insert("loginMapper.joinPointSaving",params);
		
	}
	
	public String findUserId(UserDTO dto) {
		
		return sessionTemplate.selectOne("loginMapper.findUserId",dto);
		
	}
	
	public UserDTO findUserPwd(UserDTO dto) {
		
		UserDTO findedDto = sessionTemplate.selectOne("loginMapper.findUserPwd",dto);
		
		return findedDto;
	}
	
	public void updateTempPwd(String tempPwd, String userId) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("userPwd", tempPwd);
		
		sessionTemplate.update("loginMapper.tempPwd",params);
		
	}
	
	public int getPointValue(String userId) {
	
		return sessionTemplate.selectOne("loginMapper.getPointValue",userId);
	}
	
	public int checkRecentBook(String userId, String isbn) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("isbn", isbn);
		
		return sessionTemplate.selectOne("loginMapper.checkRecentBook",params);
	}
	
	public void recentBookAdd(String userId, String isbn) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("isbn", isbn);
		
		sessionTemplate.update("loginMapper.recentBookAdd",params);
		
	}
	
	public void updateRecentBookTime(String userId, String isbn) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("isbn", isbn);
		
		sessionTemplate.update("loginMapper.updateRecentBookTime",params);
	}
	
	public int getCounselCount(String userId) {
		
		return sessionTemplate.selectOne("loginMapper.getCounselCount",userId);
	}
	
	public int phoneOverlapCheck(String phone) {
		
		return sessionTemplate.selectOne("loginMapper.phoneOverlapCheck",phone);
		
	}
	
}
