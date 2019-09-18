<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<script src="<%=cp%>/resources/js/swiper_min.js"></script>
<script src="<%=cp%>/resources/js/swiper.js"></script>

<script type="text/javascript">

	function showWindow(addr,width) {
		
		var url = "/webproject/" + addr + ".action";
		var wH = 750;
		var wW = width;
		var wL = (window.screen.width/2)-(wW/2);
		var wT = (window.screen.height/2)-(wH/2);
		
		var setting = 'toolbar=no,menubar=no,status=no,resizable=no,location=no,top='+wT+',left='+wL+',height='+wH+',width=' +wW;
		
		window.open(url,"반디앤루니스 인터넷서점",setting);
	
	} 

</script>

<div class="footer" style="width: 1100px;">
	<div class="copyright" style="width: 1100px;">
		<div class="f_menu" style="width: 1100px;">
			<ul>
				<li>
					<a href="<%=cp%>/company.action">회사소개</a>
				</li>
				<li>
					<font>채용정보</font>
				</li>
				<li>
					<a onclick="javascript:showWindow('rules/rulesInfo',1100)"
					style="cursor: pointer;">이용약관</a>
				</li>
				<li>
					<a onclick="javascript:showWindow('rules/rules_privacy',700)"
					style="color: #7B5A2B; cursor:pointer; font-weight: bold;">개인정보 처리방침</a>
				</li>
				<li>
					<font>출판사를위한안내</font>
				</li>
				<li>
					<font>광고안내</font>
				</li>
				<li>
					<font>SCM</font>
				</li>
				<li>
					<font>제휴/입점문의</font>
				</li>
			</ul>
			<div class="sns_btn">
				<a href="https://www.instagram.com/bandinlunis_book/" target="_blank">
					<button class="btn_inst"></button>
				</a>
				<a href="http://blog.naver.com/bandinbook" target="_blank">
					<button class="btn_nb"></button>
				</a>
			</div>
		</div>
		<div class="f_logo" style="width: 300px;">
			<img src="<%=cp%>/resources/image/main/logo_footer.gif">
		</div>
		<div class="f_info">
			<div class="f_info_box">
				<div class="fib_customer">
					<strong>고객문의</strong>: <strong class="tel">1577-4030</strong>
					<span class="tel_time">(발신자 부담) 평일 9시~18시(토요일,일요일,공휴일 휴무)</span>
					<span> | Fax: 02-3703-2499</span>
					<a href="<%=cp%>/help/helpCounsel.action">
						<img src="<%=cp%>/resources/image/main/btn_footer_customer.gif" style="vertical-align: middle;">
					</a>
				</div>
				<div class="fib_company">
					<ul class="company_info" style="width: 238px;">
						<li>회사명 : (주)서울문고</li>
						<li>대표이사 : 김동국</li>
						<li>개인정보 관리 책임자 : 이해권</li>
					</ul>
					<ul class="company_info" style="width: 480px; border-left: 1px solid #eeeeee; padding-left: 23px;">
						<li>소재지 : 서울 서초구 강남대로 331 광일프라자빌딩 14층</li>
						<li>사업자 등록번호 : 120-81-02543 </li>
						<li>
							<span>통신판매업 신고번호 : 제2016-서울서초-1668호</span> 
						</li>
					</ul>
				</div>
				<div class="fib_cr">
					copyright ⓒ 2016 BANDI&LUNI'S All Rights Reserved
				</div>
			</div>	
		</div>
	</div>
	<div class="copy_award">
		<img src="<%=cp%>/resources/image/main/footer_award.jpg">
	</div>
</div>
