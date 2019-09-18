package com.spring.webproject.controller;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.webproject.dao.SearchDAO;
import com.spring.webproject.dto.SearchDTO;
import com.spring.webproject.util.MyUtil;

import net.sf.json.JSONArray;
import oracle.net.aso.h;

@Controller
public class SearchController {

	@Autowired
	@Qualifier("searchDAO")
	SearchDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@RequestMapping(value = "/search/search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String search(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String cp = req.getContextPath();
		String searchValue = req.getParameter("searchValue");
		String categoryId = req.getParameter("categoryId");
		if (searchValue == null) {
			searchValue = "";
		}
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		int dataCount =0;
		if(categoryId==null|| categoryId.equals("")) {		
			dataCount = dao.getBookCount(searchValue);
		}else if(categoryId!=null) {					
			dataCount = dao.getBookCount2(searchValue, categoryId);			
		}
		
		//System.out.println(searchValue);
		String pageNum = req.getParameter("pageNum");
		int currentPage = 1;

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);
		
		int numPerpage =20;
		int totalPage = myUtil.getPageCount(numPerpage, dataCount);
		if (currentPage > totalPage)
			currentPage = totalPage;
		
		int start = (currentPage - 1) * numPerpage + 1;
		int end = currentPage * numPerpage;
		
		//
		String param ="";
		if (!searchValue.equals("")) {
			
			param += "searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		if(categoryId!=null) {
			param += "&categoryId="+categoryId;
		}
		
		//System.out.println(param);
		String listUrl = cp + "/search/search.do";
		if (!param.equals("")) {
			listUrl = listUrl + "?" + param;
		}
		//System.out.println(totalPage);
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
		req.setAttribute("pageIndexList", pageIndexList);
		//

		
		
		
		if(categoryId ==null) {
			List<SearchDTO> searchBook = dao.getSearchBook(start, end, searchValue);
			req.setAttribute("searchBook", searchBook);
		}else {
			List<SearchDTO> searchBook = dao.getCategoryBook(start, end, searchValue, categoryId);
			req.setAttribute("searchBook", searchBook);
			req.setAttribute("categoryId",categoryId);
		}	
		
		
		List<SearchDTO> bookTitle = dao.getBookTitle(searchValue);
		/*System.out.println("ddddddd");*/
		List<SearchDTO> categoryList = dao.getCategory(searchValue);
		
		req.setAttribute("categoryList", categoryList);
		
		req.setAttribute("bookTitle", bookTitle);
		req.setAttribute("dataCount", dataCount);
		
		req.setAttribute("searchValue", searchValue);
		return "search/search";
	}
	
	@RequestMapping(value = "/search/search2.do", produces="application/json;charset=UTF-8",method = { RequestMethod.GET, RequestMethod.POST })
	public String search1(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String result = req.getParameter("bookTitle");
		String searchValue = req.getParameter("searchValue");
		req.setAttribute("searchValue",searchValue);		
		
		String cp = req.getContextPath();				
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		//return "search/search1";
		return "search/search3";
	}
	@RequestMapping(value = "/search/autocomplete.do",method = { RequestMethod.GET, RequestMethod.POST },produces="application/json;charset=UTF-8")
	public String search12(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		String result = req.getParameter("searchValue");
		
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		//System.out.println("searchValue="+result);
		
		List<SearchDTO> list = dao.getBookTitle(result); //result값이 포함되어 있는 emp테이블의 네임을 리턴
		//System.out.println("bookt :" +list.get(0).getBookTitle());
		//System.out.println("isbn :"+list.get(0).getIsbn());
		req.setAttribute("list", list);
//		JSONArray array = new JSONArray();
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println(list.get(i).getBookTitle());
//			array.add(list.get(i).getBookTitle());
//		}
//
//		PrintWriter out = resp.getWriter();
//
//		//req.setAttribute("ja", ja);
//		out.print(array.toString());
		
		return "search/search3";
		
	
	}
	




	
}
