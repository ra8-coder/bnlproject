package com.spring.webproject.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.spring.webproject.dao.BookSectionsDAO;
import com.spring.webproject.dao.LoginDAO;
import com.spring.webproject.dao.MyShoppingDAO;
import com.spring.webproject.dto.BookSectionsDTO;
import com.spring.webproject.dto.OrderBooksDTO;
import com.spring.webproject.dto.OrdersDTO;
import com.spring.webproject.dto.UserDTO;
import com.spring.webproject.util.MyUtil;

@Controller
public class BookSectionColtroller {
	
	@Autowired
	@Qualifier("bookSectionsDAO")
	BookSectionsDAO raDao;
	
	@Autowired
	@Qualifier("loginDAO")
	LoginDAO leeDao; /* UserDTO*/
	
	@Autowired
	@Qualifier("myShoppingDAO")
	MyShoppingDAO shoppingDao;

	@Autowired
	MyUtil raMyUtil;
	
	@RequestMapping(value="/bnlBSList.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");

		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		/* 
		장르별 검색을 위해서 between 을 넣어서 
		sortNum lke 1 and 99 or 1 and 4 필요
		*/
		
		String sort1st = request.getParameter("sort1st");
		String sort2nd = request.getParameter("sort2nd");
		
		if(sort1st == null && sort2nd == null){
			sort1st = "1";
			sort2nd = "2000";
		}

		/* 
		장르별 검색을 위해서 between 을 넣어서 
		sortNum lke 1 and 99 or 1 and 4 필요
		*/

		
		//전체데이터 갯수
		int dataCount = raDao.getDataCount();
		
