
//png file
function setPng24(obj) {
	obj.width=obj.height=1;
	obj.className=obj.className.replace(/\bpng24\b/i,'');
	obj.style.filter =
	"progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
	obj.src=''; 
	return '';
}


//z-index 
function selView(idName)	
{
	var	obj_lay	= document.getElementById("" + idName + "");

	obj_lay.style.display="block";
	obj_lay.style.zIndex="10";
}

function selHidden(idName)	
{
	var	obj_lay	= document.getElementById("" + idName + "");

	obj_lay.style.display="none";
	obj_lay.style.zIndex="1";
}


// 롤링 banner 
function	tabView(idName,n)	{
	obj_tab = document.getElementById("" + idName + "");
	obj_tab	= obj_tab.getElementsByTagName("a");
	
	for (var i=1; i<=obj_tab.length ; i++)	{
		obj_con = document.getElementById("" + idName + "_con" + i);
		
		if(i==n)	{
			obj_con.style.display="block";
			obj_tab[i-1].className="";
		}
		else	{
			obj_con.style.display="none";
			obj_tab[i-1].className="";
		}
	}
}

// 레이어팝업 오픈 앤 클로즈
function openCon(id) {
	var id_obj = document.getElementById(id);
	id_obj.style.display = "";
}

function closeCon(id) {
	var id_obj = document.getElementById(id);
	id_obj.style.display = "none";
}


/* gnb type select */
function stView(idName)	
{
	arrowBtn_obj = document.getElementById("arrowBtn");	
	var	obj_lay	= document.getElementById("" + idName + "");

	obj_lay.style.display="block";
	obj_lay.style.zIndex="10";
	arrowBtn_obj.src="/images/common/btn_gnbSearchA_up.gif"
}

function stHidden(idName)	
{	
	arrowBtn_obj = document.getElementById("arrowBtn");	
	var	obj_lay	= document.getElementById("" + idName + "");

	obj_lay.style.display="none";
	obj_lay.style.zIndex="1";
	arrowBtn_obj.src="/images/common/btn_gnbSearchA_down.gif"
}


/* 제품 over시 icon */
function icoShow(nameV)	{
	 obj_O  = document.getElementById(nameV);
	 obj_O.style.display="block";
}

function icoHidden(nameV)	{
	//alert(nameV);
	 obj_O  = document.getElementById(nameV);
	 obj_O.style.display="none";
}

/* over시 레이어 2개 */
function twoShow(nameA,nameB)	{
	 obj_O  = document.getElementById(nameA);
	 obj_1  = document.getElementById(nameB);
	 obj_O.style.display="block";	
	 obj_1.style.display="block";
}

function twoHidden(nameA,nameB)	{
	 obj_O  = document.getElementById(nameA);
	 obj_1  = document.getElementById(nameB);
	 obj_O.style.display="none";
	 obj_1.style.display="none";
}

/* 토글 레이어  추가-jj 081027*/

    var infoToggleLayer;
	function popLayer(id){
		var o = document.getElementById(id);
	//alert(o);
		if (o.style.visibility=="visible"){	
			o.style.visibility = "hidden";
		} else {
			if(infoToggleLayer) infoToggleLayer.style.visibility = "hidden";
			o.style.visibility = "visible";
			infoToggleLayer = o;
		}
	}

	function layerVisible(id){
		var o = document.getElementById(id);
		if(!o) return;
		o.style.visibility = "visible";
	}

	function popHidden(id){
		var o = document.getElementById(id);
		if(!o) return;
		o.style.visibility = "hidden";
	}

	function Hide_prevHelpLayer()
	{
		if(infoToggleLayer) infoToggleLayer.style.visibility = "hidden";
	}

