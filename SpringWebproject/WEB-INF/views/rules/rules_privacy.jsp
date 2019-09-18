<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
%>
<!DOCTYPE html>
<html>
<head>
<title>반디앤루니스 인터넷서점</title>

<style type="text/css">
	div {width: 640px;}
	dl {display: block; margin-block-start: 1em; margin-block-end: 1em; margin-inline-start: 0px; margin-inline-end: 0px;}
	dt {font-weight: bold; margin: 10px;}
	dd {font-size: 10pt;}
	ul {list-style: none; margin: 0px; padding: 0px;}
	li {padding: 0px; font-size: 10pt;}
	th {background: #f7f7f7; padding: 5px; font-size: 11pt; width: 100px; height: 30px; border-bottom: 1px solid #d8d8d8;}
	td {padding: 10px 5px; border-bottom: 1px solid #d8d8d8; border-left: 1px solid #d8d8d8;}
	.table_t_line {border-top: 1px solid #d8d8d8; text-align: center; width: 600px; font-size: 10pt;}
	
</style>

</head>
<body>

<div>
	<dl style="margin-top: 15px;">
		<dt>개인정보의 수집 항목 및 목적 </dt>
		<dd>
			<ul>
				<li>
					<p></p>
						<table cellspacing="0" cellpadding="0" class="table_t_line">
						  <tbody>
						  <tr>
						    <th width="100" height="30" bgcolor="#efefef"><strong>회원유형</strong></th>
						    <th width="255" bgcolor="#efefef"><strong>필수항목</strong></th>
						    <th width="255" bgcolor="#efefef"><strong>목적</strong></th>
						    <th width="100" bgcolor="#efefef"><strong>보유 및 이용기간</strong></th>
						  </tr>
						  <tr>
						    <td rowspan="2" style="border-left: none;">일반</td>
						    <td>I-pin, 이름, 생년월일, 성별, 아이디, 비밀번호</td>
						    <td>본인확인, 회원관리, 아이디/비밀번호 찾기</td>
						    <td rowspan="8">회원탈퇴시<br>또는<br>(제 6항에 관계법령에 따름)</td>
						  </tr>
						  <tr>
						  	<td style="border-left:1px solid #d8d8d8">휴대폰번호, 이메일, 수신동의(이메일, SMS)</td>
						  	<td>배송/결제 진행사항 통보, 이벤트 안내 및 상품 정보 발송</td>
						  </tr>					  
						  </tbody>
						 </table>
					<p></p>					
				</li>
			</ul>
		</dd>
		
		<dt>개인정보의 보유 및 이용기간</dt>
		<dd>
			<p>"반디앤루니스"가 이용자의 개인정보를 수집하는 경우 그 보유기간은 회원가입 하신 후 해지(탈퇴신청, 직권탈퇴 포함)시까지 입니다. 또한, 다음과 같은 경우 개인정보의 수집 목적 또는 제공받은 목적이 달성되면, 개인정보를 파기합니다.</p>
			<ul>
				<li>(1) 결제정보의 경우, 대금의 완제일 또는 채권소멸시효기간의 만료된 때</li>
				<li>(2) 배송정보의 경우, 물품 또는 서비스가 인도되거나 제공된 때</li>
				<li>(3) 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 이 경우 "반디앤루니스"는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.
				<p>
				① 계약 또는 청약철회 등에 관한 기록<br>
				 - 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
				 - 보존 기간 : 5년<br>
				② 대금결제 및 재화 등의 공급에 관한 기록<br>
				 - 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
				 - 보존 기간 : 5년<br>
				③ 소비자의 불만 또는 분쟁처리에 관한 기록<br>
				 - 보존 근거 : 전자상거래 등에서의 소비자보호에 관한 법률<br>
				 - 보존 기간 : 3년<br>
				④ 본인 확인에 관한 기록<br>
				 - 보존 근거 : 정보통신망 이용촉진 및 정보보호 등에 관한 법률<br>
				 - 보존 기간 : 6개월<br>
				⑤ 웹사이트 방문기록<br>
				 - 보존 근거 : 통신비밀보호법<br>
				 - 보존 기간 : 3개월
				 </p>
				</li>
			</ul> 
		</dd>
	</dl>

</div>



</body>
</html>