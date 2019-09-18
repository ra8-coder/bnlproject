package com.spring.webproject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.webproject.dao.LoginDAO;
import com.spring.webproject.dao.MyShoppingDAO;
import com.spring.webproject.dto.CounselDTO;
import com.spring.webproject.dto.MainDTO;
import com.spring.webproject.dto.MyReviewDTO;
import com.spring.webproject.dto.OrderDetailDTO;
import com.spring.webproject.dto.OrderListDTO;
import com.spring.webproject.dto.PointDTO;
import com.spring.webproject.dto.UserDTO;
import com.spring.webproject.util.AjaxPageIndex;

@Controller
public class MyShoppingController {

	@Autowired
	MyShoppingDAO dao;

	@Autowired
	AjaxPageIndex ajaxPaging;

	@Autowired
	LoginDAO loginDao;

	//나의쇼핑 메인
	@RequestMapping(value = "/myShoppingMain.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String myShoppingMain(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		//진행중 주문건 건수, 최근 본 상품 리스트 갯수
		int orderCount = dao.getCountOrderListNormal(userId);
		int recentCount = dao.getRecentCount(userId);
		request.getSession().setAttribute("orderCount", orderCount);
		request.getSession().setAttribute("recentCount", recentCount);

		//위시리스트 갯수
		int wishCount = dao.getWishCount(userId);	
		request.setAttribute("wishCount", wishCount);

		//최근 주문/배송 내역 간략리스트(최대 3개)
		int start = 1;
		int end = 3;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<OrderListDTO> orderList = dao.getOrderList(hMap);
		request.setAttribute("orderList", orderList);
		hMap.clear();

		//최근본 상품
		start = 1;
		end = 4;
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);
		List<MainDTO> recentList = dao.LatesBooksList(hMap);
		request.setAttribute("recentList", recentList);

		//위시리스트
		List<MainDTO> wishList = dao.getWishListDefault(hMap);
		request.setAttribute("wishList", wishList);

		//1:1 상담내역
		hMap.clear();
		hMap.put("userId", userId);
		hMap.put("start", 1);
		hMap.put("end",3);
		List<CounselDTO> counselList = dao.getAllCounselList(hMap);
		request.setAttribute("counselList", counselList);

