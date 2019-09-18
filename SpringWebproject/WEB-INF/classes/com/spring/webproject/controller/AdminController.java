package com.spring.webproject.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.UploadContext;
import org.apache.log4j.Logger;
import org.apache.log4j.xml.SAXErrorHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.webproject.dao.AdminDAO;
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
import com.spring.webproject.util.Criteria;
import com.spring.webproject.util.FileUtil;
import com.spring.webproject.util.PageMaker;
import com.spring.webproject.util.SearchCriteria;
import com.spring.webproject.util.SearchDateCriteria;

@Controller
public class AdminController {

	@Autowired
	AdminDAO dao;

	@Autowired
	private ServletContext servletContext;

	@RequestMapping(value = "/admin.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String home() {

		return "admin/admin_goods";
	}

	// users
	@RequestMapping(value = "/admin_users.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String users(Model model, SearchCriteria cri) {

		List<AdminUsersDTO> userList = dao.getUserList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getUserTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("userList", userList);

		return "admin/admin_users";
	}

	@RequestMapping(value = "/admin_users_delete.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String usersDel(HttpServletRequest request, SearchCriteria cri) {

		dao.delUser((String) request.getParameter("userId"));

		String url = "/admin_users.action?page=" + cri.getPage();

		if (cri.getSearchKey() != null || cri.getSearchKey() == "") {
			url += "&searchKey=" + cri.getSearchKey();
			if (cri.getSearchValue() != null) {
				url += "&searchValue=" + cri.getSearchValue();
			} else {
				url = "/admin_users.action";
			}
		}

		return "redirect:/" + url;
	}

	// goods
	@RequestMapping(value = "/admin_goods.action", method = { RequestMethod.GET })
	public String goods() {
		return "admin/admin_goods";
	}

	@RequestMapping(value = "/admin_goods_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String goodsOK(AdminBooksDTO dto, MultipartFile file, FileUtil fileutil) throws IOException {

		String bookImagePath = servletContext.getRealPath("/") + "\\resources\\image\\book";

		// System.out.println(servletContext.getRealPath("/")+"\\resources\\image\\book");

		dto.setBookImage(fileutil.fileNameMaker(file.getOriginalFilename()));

		File target = new File(bookImagePath, dto.getBookImage());

		FileCopyUtils.copy(file.getBytes(), target);

		dao.insertBook(dto);
		dao.insertBookSpecial(dto);
		dao.insertBookCategory(dto);
		dao.insertBookImage(dto);
		dao.insertQuantity(dto);

		return "redirect:/admin_goods.action";
	}
	
	@RequestMapping(value = "/admin_books_ok.action", method = { RequestMethod.GET,RequestMethod.POST })
	public String booksOK(Model model, SearchCriteria cri) {
		
		if (cri.getSearchValue() == null || cri.getSearchValue().equals("")) {
			cri.setSearchValue(null);
		}
		if (cri.getSearchKey() == null || cri.getSearchKey().equals("")) {
			cri.setSearchKey(null);
		}
		
		
		
		List<AdminBooksDTO> bookList = dao.getBooklist(cri);
		
		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getbooksTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("bookList", bookList);
		
		
		return "admin/admin_books_ok";
	}
	
	

	// author
	@RequestMapping(value = "/admin_search_author.action", method = { RequestMethod.GET })
	public String searchAuthor(Model model, SearchCriteria cri) {

		cri.setNumPerPage(5);

		List<AdminAuthorDTO> authorList = dao.getAuthorList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getAuthorTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("authorList", authorList);

		return "admin/admin_search_author";
	}

	// translator
	@RequestMapping(value = "/admin_search_translator.action", method = { RequestMethod.GET })
	public String searchTranslator(Model model, SearchCriteria cri) {

		cri.setNumPerPage(5);

		List<AdminTranslatorDTO> translatorList = dao.getTranslatorList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getTranslatorTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("translatorList", translatorList);

		return "admin/admin_search_translator";
	}