		//페이징 처리
		int numPerPage = 10;
		int totalPage = raMyUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		/* 
		sort 분류 
		sort0 = order by soldBookCnt desc, rate desc, reviewCnt desc
		sort1 = order by publish
		sort2 = order by goods 
		sort3 = order by review
		*/
		String sort = request.getParameter("sort");
		if(sort == null || sort == "") {
			
			sort = "";
			List<BookSectionsDTO> lists = raDao.getListMain(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
		
		}else if(sort.equals("sort1")) {
			
			List<BookSectionsDTO> lists = raDao.getListSort1(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}else if(sort.equals("sort2")) {
			
			List<BookSectionsDTO> lists = raDao.getListSort2(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}else if(sort.equals("sort3")) {
			
			List<BookSectionsDTO> lists = raDao.getListSort3(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}else if(sort.equals("sort4")) {
			
			List<BookSectionsDTO> lists = raDao.getListSort4(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}

		String bnlBSListUrl = cp + "/bnlBSList.action";
		
		String pageIndexList =
				raMyUtil.pageIndexList(currentPage, totalPage, bnlBSListUrl);
		
		request.setAttribute("sort", sort);
		request.setAttribute("sort1st", sort1st);
		request.setAttribute("sort2nd", sort2nd);
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);

	
		return "bookSections/bnlBSList";
	}
	
	@RequestMapping(value="bnlNewBookList.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String newBookList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");

		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		/* 
		장르별 검색을 위해서 between 을 넣어서 
		sortNum lke 1 and 99 or 1 and 4 필요
		*/
		
		String sort1st = request.getParameter("sort1st");
		String sort2nd = request.getParameter("sort2nd");
		
		if(sort1st == null && sort2nd == null){
			sort1st = "1";
			sort2nd = "2000";
		}

		/* 
		장르별 검색을 위해서 between 을 넣어서 
		sortNum like 1 and 99 or 1 and 4 필요
		*/

		//전체데이터 갯수
		int dataCount = raDao.getDataCountForNewBooks();
		
		//페이징 처리
		int numPerPage = 4;
		int totalPage = raMyUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		/* 
		sort 분류 
		sort0 = order by soldBookCnt desc, rate desc, reviewCnt desc
		sort1 = order by publish
		sort2 = order by goods 
		sort3 = order by review
		*/
		String sort = request.getParameter("sort");
		if(sort == null || sort == "") {
			
			sort = "";
			
			List<BookSectionsDTO> adLists = raDao.getSlideAd(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("adLists", adLists);
			
			List<BookSectionsDTO> lists = raDao.getBooksOfTheMonth(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			
			request.setAttribute("lists", lists);
		
		}else if(sort.equals("sort1")) {
			
			List<BookSectionsDTO> adLists = raDao.getSlideAd(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("adLists", adLists);
			
			List<BookSectionsDTO> lists = raDao.getBooksOfTheMonthSort1(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}else if(sort.equals("sort2")) {
			
			List<BookSectionsDTO> adLists = raDao.getSlideAd(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("adLists", adLists);
			
			List<BookSectionsDTO> lists = raDao.getBooksOfTheMonthSort2(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}else if(sort.equals("sort3")) {
			
			List<BookSectionsDTO> adLists = raDao.getSlideAd(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("adLists", adLists);
			
			List<BookSectionsDTO> lists = raDao.getBooksOfTheMonthSort3(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}else if(sort.equals("sort4")) {
			
			List<BookSectionsDTO> adLists = raDao.getSlideAd(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("adLists", adLists);
			
			List<BookSectionsDTO> lists = raDao.getBooksOfTheMonthSort4(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), start, end);
			request.setAttribute("lists", lists);
			
		}

		String bnlNewBookListUrl = cp + "/bnlNewBookList.action";
		
		String pageIndexList =
				raMyUtil.pageIndexList(currentPage, totalPage, bnlNewBookListUrl);
		
		
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		request.setAttribute("sort", sort);
		request.setAttribute("sort1st", sort1st);
		request.setAttribute("sort2nd", sort2nd);
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);

		return "bookSections/bnlNewBookList";
	}
	
	@RequestMapping(value="discountBookMain.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String discountBookMain(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pageNum = request.getParameter("pageNum");

		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		
		//전체데이터 갯수
		int dataCount = raDao.getDataCountForEachRnum();
		
		//페이징 처리
		int numPerPage = 10;
		int totalPage = raMyUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		request.setAttribute("start", start);
		request.setAttribute("end", end);
		
		List<BookSectionsDTO> dcSixSlideLists = raDao.getDcSixSlide();
		request.setAttribute("dcSixSlideLists", dcSixSlideLists);
		
		List<BookSectionsDTO> dcRnumSlideLists = raDao.getDcRnumSlide(start, end);
		request.setAttribute("dcRnumSlideLists", dcRnumSlideLists);	
		
		List<BookSectionsDTO> dcOfTheMonth = raDao.getDcSixSlide();
		request.setAttribute("dcOfTheMonth", dcOfTheMonth);
		
		List<BookSectionsDTO> bestSellerTop10 = raDao.getBestSellerTop10();
		request.setAttribute("bestSellerTop10", bestSellerTop10);
		
				
		return "bookSections/discountBookMain";
	}
	
	@RequestMapping(value="discountBookList.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String discountBookList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String cp = request.getContextPath();
		
		String pageNum = request.getParameter("pageNum");
		String theMonth = request.getParameter("theMonth");
		
		String sort = request.getParameter("sort");
		if(sort == null) {
			sort = "";
		}
		
		/*장르*//*장르*/
		String sort1st = request.getParameter("sort1st");
		String sort2nd = request.getParameter("sort2nd");
		
		if(sort1st == null && sort2nd == null){
			sort1st = "1";
			sort2nd = "2000";
		}
		/*장르*//*장르*/
		
		/*discountRate*/
		String fromDiscount = request.getParameter("fromDiscount");
		String toDiscount = request.getParameter("toDiscount");
		if(fromDiscount == null && toDiscount == null){
			fromDiscount = "30";
			toDiscount = "100";
		}
		
		/* 페이지 */
		int currentPage = 1;
		
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		/* 페이지 */
		
		

		/* 이달의 신규 할인 도서만 검색하기 위한 조건 생성(the month = 1) */

		if(theMonth.equals("1")) {
			
			//전체데이터 갯수
			int dataCount = raDao.getDcDataCountOfTheMonth(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount));
			//페이징 처리
			int numPerPage = 1;
			int totalPage = raMyUtil.getPageCount(numPerPage, dataCount);
			
			if(currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			String discountBookListUrl = cp + "/discountBookList.action?theMonth="+theMonth+"&sort="+sort+"&sort1st="+sort1st+"&sort2nd="+sort2nd+"&fromDiscount="+fromDiscount+"&toDiscount="+toDiscount;
			
			String pageIndexListforJ =
					raMyUtil.pageIndexListforJ(currentPage, totalPage, discountBookListUrl);
			
			
			request.setAttribute("dataCount", dataCount);
			request.setAttribute("pageIndexListforJ", pageIndexListforJ);	
			

			if(sort == "") {
				
				List<BookSectionsDTO> lists = raDao.getDcListsOfTheMonth(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
			
			}else if(sort.equals("sort1")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsOfTheMonthSort1(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}else if(sort.equals("sort2")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsOfTheMonthSort2(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}else if(sort.equals("sort3")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsOfTheMonthSort3(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}else if(sort.equals("sort4")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsOfTheMonthSort4(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
			}
			
		}else{
			
			//전체데이터 갯수
			int dataCount = raDao.getDcDataCount(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount));
			//페이징 처리
			int numPerPage = 1;
			int totalPage = raMyUtil.getPageCount(numPerPage, dataCount);
			
			if(currentPage > totalPage)
				currentPage = totalPage;
			
			int start = (currentPage-1)*numPerPage+1;
			int end = currentPage*numPerPage;
			
			String discountBookListUrl = cp + "/discountBookList.action?theMonth="+theMonth+"&sort="+sort+"&sort1st="+sort1st+"&sort2nd="+sort2nd+"&fromDiscount="+fromDiscount+"&toDiscount="+toDiscount;
			
			String pageIndexListforJ =
					raMyUtil.pageIndexListforJ(currentPage, totalPage, discountBookListUrl);

			request.setAttribute("dataCount", dataCount);
			request.setAttribute("pageIndexListforJ", pageIndexListforJ);
			
			if(sort == "") {

				List<BookSectionsDTO> lists = raDao.getDcLists(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
			
			}else if(sort.equals("sort1")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsSort1(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}else if(sort.equals("sort2")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsSort2(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}else if(sort.equals("sort3")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsSort3(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}else if(sort.equals("sort4")) {
				
				List<BookSectionsDTO> lists = raDao.getDcListsSort4(Integer.parseInt(sort1st), Integer.parseInt(sort2nd), Integer.parseInt(fromDiscount), Integer.parseInt(toDiscount), start, end);
				request.setAttribute("lists", lists);
				
			}
		
		}
		
		/* 이달의 신규 할인 도서만 검색하기 위한 조건 생성(the month = 1) */
		
		request.setAttribute("theMonth", theMonth);
		request.setAttribute("sort", sort);
		request.setAttribute("sort1st", sort1st);
		request.setAttribute("sort2nd", sort2nd);
		request.setAttribute("fromDiscount", fromDiscount);
		request.setAttribute("toDiscount", toDiscount);
		request.setAttribute("pageNum", currentPage);
		
		
		return "bookSections/discountBookList";
	}
	
	@RequestMapping(value="shopCartList.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String shopCartList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		UserDTO dto5 = (UserDTO)request.getSession().getAttribute("userInfo");
		
		if(dto5 != null) {
			
			//남은 포인트	
			int leftPoint = raDao.getLeftPoint(dto5.getUserId());
				
			request.setAttribute("leftPoint", leftPoint);
		}
		
		return "shopAndOrder/shopCartList";
	}
	
	
	@RequestMapping(value="order_dirOrder.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String dirOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		UserDTO dto2 = (UserDTO)request.getSession().getAttribute("userInfo");
		
		//배송지 중에서 폰 및 일반 전화번호 splited by '-'

		String addPhone = dto2.getPhone();
		
		String[] arrayAddPhone = addPhone.split("-");

		String addPhone2 = arrayAddPhone[1];
		String addPhone3 = arrayAddPhone[2];

		String isbn = request.getParameter("isbn");
		String orderCount = request.getParameter("orderCount");
		//--------------------------------------------------------------------------
	
		
		//남은 포인트
		String userId = dto2.getUserId();
		
		int leftPoint = raDao.getLeftPoint(userId);
		//남은 포인트
		
		//쿠키 책 출력
		int num = 0;
		List<BookSectionsDTO> lists = new ArrayList<BookSectionsDTO>();
		
		for(int i=0;i<1;i++) {
			
			int seqNum = 1000+i;
			num += 1;
			
			BookSectionsDTO dto = raDao.getBookSection(isbn);
			dto.setOrderCount(orderCount);
			dto.setSeqNum(seqNum);
			
			lists.add(dto);
			
		}
		//쿠키 책 출력
		
		request.setAttribute("leftPoint", leftPoint);
		request.setAttribute("addPhone2", addPhone2);
		request.setAttribute("addPhone3", addPhone3);
		request.setAttribute("num", num);
		request.setAttribute("lists", lists);
		
		return "shopAndOrder/order";
	}
	
	@RequestMapping(value="order.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String order(HttpServletRequest request, HttpServletResponse response) throws Exception {

		UserDTO dto2 = (UserDTO)request.getSession().getAttribute("userInfo");
		
		//배송지 중에서 폰 및 일반 전화번호 splited by '-'

		String addPhone = dto2.getPhone();
		
		String[] arrayAddPhone = addPhone.split("-");

		String addPhone2 = arrayAddPhone[1];
		String addPhone3 = arrayAddPhone[2];

		String[] arrayIsbn = request.getParameterValues("isbn");
		String[] arrayOrderCnt = request.getParameterValues("orderCount");
		//--------------------------------------------------------------------------
		
		//남은 포인트
		String userId = dto2.getUserId();
		
		int leftPoint = raDao.getLeftPoint(userId);
		//남은 포인트
		
		//쿠키 책 출력
		int num = 0;
		List<BookSectionsDTO> lists = new ArrayList<BookSectionsDTO>();
		
		for(int i=0;i<arrayIsbn.length;i++) {
			
			String isbn = arrayIsbn[i];
			String OrderCount = arrayOrderCnt[i];
			int seqNum = 1000+i;
			num += 1;
			
			BookSectionsDTO dto = raDao.getBookSection(isbn);
			dto.setOrderCount(OrderCount);
			dto.setSeqNum(seqNum);
			
			lists.add(dto);
			
		}
		//쿠키 책 출력
		
		request.setAttribute("leftPoint", leftPoint);
		request.setAttribute("addPhone2", addPhone2);
		request.setAttribute("addPhone3", addPhone3);
		request.setAttribute("num", num);
		request.setAttribute("lists", lists);

		return "shopAndOrder/order";
	}
	
	@RequestMapping(value="order_ok.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String order_ok(OrdersDTO dto4, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//상품권 포인트 - 총 값에서 빼야함( USERINFO, POINT 차감해야함)
		int usedPoint = Integer.parseInt(request.getParameter("reserve_point"));
		
		UserDTO dto3 = (UserDTO)request.getSession().getAttribute("userInfo");
		
		String[] arrayIsbn = request.getParameterValues("isbn");
		String[] arrayOrderCnt = request.getParameterValues("orderCount");
		String[] arraySaleCosVal = request.getParameterValues("price");
		String[] arrayPointVal = request.getParameterValues("rodPointVal");

		// orders table insert	start
		int totCosVal = 0;
		int totValue = 0;
		int deliveryFee = 2000;
		for(int i=0;i<arrayIsbn.length;i++) {

			int saleCosVal = Integer.parseInt(arraySaleCosVal[i]);
			int OrderCount = Integer.parseInt(arrayOrderCnt[i]);
			int value = Integer.parseInt(arrayPointVal[i]);

			totCosVal += saleCosVal * OrderCount;
				if(totCosVal < 10000) {
					totCosVal += deliveryFee;
				}
			
			totValue += value;

		}

		int orderPrice = totCosVal - usedPoint;
		
		int maxOrderId = raDao.getMaxOrderId();
		dto4.setOrderId(maxOrderId + 1);
		dto4.setUserId(dto3.getUserId());
		dto4.setOrderPrice(orderPrice);
		
		raDao.getOrdersInsertData(dto4);
		// orders table insert	end
		
		
		// orderBooks table insert start
		OrderBooksDTO orderBooksDTO = new OrderBooksDTO();
		
		for(int i=0;i<arrayIsbn.length;i++) {

			String isbn = arrayIsbn[i];
			int price = Integer.parseInt(arraySaleCosVal[i]);
			int OrderCount = Integer.parseInt(arrayOrderCnt[i]);
			
			orderBooksDTO.setOrderId(dto4.getOrderId());
			orderBooksDTO.setIsbn(isbn);
			orderBooksDTO.setPrice(price);
			orderBooksDTO.setQuantity(OrderCount);
			raDao.getOrderBooksInsertData(orderBooksDTO);
		}
		// orderBooks table insert end
		
		
		//usedPoint가 0이면 그냥 넘어가게 (시작)
		if(usedPoint != 0) {
			// point table insert
			//usedPoint : 주문시에 사용한 포인트
			int inputPoint = usedPoint-(usedPoint*2);	//DB에 입력할 때 사용할 포인트 변수
			
			while(usedPoint!=0) {	//usedPoint가 0이 될때까지 동작
	
				//rownum으로 leftPoint를 만료일자가 가까운 순으로 불러옴
				//pointMap안에는 pointid, leftValue가 들어있음
				HashMap<String, Object> pointMap = shoppingDao.getLeftPoint(dto3.getUserId());
	
				//pointMap 풀어내기
				int leftValue = ((BigDecimal)pointMap.get("LEFTVALUE")).intValue();
				int pointId = ((BigDecimal)pointMap.get("POINTID")).intValue();
				
	
				
				//사용한 포인트>적립된 포인트
				//적립된 포인트(point테이블 안의 leftValue)를 0으로 만든다음 사용한포인트-적립된 포인트한 금액을
				//다시 usedPoint에 넣음 그리고 while문 반복
				if(usedPoint>=leftValue) { 
					//leftValue를 0으로 만들고, usedPoint를 그만큼 줄여서 다시 저장
					shoppingDao.pointUseUpdate(pointId, 0);
					usedPoint = usedPoint-leftValue;
	
				}
				//사용한 포인트<적립된 포인트
				//적립된 포인트-사용한 포인트 금액을 불러온 pointId를 통해 leftValue를 업데이트한 후 while문 종료됨
				else {
	
					leftValue = leftValue-usedPoint;
					shoppingDao.pointUseUpdate(pointId, leftValue);
					usedPoint = 0;
	
				}
			}
			//포인트 아이디 생성
			
			//DB에 포인트 사용한 내역 추가함
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userId", dto3.getUserId());
			map.put("orderId", dto4.getOrderId());	//orderId 생성후 입력
			map.put("value", inputPoint);
			map.put("pointId", shoppingDao.getMaxPointId()+1);//pointId 생성후 입력
	
			shoppingDao.usedPointInsert(map);
		}
		//usedPoint가 0이면 그냥 넘어가게 (끝)
		
		
		//상품 구입후 포인트 적립 시작
		String orderId = Integer.toString(dto4.getOrderId());
		shoppingDao.getPurchasingPoint(dto3.getUserId(), shoppingDao.getMaxPointId()+1, orderId, totValue, totValue);
		//상품 구입후 포인트 적립 끝
		// point table insert end

		//shipment table insert
		shoppingDao.getShipmentsStatus(shoppingDao.getMaxShipmentsId()+1, dto4.getOrderId());
		//shipment table insert
		
		
		//책권수 빼기
		for(int i=0;i<arrayIsbn.length;i++) {
			int finalOrderCount = 0;
			String isbn = arrayIsbn[i];
			int orderCount = Integer.parseInt(arrayOrderCnt[i]);
			
			int totOrderCount = raDao.getSelectBookQuantity(isbn);
			System.out.println(totOrderCount);
			
			finalOrderCount = totOrderCount - orderCount;
			System.out.println(finalOrderCount);

			raDao.getUpdateBookQuantity(isbn, finalOrderCount);
		}
		//책권수 빼기

	    // 특정 쿠키만 삭제하기
	    Cookie kc = new Cookie("shop", null);
	    kc.setMaxAge(0);
	    kc.setPath("/");
	    response.addCookie(kc);
	    
	    //세션에 적립금 정보 다시 올리기(적립금 사용 및 적립 변동사항 적용)
	    int pointValue = shoppingDao.getPointValue(dto3.getUserId());
	    request.getSession().setAttribute("pointValue", pointValue);

		return "redirect:/myShoppingMain.action";
	}
	
	@RequestMapping(value="cartList.action", method= {RequestMethod.GET, RequestMethod.POST})
	public String cartList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String ck = request.getParameter("isbn");
		String ckC = request.getParameter("orderCount");
		
		if(!ck.equals("") && ck!=null) {
			List<BookSectionsDTO> lst = new ArrayList<BookSectionsDTO>();
			
			lst = raDao.cartList(ck,ckC);
			
			request.setAttribute("lst", lst);
		}
		
		return "shopAndOrder/cartList";
	}

}