		return "myShopping/myShoppingMain";
	}

	//회원정보수정(비밀번호 재확인)
	@RequestMapping(value = "myShopping/pre_updateMyInfo.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String preUpdateMyInfo(HttpServletRequest request) {

		String mode = request.getParameter("mode");
		request.setAttribute("mode", mode);

		return "myShopping/pre_updateMyInfo";
	}

	//회원정보수정(비밀번호 재확인 완료 후 회원정보수정 페이지로 넘어감)
	@RequestMapping(value = "myShopping/pre_updateMyInfo_ok.action", method = RequestMethod.POST)
	public String myInfoPwdCheck(HttpServletRequest request) {	

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();
		String inputPwd = request.getParameter("userPwd");
		String mode = request.getParameter("mode");

		//userPwd 찾아오기
		String userPwd = dao.getUserPwd(userId);

		if(!(inputPwd.equals(userPwd))) {
			request.getSession().setAttribute("pwdErrMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/myShopping/pre_updateMyInfo.action?mode=" + mode;
		}
		else {
			if(mode.equals("update")) {
				return "redirect:/myShopping/updateMyInfo.action";
			}
			else if(mode.equals("out")) {
				return "redirect:/myShopping/memberOut.action";
			}
			else {
				return "redirect:/myShopping/pre_updateMyInfo.action?mode=" + mode;
			}
		}
	}

	//회원정보수정 페이지
	@RequestMapping(value = "myShopping/updateMyInfo.action", method = {RequestMethod.POST,RequestMethod.GET})
	public String updateMyInfo(HttpServletRequest request) {

		request.getSession().removeAttribute("pwdErrMessage");

		return "myShopping/updateMyInfo";
	}

	//회원정보수정 저장
	@RequestMapping(value = "myShopping/updateMyInfo_ok.action", method = RequestMethod.POST)
	public String updateUserInfo(HttpServletRequest request, UserDTO dto, Model model) {

		//회원정보 수정
		dao.updateUserInfo(dto);

		model.addAttribute("alertMsg","성공적으로 회원정보가 수정되었습니다!");
		model.addAttribute("nextUrl","/myShoppingMain.action");

		//수정된 회원정보를 다시 불러 세션에 올림
		UserDTO updatedDTO = dao.getUserInfo(dto.getUserId());
		request.getSession().setAttribute("userInfo", updatedDTO);

		return "common/alert";
	}

	//비밀번호 변경 페이지
	@RequestMapping(value = "myShopping/updatePwd.action", method = RequestMethod.GET)
	public String updatePwd() {

		return "myShopping/updatePwd";
	}

	//비밀번호 변경 진행
	@RequestMapping(value = "myShopping/updatePwd_ok.action", method = RequestMethod.POST)
	public String updatePwd(HttpServletRequest request, Model model) {

		//form에서 넘어오는 패스워드
		String userPwd = request.getParameter("userPwd");
		String updatePwd = request.getParameter("newPwd1");

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		//userPwd 찾아오기
		String findedUserPwd = dao.getUserPwd(userId);

		//기존 비밀번호 불일치
		if(!(userPwd.equals(findedUserPwd))) {

			model.addAttribute("alertMsg","기존 비밀번호가 일치하지 않습니다.");
			model.addAttribute("nextUrl","myShopping/updatePwd.action");

			return "common/alert";
		}
		else {	//기존 비밀번호 일치, 비밀번호 변경 진행

			dao.updatePwd(userId, updatePwd);

			model.addAttribute("alertMsg","비밀번호가 변경되었습니다.");
			model.addAttribute("nextUrl","myShopping/updatePwd.action");
			model.addAttribute("windowClose","window.close();");

			return "common/alert";
		}

	}

	//주문/배송조회 페이지
	@RequestMapping(value = "myShopping/myOrderList.action", method = RequestMethod.GET)
	public String myOrderList(HttpServletRequest request) {

		return "myShopping/myOrderList";
	}

	//주문/배송조회 리스트 가져오기
	@RequestMapping(value = "myShopping/getOrderList.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String getOrderList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String pageNum = request.getParameter("pageNum");	
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		String searchValue = request.getParameter("searchValue");

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && !pageNum.equals("")) {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		//전체 출력 건수 가져오기
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate.equals("undefined") || toDate==null || toDate.equals("undefined")) {

			totalDataCount = dao.getCountOrderListNormal(userId);

			//출력 건수에 맞춰 내용 가져오기
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);

			List<OrderListDTO> orderList = dao.getOrderList(hMap);

			request.setAttribute("lists", orderList);

		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {

			totalDataCount = dao.getCountOrderListByDate(userId, fromDate, toDate);

			//출력 건수에 맞춰 내용 가져오기
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);
			hMap.put("fromDate", fromDate);
			hMap.put("toDate", toDate);

			List<OrderListDTO> orderList  = dao.getOrderListByDate(hMap);

			request.setAttribute("lists", orderList);

		}
		//3.상품명 또는 ISBN 검색
		if(searchValue!=null) {

			totalDataCount = dao.getCountOrderListByName(userId,searchValue);

			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);
			hMap.put("searchValue", searchValue);

			List<OrderListDTO> orderList  = dao.getOrderListByName(hMap);

			request.setAttribute("lists", orderList);

		}

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		//페이징 인덱스
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate=="" || fromDate.equals("undefined")) {	//
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, "", "");
			request.setAttribute("pageIndexList", pageIndexList);
		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {
			String params = "'" + fromDate + "','" + toDate + "',''";
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, params, "");
			request.setAttribute("pageIndexList", pageIndexList);
		}
		//3.상품명 또는 ISBN 검색
		if(searchValue!=null && !searchValue.equals("")) {
			String params = "'" + fromDate + "','" + toDate + "','" + searchValue + "'";
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, params, "");
			request.setAttribute("pageIndexList", pageIndexList);
		}


		return "myShopping/lists/lists";
	}

	//주문내역 상세페이지
	@RequestMapping(value = "myShopping/myOrderDetail.action", method = RequestMethod.GET)
	public String myOrderDetail(HttpServletRequest request) {

		String orderId = request.getParameter("orderId");

		//주문 도서 리스트 가져오기
		List<OrderDetailDTO> lists = dao.getOrderDetailList(orderId);
		request.setAttribute("lists", lists);

		OrderListDTO dto = dao.getOrderDetailInfo(orderId);
		request.setAttribute("orderInfo", dto);

		return "myShopping/myOrderDetail";
	}

	//취소/반품/교환 내역 페이지
	@RequestMapping(value = "myShopping/myOrderRetList.action", method = RequestMethod.GET)
	public String myOrderRetList(HttpServletRequest request) {

		return "myShopping/myOrderRetList";
	}

	@RequestMapping(value = "myShopping/getRetList.action", method = {RequestMethod.POST, RequestMethod.GET})
	public String getRetList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String pageNum = request.getParameter("pageNum");	
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		//전체 출력 건수 가져오기
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate.equals("undefined") || toDate==null || toDate.equals("undefined")) {

			totalDataCount = dao.getCountRetListNormal(userId);

			//출력 건수에 맞춰 내용 가져오기
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);

			List<OrderListDTO> orderList = dao.getRetList(hMap);

			request.setAttribute("lists", orderList);
		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {

			totalDataCount = dao.getCountRetListByDate(userId, fromDate, toDate);

			//출력 건수에 맞춰 내용 가져오기
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);
			hMap.put("fromDate", fromDate);
			hMap.put("toDate", toDate);

			List<OrderListDTO> orderList  = dao.getRetListByDate(hMap);

			request.setAttribute("lists", orderList);

		}

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		//페이징 인덱스
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate=="" || fromDate.equals("undefined")) {	//
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, "", "ret");
			request.setAttribute("pageIndexList", pageIndexList);
		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {
			String params = "'" + fromDate + "','" + toDate + "','ret'";
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, params, "ret");
			request.setAttribute("pageIndexList", pageIndexList);
		}

		return "myShopping/lists/lists_retList";
	}


	//적립금 페이지
	@RequestMapping(value = "myShopping/myPointHistory.action", method = RequestMethod.GET)
	public String myPointHistory(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		//소멸 예정 적립금 검색
		int exPoint = dao.getExPoint(userId);
		request.setAttribute("exPoint", exPoint);

		return "myShopping/myPointHistory";
	}

	//적립금 리스트 불러오기
	@RequestMapping(value = "myShopping/getPointList.action", method = RequestMethod.POST)
	public String getTotalPointList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String pageNum = request.getParameter("pageNum");	
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");	
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "all";
		}

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		//전체 출력 건수 가져오기
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate.equals("undefined") || toDate==null || toDate.equals("undefined")) {

			totalDataCount = dao.getCountPointList(userId);

			//출력 건수에 맞춰 내용 가져오기
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);

			List<PointDTO> pointList = dao.getTotalPointList(hMap);

			request.setAttribute("lists", pointList);
		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {

			//mode로(내역별조회) 리스트 불러오기
			//기본 조회, 전체 조회
			if(mode==null || mode.equals("") || mode.equals("undefined") || mode.equals("all")) {

				totalDataCount = dao.getCountPointListByDate(userId, fromDate, toDate);

				//출력 건수에 맞춰 내용 가져오기
				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put("start", start);
				hMap.put("end", end);
				hMap.put("userId", userId);
				hMap.put("fromDate", fromDate);
				hMap.put("toDate", toDate);

				List<PointDTO> pointList  = dao.getPointListByDate(hMap);

				request.setAttribute("lists", pointList);

			}
			else if(mode.equals("save")) {	//적립내역

				totalDataCount = dao.getCountSavePoint(userId, fromDate, toDate);

				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put("start", start);
				hMap.put("end", end);
				hMap.put("userId", userId);
				hMap.put("fromDate", fromDate);
				hMap.put("toDate", toDate);

				List<PointDTO> pointList = dao.getSavePointList(hMap);

				request.setAttribute("lists", pointList);

			}
			else if(mode.equals("use")) {	//사용내역

				totalDataCount = dao.getCountUsePoint(userId, fromDate, toDate);

				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put("start", start);

				hMap.put("end", end);
				hMap.put("userId", userId);
				hMap.put("fromDate", fromDate);
				hMap.put("toDate", toDate);

				List<PointDTO> pointList = dao.getUsePointList(hMap);

				request.setAttribute("lists", pointList);

			}

		}

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		//페이징 인덱스
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate=="" || fromDate.equals("undefined")) {	//
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, "",mode);
			request.setAttribute("pageIndexList", pageIndexList);
		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {
			String params = "'" + fromDate + "','" + toDate + "','" + mode + "'";
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, params, mode);
			request.setAttribute("pageIndexList", pageIndexList);
		}

		return "myShopping/lists/lists_pointList";
	}

	//소멸예정 적립금 보기
	@RequestMapping(value = "myShopping/expPointDetail.action", method = RequestMethod.GET)
	public String expPointDetail(HttpServletRequest request) {

		//소멸 예정 적립금 검색
		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		int exPoint = dao.getExPoint(userId);
		request.setAttribute("exPoint", exPoint);

		return "myShopping/expPointDetail";

	}
	//소멸예정 적립금 리스트불러오기
	@RequestMapping(value = "myShopping/expPointList.action", method = RequestMethod.POST)
	public String expPointList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String pageNum = request.getParameter("pageNum");
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "exp";
		}

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		//전체 출력 건수 가져오기
		totalDataCount = dao.expPointCount(userId);

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<PointDTO> lists = dao.expPointList(hMap);

		request.setAttribute("lists", lists);

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, "", mode);
		request.setAttribute("pageIndexList", pageIndexList);

		return "myShopping/lists/lists_expPoint";

	}

	//최근 본 상품 페이지
	@RequestMapping(value = "myShopping/myLatesBooksList.action", method = RequestMethod.GET)
	public String myLatesBooksList(HttpServletRequest request) {

		return "myShopping/myLatesBooksList";
	}

	//최근 본 상품 리스트 불러오기
	@RequestMapping(value = "myShopping/getLatesBooksList.action", method = {RequestMethod.POST,RequestMethod.GET})
	public String getLatesBooksList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String pageNum = request.getParameter("pageNum");
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "LatesBooks";
		}

		//한 페이지당 출력 건수
		int numPerPage = 12;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		//전체 출력 건수 가져오기
		totalDataCount = dao.getRecentCount(userId);

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<MainDTO> lists = dao.LatesBooksList(hMap);

		request.setAttribute("lists", lists);

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}
		else {
			String emptyMsg = "최근 본 상품이 없습니다.";
			request.setAttribute("emptyMsg", emptyMsg);
		}

		String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, mode);
		request.setAttribute("pageIndexList", pageIndexList);

		return "myShopping/lists/lists_LatesBooks";
	}

	//최근 본 상품 => 위시리스트로 이동
	@ResponseBody
	@RequestMapping(value = "myShopping/addWishList.action", method = RequestMethod.POST)
	public boolean addWishList(HttpServletRequest request, @RequestParam(value="checkArray[]") List<String> checkList) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		List<String> goWish = new ArrayList<String>();

		for(int i=0;i<checkList.size();i++) {
			String isbn = checkList.get(i);

			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("userId", userId);
			hMap.put("isbn", isbn);

			//위시리스트 중복검사함
			String result = dao.wishOverlapCheck(hMap);
			if(result==null || result.equals("")) {
				goWish.add(checkList.get(i));
				hMap.clear();
			}
			else {
				return false;
			}

		}

		//위시리스트에 넣기
		dao.addWishList(goWish, userId);

		return true;
	}


	//최근 본 상품 삭제
	@RequestMapping(value = "myShopping/deleteLatesBooks.action", method = RequestMethod.POST)
	public String deleteLatesBooks(HttpServletRequest request, @RequestParam(value="checkArray[]") List<String> checkList) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		List<String> delList = new ArrayList<String>();

		for(int i=0;i<checkList.size();i++) {
			delList.add(checkList.get(i));
		}

		dao.deleteLatesBooks(delList, userId);

		int recentCount = dao.getRecentCount(userId);
		request.getSession().setAttribute("recentCount", recentCount);

		return "redirect:/myShopping/myLatesBooksList.action";	
	}

	//위시리스트 페이지
	@RequestMapping(value = "myShopping/myWishList.action", method = RequestMethod.GET)
	public String myWishList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();
		int wishCount = dao.getWishCount(userId);
		request.setAttribute("wishCount",wishCount);

		return "myShopping/myWishList";
	}

	//위시리스트 가져오기
	@RequestMapping(value = "myShopping/getWishList.action", method = RequestMethod.POST)
	public String getWishList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();
		String pageNum = request.getParameter("pageNum");
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "wishDefault";
		}

		//한 페이지당 출력 건수
		int numPerPage = 12;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		//전체 출력 건수 가져오기
		totalDataCount = dao.getWishCount(userId);

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<MainDTO> lists = new ArrayList<MainDTO>();
		if(mode.equals("wishDefault")) {	//최근순
			lists = dao.getWishListDefault(hMap);
		}
		else if(mode.equals("wishOldDate")) {	//오래된순
			lists = dao.getWishListOld(hMap);
		}
		else if(mode.equals("wishName")) {	//상품명순
			lists = dao.getWishListName(hMap);
		}
		else if(mode.equals("wishHighPrice")) {	//높은가격순
			lists = dao.getWishListHighPrice(hMap);
		}
		else if(mode.equals("wishLowPrice")) {	//낮은가격순
			lists = dao.getWishListLowPrice(hMap);
		}
		else if(mode.equals("wishBuy")) {	//구매한상품만
			totalDataCount = dao.getWishBuyCount(userId);
			lists = dao.getWishListBuy(hMap);
		}
		else {	//mode=wishNoBuy	//구매하지않은 상품만
			totalDataCount = dao.getWishNoBuyCount(userId);
			lists = dao.getWishListNoBuy(hMap);
		}

		request.setAttribute("lists", lists);

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}
		else {
			String emptyMsg = "위시리스트에 담긴 상품이 없습니다.";
			request.setAttribute("emptyMsg", emptyMsg);
		}

		String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, mode);
		request.setAttribute("pageIndexList", pageIndexList);


		return "myShopping/lists/lists_LatesBooks";
	}

	//위시리스트 삭제하기
	@RequestMapping(value = "myShopping/deleteWish.action", method = RequestMethod.POST)
	public String deleteWish(HttpServletRequest request, @RequestParam(value="checkArray[]") List<String> checkList) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		List<String> delList = new ArrayList<String>();

		for(int i=0;i<checkList.size();i++) {
			delList.add(checkList.get(i));
		}

		dao.deleteWish(delList, userId);

		return "redirect:/myShopping/myWishList.action";

	}


	//리뷰가 있는 책 페이지
	@RequestMapping(value = "myShopping/myReviewList.action", method = RequestMethod.GET)
	public String myReviewList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		int reviewCount = dao.myReviewCount(userId);

		request.setAttribute("reviewCount", reviewCount);

		return "myShopping/myReviewList";
	}

	//리뷰가 있는 책 리스트 가져오기
	@RequestMapping(value = "myShopping/getReviewList.action", method = RequestMethod.POST)
	public String getReviewList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();
		String pageNum = request.getParameter("pageNum");
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "myReviewDefault";
		}

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		//전체 출력 건수 가져오기
		totalDataCount = dao.myReviewCount(userId);

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<MyReviewDTO> lists = dao.myReviewList(hMap);

		request.setAttribute("lists", lists);

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, mode);
		request.setAttribute("pageIndexList", pageIndexList);	

		return "myShopping/lists/lists_myReview";
	}

	//리뷰 삭제
	@RequestMapping(value = "myShopping/deleteReview.action", method = RequestMethod.POST)
	public String deleteReview(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		dao.deleteReview(reviewId);

		return "redirect:/myShopping/myReviewList.action";
	}

	//리뷰 내용 보기
	@RequestMapping(value = "myShopping/reviewArticle.action", method = RequestMethod.GET)
	public String reviewArticle(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		MyReviewDTO dto = dao.getReviewArticle(reviewId);

		dto.setContents(dto.getContents().replaceAll("\n", "<br/>"));

		request.setAttribute("dto", dto);

		return "myShopping/myReviewArticle";
	}

	//리뷰 수정하기 페이지
	@RequestMapping(value = "myShopping/reviewUpdate.action", method = RequestMethod.GET)
	public String reviewUpdate(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));
		String back = request.getParameter("back");

		MyReviewDTO dto = dao.getReviewArticle(reviewId);

		request.setAttribute("dto", dto);
		request.setAttribute("back", back);

		return "myShopping/myReviewUpdate";
	}

	//리뷰 수정 진행
	@RequestMapping(value = "myShopping/reviewUpdate_ok.action", method = RequestMethod.POST)
	public String reviewUpdate_ok(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));
		String reviewTitle = request.getParameter("reviewTitle");
		String contents = request.getParameter("contents");

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("reviewId", reviewId);
		hMap.put("reviewTitle", reviewTitle);
		hMap.put("contents", contents);

		dao.reviewUpdate(hMap);

		return "redirect:/myShopping/myReviewList.action";

	}


	//리뷰를 기다리는 책 페이지
	@RequestMapping(value = "myShopping/readyReviewList.action", method = RequestMethod.GET)
	public String readyReviewList(HttpServletRequest request) {

		return "myShopping/readyReviewList";
	}

	//리뷰를 기다리는 책 페이지 리스트 가져오기
	@RequestMapping(value = "myShopping/getReadyReviewList.action", method = RequestMethod.POST)
	public String getReadyReviewList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();
		String pageNum = request.getParameter("pageNum");
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "readyReivew";
		}

		//한 페이지당 출력 건수
		int numPerPage = 12;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		//전체 출력 건수 가져오기
		totalDataCount = dao.readyReviewCount(userId);

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<MyReviewDTO> lists = dao.readyReviewList(hMap);

		request.setAttribute("lists", lists);

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, mode);
		request.setAttribute("pageIndexList", pageIndexList);		

		return "myShopping/lists/lists_readyReview";
	}

	//간단평 페이지
	@RequestMapping(value = "myShopping/mySentenceList.action", method = RequestMethod.GET)
	public String mySentenceList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		int sentenceCount = dao.sentenceCount(userId);

		request.setAttribute("sentenceCount", sentenceCount);


		return "myShopping/mySentenceList";
	}

	//간단평 리스트 가져오기
	@RequestMapping(value = "myShopping/getSentenceList.action", method = RequestMethod.POST)
	public String getSentenceList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();
		String pageNum = request.getParameter("pageNum");
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "sentence";
		}

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		//전체 출력 건수 가져오기
		totalDataCount = dao.sentenceCount(userId);

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("userId", userId);

		List<MyReviewDTO> lists = dao.getSentenceList(hMap);

		request.setAttribute("lists", lists);

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, mode);
		request.setAttribute("pageIndexList", pageIndexList);		

		return "myShopping/lists/lists_sentence";
	}

	//간단평 작성하기 페이지 출력
	@RequestMapping(value = "myShopping/createSentence.action", method = RequestMethod.GET)
	public String createSentence(HttpServletRequest request) {

		String isbn = request.getParameter("isbn");

		MyReviewDTO dto = dao.readBook(isbn);

		request.setAttribute("dto", dto);

		return "myShopping/mySentenceCreate";

	}

	//간단평 등록하기
	@RequestMapping(value = "myShopping/sentenceCreate_ok.action", method = RequestMethod.POST)
	public String sentenceCreate_ok(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();	
		String isbn = request.getParameter("isbn");
		String sentence = request.getParameter("sentence");

		//리뷰 아이디 가져오기
		int reviewId = dao.getReviewId();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("isbn", isbn);
		map.put("sentence", sentence);
		map.put("reviewId", reviewId);

		//DB에 간단평 입력
		dao.createSentence(map);

		request.setAttribute("alertMsg", "간단평 등록이 완료되었습니다.");
		request.setAttribute("nextUrl", "/myShopping/mySentenceList.action");
		return "common/alert";

	}

	//간단평 삭제하기
	@RequestMapping(value = "myShopping/deleteSentence.action", method = RequestMethod.POST)
	public String deleteSentence(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		dao.deleteReview(reviewId);

		return "redirect:/myShopping/mySentenceList.action";

	}

	//간단평 수정하기 페이지 
	@RequestMapping(value = "myShopping/updateSentence.action", method = RequestMethod.GET)
	public String updateSentence(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		MyReviewDTO dto = dao.getReviewArticle(reviewId);

		request.setAttribute("dto", dto);

		return "myShopping/mySentenceUpdate";

	}

	//간단평 수정하기 진행
	@RequestMapping(value = "myShopping/updateSentence_ok.action", method = RequestMethod.POST)
	public String updateSentence_ok(HttpServletRequest request) {

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));
		String sentence = request.getParameter("sentence");

		dao.updateSentence(reviewId, sentence);

		return "redirect:/myShopping/mySentenceList.action";

	}


	//1:1상담내역 페이지
	@RequestMapping(value = "myShopping/myCounselHistory.action", method = RequestMethod.GET)
	public String myCounselHistory(HttpServletRequest request) {

		return "myShopping/myCounselHistory";
	}

	//1:1상담내역 불러오기
	@RequestMapping(value = "myShopping/getCounselList.action", method = RequestMethod.POST)
	public String getCounselList(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String pageNum = request.getParameter("pageNum");	
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");	
		String mode = request.getParameter("mode");

		if(mode==null || mode.equals("")) {
			mode = "counselAll";
		}

		//한 페이지당 출력 건수
		int numPerPage = 10;
		//전체 페이징 페이지
		int totalPage = 0;
		//전체 출력 건수
		int totalDataCount = 0;

		//현재 페이지
		int currentPage = 1;
		if(pageNum!=null && pageNum!="") {
			currentPage = Integer.parseInt(pageNum);
		}
		else {
			pageNum = "1";
		}

		int start = (currentPage-1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		//전체 출력 건수 가져오기
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate.equals("undefined") || toDate==null || toDate.equals("undefined")) {

			totalDataCount = dao.getAllCounselCount(userId);

			//출력 건수에 맞춰 내용 가져오기
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("start", start);
			hMap.put("end", end);
			hMap.put("userId", userId);

			List<CounselDTO> lists = dao.getAllCounselList(hMap);

			request.setAttribute("lists", lists);
		}

		//mode로(내역별조회) 리스트 불러오기
		//기본 조회, 전체 조회
		if(fromDate!=null && !fromDate.equals("undefined")) {

			if(mode.equals("undefined") || mode.equals("counselAll")) {

				totalDataCount = dao.getCounselCountByDate(userId, fromDate, toDate);

				//출력 건수에 맞춰 내용 가져오기
				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put("start", start);
				hMap.put("end", end);
				hMap.put("userId", userId);
				hMap.put("fromDate", fromDate);
				hMap.put("toDate", toDate);

				List<CounselDTO> pointList  = dao.getCounselListByDate(hMap);

				request.setAttribute("lists", pointList);

			}
			else if(mode.equals("yes")) {	//답변내역

				totalDataCount = dao.getCounselCountYes(userId, fromDate, toDate);

				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put("start", start);
				hMap.put("end", end);
				hMap.put("userId", userId);
				hMap.put("fromDate", fromDate);
				hMap.put("toDate", toDate);

				List<CounselDTO> pointList = dao.getCounselListYes(hMap);

				request.setAttribute("lists", pointList);

			}
			else if(mode.equals("no")) {	//미답변내역

				totalDataCount = dao.getCountUsePoint(userId, fromDate, toDate);

				Map<String, Object> hMap = new HashMap<String, Object>();
				hMap.put("start", start);
				hMap.put("end", end);
				hMap.put("userId", userId);
				hMap.put("fromDate", fromDate);
				hMap.put("toDate", toDate);

				List<CounselDTO> pointList = dao.getCounselListNo(hMap);

				request.setAttribute("lists", pointList);

			}

		}

		//출력 건수가 0이 아니면 페이징 작업
		if(totalDataCount!=0) {
			totalPage = ajaxPaging.getPageCount(numPerPage, totalDataCount);
		}

		//페이징 인덱스
		//1.기본 검색(조건 없음)
		if(fromDate==null || fromDate=="" || fromDate.equals("undefined")) {	//
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, "", mode);
			request.setAttribute("pageIndexList", pageIndexList);
		}
		//2.기간별 조회
		if(fromDate!=null && fromDate!="" && !fromDate.equals("undefined")) {
			String params = "'" + fromDate + "','" + toDate + "','" + mode + "'";
			String pageIndexList = ajaxPaging.pageIndexList(currentPage, totalPage, params, mode);
			request.setAttribute("pageIndexList", pageIndexList);
		}

		return "myShopping/lists/lists_counsel";
	}

	//1:1상담내역 내용보기
	@RequestMapping(value = "myShopping/counselArticle.action", method = RequestMethod.GET)
	public String counselArticle(HttpServletRequest request) {

		int consultId = Integer.parseInt(request.getParameter("consultId"));

		CounselDTO dto = dao.getCounselContents(consultId);
		dto.setContents(dto.getContents().replaceAll("\n", "<br/>"));

		request.setAttribute("dto", dto);

		return "myShopping/myCounselArticle";
	}


	//회원 탈퇴 페이지
	@RequestMapping(value = "myShopping/memberOut.action", method = RequestMethod.GET)
	public String memberOut(HttpServletRequest request) {

		return "myShopping/memberOut";
	}

	//회원 탈퇴 전 주문내역 확인(주문/반품진행중/교환진행중 상태일 때는 회원탈퇴 제한)
	@ResponseBody
	@RequestMapping(value="myShopping/memberOut_pre.action", method = RequestMethod.POST)
	public boolean memberOut_pre(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		//진행중인 주문 갯수를 반환함(반환값이 0인 경우에만 회원탈퇴 진행하도록)
		int check = dao.checkOrderStatus(userId);

		if(check>0) {
			return false;
		}
		else {
			return true;
		}

	}

	//회원 탈퇴 진행
	@RequestMapping(value = "myShopping/memberOut_ok.action", method = RequestMethod.GET)
	public String memberOut_ok(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();

		UserDTO dto = (UserDTO) session.getAttribute("userInfo");
		String userId = dto.getUserId();

		//DB 회원정보 삭제
		dao.deleteUser(userId);

		//세션 종료
		session.removeAttribute("userInfo");
		session.invalidate();

		//팝업 띄운 후 메인으로 이동
		model.addAttribute("alertMsg","회원탈퇴가 완료되었습니다.");
		model.addAttribute("nextUrl","main.action");

		return "common/alert";

	}

	//주문 취소
	@RequestMapping(value = "myShopping/cancelOrder.action", method = RequestMethod.GET)
	public String cancelOrder(HttpServletRequest request) {

		UserDTO dto = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto.getUserId();

		String orderId = request.getParameter("orderId");
		int usedValue = 0;
		
		try {
			usedValue = Integer.parseInt(request.getParameter("usedPoint"));
		} catch (Exception e) {
			usedValue = 0;
		}
		
		int point  = Integer.parseInt(request.getParameter("point"));

		//주문상태 변경
		dao.cancelOrder(orderId);

		//적립되었던 포인트 회수 및 주문시 사용했던 포인트 재적립
		
		//1.적립되었던 포인트 id가져오기
		int savePointId = dao.getSavePointId(orderId);
		
		//3.적립되었던 포인트의 leftValue를 0으로 update
		dao.pointUseUpdate(savePointId, 0);

		//4. 주문시 사용했던 포인트 다시 적립시키기
		if(usedValue!=0) {	
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("userId", userId);
			hMap.put("orderId", orderId);
			hMap.put("value", usedValue);
			hMap.put("pointId", dao.getMaxPointId()+1);
			hMap.put("leftValue", usedValue);
			dao.reSavePoint(hMap);
		}

		//5.포인트 회수내역 DB에 입력
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("userId", userId);
		hMap.put("value", point-(point*2));
		hMap.put("pointId", dao.getMaxPointId()+1);
		hMap.put("orderId", orderId);
		dao.canceledOrderPoint(hMap);
		
		//적립금 리다이렉트
		int pointValue = loginDao.getPointValue(userId);	
		request.getSession().setAttribute("pointValue", pointValue);
		//진행중 주문 건수 리다이렉트
		int orderCount = dao.getCountOrderListNormal(userId);
		request.getSession().setAttribute("orderCount", orderCount);
		
		return "redirect:/myShopping/myOrderDetail.action?orderId=" + orderId;	
		
	}

	//반품 신청
	@RequestMapping(value = "myShopping/returnOrder.action", method = RequestMethod.GET)
	public String returnOrder(HttpServletRequest request) {

		String orderId = request.getParameter("orderId");

		dao.returnOrder(orderId);


		return "redirect:/myShopping/myOrderDetail.action?orderId=" + orderId;
	}

	//구매 완료
	@RequestMapping(value = "myShopping/confirmOrder.action", method = RequestMethod.GET)
	public String confirmOrder(HttpServletRequest request) {

		String orderId = request.getParameter("orderId");

		//구매완료로 상태 변환
		dao.confirmOrder(orderId);

		return "redirect:/myShopping/myOrderDetail.action?orderId=" + orderId;
	}

	//교환 신청
	@RequestMapping(value = "myShopping/exchangeOrder.action", method = RequestMethod.GET)
	public String exchangeOrder(HttpServletRequest request) {

		String orderId = request.getParameter("orderId");

		dao.exchangeOrder(orderId);

		return "redirect:/myShopping/myOrderDetail.action?orderId=" + orderId;
	}

}
