	$(document).ready(function(){
		
		//할인금 1000원 올렸을때
		$("#reserve_point").keyup(function() {

			(function () {
			    calC();
			})()

			$("#totDiscountCost").text(FormatNumber3($("#reserve_point").val()));

		});
		
		$(".checkAll").each(function(){
			this.checked = true;
		});
	
		//전체선택&해제
		$(".checkAll").click(function(){
			if(this.checked) {
				$(".check_"+this.id).prop("checked",true);
			}else {
				$(".check_"+this.id).prop("checked",false);
			}
			
		});
		
		//결제하기
		$("#btn_order").click(function(){
			
			
			if(!($("#item03").is(":checked")) || !($("#item04").is(":checked"))){
				alert("체크 박스를 모두 체크 하셔야합니다.")
				return;
			}
			
			$("#getDone").submit();
			
		});

	});
	
		


	// 쇼핑카트 수정
	function goCart() {
		
		document.location.href = "shopCartList.action";
		
	}

	// 금액 계산
	function calC() {

		var bookCnt = 0;
		var giftCnt = 0;
		var bandiGiftCnt = 0;
		var storeCost = 0;

		/* 소득공제상품 */
		var bandiDeductionTotCnt = 0;
		var bandiDeductionTotProdCnt = 0;
		var bandiDeductionTotMarketSale = 0;
		var bandiDeductionTotCost = 0;
		var bandiDeductionTotDc = 0;
		var bandiDeductionTotSaleCost = 0;
		var bandiDeductionTotDeliCost = 0;
		var bandiDeductionTotOrdCost = 0;
		var bandiDeductionTotPoint = 0;

		bandiDeductionTotCnt = $(".check_bandiDeduction:checked").size();

		for (i = 0; i < bandiDeductionTotCnt; i++) {
			var seq = $(".check_bandiDeduction:checked").eq(i).val();
			var cnt = parseInt($("#orderCnt_" + seq).val(), 10);
			bandiDeductionTotProdCnt += cnt;
			bandiDeductionTotMarketSale += parseInt($("#marketSaleVal_" + seq).val(), 10)
					* cnt;
			bandiDeductionTotSaleCost += parseInt($("#saleCostVal_" + seq).val(), 10)
					* cnt;
			bandiDeductionTotCost += parseInt($("#marketSaleVal_" + seq).val(), 10)
					* cnt;
			bandiDeductionTotPoint += parseInt($("#prodPointVal_" + seq).val(), 10)
					* cnt;
			//bandiDeductionTotDc += parseInt($("#marketSaleVal_" + seq).val(), 10)
					//* cnt * 1 / parseInt($("#discountRate_" + seq).val(), 10);
		}

		// 배송비용
		if (bandiDeductionTotSaleCost < 10000) {
			bandiDeductionTotDeliCost = 2000;
		}
		
		
		
		

		// 총비용(+배달비용)
		bandiDeductionTotOrdCost = bandiDeductionTotSaleCost
				+ bandiDeductionTotDeliCost;

		$("#bandiDeduction_totOrdCnt").text("수량: " + (bandiDeductionTotCnt) + "종(" + (bandiDeductionTotProdCnt)
						+ "개)");
		$("#bandiDeduction_totSaleCost").text(
				FormatNumber3(bandiDeductionTotSaleCost));
		$("#bandiDeduction_totDeliCost").text(
				FormatNumber3(bandiDeductionTotDeliCost));
		$("#bandiDeduction_totOrdCost").text(
				FormatNumber3(bandiDeductionTotOrdCost));
		$("#bandiDeduction_totPoint").text(FormatNumber3(bandiDeductionTotPoint));
		$("#pop_deduction_price").html(
				FormatNumber3(bandiDeductionTotOrdCost) + "원");

		$("#totOrdCnt").text(
				"수량: " + (bandiDeductionTotCnt) + "종(" + (bandiDeductionTotProdCnt)
						+ "개)");
		$("#totDiscountCost").text(FormatNumber3(bandiDeductionTotDc));
		$("#totMarketSale").text(FormatNumber3(bandiDeductionTotCost));
		$("#totDeliCost").text(FormatNumber3(bandiDeductionTotDeliCost));
		if($("#reserve_point").val() != null){
			$("#totOrdCost").text(FormatNumber3(bandiDeductionTotOrdCost - $("#reserve_point").val()));
			$(".finalCashCost").text(FormatNumber3(bandiDeductionTotOrdCost - $("#reserve_point").val()));
		}else{
			$("#totOrdCost").text(FormatNumber3(bandiDeductionTotOrdCost));
			$(".finalCashCost").text(FormatNumber3(bandiDeductionTotOrdCost));
		}
		
		$(".finalProdPoint").text(FormatNumber3(bandiDeductionTotPoint));
		
		/*if($("#reserve_point").val() >= $("#reserve_point_max").val()){
			alert("소지하고 있는 포인트보다 초과된 포인트 입니다.")
			document.getElementById('reserve_point').value = 0;
			document.getElementById('reserve_point').focus();
			location.reload();
		}*/
		
		
		
		//$("#totDiscountcost").text(FormatNumber3($("#reserve_point").val()));
		
		
	}
	

	function popUpRules2(){
		window.open("https://www.bandinlunis.com/global/rules_privacy2.html","popUpRules","width=600, height=680, status=no, scrollbars=yes,resizable=no, menubar=no");
	}
	function popUpRules3(){
		window.open("https://www.bandinlunis.com/global/rules_privacy3.html","popUpRules","width=600, height=680, status=no, scrollbars=yes,resizable=no, menubar=no");
	}
	
	
	
	
	
	
	



