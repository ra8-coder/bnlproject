package com.spring.webproject.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.webproject.dao.QuestionDAO;
import com.spring.webproject.dto.CounselDTO;
import com.spring.webproject.dto.QuestionDTO;
import com.spring.webproject.dto.UserDTO;
import com.spring.webproject.util.MyUtil;

@Controller
public class QuestionController {

	@Autowired
	@Qualifier("questionDAO")
	QuestionDAO dao;

	@Autowired
	MyUtil myUtil;

	@RequestMapping(value = "/help/helpMain.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String helpMain(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		// String cp = req.getContextPath();
		String key = "1";
		
		UserDTO info = (UserDTO) req.getSession().getAttribute("userInfo");
		if (info != null) {
			String userId = info.getUserId();
			String userName = info.getUserName();
			String email = info.getEmail();
			req.setAttribute("userId", userId);
			req.setAttribute("userName", userName);
			req.setAttribute("email", email);			
		}
			

		List<QuestionDTO> lists = dao.getList();
		List<QuestionDTO> topLists = dao.topView();
		List<QuestionDTO> topDate = dao.topDate();

		req.setAttribute("key", key);
		req.setAttribute("lists", lists);
		req.setAttribute("topLists", topLists);
		req.setAttribute("topDate", topDate);

		return "help/help";
	}

