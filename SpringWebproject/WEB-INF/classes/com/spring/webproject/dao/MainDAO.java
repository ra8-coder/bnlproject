package com.spring.webproject.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.mybatis.spring.SqlSessionTemplate;

import com.spring.webproject.dto.BookSectionsDTO;
import com.spring.webproject.dto.MainDTO;
import com.spring.webproject.dto.QuestionDTO;
import com.spring.webproject.dto.StoreDTO;

public class MainDAO {
	
	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	
	//유사 카테고리 책 가져오기
	public List<MainDTO> similCate(String isbn){
		
		List<MainDTO> lst = sessionTemplate.selectList("mainMapper.similCate",isbn);
		
		if(lst.size()>=3) {
			Random rd = new Random();
			int[] num = new int[3];
			
			int i,n;
			n=0;
			while(n<3){
				num[n] = rd.nextInt(lst.size());
				
				for(i=0;i<n;i++) {
					if(num[i]==num[n]) {
						n--;
						break;
					}
				}
				n++;
			}
			List<MainDTO> list = new ArrayList<MainDTO>();
			
			for(i=0;i<num.length;i++) {
				
				list.add(lst.get(num[i]));
			}
			return list;
		}else if(lst.size()<3){
			Random rd = new Random();
			int[] num = new int[lst.size()];
			
			int i,n;
			n=0;
			while(n<lst.size()){
				num[n] = rd.nextInt(lst.size());
				
				for(i=0;i<n;i++) {
					if(num[i]==num[n]) {
						n--;
						break;
					}
				}
				n++;
			}
			List<MainDTO> list = new ArrayList<MainDTO>();
			
			for(i=0;i<num.length;i++) {
				
				list.add(lst.get(num[i]));
			}
			return list;
		}else {
			return null;
		}
	}
	
	
	//기대신간
	public List<MainDTO> newBook(int categoryId){
		
		List<MainDTO> lst = sessionTemplate.selectList("mainMapper.newBook",categoryId);
		
		return lst;	
	}
	
	//기대신간 -전체
	public List<MainDTO> newBookAll(){
		
		List<MainDTO> lst = sessionTemplate.selectList("mainMapper.newBookAll");
		
		return lst;
	}
	
	//이슈북
	public List<MainDTO> issueBook(){
		
		List<MainDTO> lst = sessionTemplate.selectList("mainMapper.issueBook");
		
		return lst;
	}
	
	//베스트셀러
	public List<MainDTO> bestSeller(){
		
		List<MainDTO> lst = sessionTemplate.selectList("mainMapper.bestSeller");
		
		return lst;
	}
	
	//임시 책 정보
	public MainDTO tempBook(String isbn){
		
		MainDTO dto = sessionTemplate.selectOne("mainMapper.tempBook",isbn);
		
		return dto;
	}
	
	//오늘 본 상품
	public List<MainDTO> todayView(String ck){
		
		List<MainDTO> lst = new ArrayList<MainDTO>();
		
		String[] isbn = ck.split(",");

		for(int i=0;i<isbn.length;i++) {
			
			MainDTO dto = sessionTemplate.selectOne("mainMapper.todayView",isbn[i]);
			lst.add(dto);
		}
		return lst;
	}
	
	//매장 정보
	public StoreDTO storeInfo(int warehouseId){
		
		StoreDTO dto = sessionTemplate.selectOne("mainMapper.storeInfo",warehouseId);
		
		return dto;	
	}
	
	//매장 이미지
	public List<StoreDTO> storeImage(int warehouseId){
		
		List<StoreDTO> lst = new ArrayList<StoreDTO>();
		lst = sessionTemplate.selectList("mainMapper.storeImage",warehouseId);
		
		return lst;	
	}
	
	//로그인시 오늘 본 상품
	public List<MainDTO> todayLogin(String userId){
		
		List<MainDTO> lst = new ArrayList<MainDTO>();
		lst = sessionTemplate.selectList("mainMapper.todayLogin",userId);
		
		return lst;
	}
	
	
	//로그인시 최근 본 상품
	public List<MainDTO> recentLogin(String userId){
		
		List<MainDTO> lst = new ArrayList<MainDTO>();
		lst = sessionTemplate.selectList("mainMapper.recentLogin",userId);
		
		return lst;			
	}
	
	//자주묻는 질문
	public List<QuestionDTO> topView(){
		
		List<QuestionDTO> lst = new ArrayList<QuestionDTO>();
		lst = sessionTemplate.selectList("mainMapper.topView");
		
		return lst;
	}
	
	//정가인하도서
	public List<BookSectionsDTO> dcBook(){
		
		List<BookSectionsDTO> lst = new ArrayList<BookSectionsDTO>();
		lst = sessionTemplate.selectList("mainMapper.dcBook");
		
		return lst;
	}
}


