package com.spring.webproject.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.webproject.dao.BookSectionsDAO;
import com.spring.webproject.dao.BooksDAO;
import com.spring.webproject.dao.LoginDAO;
import com.spring.webproject.dto.AuthorDTO;
import com.spring.webproject.dto.BookSectionsDTO;
import com.spring.webproject.dto.BooksDTO;
import com.spring.webproject.dto.BooksImageDTO;
import com.spring.webproject.dto.CateDTO;
import com.spring.webproject.dto.CateDTO2;
import com.spring.webproject.dto.ReviewDTO;
import com.spring.webproject.dto.SimpleReviewDTO;
import com.spring.webproject.dto.UserDTO;
import com.spring.webproject.dto.WareHouseDTO;
import com.spring.webproject.util.CookieUtil;
import com.spring.webproject.util.MyUtil;

@Controller
public class BookController {

	@Autowired
	BooksDAO dao;

	@Autowired
	LoginDAO dao2;

	@Autowired
	LoginDAO dao3;

	@Autowired
	@Qualifier("bookSectionsDAO")
	BookSectionsDAO raDao;

	@Autowired
	MyUtil myUtil;

	@Autowired
	MyUtil raMyUtil;

	List<String> bookCookie; // 최근 본 상품 쿠키 리스트

	// 소설
	@RequestMapping(value = "/book_novel.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_novel(HttpServletRequest request, HttpServletResponse response) {
		String cp = request.getContextPath();
		String pageNum = request.getParameter("pageNum");
		int categoryId = 1;
		request.setAttribute("categoryId", 1);
		// 대분류
		CateDTO dto_Main = dao.getReadCate(categoryId);

		request.setAttribute("dto_Main", dto_Main); // 메인 분류 이름

		// 중분류
		List<CateDTO2> lists = dao.getReadCateList2(dto_Main.getCategoryId());

		Iterator<CateDTO2> iterator = lists.iterator();

		while (iterator.hasNext()) {
			CateDTO2 dto2 = iterator.next();

			List<CateDTO> lists3 = dao.getReadCateList3(dto2.getCategoryId());
			Iterator<CateDTO> it = lists3.iterator();
			while (it.hasNext()) {
				CateDTO dto = it.next();

				dto2.setLastNode(dto);

			}
		}

		request.setAttribute("lists", lists);

		int currentPage = 1;

		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}

		// 베스트 셀러

		int cateStart = categoryId;

		int cateEnd = dao.getCateEnd(categoryId);
		/* discountRate */
		int fromDiscount = 0;
		int toDiscount = 0;
		if (request.getParameter("fromDiscount") == null || request.getParameter("fromDiscount").equals("")) {
			fromDiscount = 0;
		} else {
			fromDiscount = Integer.parseInt(request.getParameter("fromDiscount"));
		}
		if (request.getParameter("toDiscount") == null || request.getParameter("toDiscount").equals("")) {
			toDiscount = 100;
		} else {
			toDiscount = Integer.parseInt(request.getParameter("toDiscount"));
		}

		// 페이징 처리

		int numPerPage = 10;

		int lists_Discount_Num = dao.getLists_Discount_Num(cateStart, cateEnd, fromDiscount, toDiscount);
		request.setAttribute("lists_Discount_Num", lists_Discount_Num);
		int totalPage = raMyUtil.getPageCount(numPerPage, lists_Discount_Num);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		request.setAttribute("start", start);
		request.setAttribute("end", end);

		List<BookSectionsDTO> lists_Best = dao.getLists_Best(cateStart, cateEnd);
		request.setAttribute("lists_Best", lists_Best);

		// 새로나온 책
		List<BookSectionsDTO> lists_New = dao.getLists_New(cateStart, cateEnd);
		request.setAttribute("lists_New", lists_New);

		int lists_New_Num = dao.getLists_New_Count(cateStart, cateEnd);
		request.setAttribute("lists_New_Num", lists_New_Num);

		// 할인도서