	// warehouse
	@RequestMapping(value = "/admin_search_warehouse.action", method = { RequestMethod.GET })
	public String searchWarehouse(Model model, SearchCriteria cri) {

		cri.setNumPerPage(5);

		List<AdminWarehouseDTO> warehouseList = dao.getWarehouseList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getTranslatorTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("warehouseList", warehouseList);

		return "admin/admin_search_warehouse";
	}

	@RequestMapping(value = "/admin_warehouse.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String warehouse() {

		return "admin/admin_warehouse";
	}

	@RequestMapping(value = "/admin_warehouse_ok.action", method = { RequestMethod.POST })
	public String warehouseOK(AdminWarehouseDTO dto) {

		dao.insertWarehouse(dto);

		return "redirect:/admin_warehouse.action";
	}
	
	@RequestMapping(value = "/admin_warehouseList_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String warehouseListOK(SearchCriteria cri, Model model) {
		
		if (cri.getSearchValue() == null || cri.getSearchValue().equals("")) {
			cri.setSearchValue(null);
		}
		if (cri.getSearchKey() == null || cri.getSearchKey().equals("")) {
			cri.setSearchKey(null);
		}
		
		List<AdminWarehouseDTO> warehouseList = dao.getWarehouseList(cri);
		
		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getWarehouseTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("warehouseList", warehouseList);
		
		return "admin/admin_warehouseList_ok";
	}
	

	// quantity
	@RequestMapping(value = "/admin_quantity.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String quantity(Model model, SearchCriteria cri) {

		List<AdminQuantityDTO> quantityList = dao.getQuantityList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getQuantityTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("quantityList", quantityList);

		return "admin/admin_quantity";
	}

	// category

	@RequestMapping(value = "/admin_categoryList.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String categoryList(Model model, AdminCategoryDTO dto) {

		List<AdminCategoryDTO> categoryList = dao.getCategoryList(dto);

		model.addAttribute("categoryList", categoryList);

		return "admin/admin_categoryList";
	}

	@RequestMapping(value = "/admin_category.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String category(Model model, AdminCategoryDTO dto) {

		List<AdminCategoryDTO> categoryList = dao.getCategoryList(dto);

		model.addAttribute("categoryList", categoryList);

		return "admin/admin_category";
	}

