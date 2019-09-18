package com.spring.webproject.util;

public class AjaxPageIndex {

	//전체 페이지수 구하기
	//numPerPage : 한화면에 표시할 데이터의 갯수
	//dataCount : 전체 데이터의 갯수
	public int getPageCount(int numPerPage, int dataCount){

		int pageCount = 0;
		pageCount = dataCount / numPerPage;

		if(dataCount % numPerPage != 0)
			pageCount++;

		return pageCount;	

	}

	//페이징 처리 메소드
	//currentPage :현재 표시할 페이지
	//totalPage : 전체 페이지수
	//params : 검색조건
	public String pageIndexList(int currentPage, int totalPage, String params, String mode){

		int numPerBlock = 5; //1◀이전 6 7 8 9 10 다음▶11(6-10까지 표시되는 페이지 갯수)
		int currentPageSetup; //표시할 첫 페이지(6)의 – 1 해준 값(5,10,15,20...)
		int page;

		StringBuffer sb = new StringBuffer();

		if(currentPage==0 || totalPage==0)	//데이터가 없을 경우
			return "";

		//표시할 첫 페이지의 – 1 해준 값
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;

		if(currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;

		//바로가기 페이지
		page = currentPageSetup + 1;

		//mode가 null이면 주문조회에서 넘어온 리스트 페이징
		if(mode==null || mode.equals("")) {

			if(params==null || params.equals("")) {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getList(" +  page + ",'','','')\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}		
			}
			else {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getList(" 
								+ page + "," + params +")\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}
			}

		}
		//취소/반품/교환 내역 조회에서 넘어온 리스트 페이징
		else if(mode.equals("ret")) {	

			if(params==null || params.equals("")) {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getRetList(" +  page + ",'','','ret')\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}		
			}
			else {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getRetList(" 
								+ page + "," + params +")\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}
			}

		}

		//포인트조회에서 넘어온 리스트 페이징
		else if(mode.equals("all") || mode.equals("save") || mode.equals("use")) {	

			if(params==null || params.equals("")) {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getPointList(" +  page + ",'','','')\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}		
			}
			else {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getPointList(" 
								+ page + "," + params +")\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}
			}

		}
		//1:1상담내역에서 넘어온 리스트 페이징
		else if(mode.equals("counselAll") || mode.equals("yes") || mode.equals("no")) {	
			if(params==null || params.equals("")) {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getCounselList(" +  page + ",'','','" +mode+"')\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}		
			}
			else {
				while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
					if(page == currentPage){				
						sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
					}
					else{
						sb.append("<span class='page_off'><a href=\"javascript:getCounselList(" 
								+ page + "," + params + ",'"+ mode+"')\">"
								+ page + "</a></span>&nbsp;");		
					}				
					page++;		
				}
			}	
		}
		//소멸예정 포인트 조회 리스트에서 넘어온 리스트 페이징
		else {
			while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
				if(page == currentPage){				
					sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
				}
				else{
					sb.append("<span class='page_off'><a href=\"javascript:getExpPointList(" +  page + ",'','','exp')\">"
							+ page + "</a></span>&nbsp;");		
				}				
				page++;		
			}		
		}

		return sb.toString();

	}
	
	public String pageIndexList(int currentPage, int totalPage, String mode) {
		
		int numPerBlock = 5; //1◀이전 6 7 8 9 10 다음▶11(6-10까지 표시되는 페이지 갯수)
		int currentPageSetup; //표시할 첫 페이지(6)의 – 1 해준 값(5,10,15,20...)
		int page;

		StringBuffer sb = new StringBuffer();

		if(currentPage==0 || totalPage==0)	//데이터가 없을 경우
			return "";

		//표시할 첫 페이지의 – 1 해준 값
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;

		if(currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;

		//바로가기 페이지
		page = currentPageSetup + 1;
		
		//리뷰를 기다리는 책 페이지
		if(mode.equals("readyReivew")) {
			while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
				if(page == currentPage){				
					sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
				}
				else{
					sb.append("<span class='page_off'><a href=\"javascript:getReadyReivewList(" +  page + ",'readyReivew')\">"
							+ page + "</a></span>&nbsp;");		
				}				
				page++;		
			}	
		}
		//최근 본 상품
		else if(mode.equals("LatesBooks")) {
			while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
				if(page == currentPage){				
					sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
				}
				else{
					sb.append("<span class='page_off'><a href=\"javascript:getLatesBooksList(" +  page + ",'LatesBooks')\">"
							+ page + "</a></span>&nbsp;");
				}				
				page++;		
			}			
		}
		//리뷰가 있는 책
		else if(mode.equals("myReviewDefault")) {
			
			while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
				if(page == currentPage){				
					sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
				}
				else{
					sb.append("<span class='page_off'><a href=\"javascript:getMyReviewList(" +  page + ",'myReviewDefault')\">"
							+ page + "</a></span>&nbsp;");
				}				
				page++;		
			}	
		}
		else if(mode.indexOf("wish")!=-1) {
			while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
				if(page == currentPage){				
					sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
				}
				else{
					sb.append("<span class='page_off'><a href=\"javascript:getWishList(" +  page + ",'" + mode + "')\">"
							+ page + "</a></span>&nbsp;");
				}				
				page++;		
			}	
		}
		else if(mode.equals("sentence")) {
			while(page <= totalPage && page <= (currentPageSetup + numPerBlock)){
				if(page == currentPage){				
					sb.append("<span class='page_on'>" + page + "</span>&nbsp;");				
				}
				else{
					sb.append("<span class='page_off'><a href=\"javascript:getSentenceList(" +  page + ",'" + mode + "')\">"
							+ page + "</a></span>&nbsp;");
				}				
				page++;		
			}	
		}
		
		
		return sb.toString();
		
	}
}