		List<BookSectionsDTO> lists_Discount = dao.getLists_Discount(cateStart, cateEnd, fromDiscount, toDiscount,
				start, end);

		request.setAttribute("lists_Discount", lists_Discount);

		String bnlBSListUrl = cp + "/book_novel.action";

		String pageIndexList = raMyUtil.pageIndexListforDiscount2(currentPage, totalPage, bnlBSListUrl, categoryId);

		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);

		return "/books/cate/novel/book_novel";
	}

	// 자기계발 도서
	@RequestMapping(value = "/book_self_improvement.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_self_improvement(HttpServletRequest request, HttpServletResponse response) {

		String cp = request.getContextPath();

		int categoryId = 255;
		request.setAttribute("categoryId", 255);
		// 대분류
		CateDTO dto_Main = dao.getReadCate(categoryId);

		request.setAttribute("dto_Main", dto_Main); // 메인 분류 이름

		// 중분류
		List<CateDTO2> lists = dao.getReadCateList2(dto_Main.getCategoryId());

		Iterator<CateDTO2> iterator = lists.iterator();

		while (iterator.hasNext()) {
			CateDTO2 dto2 = iterator.next();

			List<CateDTO> lists3 = dao.getReadCateList3(dto2.getCategoryId());
			Iterator<CateDTO> it = lists3.iterator();
			while (it.hasNext()) {
				CateDTO dto = it.next();

				dto2.setLastNode(dto);

			}
		}

		request.setAttribute("lists", lists);

		// 베스트 셀러
		int cateStart = categoryId;

		int cateEnd = dao.getCateEnd(categoryId);

		List<BookSectionsDTO> lists_Best = dao.getLists_Best(cateStart, cateEnd);
		request.setAttribute("lists_Best", lists_Best);

		// 새로나온 책
		List<BookSectionsDTO> lists_New = dao.getLists_New(cateStart, cateEnd);
		request.setAttribute("lists_New", lists_New);

		int lists_New_Num = dao.getLists_New_Count(cateStart, cateEnd);
		request.setAttribute("lists_New_Num", lists_New_Num);

		// 할인도서
		/* discountRate */
		int fromDiscount = 0;
		int toDiscount = 0;
		if (request.getParameter("fromDiscount") == null || request.getParameter("fromDiscount").equals("")) {
			fromDiscount = 0;
		} else {
			fromDiscount = Integer.parseInt(request.getParameter("fromDiscount"));
		}
		if (request.getParameter("toDiscount") == null || request.getParameter("toDiscount").equals("")) {
			toDiscount = 100;
		} else {
			toDiscount = Integer.parseInt(request.getParameter("toDiscount"));
		}

		return "/books/cate/self_improvement/book_self_improvement";
	}

	// 장르소설
	@RequestMapping(value = "/genre_fiction.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String genre_fiction(HttpServletRequest request, HttpServletResponse response) {

		String pageNum = request.getParameter("pageNum");
		int categoryId = 91;
		request.setAttribute("categoryId", 91);
		// 대분류
		CateDTO dto_Main = dao.getReadCate(categoryId);

		request.setAttribute("dto_Main", dto_Main); // 메인 분류 이름

		// 중분류
		List<CateDTO2> lists = dao.getReadCateList2(dto_Main.getCategoryId());

		Iterator<CateDTO2> iterator = lists.iterator();

		while (iterator.hasNext()) {
			CateDTO2 dto2 = iterator.next();

			List<CateDTO> lists3 = dao.getReadCateList3(dto2.getCategoryId());
			Iterator<CateDTO> it = lists3.iterator();
			while (it.hasNext()) {
				CateDTO dto = it.next();

				dto2.setLastNode(dto);

			}
		}

		request.setAttribute("lists", lists);

		String cp = request.getContextPath();

		// 베스트 셀러
		int cateStart = categoryId;

		int cateEnd = dao.getCateEnd(categoryId);

		List<BookSectionsDTO> lists_Best = dao.getLists_Best(cateStart, cateEnd);
		request.setAttribute("lists_Best", lists_Best);

		// 새로나온 책
		List<BookSectionsDTO> lists_New = dao.getLists_New(cateStart, cateEnd);
		request.setAttribute("lists_New", lists_New);

		int lists_New_Num = dao.getLists_New_Count(cateStart, cateEnd);
		request.setAttribute("lists_New_Num", lists_New_Num);

		// 할인도서
		/* discountRate */
		int fromDiscount = 0;
		int toDiscount = 0;
		if (request.getParameter("fromDiscount") == null || request.getParameter("fromDiscount").equals("")) {
			fromDiscount = 0;
		} else {
			fromDiscount = Integer.parseInt(request.getParameter("fromDiscount"));
		}
		if (request.getParameter("toDiscount") == null || request.getParameter("toDiscount").equals("")) {
			toDiscount = 100;
		} else {
			toDiscount = Integer.parseInt(request.getParameter("toDiscount"));
		}
		// 페이징 처리

		int lists_Discount_Num = dao.getLists_Discount_Num(cateStart, cateEnd, fromDiscount, toDiscount);
		request.setAttribute("lists_Discount_Num", lists_Discount_Num);

		return "/books/cate/novel/genre_fiction";
	}

	// 도서 상세 페이지
	@RequestMapping(value = "/book_info.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_info(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, InterruptedException {
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		BooksDTO dto = dao.getReadBookData(isbn);

		AuthorDTO dto2 = dao.getReadAuthorData(isbn);
		// 카테고리 아이디 가져오기

		int categoryId = dao.getCategoryId(isbn);
		int cateStart = categoryId;
		int cateEnd = dao.getCateEnd(categoryId);

		// 카테고리 이름 가져오기

		CateDTO cateDTO1 = dao.getReadCate(categoryId);
		System.out.println("카테고리 아이디 : " + cateDTO1.getCategoryId());
		System.out.println("부모 카테고리 아이디 : " + cateDTO1.getParentsId());
		if (cateDTO1 != null) {
			CateDTO cateDTO2 = dao.getReadCate(cateDTO1.getParentsId());
			if (cateDTO2 != null) {
				CateDTO cateDTO3 = dao.getReadCate(cateDTO2.getParentsId());

				request.setAttribute("cateDTO3", cateDTO3);
			}
			request.setAttribute("cateDTO2", cateDTO2);
		}
		request.setAttribute("cateDTO1", cateDTO1);
		List<BookSectionsDTO> lists_Best3 = dao.getLists_Best3(cateStart, cateEnd);
		request.setAttribute("lists_Best3", lists_Best3);

		String book_image = dao.getReadBookImage(isbn); // 북 커버 이미지

		request.setAttribute("book_image", book_image); // 북 커버 이미지

		UserDTO dto3 = (UserDTO) request.getSession().getAttribute("userInfo");
		if (dto3 != null) {
			String userId = dto3.getUserId();
			request.setAttribute("userId", userId);

			// 이미 recentList에 있는 책인지 확인
			int check = dao3.checkRecentBook(userId, isbn);
			// check==0 -> DB에 없는책
			// insert실행
			if (check == 0) {
				dao3.recentBookAdd(userId, isbn);
			} else {
				dao3.updateRecentBookTime(userId, isbn);
			}
			Thread.sleep(100);
		}
		int reviewNum = dao.getReviewDataCount(isbn);
		int simplereviewNum = dao.getSimpleReivewDataCount(isbn);
		request.setAttribute("simplereviewNum", simplereviewNum);

		WareHouseDTO dto4 = dao.getWareHouseData(isbn); // 창고 재고 받아오기

		request.setAttribute("dto4", dto4); // 웨어하우스 재고 넘겨주기

		request.setAttribute("dto", dto); // 책 정보 넘겨주기
		String introduction = dto.getIntroduction();
		if (introduction == null) {
			request.setAttribute("intro1", "추가 예정");
		} else if (introduction.length() < 200) {
			String intro1 = introduction;
			request.setAttribute("intro1", intro1);
		} else {
			String intro1 = introduction.substring(0, 200);
			String intro2 = introduction.substring(200);
			request.setAttribute("intro1", intro1);
			request.setAttribute("intro2", intro2);
		}

		String contents = dto.getTableOfContents();

		if (contents == null) {
			request.setAttribute("cont1", "추가 예정");
		} else if (contents.length() < 200) {
			String cont1 = contents;
			request.setAttribute("cont1", cont1);
		} else {
			String cont1 = contents.substring(0, 200);
			String cont2 = contents.substring(200);
			request.setAttribute("cont1", cont1);
			request.setAttribute("cont2", cont2);
		}

		request.setAttribute("dto2", dto2); // 작가 정보 넘겨주기

		request.setAttribute("isbn", isbn); // 책 번호 넘겨주기

		request.setAttribute("reviewNum", reviewNum);

		// 쿠키쿠키

		CookieUtil cookieutil = new CookieUtil();

		try {

			cookieutil.setCookie("bookCookie", book_image, 1, request, response);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/books/book_info";
	}

	// 도서 리뷰 페이지
	@RequestMapping(value = "/book_review.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_review(HttpServletRequest request, HttpServletResponse response) {
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기
		request.setAttribute("isbn", isbn); // 도서 번호 넘겨주기

		String pageNum = request.getParameter("pageNum"); // 페이지 번호
		String userId = "";
		UserDTO dto3 = (UserDTO) request.getSession().getAttribute("userInfo");
		if (dto3 != null) {
			userId = dto3.getUserId();
			request.setAttribute("userId", userId);
		}

		int reviewNum = dao.getReviewDataCount(isbn); // 게시물 개수

		int currentPage = 1; // 현재페이지

		if (pageNum != null)
			currentPage = Integer.parseInt(pageNum);

		int numPerPage = 5;
		int totalPage = myUtil.getPageCount(numPerPage, reviewNum);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<ReviewDTO> lists = dao.getReadReviewList(start, end, isbn);
		String listUrl = "/webproject/book_review.action?isbn=" + isbn;
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);

		int check_review = dao.getReviewCheck(isbn, userId);

		request.setAttribute("check_review", check_review);
		request.setAttribute("lists", lists);
		request.setAttribute("reviewNum", reviewNum);
		request.setAttribute("pageIndexList", pageIndexList);
		return "/books/review/book_review";

	}

	// 도서 리뷰 상세 페이지

	@RequestMapping(value = "/book_review_main.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_review_main(HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기
		int reviewId = Integer.parseInt(request.getParameter("reviewId")); // 리뷰 게시물 번호

		ReviewDTO dto = dao.getReadReviewData(reviewId);

		dao.updateHitCount(reviewId);

		request.setAttribute("dto", dto);

		ReviewDTO preDto = dao.preReadReviewData(isbn, reviewId);
		ReviewDTO nextDto = dao.nextReadReviewData(isbn, reviewId);

		request.setAttribute("preDto", preDto);
		request.setAttribute("nextDto", nextDto);
		request.setAttribute("isbn", isbn);
		return "/books/review/book_review_main";

	}

	// 도서 리뷰 작성 페이지
	@RequestMapping(value = "/book_review_created.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_review_created(HttpServletRequest request, HttpServletResponse response) {
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		BooksDTO dto = dao.getReadBookData(isbn);

		UserDTO dto3 = (UserDTO) request.getSession().getAttribute("userInfo");
		if (dto3 != null) {
			String userName = dto3.getUserName();
			request.setAttribute("userName", userName);

		}

		String book_image = dao.getReadBookImage(isbn); // 북 커버 이미지

		request.setAttribute("book_image", book_image); // 북 커버 이미지
		request.setAttribute("dto", dto);
		request.setAttribute("isbn", isbn);

		return "/books/review/book_review_created";
	}

	// 도서 리뷰 작성_프로세스
	@RequestMapping(value = "/book_review_created_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_review_created_ok(ReviewDTO dto, HttpServletRequest request, HttpServletResponse response) {
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		UserDTO dto3 = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto3.getUserId();
		int rate = Integer.parseInt(request.getParameter("rate"));

		int maxReviewId = dao.getMaxNum(); // 리뷰게시물 최대번호
		System.out.println("게시물 맥스넘버 : " + maxReviewId);
		System.out.println("유저 아이디 : " + userId);
		dto.setIsbn(isbn);
		dto.setReviewId(maxReviewId + 1);
		dto.setUserId(userId);
		dto.setContents(dto.getContents());

		System.out.println("isbn = " + dto.getIsbn());
		System.out.println("maxReviewId = " + dto.getReviewId());
		System.out.println("userId = " + userId);
		System.out.println("contents = " + dto.getContents());
		System.out.println("reviewTitle = " + dto.getReviewTitle());

		dao.insertReviewData(dto); // 리뷰게시물 등록
		System.out.println("게시물등록완료");

		System.out.println("rate : " + rate);
		dao.insertReviewRateData(isbn, userId, rate); // 평점 등록
		System.out.println("평점 등록완료");

		dao.insertReviewThumbUpData(userId, dto.getReviewId());

		return "redirect:/book_info.action?isbn=" + isbn;

	}

	// 도서 간단평
	@RequestMapping(value = "/book_simpleReview.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_simpleReview(HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		UserDTO dto3 = (UserDTO) request.getSession().getAttribute("userInfo");
		int check_simpleReview = 0;

		if (dto3 != null) {
			String userId = dto3.getUserId();
			request.setAttribute("userId", userId);
			check_simpleReview = dao.getSimpleReviewCheck(isbn, userId);

		}
		request.setAttribute("check_simpleReview", check_simpleReview);
		System.out.println("간단평 체크 : " + check_simpleReview);
		int simplereviewNum = dao.getSimpleReivewDataCount(isbn);

		request.setAttribute("simplereviewNum", simplereviewNum);
		request.setAttribute("isbn", isbn);

		return "/books/review/book_simpleReview";

	}

	// 간단평 데이터 가져오기
	@RequestMapping(value = "/book_simpleReview_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_simpleReview_ok(HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		List<SimpleReviewDTO> lists = dao.getReadSimpleReviewList(isbn);

		request.setAttribute("lists", lists);

		return "/books/review/book_simpleReview_ok";
	}

	// 도서 미리보기
	@RequestMapping(value = "/book_preview.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_preview(HttpServletRequest request, HttpServletResponse response) {

		String cp = request.getContextPath();
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		List<BooksImageDTO> lists = dao.getReadBookImageData(isbn); // 책 미리보기 이미지
		BooksDTO dto2 = dao.getReadBookData(isbn); // 책정보

		// 도서 객체 전송
		request.setAttribute("lists", lists);
		request.setAttribute("dto2", dto2);

		return "/books/book_preview";
	}

	// 로그인 안되어 있을경우 로그인
	@RequestMapping(value = "/login2.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String login2(HttpServletRequest request, HttpServletResponse response) {
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		request.setAttribute("isbn", isbn);
		return "books/book_login2";
	}

	@RequestMapping(value = "/login_ok2.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginProcess2(HttpServletRequest request) {

		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		String returnUrl = "";
		String userId = request.getParameter("user_id");
		String userPwd = request.getParameter("userPwd");

		UserDTO dto = dao2.login(userId, userPwd);

		if (dto != null) { // 로그인 성공

			// 회원 적립금 정보 불러오기
			int pointValue = dao2.getPointValue(userId);

			// 회원 등급 정보 불러오기

			// 세션 - dto, pointValue 올리기
			request.getSession().setAttribute("userInfo", dto);
			request.getSession().setAttribute("pointValue", pointValue);
			request.getSession().removeAttribute("message");
			returnUrl = "redirect:/book_info.action?isbn=" + isbn + "#sub02";

		} else { // 로그인 실패

			returnUrl = "redirect:/login2.action?isbn=" + isbn;
			request.getSession().setAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}

		return returnUrl;
	}

	// 공감하기 1
	@RequestMapping(value = "/book_review_vote.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_review_vote(HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기

		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		dao.updateThumbUp(reviewId);

		System.out.println("공감수 업데이트 완료");

		return "redirect:/book_review_main.action?isbn=" + isbn + "&reviewId=" + reviewId;

	}

	// 공감하기 2
	@RequestMapping(value = "/book_simpleReviewVote.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_simpleReviewVote(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("공감공감");
		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기
		System.out.println("isbn: " + isbn + "입니다.");
		int reviewId = Integer.parseInt(request.getParameter("reviewId"));

		dao.updateThumbUp(reviewId);

		System.out.println("공감수 업데이트 완료2");

		return "redirect:/book_simpleReview.action?isbn=" + isbn;
	}

	// 도서 간단평 등록
	@RequestMapping(value = "/enroll_simpleReview.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String enroll_simpleReview(SimpleReviewDTO dto, HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn"); // 책 고유번호 가져오기
		String sentence = request.getParameter("sentence");

		UserDTO dto3 = (UserDTO) request.getSession().getAttribute("userInfo");
		String userId = dto3.getUserId();
		int maxReviewId = dao.getMaxNum(); // 리뷰게시물 최대번호
		dto.setIsbn(isbn);
		dto.setReviewId(maxReviewId + 1);
		dto.setUserId(userId);
		dto.setSentence(sentence);
		System.out.println(isbn + " / " + (maxReviewId + 1) + " / " + userId + " / " + dto.getSentence());
		System.out.println("유저 아이디 : " + userId);
		System.out.println("리뷰 번호 : " + maxReviewId + 1);

		dao.insertSimpleReviewData(dto); // 간단평 등록
		System.out.println("간단평 등록1 완료");
		dao.insertSimpleReviewData2(userId, (maxReviewId + 1));
		System.out.println("간단평 등록2 완료");

		System.out.println(userId + " / " + (maxReviewId + 1));

		return "redirect:/book_simpleReview.action?isbn=" + isbn;
	}

	// 도서 카테고리 메인
	@RequestMapping(value = "/book_cate.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_cate(HttpServletRequest request, HttpServletResponse response) {

		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		request.setAttribute("categoryId", categoryId);
		// 대분류
		CateDTO dto_Main = dao.getReadCate(categoryId);

		request.setAttribute("dto_Main", dto_Main); // 메인 분류 이름

		// 중분류
		List<CateDTO2> lists = dao.getReadCateList2(dto_Main.getCategoryId());

		Iterator<CateDTO2> iterator = lists.iterator();

		while (iterator.hasNext()) {
			CateDTO2 dto2 = iterator.next();

			List<CateDTO> lists3 = dao.getReadCateList3(dto2.getCategoryId());
			Iterator<CateDTO> it = lists3.iterator();
			while (it.hasNext()) {
				CateDTO dto = it.next();

				dto2.setLastNode(dto);

			}
		}

		request.setAttribute("lists", lists);

		// ---------------------------------------------------------------------------

		String cp = request.getContextPath();

		String pageNum = request.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}

		// 베스트 셀러
		int cateStart = categoryId;

		int cateEnd = dao.getCateEnd(categoryId);

		List<BookSectionsDTO> lists_Best = dao.getLists_Best(cateStart, cateEnd);
		request.setAttribute("lists_Best", lists_Best);

		// 할인도서
		/* discountRate */
		int fromDiscount = 0;
		int toDiscount = 0;
		if (request.getParameter("fromDiscount") == null || request.getParameter("fromDiscount").equals("")) {
			fromDiscount = 0;
		} else {
			fromDiscount = Integer.parseInt(request.getParameter("fromDiscount"));
		}
		if (request.getParameter("toDiscount") == null || request.getParameter("toDiscount").equals("")) {
			toDiscount = 100;
		} else {
			toDiscount = Integer.parseInt(request.getParameter("toDiscount"));
		}
		// 페이징 처리

		int lists_Discount_Num = dao.getLists_Discount_Num(cateStart, cateEnd, fromDiscount, toDiscount);
		request.setAttribute("lists_Discount_Num", lists_Discount_Num);

		String bnlBSListUrl = cp + "/book_cate.action";
		// 페이징 처리
		int numPerPage = 10;

		int totalPage = raMyUtil.getPageCount(numPerPage, lists_Discount_Num);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		// ****************************************
		List<BookSectionsDTO> lists_Discount = dao.getLists_Discount(cateStart, cateEnd, fromDiscount, toDiscount,
				start, end);
		request.setAttribute("lists_Discount", lists_Discount);

		request.setAttribute("start", start);
		request.setAttribute("end", end);

		// ****************************************
		String pageIndexList = raMyUtil.pageIndexListforDiscount(currentPage, totalPage, bnlBSListUrl, categoryId);

		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);

		return "books/cate/book_cate";
	}

	@RequestMapping(value = "/book_New.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_New(HttpServletRequest request, HttpServletResponse response) {

		int categoryId = Integer.parseInt(request.getParameter("categoryId"));

		int cateStart = categoryId;

		int cateEnd = dao.getCateEnd(categoryId);

		String cp = request.getContextPath();

		String pageNum = request.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}

		// 새로나온 책
		List<BookSectionsDTO> lists_New = dao.getLists_New(cateStart, cateEnd);
		request.setAttribute("lists_New", lists_New);

		int lists_New_Num = dao.getLists_New_Count(cateStart, cateEnd);
		request.setAttribute("lists_New_Num", lists_New_Num);

		String bnlBSListUrl = cp + "/book_New.action";
		// 페이징 처리
		int numPerPage = 10;

		int totalPage = raMyUtil.getPageCount(numPerPage, lists_New_Num);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		// ****************************************

		String pageIndexList = raMyUtil.pageIndexListforDiscount(currentPage, totalPage, bnlBSListUrl, categoryId);

		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);

		return "books/book_New";
	}

	@RequestMapping(value = "/book_Discount.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String book_Discount(HttpServletRequest request, HttpServletResponse response) {

		int categoryId = Integer.parseInt(request.getParameter("categoryId"));

		int cateStart = categoryId;

		int cateEnd = dao.getCateEnd(categoryId);

		String cp = request.getContextPath();

		String pageNum = request.getParameter("pageNum");

		int currentPage = 1;

		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}

		// 할인도서
		/* discountRate */
		int fromDiscount = 0;
		int toDiscount = 0;
		if (request.getParameter("fromDiscount") == null || request.getParameter("fromDiscount").equals("")) {
			fromDiscount = 0;
		} else {
			fromDiscount = Integer.parseInt(request.getParameter("fromDiscount"));
		}
		if (request.getParameter("toDiscount") == null || request.getParameter("toDiscount").equals("")) {
			toDiscount = 100;
		} else {
			toDiscount = Integer.parseInt(request.getParameter("toDiscount"));
		}

		int lists_Discount_Num = dao.getLists_Discount_Num(cateStart, cateEnd, fromDiscount, toDiscount);
		request.setAttribute("lists_Discount_Num", lists_Discount_Num);

		String bnlBSListUrl = cp + "/book_Discount.action";

		// 페이징 처리
		int numPerPage = 10;

		int totalPage = raMyUtil.getPageCount(numPerPage, lists_Discount_Num);

		if (currentPage > totalPage)
			currentPage = totalPage;

		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		List<BookSectionsDTO> lists_Discount = dao.getLists_Discount(cateStart, cateEnd, fromDiscount, toDiscount,
				start, end);
		request.setAttribute("lists_Discount", lists_Discount);

		// ****************************************

		String pageIndexList = raMyUtil.pageIndexListforDiscount2(currentPage, totalPage, bnlBSListUrl, categoryId);

		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);

		return "books/book_Discount";
	}

}
