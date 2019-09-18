package com.spring.webproject.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.spring.webproject.dto.CounselDTO;
import com.spring.webproject.dto.QuestionDTO;


public class QuestionDAO {
	private SqlSessionTemplate sessionTemplate;

	public void setSqlSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception {
		this.sessionTemplate = sessionTemplate;
	}	

	
	//typeId==0, 전체 데이터 갯수
	public int getDataCount(String searchKey, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		
		int result =sessionTemplate.selectOne("questionMapper.getDataCount",params);
				
		return result;
	}
	
	//typeId!=0, 전체 데이터 갯수
	public int getDataCount2(String searchKey, String searchValue, String parentsTypeId) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("parentsTypeId", parentsTypeId);
		
		int result =sessionTemplate.selectOne("questionMapper.getDataCount2",params);
		
		return result;
	}
	
	//좌측 자주 찾는 질문 FAO / typeId, type불러오기
	public List<QuestionDTO> getList(){
				
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getList");
		return lists;
	}
	
	// typeId서치 - subTypeId
	public List<QuestionDTO> getSubTypeId(String parentsTypeId){
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("parentsTypeId", parentsTypeId);
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getSubTypeId",params);
		return lists;
	}
		
	// FAO게시글 TypeId별로 번호,질문유형,제목,내용 불러오기
	public List<QuestionDTO> getTypeList(int start, int end, String searchKey, String searchValue,String parentsTypeId) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("parentsTypeId", parentsTypeId);		
		
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getTypeList",params);
		return lists;
	}

	//FAO게시글 typeId=0, 번호,질문유형,제목,내용 불러오기
	public List<QuestionDTO> getType0List(int start, int end, String searchKey, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);		
		
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getType0List",params);
		return lists;
	}
	
	// FAO리스트 출력 번호, 질문유형, 제목 (subTypeId서치) 
	public List<QuestionDTO> getSubTypeList(String typeId) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("typeId", typeId);
		
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.getSubTypeList",params);
		return lists;
	}
	
	//조회수 증가
	public void updateHitCount(int questionNum) {
		sessionTemplate.update("questionMapper.updateHitCount",questionNum);
	}
	
	//조회수 TOP10
	public List<QuestionDTO> topView() {		
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.topView");
		return lists;		
	}
	
	//최근등록 TOP10
	public List<QuestionDTO> topDate() {		
		List<QuestionDTO> lists = sessionTemplate.selectList("questionMapper.topDate");
		return lists;		
	}
	
	////////////////////////////////////////////////////////
	
	//typeId의 갯수
	public int maxNum() {
		int maxNum =0;
		maxNum = sessionTemplate.selectOne("questionMapper.maxNum");
		
		return maxNum;
	}
	
	public void insertCounsel(CounselDTO dto) {
		
		
		sessionTemplate.insert("questionMapper.insertCounsel",dto);
		
	}
}