	@RequestMapping(value = "/admin_category_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String categoryOK(Model model, AdminCategoryDTO dto, AdminBooksDTO bookDTO) {

		try {
			dao.insertCategory(dto);

			if (bookDTO.getIsbn() != null) {
				dao.insertBookCategory(bookDTO);
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "redirect:/admin_category.action";
		}

		return "redirect:/admin_category.action";
	}
	
	
	@RequestMapping(value = "/admin_categorylist_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String categoryListOK(Model model, SearchCriteria cri) {

		if (cri.getSearchValue() == null || cri.getSearchValue().equals("")) {
			cri.setSearchValue(null);
		}
		if (cri.getSearchKey() == null || cri.getSearchKey().equals("")) {
			cri.setSearchKey(null);
		}
		
		List<AdminCategoryDTO> categoryList = dao.CategoryList(cri);
		
		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getCategoryTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("categoryList", categoryList);
		
		
		return "admin/admin_categorylist_ok";
	}
	

	// consultation
	@RequestMapping(value = "/admin_consultation.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String consultation(Model model, HttpServletRequest request, SearchDateCriteria cri) {

		if (cri.getAnswerCheck() == null || cri.getAnswerCheck().equals("")) {
			cri.setAnswerCheck(null);
		}
		if (cri.getToDate() == null || cri.getToDate().equals("")) {
			cri.setToDate(null);
		}
		if (cri.getFromDate() == null || cri.getFromDate().equals("")) {
			cri.setFromDate(null);
		}
		if (cri.getSearchValue() == null || cri.getSearchValue().equals("")) {
			cri.setSearchValue(null);
		}
		if (cri.getSearchKey() == null || cri.getSearchKey().equals("")) {
			cri.setSearchKey(null);
		}
		List<AdminCounsultationDTO> consultationList = dao.getCounsultationList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getCounsultationTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("consultationList", consultationList);

		return "admin/admin_consultation";
	}

	// bookimage
	@RequestMapping(value = "/admin_image.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String image(AdminBooksDTO dto, MultipartHttpServletRequest multipartFile) throws IOException {

		String sampleImagePath = servletContext.getRealPath("/") + "\\resources\\book_image\\sample";

		List<MultipartFile> fileList = multipartFile.getFiles("file");

		Iterator<MultipartFile> iter = fileList.iterator();

		while (iter.hasNext()) {

			MultipartFile temp = iter.next();

			File tempTarget = new File(sampleImagePath, temp.getOriginalFilename());

			dto.setBookImage(temp.getOriginalFilename());

			FileCopyUtils.copy(temp.getBytes(), tempTarget);

			dao.insertBookImage(dto);

		}

		return "redirect:/admin_goods.action";
	}

	// author translator
	@RequestMapping(value = "/admin_author.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String image(Model model, SearchCriteria cri) {

		cri.setNumPerPage(5);

		List<AdminAuthorDTO> authorList = dao.getAuthorList(cri);

		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getAuthorTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("authorList", authorList);

		return "admin/admin_author";
	}

	@RequestMapping(value = "/admin_author_ok.action", method = { RequestMethod.POST })
	public String imageOK(HttpServletRequest request, AdminAuthorDTO author, AdminTranslatorDTO translator,
			MultipartFile file) throws IOException {

		String path = servletContext.getRealPath("/") + "\\resources";
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String select = request.getParameter("select");

		System.out.println(author.getCategory());
		System.out.println(translator.getCategory());

		if (select.equals("author")) {

			author.setAuthorId(id);
			author.setAuthorName(name);
			author.setImage(file.getOriginalFilename());

			dao.insertAuthor(author);

			File target = new File(path + "\\author_image", file.getOriginalFilename());

			FileCopyUtils.copy(file.getBytes(), target);

		} else if (select.equals("translator")) {

			translator.setTranslatorId(id);
			translator.setTranslatorName(name);
			translator.setImage(file.getOriginalFilename());

			dao.insertTranslator(translator);

			File target = new File(path + "\\translator_image", file.getOriginalFilename());

			FileCopyUtils.copy(file.getBytes(), target);

		}

		return "redirect:/admin_author.action";
	}

	// order
	@RequestMapping(value = "/admin_order.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String adminOrder() {
		
		return "admin/admin_order";
	}

	@RequestMapping(value = "/admin_order_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String adminOrderOk(SearchDateCriteria cri, Model model) {
		
		cri.setNumPerPage(5);
		
		
		if (cri.getToDate() == null || cri.getToDate().equals("")) {
			cri.setToDate(null);
		}
		if (cri.getFromDate() == null || cri.getFromDate().equals("")) {
			cri.setFromDate(null);
		}
		if (cri.getSearchValue() == null || cri.getSearchValue().equals("")) {
			cri.setSearchValue(null);
		}
		
		List<AdminOrderDTO> orderList = dao.getOrderList(cri);
		
		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getOrderTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("orderList", orderList);
		
		return "admin/admin_order_ok";
	}
	
	//shipments
	@RequestMapping(value = "/admin_shipments_ok.action", method = { RequestMethod.POST, RequestMethod.GET })
	public String adminShipmentsOk(SearchCriteria cri, Model model) {
		
		cri.setNumPerPage(5);
		
		if (cri.getSearchValue() == null || cri.getSearchValue().equals("")) {
			cri.setSearchValue(null);
		}
		
		List<AdminShipmentsDTO> shipmentsList = dao.getShipmentsList(cri);
		
		PageMaker pageMaker = new PageMaker(cri);
		pageMaker.setTotalDataCount(dao.getShipmentsTotalCount(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("shipmentsList", shipmentsList);
		
		return "admin/admin_shipments_ok";
	}
	
	
	

}