	@RequestMapping(value = "/help/helpIndex.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String helpIndex(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		String cp = req.getContextPath();
		String key = "2";
		String parentsTypeId = req.getParameter("parentsTypeId");
		String typeId = req.getParameter("typeId");
		
		UserDTO info = (UserDTO) req.getSession().getAttribute("userInfo");
		if (info != null) {
			String userId = info.getUserId();
			String userName = info.getUserName();
			String email = info.getEmail();
			req.setAttribute("userId", userId);
			req.setAttribute("userName", userName);
			req.setAttribute("email", email);			
		}
		
		int questionId;
		if (req.getParameter("questionId") == null || req.getParameter("questionId").equals("")) {
			questionId = 0;
		} else {
			questionId = Integer.parseInt(req.getParameter("questionId"));
		}

		if (req.getParameter("typeId") == null || req.getParameter("typeId").equals("")) {

		} else {
			typeId = req.getParameter("typeId");			
			List<QuestionDTO> subTypeLists = dao.getSubTypeList(typeId);
			req.setAttribute("subTypeLists", subTypeLists);
		}

		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		String searchKey = "subject";
		String searchValue = req.getParameter("searchValue");

		if (searchValue == null) {
			searchValue = "";
		}

		searchValue = URLDecoder.decode(searchValue, "UTF-8");

		System.out.println(searchValue);

		int dataCount = 0;
		if (parentsTypeId.equals("0")) {
			dataCount = dao.getDataCount(searchKey, searchValue);
			System.out.println("if" + searchKey + "/" + searchValue);
		} else {
			dataCount = dao.getDataCount2(searchKey, searchValue, parentsTypeId);

		}

		System.out.println("dataCount:");

		int numPerPage = 10;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		System.out.println("typeId : " + typeId);
		
		List<QuestionDTO> lists = dao.getList();
		System.out.println("parentsTypeId : " + parentsTypeId);
		List<QuestionDTO> typeLists = dao.getTypeList(start, end, searchKey, searchValue, parentsTypeId);
		System.out.println("parentsTypeId : " + parentsTypeId);
		System.out.println("typeLists.size :" +typeLists.size());
		List<QuestionDTO> type0Lists = dao.getType0List(start, end, searchKey, searchValue);	
		System.out.println(parentsTypeId);
		List<QuestionDTO> lists3 = dao.getSubTypeId(parentsTypeId);		
		System.out.println(lists3.size());		
		// List<QuestionDTO> subTypeLists = dao.getSubTypeList(subTypeId);
		List<QuestionDTO> topLists = dao.topView();
		
		String param = "parentsTypeId=" + parentsTypeId;
		if (!searchValue.equals("")) {

			param += "&searchKey=" + searchKey;
			param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		

		String listUrl = cp + "/help/helpIndex.action";
		if (!param.equals("")) {
			listUrl = listUrl + "?" + param;
		}
		System.out.println("total:");
		System.out.println(totalPage);
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		if (questionId != 0) {
			dao.updateHitCount(questionId);
		}
		
		req.setAttribute("key", key);
		req.setAttribute("lists", lists);
		req.setAttribute("typeLists", typeLists);
		System.out.println("typeLists size : " +typeLists.size());
		req.setAttribute("type0Lists", type0Lists);
		// req.setAttribute("subTypeLists", subTypeLists);
		req.setAttribute("lists3", lists3);
		req.setAttribute("parentsTypeId", parentsTypeId);
		req.setAttribute("typeId", typeId);
		req.setAttribute("questionId", questionId);
		req.setAttribute("topLists", topLists);
		req.setAttribute("pageIndexList", pageIndexList);
		req.setAttribute("dataCount", dataCount);

		return "help/help";
	}

	@RequestMapping(value = "/help/helpCounsel.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String helpCounsel(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		String parentsTypeId = req.getParameter("parentsTypeId");
		String key = "3";

		UserDTO info = (UserDTO) req.getSession().getAttribute("userInfo");
		if (info != null) {
			String userId = info.getUserId();
			String userName = info.getUserName();
			String email = info.getEmail();
			req.setAttribute("userId", userId);
			req.setAttribute("userName", userName);			
		}
		else {
			return "/webproject/login.action";
		}
		
		if (req.getParameter("parentsTypeId") == null || req.getParameter("parentsTypeId").equals("")) {

		} else {
			parentsTypeId = req.getParameter("parentsTypeId");
			List<QuestionDTO> lists3 = dao.getSubTypeId(parentsTypeId);
			req.setAttribute("lists3", lists3);
		}

		List<QuestionDTO> lists = dao.getList();
		// List<QuestionDTO> lists3 = dao.getSubTypeId(typeId);
		List<QuestionDTO> topLists = dao.topView();
		List<QuestionDTO> topDate = dao.topDate();

		req.setAttribute("parentsTypeId", parentsTypeId);
		req.setAttribute("key", key);
		req.setAttribute("lists", lists);
		// req.setAttribute("lists3", lists3);
		req.setAttribute("topLists", topLists);
		req.setAttribute("topDate", topDate);

		return "help/help";
	}

	@RequestMapping(value = "/help/helpMyCounsel.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String helpMyCounsel(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		
		
		// String cp = req.getContextPath();
		String parentsTypeId = req.getParameter("parentsTypeId");	
		String key = "4";
		
		UserDTO info = (UserDTO) req.getSession().getAttribute("userInfo");
		if (info != null) {
			String userId = info.getUserId();
			String userName = info.getUserName();
			String email = info.getEmail();
			req.setAttribute("userId", userId);
			req.setAttribute("userName", userName);
			req.setAttribute("email", email);			
		}
		
		List<QuestionDTO> lists = dao.getList();
		List<QuestionDTO> topLists = dao.topView();
		List<QuestionDTO> topDate = dao.topDate();

		req.setAttribute("key", key);
		req.setAttribute("lists", lists);
		req.setAttribute("topLists", topLists);
		req.setAttribute("topDate", topDate);		
		req.setAttribute("parentsTypeId", parentsTypeId);

		return "help/help";
	}

	@RequestMapping(value = "/help/helpCounsel_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String helpCounsel_ok(CounselDTO dto, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		UserDTO info = (UserDTO) req.getSession().getAttribute("userInfo");
		if (info != null) {
			String userId = info.getUserId();
			String userName = info.getUserName();
			String email = info.getEmail();
			req.setAttribute("userId", userId);
			req.setAttribute("userName", userName);
			req.setAttribute("email", email);			
		}
		
		int maxNum = dao.maxNum();
		dto.setConsultId(maxNum + 1);
		System.out.println(maxNum);
		

		dao.insertCounsel(dto);

		return "redirect:/help/helpMain.action";
	}
}
