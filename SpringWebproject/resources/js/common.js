/*document.domain = "127.0.0.1:8080/webproject";*/
var hostDomain = "127.0.0.1:8080/webproject";
var hostDomains = "127.0.0.1:8080/webproject";
var blogDomain = "127.0.0.1:8080/webproject";


/*************************************
//숫자만 입력 : onkeydown="numberKeyPress(event);"
2017-01-12 추가
*************************************/

function numberKeyPress(e) {
    var key;

    if(window.event)
         key = window.event.keyCode; //IE
    else
         key = e.which; //firefox

    // backspace or delete or tab
    var event; 
    if (key == 0 || key == 8 || key == 46 || key == 9){
        event = e || window.event;
        if (typeof event.stopPropagation != "undefined") {
            event.stopPropagation();
        } else {
            event.cancelBubble = true;
        }   
        return ;
    }

    if (key < 48 || (key > 57 && key < 96) || key > 105 || e.shiftKey) {
        e.preventDefault ? e.preventDefault() : e.returnValue = false;
    }
}




/*************************************
//특수문자&숫자체크 : onkeypress="Keycode(event);"
2017-01-10 추가
*************************************/
function Keycode(e){
    var code = (window.event) ? event.keyCode : e.which; //IE : FF - Chrome both
    if(code == 32) nAllow(e); //공백
    if( (code > 32 &&  code < 65) || (code > 90 && code < 97) || (code > 122 && code < 127) ){
    	alert('특수문자와 숫자는 사용할수 없습니다.');
    	nAllow(e);
    }
 
   
    
}
/*************************************
//키입력불가
2017-01-10 추가
*************************************/
function nAllow(e){

    if(navigator.appName!="Netscape"){ //for not returning keycode value
        event.returnValue = false;  //IE ,  - Chrome both
    }else{
        e.preventDefault(); //FF ,  - Chrome both
    }        
}


/*************************************
//숫자인지체크 : onkeypress="javascript:goNumCheck(event);"
*************************************/
function goNumCheck(e){

    var keyNum;
    
    if (window.event) {
        keyNum = event.keyCode;
    } 
    else if (e.which) {
        keyNum = e.which;
    }
    
    if (keyNum != 8 && keyNum != 13 && (keyNum < 45 || keyNum > 57) && (keyNum < 96 || keyNum > 105)) {	// 우측 키패드 숫자버튼 체크 추가
        alert("숫자만 입력 가능합니다.");
        
        if (window.event) {
            event.returnValue = false;
        } 
        else if (e.which) {
            e.preventDefault();
        }
    }
}

/*************************************
// copy & paste 방지 : onkeydown="javascript:preventPaste(event);"
*************************************/
function preventPaste(e) {

    var ctrlKey;
    var keyNum;
    
    if (window.event) {
        ctrlKey = event.ctrlKey;
        keyNum = event.keyCode;
    } 
    else if (e.which) {
        ctrlKey = e.ctrlKey;
        keyNum = e.which;
    }
    
    if (ctrlKey == true && keyNum == 86) {
        if (window.event) {
            event.returnValue = false;
        } 
        else if (e.which) {
            e.preventDefault();
        }
    }
}

/*************************************
// 전체선택 (checkBox)
*************************************/
function check_all(obj, bool)
{
    if (typeof(obj) != "object")
    {
        return;
    }

    if (obj.length)
    {   
        for (i = 0;i < obj.length;i++) 
        {
                obj[i].checked = bool;
        }
    }
    else
    {
        obj.checked = bool; 
    }
}

/*************************************
** 숫자값만 입력케 하는 함수
*************************************/
function onlyNumber(){     
    if((event.keyCode < 48) || (event.keyCode > 57))
        event.returnValue=false;
}

/*************************************
** 특정문자(chars) 집합
*************************************/
var uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var lowercase = "abcdefghijklmnopqrstuvwxyz"; 
var number    = "0123456789";

/*************************************
** 입력값이 특정문자(chars) 집합만으로 되어있는지 체크
*************************************/
function containsCharsOnly(srcStr,chars) {
    for (var i = 0; i < srcStr.length; i++) {
       if (chars.indexOf(srcStr.charAt(i)) == -1)
           return false;
    }
    return true;
}

/*************************************
** 입력값이 숫자(Number)만으로 되어있는지 체크
*************************************/
function isNumber(srcStr) {
    return containsCharsOnly(srcStr, number);
}

function numBerCheck(myname,myform){
    if(!containsCharsOnly(myname, number)){
        alert('숫자만 가능합니다.');
    }
}

/*************************************
** 입력값이 알파벳,숫자로 되어있는지 체크
*************************************/
function isAlphaNum(srcStr) {
    return containsCharsOnly(srcStr,uppercase+lowercase+number);
}

/*************************************
** 입력값이 한글만 사용못함 체크
*************************************/
function ishangle(s) {
    for (i = 0; i < s.length; i++) {
        if ((s.charCodeAt(i) != 32) && (s.charCodeAt(i) < 127)) {           
        }else{
            return true;
        }
    }
}

/*************************************
** 입력값이 숫자,대시(-)로 되어있는지 체크
*************************************/
function isNumDash(input) {
    return containsCharsOnly(input,number+"-");
}

/*************************************
** 입력 문자열 길이를 체크 
**      -->  한글은 2바이트로 적용
*************************************/
function CheckLength(srcStr)
{
    if (typeof srcStr == "undefined")
        return true

    var byteLength = 0;
    for (var i = 0; i < srcStr.value.length; i++) {
        var oneChar = escape(srcStr.value.charAt(i));
        if ( oneChar.length == 1 ) {
            byteLength ++;
        } else if (oneChar.indexOf("%u") != -1) {
            byteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            byteLength += oneChar.length/3;
        }
    }
    return byteLength;
}

/*************************************
** 입력 문자열 길이를 체크 
**      -->  한글은 3바이트로 적용
*************************************/
function CheckLength2(srcStr)
{
    if (typeof srcStr == "undefined")
        return true

    var byteLength = 0;
    for (var i = 0; i < srcStr.value.length; i++) {
        var oneChar = escape(srcStr.value.charAt(i));
        if ( oneChar.length == 1 ) {
            byteLength ++;
        } else if (oneChar.indexOf("%u") != -1) {
            byteLength += 3;
        } else if (oneChar.indexOf("%") != -1) {
            byteLength += oneChar.length/3;
        }
    }
    return byteLength;
}

/*************************************
** 컴마(",") 제거
*************************************/
function removeComma( strSrc )
{
    return strSrc.replace(/,/gi,"");
}

/*************************************
** 하이픈("-") 제거
*************************************/
function removeHyphen( strSrc )
{
    return strSrc.replace(/-/gi,"");
}

/*************************************
** String 에서 왼쪽 빈공백문자 제거 script
*************************************/
function LTrim(strSrc) {
    return strSrc.replace(/^\s+/,'');
}

/*************************************
** String 에서 오른쪽 빈공백문자 제거 script
*************************************/
function RTrim(strSrc) {
    return strSrc.replace(/\s+$/,'');
}

/*************************************
** String 에서 양쪽공백문자 제거 script
*************************************/
function Trim(strSrc) {
    var strLTrim = strSrc.replace(/^\s+/,'');
    return strLTrim.replace(/\s+$/,'');
}

/*************************************
** String 에서 모든 공백문자 제거 script
*************************************/
function Del_Space( strSrc )
{
    return strSrc.replace(/ /g, '');
}

/*************************************
** 금액 입력시 "," 자동 입력 & 우측 정렬 
*************************************/
function Add_MoneyComma( strSrc )
{
    var newVal;
    var i; 
    var factor; 
    var su; 
    var SpaceSize = 0;

    factor = strSrc.length % 3; 
    su     = (strSrc.length - factor) / 3;
    newVal    =  strSrc.substring(0,factor);

    for(i=0; i < su ; i++)
    {
        if((factor == 0) && (i == 0))       // "XXX" 인경우
        {
            newVal += strSrc.substring(factor+(3*i), factor+3+(3*i));  
        }
        else
        {
            newVal += ","  ;
            newVal += strSrc.substring(factor+(3*i), factor+3+(3*i));  
        }
    }

    return newVal; 
}

/*************************************
** 날짜형식이 올바른지 검사
*************************************/
function checkDate(strDate)
{
    var arrDate = new Array(3);
    var chkDate
    
    if (strDate.indexOf("-") != -1) {
        arrDate = strDate.split("-");
    }
    else if (strDate.indexOf("/") != -1) {
        arrDate = strDate.split("/");
    }
    else {
        if (strDate.length != 8) {
            return false;
        }
        arrDate[0] = strDate.substring(0,4);
        arrDate[1] = strDate.substring(4,6);
        arrDate[2] = strDate.substring(6,8);
    }

    if (arrDate.length != 3) {
        return false;
    }
    
    chkDate = new Date(arrDate[0] + "/" + arrDate[1] + "/" + arrDate[2]);
    
    if (isNaN(chkDate) == true ||
        (arrDate[1] != chkDate.getMonth() + 1 || arrDate[2] != chkDate.getDate())) {
        return false;
    }
    
    return true;
}

/*************************************
** 시간형식이 올바른지 검사
*************************************/
function checkTime(strTime)
{
    var arrTime = new Array(2);
    
    if (strTime.indexOf(":") != -1) {
        arrTime = strTime.split(":");
    }
    else {
        if (strTime.length != 4) {
            return false;
        }
        arrTime[0] = strTime.substring(0,2);
        arrTime[1] = strTime.substring(2,4);
    }

    if (arrTime.length != 2) {
        return false;
    }
    
    if (arrTime[0] < 0 || arrTime[0] > 23) {
        return false;
    }
    if (arrTime[1] < 0 || arrTime[1] > 59) {
        return false;
    }
    
    return true;
}

/*************************************
** email 주소형식이 올바른지 검사
*************************************/
function checkEmail(strEmail) { 
    var arrMatch = strEmail.match(/^(\".*\"|[A-Za-z0-9_-]([A-Za-z0-9_-]|[\+\.])*)@(\[\d{1,3}(\.\d{1,3}){3}]|[A-Za-z0-9][A-Za-z0-9_-]*(\.[A-Za-z0-9][A-Za-z0-9_-]*)+)$/);
    if (arrMatch == null) {
        return false;
    }

    var arrIP = arrMatch[2].match(/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/);
    if (arrIP != null) {
        for (var i = 1; i <= 4; i++) {
            if (arrIP[i] > 255) {
                return false;
            }
        }
    }
    return true;
}

/*************************************
** 입력값이 전화번호 형식(숫자-숫자-숫자)인지 체크
*************************************/
function checkPhone(strPhone) {
    var arrMatch = strPhone.match(/^(\d+)-(\d+)-(\d+)$/);
    if(arrMatch == null) {
            return false;
    }
    return true;
}

/*************************************
** 입력값이 우편번호 형식(숫자-숫자)인지 체크
*************************************/
function checkZipcode(strZipcode) {
    var arrMatch = strZipcode.match(/^(\d+)-(\d+)$/);
    if(arrMatch == null) {
            return false;
    }
    return true;
}


/*******************************************************************
        설명 : 숫자만 입력가능하당.. 
                 텍스트 필드에서 다음과 같이 씀다.. onKeyDown="onlyNumber()"      
*******************************************************************/
function onlyNumber() 
{
     var code = window.event.keyCode;

     if ((code > 34 && code < 41) || (code > 47 && code < 58) || (code > 95 && code < 106) || code == 8 || code == 9 || code == 13 || code == 46)
     {
          window.event.returnValue = true;
          return;
     }

//2017-01-10 수정     
     nAllow(window.event); 
}

/*******************************************************************
    숫자,BackSpace,Tab,Enter,Delete,방향이동 키만 입력받음 (반드시, onKeyDown 이벤트로 체크!!)
*******************************************************************/
function checkNumberKey() {
    if ( (event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) ||
        event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 13 || event.keyCode == 46 ||
        (event.keyCode >= 37 && event.keyCode <= 40) )
        event.returnValue=true;
    else
        event.returnValue=false;
}


/***************************************************************** 
 주민등록번호를 check   
 @param juminNo : "-"(하이픈)이 없는 연속된 주민등록번호 13자리
 @return boolean : 정상이면 true, ,된 주민등록번호이면 false
 *****************************************************************/

// 주민등록번호 13자리에 대한 정상 여부를 check한다.
function CheckJuminNo(juminNo) {
    
    var birthYear = juminNo.substring(0,2);
    var birthMonth = juminNo.substring(2,4);
    var birthDay = juminNo.substring(4,6);  
    var genderBit = juminNo.substring(6,7);

    // 주민번호 자리수가 13자리가 아니면 false
    if (juminNo.length != 13) {
        alert("주민등록번호 13자리이어야 합니다.");
        return false;
    }
    
    // 주민번호중 숫자가 아닌값이 포함되어있으면 false
    for (i=0; i<juminNo.length; i++){
        numCheck = juminNo.substring(i,i+1);
        if (numCheck < '0' || numCheck > '9'){ 
            alert("숫자가 아닌값이 들어가 있읍니다.");
            return false;
        }
    }
    
    // 주민번호 (6)번째 자리수가 "1" 또는 "2"이면 1900년대생이고, "3" 또는 "4"이면 2000년대생이다.
    if (genderBit == '1' || genderBit == '2') {
        birthYear = "19" + birthYear
    } else if (birthYear == '3' || birthYear == '4') {
        birthYear = "20" + birthYear
    } else {
        alert("성별 bit가 틀립니다.");
        return false;
    }
    
    // 생년에 따른 월과 일이 범위안에 있는가 체크한다.(윤년 확인)
    var days;
    if (birthMonth==1 || birthMonth==3 || birthMonth==5 || birthMonth==7 || birthMonth==8 || birthMonth==10 || birthMonth==12)  days=31;
    else if (birthMonth==4 || birthMonth==6 || birthMonth==9 || birthMonth==11) days=30;
    else if (birthMonth==2)  {
        if (((birthYear % 4)==0) && ((birthYear % 100)!=0) || (birthYear==0)) days=29;
        else days=28;
    }
    
    if (birthDay > days) {
        alert("일자가 틀립니다.");
        return false;
    }
   
    // check digit bit  
    var checkBit = 0;
    var checkDigit = juminNo.substring(12,13);
    
    checkBit = checkBit + juminNo.substring(0,1) * 2;
    checkBit = checkBit + juminNo.substring(1,2) * 3
    checkBit = checkBit + juminNo.substring(2,3) * 4;
    checkBit = checkBit + juminNo.substring(3,4) * 5;
    checkBit = checkBit + juminNo.substring(4,5) * 6;
    checkBit = checkBit + juminNo.substring(5,6) * 7;
    
    checkBit = checkBit + juminNo.substring(6,7) * 8;
    checkBit = checkBit + juminNo.substring(7,8) * 9;
    checkBit = checkBit + juminNo.substring(8,9) * 2;
    checkBit = checkBit + juminNo.substring(9,10) * 3;
    checkBit = checkBit + juminNo.substring(10,11) * 4;
    checkBit = checkBit + juminNo.substring(11,12) * 5;
        
    checkBit = (11 - (checkBit % 11)) % 10;
    if (checkBit != checkDigit) {
        alert("유효한 주민등록번호가 아닙니다.");
        return false;   
    }
        
    return true;
}

/***************************************************************** 
 주민등록번호를 check
 *****************************************************************/
function jumin_check(strjumin) {

    if( strjumin.length == 13 ){
    
        var temp = 0;
        var checktemp = strjumin.substring(12, 13);
        
        for(var i=0; i<=11; i++){
            temp = temp + ((i%8+2) * parseInt(strjumin.substring(i, i+1)));
        }
        
        temp = 11-(temp % 11);
        temp = temp % 10;
        
        if( temp == checktemp) return true;
        else return false; 
    }
    
    return false;
}

/***************************************************************** 
 재외국인 번호  check  
 *****************************************************************/
function check_fgnno(fgnno) {  
    
    var sum=0;  
    var odd=0;  
    
    buf = new Array(13);
      
    for(i=0; i<13; i++) { 
        buf[i]=parseInt(fgnno.charAt(i)); 
    }
      
    odd = buf[7]*10 + buf[8];  
    if(odd%2 != 0) { return false; }
      
    if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) {    
        return false;  
    }
      
    multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];  
    for(i=0, sum=0; i<12; i++) { 
        sum += (buf[i] *= multipliers[i]); 
    }
      
    sum = 11 - (sum%11);
      
    if(sum >= 10) { sum -= 10; }
      
    sum += 2;
      
    if(sum >= 10) { sum -= 10;  }  
    if(sum != buf[12]) { return false }
      
    return true; 
}

/***************************************************************** 
 사업자번호를 check    
 *****************************************************************/

function gb_BusiNoCheck(sBusiNo) {  
   var iBusi = new Array();
   var iSum  = 0;
   var iMod  = 0;
   var iMod_a = 0;
   var iMod_b = 0;
   var iMod_c = 0;
    
 if (sBusiNo == "" || sBusiNo == " ")  return  false; 

 if (sBusiNo.length != 10)  // 처음은 자리수부터 Check 한다.
     return false;
    
   iBusi[0]  = parseInt(sBusiNo.substring(0,1),  10);    
   iBusi[1]  = parseInt(sBusiNo.substring(1,2),  10) * 3;    
   iBusi[2]  = parseInt(sBusiNo.substring(2,3),  10) * 7;    
   iBusi[3]  = parseInt(sBusiNo.substring(3,4),  10);    
   iBusi[4]  = parseInt(sBusiNo.substring(4,5),  10) * 3;    
   iBusi[5]  = parseInt(sBusiNo.substring(5,6),  10) * 7;    
   iBusi[6]  = parseInt(sBusiNo.substring(6,7),  10);    
   iBusi[7]  = parseInt(sBusiNo.substring(7,8),  10) * 3;    
   
   iBusi[8]  = parseInt(sBusiNo.substring(8,9),  10) * 5;
   
   iBusi[9]  = parseInt(sBusiNo.substring(9,10), 10);    
   
   // 8 자리수 까지 SUM  
    for(var i=0; i < sBusiNo.length - 2; i++) {
       iSum += iBusi[i];
    }
    
   iMod_a = iSum  %  10;  // 10으로 나눈 나머지 a
        
    //  9번째 자리 는  
    iMod_b = parseInt((iBusi[8] / 10),10);  //몫     b
    iMod_c = iBusi[8] % 10;                 //나머지 c    
       
    iMod = 10 -  ((iMod_a + iMod_b + iMod_c) % 10);
    iMod = iMod % 10; 

    if (iMod == iBusi[9])
   {   return true; // 사업자 번호 OK
        }
   else
   { return false; // 사업자 번호 오류 
   }
 }

/*************************************
** 파일명을 받아 확장자를 리턴시켜준다.(.포함)
*************************************/
function getExt(filename)
{
    if(filename == null) return "";
    
    var fname = "";
    if (filename.indexOf(".") != -1) {
        fname = filename.substring(filename.lastIndexOf("."));
        return fname;
    } else {
        return "";
    }
}

/*************************************
** 이미지파일인지 체크한다.
*************************************/
function isImageFile(fileName)
{
    var ext = getExt(fileName);

    if(ext ==".gif" || ext ==".jpg" || ext ==".png" || ext ==".bmp" ||ext ==".GIF" || ext ==".JPG" || ext ==".PNG" || ext ==".BMP")
    {
        return true;    
    }
    else
    {
        return false;
    }
}

/*************************************
** 이미지 없을 경우 정해진 이미지로 교체
*************************************/
function replaceImage(obj, replaceImage){
    obj.src = replaceImage;
}

/*************************************
** 숫자 체크한다.
*************************************/
function checkNumber(form) {
    var bFlag = true;
    var value = form.value;
    
    if (isNaN(value) || event.keyCode == 32) {
        alert("숫자만 입력 가능합니다.");
        form.value = "";
    }
}

/*************************************
** 리스트의 체크박스 선택여부 체크
*************************************/
function isCheckedChkBox(name)
{
    if(name==null){
        return false;
    }
    if(name.length == null) {    
        return name.checked;
    } else {
        for (var i = 0; i < name.length ; i++) {
            if (name[i].checked)
                 return true;
        }
    }
    return false;
}


/*************************************
textArea 글자수 세기 
*************************************/
function setCommentLength(frmObj, strNum, textAreaId, lengthId) 
{
    var lengthObj   = document.getElementById(lengthId);    
    var textAreaObj = document.getElementById(textAreaId);  
    
    lengthObj.innerHTML = "(" + textAreaObj.value.length + "/"+strNum+"byte)";
    
    if(textAreaObj.value.length > strNum)
    {
        alert(strNum+"자까지 등록 가능합니다.");
        textAreaObj.value = textAreaObj.value.substring(0,strNum);
        lengthObj.innerHTML = "(" + textAreaObj.value.length + "/"+strNum+"byte)";
        return;
    }
}

/*************************************
textArea 글자수 세기 
 *  
 * <textarea onkeyup="chkMsgLength(200,comments,currentMsgLen);"></textarea>
 * <span id="currentMsgLen" style="padding-left:60;" >0</span>/ 200byte
*************************************/
function chkMsgLength(intMax, objMsg, st) 
{
        var length = lengthMsg(objMsg.value);
        st.innerHTML = length;//현재 byte수를 넣는다
    
    if (length > intMax) {
        alert("최대 " + intMax + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.\n");
        objMsg.value = objMsg.value.replace(/\r\n$/, "");
        objMsg.value = assertMsg(intMax,objMsg.value,st );
    }
}

function lengthMsg(objMsg) 
{
    var nbytes = 0;
    for (i=0; i<objMsg.length; i++) 
    {
        var ch = objMsg.charAt(i);
        if(escape(ch).length > 4) {
            nbytes += 2;
        } else if (ch == '\n') {
            if (objMsg.charAt(i-1) != '\r') {
                nbytes += 1;
            }
        } else if (ch == '<' || ch == '>') {
            nbytes += 4;
        } else {
            nbytes += 1;
        }
    }
    return nbytes;
}

function assertMsg(intMax, objMsg, st ) 
{
    var inc = 0;
    var nbytes = 0;
    var msg = "";
    var msglen = objMsg.length;
 
    for (i=0; i<msglen; i++) 
    {
        var ch = objMsg.charAt(i);
        if (escape(ch).length > 4) {
            inc = 2;
        } else if (ch == '\n') {
            if (objMsg.charAt(i-1) != '\r') {
                inc = 1;
            }
        } else if (ch == '<' || ch == '>') {
            inc = 4;
        } else {
            inc = 1;
        }
        if ((nbytes + inc) > intMax) {
            break;
        }
        nbytes += inc;
        msg += ch;
    }
    st.innerHTML = nbytes; //현재 byte수를 넣는다
    return msg;
}
    
/*************************************
** 레이어 보임
*************************************/
function layerView(idName)  
{
    Obj = document.getElementById(idName);
    Obj.style.display="block";
    Obj.style.left=event.x+50 ; 
    Obj.style.top=event.y+0;
}

/*************************************
** 레이어 숨김
*************************************/
function layerHidden(idName)    
{
    Obj = document.getElementById(idName);
    Obj.style.display="none";
}


/*************************************
** 상단 로케이션 위치 정보 구성
*************************************/
function makeLocation(info){
    // 파라미터 검증
    if(!info){                  info                = {}                        }
    if(!info["area"]){          info["area"]        = "conLocationArea";        }
    if(!info["image"]){         alert("image empty");       return;             }


    // 경로설정
    var pathInfo = Array();
    for(var key in info["path"]){
        pathInfo.push("<p><a href='" + info["path"][key] + "'>" + key + "</a></p>");
        pathInfo.push("<p>&nbsp;&gt;&nbsp;</p>");
    }



    // 최종 문자열 처리
    var arr = Array();
    arr.push("<div id='conLocation' nowrap>");
    arr.push("  <div class='location t_11gr' id='selCSS1'>");
    arr.push("      <h1><img src='" + info["image"] + "'></h1>");
    //arr.push(pathInfo.length > 2 ? jutil.array.removeLast(pathInfo, 1).join("") : pathInfo.join(""));
    arr.push(!info.category ? jutil.array.removeLast(pathInfo, 1).join("") : pathInfo.join(""));
    arr.push("<p><span id='locationSelectArea'></span></p>");
    //arr.push("      <p class='rss'><a href='#'><img src='/images/common/ico_rss.gif' alt='RSS'></a></p>");
    arr.push("      <div class='search'>");
    arr.push("          <p class='tit'><img src='/images/common/tit_locationSearch.gif' alt='분야별검색'></p>");
    arr.push("          <p class='inputL'></p>");
    arr.push("          <p><input type='text' name=''></p>");
    arr.push("          <p class='inputR'></p>");
    arr.push("      </div>");
    arr.push("  </div>");
    arr.push("</div>");
    
    // 등록
    jutil.e(info["area"]).innerHTML = arr.join("");



    // select 박스 처리
    if(info["category"]){
        //removeSelectCategory('locationSelectArea', -1);
        //changeCategory('locationSelectArea', 'categoryCheckbox', 'cateType', 'storeId', 0, '0', 1, '--선택하세요--', 'selectedCates');
        makeCategorySelect({
            "area"                  : "locationSelectArea",
            "cateType"              : "01",  
            "category"              : info.category, 
            "category_delimiter"    : info.category_delimiter, 
            "fn_name_onchange"      : info.fn_name_onchange ? info.fn_name_onchange : "" 
        }); 
    }
}

/*************************************
** 카테고리 선택 인터페이스를 생성한다.
*************************************/
var makeCategorySelectInfo;
var makeCategorySelectInfoWait = Array();
function makeCategorySelect(info){
    // 대기 처리
    if(makeCategorySelectInfo != null){
        if(makeCategorySelectInfo.area != info.area){
            makeCategorySelectInfoWait.push(info);
            return;
        }
    }else{
        makeCategorySelectInfo = info;
    }
    

    // 파라미터 검증
    if(!info){                          info                        = {}                            }
    if(!info["area"]){                  alert("area empty");        return;                         }
    if(!info["category"]){              alert("category empty");    return;                         }
    if(!info["cateType"]){              info["cateType"]            = "01";                         }
    if(!info["step"]){                  info["step"]                = 0;                            }
    if(!info["fn_name_onchange"]){      info["fn_name_onchange"]    = "makeCategorySelectChange";   }

    
    // 파라미터 정보 저장
    var objArea                 = jutil.e(info.area);
    objArea.category            = info.category;
    objArea.cateType            = info.cateType;
    objArea.step                = info.step;
    objArea.fn_name_onchange    = info.fn_name_onchange;
    objArea.category_delimiter  = info.category_delimiter;


    // 현재 처리할 카테고리 정보 추출
    var category = info.category.split(",")[info.step];


    // 데이터 요청
    makeCategorySelectInfo = info;
    ajaxRequest("getCategories", {cateType:info.cateType, prntCateId:category, storeId:1}, makeCategorySelectCallBack); 
}


function makeCategorySelectCallBack(data){
    // 선택 박스 임시 영역 설정
    var obj = jutil.e("makeCategorySelectTmpArea");
    if(!obj){
        obj = document.createElement("SPAN");
        obj.id = "makeCategorySelectTmpArea";
        document.body.appendChild(obj);
    } 

    // 선택 박스 구성
    if(data.length > 0){
        var object_id       = makeCategorySelectInfo.area + "_CategorySelect_" + makeCategorySelectInfo.category.split(",")[makeCategorySelectInfo.step];
        var selected_value  = makeCategorySelectInfo.category.split(",")[makeCategorySelectInfo.step+1];
        var sel = jutil.form.select({
            "type"                  : "dwr", 
            "data"                  : data, 
            "field_value"           : "cate_id", 
            "field_text"            : "cate_name",
            "subject"               : "선택", 
            "object_id"             : object_id,
            "selected_value"        : selected_value,
            "fn_name_onchange"      : makeCategorySelectInfo.fn_name_onchange, 
            "area_id"               : "makeCategorySelectTmpArea"  
        });


        // 구분자 구성
        if(makeCategorySelectInfo.step > 0){
            var object_id_deli  = makeCategorySelectInfo.area + "_CategorySelectDeli_" + makeCategorySelectInfo.category.split(",")[makeCategorySelectInfo.step];
            var obj         = document.createElement("<SPAN>");
            obj.id          = object_id_deli;
            obj.innerHTML   = makeCategorySelectInfo.category_delimiter;
            jutil.e(makeCategorySelectInfo.area).appendChild(obj);
        }


    
        // 적용
        jutil.e(makeCategorySelectInfo.area).appendChild(jutil.e(object_id));
        //new Selectbox(jutil.e(object_id), {skinFormat  : '/images/common/sel_arrow_01.gif'});



        // 다음 단계 진행
        if(makeCategorySelectInfo.step < makeCategorySelectInfo.category.split(",").length-1){
            // 선택박스 구성
            makeCategorySelectInfo.step++;
            makeCategorySelect(makeCategorySelectInfo);
        }else{
            makeCategorySelectInfo = null;
            
            // select 박스 인터페이스 구성
            //alert(object_id);
            //new Selectbox(jutil.e(object_id), {skinFormat  : '/images/common/sel_arrow_01.gif'});
            
            
            // 대기중인 프로세스가 존재하는 경우 처리
            if(makeCategorySelectInfoWait.length > 0){
                var info = makeCategorySelectInfoWait[0];
                makeCategorySelectInfoWait = jutil.array.removeAt(makeCategorySelectInfoWait, 0);
                makeCategorySelect(info);
            }
        }
    }
    /*
    if(){
        //new Selectbox(jutil.e(object_id), {skinFormat  : '/images/common/sel_arrow_01.gif'});
        var category =  makeCategorySelectInfo.category.split(",");
        for(var i=0 ; i < category.length ; i++){
            var object_id = makeCategorySelectInfo.area + "_CategorySelect_" + category[i];
            alert(jutil.e(object_id));
        }
    }
    */
}


function makeCategorySelectChange(obj){
    // 영역정보 로드, 선택한 카테고리 값 처리
    var arr         = obj.id.split("_");
    var objArea     = jutil.e(arr[0]);
    var category_o  = objArea.category.split(",");
    var category_n  = Array();
    
    // 카테고리 정보 재구성
    for(var i=0 ; i < category_o.length ; i++){
        category_n.push(category_o[i]);
        if(category_o[i] == arr[2]){
            category_n.push(obj.value);
            objArea.step = i+1;
            break;
        }
    } 
    objArea.category = category_n.join(",");

    
    // 하위 삭제 항목 제거
    for(var j=i+1 ; j < category_o.length ; j++){
        var objSel = jutil.e(objArea.id + "_CategorySelect_" + category_o[j]);
        var objDel = jutil.e(objArea.id + "_CategorySelectDeli_" + category_o[j]);
        if(objSel){ objSel.parentNode.removeChild(objSel);  }
        if(objDel){ objDel.parentNode.removeChild(objDel);  }
    }



    // 선택 인터페이스 구성
    makeCategorySelect({
        "area"                  : objArea.id,
        "cateType"              : objArea.cateType,  
        "prntCateId"            : objArea.prntCateId, 
        "step"                  : objArea.step, 
        "category"              : objArea.category, 
        "category_delimiter"    : objArea.category_delimiter 
    });
}

function getCategorySelectValue(obj){
    var arr         = obj.id.split("_");
    var objArea     = jutil.e(arr[0]);
    var category    = objArea.category.split(",");
    var rv          = {"idx" : 0, "value" : Array()}

    for(var i=0 ; i < category.length ; i++){
        var o = jutil.e(objArea.id + "_CategorySelect_" + category[i]);

        if(o){
            rv.value.push(o.value);
            
            for(var j=0 ; j < o.length ; j++){
                if(o[j].value == obj.value){
                    rv.idx = i;
                }
            }
        }
    }
    
    return rv;
}


/*************************************
* 쿠키값 추출 
* 
* 쿠키설정시(CookieUtil.class) utf-8로 인코딩
* 자바스크립트에서 추출시 decodeURIComponent() << 디코딩
*
* 쿠키가 존재하지 않거나,
* 쿠키에 해당 쿠키명이 존재하지 않을경우 [""] 반환
*************************************/
function getCookie(cookieName){

    var cookie = document.cookie;
    
    if(cookie.length < 0 || cookie.indexOf(cookieName + "=") < 0){  return "";  }
    
    var s_index = cookie.indexOf(cookieName + "=") + cookieName.length;
    var e_index = (cookie.indexOf(";", s_index) < 0) ? cookie.length : cookie.indexOf(";", s_index); 

    return unescape(cookie.substring(s_index+1, e_index));    
}

/*************************************
* 로그인 상태 여부 [true|false] 
*************************************/
function isLogin(){
	if(typeof(sMemSeq) == 'undefined') {
		return false;
	}else {
		if(parseInt(sMemSeq)>0) {
			return true;
		} else {
			return false;
		}
	}
}

/*************************************
* 팝업 
*************************************/
function openPopup(width, height, action, scroll){
    var w = width;  
    var h = height;
    var x = (screen.availWidth - w) / 2;
    var y = (screen.availHeight - h) / 2;
    var s = (scroll == 'Y') ? 'Yes' : 'No';
    var set     = 'menubar=no,width='+ w + ',height=' + h + ',left=' + x + ',top=' + y + ',scrollbars=' + s;
    window.open(action, "", set);
}

/*************************************
* 로그인 페이지로 이동
*************************************/
function goMemLogin(){
    	
    var action  = "/front/formLogin.do";
    var path    = location.pathname;
    var param   = location.search.replace(/&/g, "|");

    if(path != "" && !(path.indexOf("/front/member") > -1) && !(path.indexOf("memLeave") > -1)){
    
        action += "?resPath=" + path;
        if(param != "" && !(param.indexOf(".do") > -1)) action += "&resParam=" + param.replace("?", "");
    } 
    
	    document.location.href = action;
}

/*************************************
* 로그인 팝업 
*************************************/
function goLoginPopUp(method){
    openPopup(600, 580, "/front/formLogin.do?mode=popLogin" + (method ? "&method=" + method : ""));
}

/*************************************
* 즉시구매 or 구매하기 클릭시 - 로그인 팝업
*************************************/
function goBuyLoginPopUp(){
    openPopup(600, 540, "/front/formLogin.do?mode=popOrderLogin");
}
function goBuyLoginPopUp(method){
    openPopup(600, 540, "/front/formLogin.do?mode=popOrderLogin&method="+method);
}

/*************************************
* 비회원 주민확인 팝업
*************************************/
function goOrderCheckUp(){
    openPopup(600, 640, "/front/member/checkUpOrderForm.do?mode=pop");
}

/*************************************
* 아이디 찾기 팝업
*************************************/ 
function goSearchId(){
    openPopup(600, 550, hostDomains + "/front/member/searchMemberId.do");
}

/*************************************
* 비밀번호 찾기 팝업
*************************************/ 
function goSearchPass(){
	openPopup(600, 580, hostDomains + "/front/member/searchMemberPass.do");
}

/*************************************
* 우편번호 찾기 팝업
*************************************/ 
function openZipCode(){
    window.open("/common/zipcodeNew.do", "searchPost", "menubar=no,width=400,height=220,scrollbars=no");
}

/*************************************
* 좌우 공백 제거: prototype
*************************************/ 
String.prototype.trim = function(){
    return this.replace(/^\s*/,'').replace(/\s*$/, '');
}

/****************************hid*********
* String bytes 체크: prototype
*************************************/ 
String.prototype.bytes = function(){
    var len = 0;
    
    for(var i=0; i<this.length; i++){
        len += (this.charCodeAt(i) > 128) ? 2 : 1;
    }
    return len;
}

/*************************************
* select 스타일 
*************************************/
function common_setSelectStyle(selectElementNode){

    if (typeof(Selectbox) != "undefined") {
    
        if (document.getElementById("selCSS2") != null) {
        
            if (selectElementNode.style.display != "none") {
                new Selectbox(selectElementNode);
            }
        }
    } 
    else{
        //alert("선택상자 스타일 오브젝트가 존재 하지 않습니다.");
    }
}

/*************************************
* 파일 업로드 팝업
*************************************/
function uploadPopup(path, fileType, uploadType, returnField, valueField) {

    var url = '/common/uploadFileForm.do?path=' + path + '&fileType=' + fileType + '&uploadType=' + uploadType + '&returnField=' + returnField + '&valueField=' + valueField;

    openPopup(430, 370, url, "Y");
}

/*************************************
* 일반 파일
*************************************/
function uploadFile(path, returnField, valueField) {
    uploadPopup(path, 'file', 'file', returnField, valueField);
}

/*************************************
* 일반 파일 다수
*************************************/
function uploadFiles(path, returnField, deleteField) {
    uploadPopup(path, 'file', 'files', returnField, deleteField);
}

/*************************************
* 이미지 파일
*************************************/
function uploadImage(path, returnField, valueField) {
    uploadPopup(path, 'image', 'file', returnField, valueField);
}

/*************************************
* 이미지 파일 다수
*************************************/
function uploadImages(path, returnField, deleteField) {
    uploadPopup(path, 'image', 'files', returnField, deleteField);
}

/*************************************
* 동영상 파일
*************************************/
function uploadMovie(path, returnField, valueField) {
    uploadPopup(path, 'movie', 'file', returnField, valueField);
}

/*************************************
* 신고하기
*************************************/
function notify(nRelSeq, nTitle, nMemSeq, nMemNickname, nNotifyType, nUrlStr, nMemId)
{
    var memSeq  = sMemSeq;
    var nUrl    = "";
    
    if(nUrlStr == undefined || nUrlStr == ""){
        nUrl = location.href ;
    }else{
        nUrl = nUrlStr;
    }   
     
    if(memSeq != ''){
        jutil.bandi.setCookieInfo("nRelSeq", nRelSeq);
        jutil.bandi.setCookieInfo("nTitle", nTitle.substring(0, 50));
        jutil.bandi.setCookieInfo("nMemSeq", nMemSeq);
        if(nMemId){ jutil.bandi.setCookieInfo("nMemId", nMemId);    }
        jutil.bandi.setCookieInfo("nMemNickname", nMemNickname);
        jutil.bandi.setCookieInfo("nNotifyType", nNotifyType);
        jutil.bandi.setCookieInfo("nUrl", nUrl);

        //var win = window.open(bandiUrl+'/common/notifyForm.do', 'no', 'width=400, height=650');
        var win = window.open(hostDomain+'/common/notifyForm.do', 'no', 'width=400, height=650');
    }else{
        alert("로그인해주세요.");
        goLoginPopUp(); 
    }                                               
}

function setValues(win, nRelSeq)
{
    win.document.getElementById('text2').value = nRelSeq;
}
/*************************************
* 쇼핑카트 추가  도서,일반 상품상세용
*************************************/
function detail_add_basket(p_prod_id, p_cnt, p_opt_seq ){

    var param = {prod_id:p_prod_id,cnt:p_cnt,opt_seq:p_opt_seq};
    // 업체에 해당하는 상점 목록 가져오기
    OrderDwr.createShopCart(param, 
        function (val) {
            if(val==1){
                alert('쇼핑카트에 추가 하였습니다');
                return true;
            }else if(val==2){
                alert('쇼핑카트에 중복된 상품이 있어 수량을 추가 하였습니다.');
                return true;
            }else{
                alert('오류사항이 발견되었습니다, 관리자에게 문의해 주세요.');
                return false;
            }
        }
    );

}

/*************************************
* 쇼핑카트 추가  도서,중고책,일반 - 블로그용
*************************************/
function add_basket_common(prodId, prodCnt, bookMemId){
    add_basket_blog(prodId, prodCnt , bookMemId);
}

function add_basket_blog(p_prod_id, p_cnt ,p_bookMemId){

    var param = {prod_id:p_prod_id,cnt:p_cnt,book_mem_id:p_bookMemId};
    // 업체에 해당하는 상점 목록 가져오기
    OrderDwr.createShopCart(param, 
        function (val) {
            if(val==1){
                //alert('쇼핑카트에 추가 하였습니다');
            }else if(val==2){
                //alert('쇼핑카트에 중복된 상품이 있어 수량을 추가 하였습니다.');
            }else{
                alert('오류사항이 발견되었습니다, 관리자에게 문의해 주세요.');
            }
            
            jutil.bandi.reloadWiseCart("cart");
        }
    );

}





/*************************************
* 바로구매 - 블로그용
*************************************/
function add_order_common(prodId, prodCnt){
	window.open(bandiSslUrl + "/front/order/order.do?prod_id=" + prodId + "&ord_cnt=" + prodCnt, "", "");
}



/*************************************
* 관심상품 추가  도서,중고책,일반 - 블로그용
*************************************/
function add_wish_common(prodId){
    var prodCnt = 1;
    add_wish_array_common(prodId,true);
    /*
    if(prodId > 5000000){
        add_old_wish(prodId, prodCnt);
    }else{
        add_wish(prodId, prodCnt);
    }
    */
}

/*************************************
* 관심상품 추가  도서,일반
*************************************/
function add_wish(p_prod_id){
    if(isLogin()){
        var param = {prod_id:p_prod_id};
        // 업체에 해당하는 상점 목록 가져오기
        ajaxRequest("createInterestProd", param,         
            function (val) {
                if(val==1){
                    //alert('관심상품에 추가 하였습니다');
                }else if(val==2){
                    //alert('관심상품에 이미 들어가 있는 상품 입니다.');
                }else{
                    alert('오류사항이 발견되었습니다, 관리자에게 문의해 주세요.');
                }
                
                if(jutil.e("iframeBox").contentWindow){
                    jutil.bandi.reloadWiseCart("wish");
                }else{
                    alert("관심상품으로 등록되었습니다.");
                }
            }
        );
        return;
    }else{
        alert('관심상품 추가하기는 로그인후 이용가능합니다.');
        goLoginPopUp();
        return;
    }
}

/*************************************
* 쇼핑카트 추가  도서,일반 배열
*************************************/
function add_basket_array(check_box_obj,prod_id_obj, cnt_obj){
    // check_box_obj - > input checkbox object 
    // prod_id_obj -> input checkbox or hidden or text object
    // cnt_obj -> input hidden or text object
    
    var prodIdArr = "";
    var cntArr = "";
    var seq = 0;
    
    
    for(var i=0;i<check_box_obj.length;i++){
        if(check_box_obj[i].checked){
            if(seq>0){
                prodIdArr += ",";
                cntArr += ",";
            }
            prodIdArr += prod_id_obj[i].value;
            cntArr += "1";  

            seq++;
        }
    }
    
    if(seq==0){
        alert('상품을 1개 이상 선택해주세요.');
        return;
    }
    var tmpArr      = Array(prodIdArr.split(",").length);
    for(var i=0 ; i < tmpArr.length ; i++){
        tmpArr[i] = " ";
    }
    
    
    add_basket_array_common(prodIdArr, tmpArr.join(","), cntArr, null, false);
    jutil.bandi.reloadWiseCart("cart");
    
}

/*************************************
* 관심상품 추가  전체, 배열
    prodIds : 콤마로 구분된 상품 아이디, 중고책의 경우 중고책 상품 아이디 사용
*************************************/
function add_wish_array_common(prodIds, isPopup, callBack_){
    if(!jutil.bandi.isLogin()){     
        //alert("로그인후 이용이 가능합니다.");     
        goLoginPopUp();
        return;     
    }

    if(!isPopup){
        OrderDwr.createInterestProds({"prodIds" : prodIds}, 
            function(cnt){
                if(cnt >= 0){
                    alert("위시리스트에 담겼습니다.");
                }else{
                    if(cnt == -1){
                        alert("관심상품에 등록하는데 장애가 발생했습니다.");
                    }

                    if(cnt == -2){
                        alert("로그인후 이용이 가능합니다.");
                    }
                    
                    if(cnt == -20){
                        alert("연령제한이 적용되어 있는 상품입니다.");
                        return;
                    }            
                    
                    if(cnt == -90){
                    	alert("연령제한이 적용된 상품은 로그인 후 이용가능합니다.");
                    	resLoginPage();
                	    return;
                    }
                    
                    if(cnt == -99){
                    	alert("19세 이상 상품 이용가능한 상품으로 본인인증 후 이용가능합니다.");
                    	resAdultCertPage();
                	    return;
                    }
                }
                
                if(typeof(callBack_) == "function"){
                    callBack_(cnt);
                }
            }
        );
    }else{
        window.open("/common/addWish.do?prodIds=" + prodIds, "addWishWin", "width=400, height=240");
    }
}


/************************************************************
* 쇼핑카트 추가  전체, 배열
    콤마로 구분된 상품 정보
    prod_id     : 상품아이디(일반상품, 중고상품 포함)
    opt_seq     : 옵션 번호
    cnt         : 수량
    book_mem_id : 북멘토 아이디(있을 경우에만 사용 없으면 null)
************************************************************/
function add_basket_array_common(prod_id, opt_seq, cnt, book_mem_id, isArlert_, callBack_){
    if(!book_mem_id){
        var tmpArr      = Array(prod_id.split(",").length);
        for(var i=0 ; i < tmpArr.length ; i++){
            tmpArr[i] = " ";
        }
        var book_mem_id = tmpArr.join(",");
    }

    ajaxRequest("createShopCarts", {
            "prod_id"       : prod_id, 
            "opt_seq"       : opt_seq, 
            "cnt"           : cnt, 
            "book_mem_id"   : book_mem_id 
        }, 
        function(cnt){
            if(isArlert_){
                if(cnt == -10){
                    alert("옵션이 있는 상품은 상품상세에서 옵션을 선택해 주시기 바랍니다.");
                    return;
                }
                
                if(cnt == -20){
                    alert("연령제한이 적용되어 있는 상품입니다.");
                    return;
                }
                
                if(cnt == -30){
                    alert("품절된 상품은 쇼핑카트에 담을 수 없습니다.");
                    return;
                }
                
                if(cnt == -90){
                	alert("연령제한이 적용된 상품은 로그인 후 이용가능합니다.");
                	resLoginPage();
            	    return;
                }
                
                if(cnt == -99){
                	alert("19세 이상 상품 이용가능한 상품으로 본인인증 후 이용가능합니다.");
                	resAdultCertPage();
            	    return;
                }
                
                if(cnt >= 0){
                	alert("선택 상품이 쇼핑카트에 담겼습니다.");
                    jutil.bandi.reloadWiseCart("cart");
                }
            }

            if(typeof(callBack_) == "function"){
                callBack_(cnt);
            }
        }
    );
}

/*********************************************************
    작성자 : 김기석
    작성일 : 2008.06.30
    기능 :
        - 쇼핑카트 추가 와이즈 카트용
        - 콜백을 등록하면 콜백 함수가 실행되고, 아니면 와이즈카트가 열린다.
        - 최종본 단일상품을 등록할 경우에는 이 함수를 활용할 것!
*********************************************************/
function add_basket(isbn, cnt_, opt_, book_mem_id_, callBack_){
    //OrderDwr.createShopCarts({
    ajaxRequest("shopCartList", {
            "isbn"       : isbn, 
            "opt_seq"       : opt_ ? opt_ : "", 
            "cnt"           : cnt_ ? cnt_ : 1, 
            "book_mem_id"   : "" 
        }, 
        function(cnt){
            if(typeof(callBack_) == "function"){
                callBack_(cnt);
            }else{
            
            	if(cnt == -10){
            		alert("옵션이 있는 상품은 상품상세에서 옵션을 선택해 주시기 바랍니다.");
            		return;
            	}
            	
            	if(cnt == -20){
            		alert("연령제한이 적용되어 있는 상품입니다.");
            		return;
            	}
            	
            	if(cnt == -90){
            		alert("연령제한이 적용된 상품은 로그인 후 이용가능합니다.");
            		resLoginPage();
            		return;
            	}
            	
            	if(cnt == -99){
            		alert("19세 이상 상품 이용가능한 상품으로 본인인증 후 이용가능합니다.");
            		resAdultCertPage();
            		return;
            	}
            	
            	if(cnt == -999){            		
            		alert("이미 등록된 상품입니다.");	
            		return;
            	}
                if(jutil.e("iframeBox").contentWindow && cnt >= 0){
                	jutil.bandi.reloadWiseCart("cart");
                }else{
                    if(confirm("쇼핑카트에 등록되었습니다. 지금 바로 확인 하시겠습니까?")) {
                    	document.location.href = '/webproject/shopCarList.action';
                    }
                }
            }
        }
    );
}

function add_basket_ebook(prodId, cnt_, opt_, book_mem_id_, callBack_){
    ajaxRequest("createShopCarts", {
            "prod_id"       : prodId, 
            "opt_seq"       : opt_ ? opt_ : "", 
            "cnt"           : cnt_ ? cnt_ : 1, 
            "book_mem_id"   : "" 
        }, 
        function(cnt){
            if(typeof(callBack_) == "function"){
                callBack_(cnt);
            }else{
            	
            	if(cnt == -10){
            		alert("옵션이 있는 상품은 상품상세에서 옵션을 선택해 주시기 바랍니다.");
            		return;
            	}
            	
            	if(cnt == -20){
            		alert("연령제한이 적용되어 있는 상품입니다.");
            		return;
            	}
            	
            	if(cnt == -90){
            		alert("연령제한이 적용된 상품은 로그인 후 이용가능합니다.");
            		resLoginPage();
            		return;
            	}
            	
            	if(cnt == -99){
            		alert("19세 이상 상품 이용가능한 상품으로 본인인증 후 이용가능합니다.");
            		resAdultCertPage();
            		return;
            	}
            	
                if(jutil.e("iframeBox").contentWindow && cnt >= 0){
                	jutil.bandi.reloadWiseCart("cart");
                }else{
                    if(confirm("쇼핑카트에 등록되었습니다. 지금 바로 확인 하시겠습니까?")) {
                    	document.location.href = '/webproject/shopCartList.action';
                    }
                }
            }
        }
    );
}





/*************************************
* 관심상품 추가  도서,일반 배열
*************************************/
function add_wish_array(check_box_obj,prod_id_obj){
    // check_box_obj - > input checkbox object 
    // prod_id_obj -> input checkbox or hidden or text object
    
    var prodIdArr = "";
    var seq = 0;
    
    
    for(var i=0;i<check_box_obj.length;i++){
        if(check_box_obj[i].checked){
            if(seq>0){
                prodIdArr += ",";
            }
            prodIdArr += prod_id_obj[i].value;
            seq++;
        }
    }
    
    if(seq==0){
        alert('상품을 1개 이상 선택해주세요.');
        return;
    }
    
    
    add_wish_array_common(prodIdArr,true);
    //jutil.bandi.reloadWiseCart("wish");
}

/*************************************
* 도서 상품 미리보기 팝업
*************************************/ 
function popPreview(isbn) {

    if (typeof(isbn) == "undefined" || isbn == "") {
        return;
    }
    
    window.open("/front/product/previewBook.do?isbn=" + isbn, "preview", "width="+screen.availWidth+",height="+screen.availHeight+",resizable=yes,scrollbars=yes");
}

/*************************************
* 도서 상품 동영상 리뷰 팝업
*************************************/ 
function popVod(isbn, path) {

    if (typeof(isbn) == "undefined" || isbn == "" || typeof(path) == "undefined" || path == "") {
        return;
    }
    
    window.open("/front/product/vodBook.do?prodId=" + isbn + "&path=" + path, "vod", "width=400,height=380,resizable=yes");
}

/*************************************
* front 상품 검색
*************************************/
function goFrontSearchProduct(searchType, returnFn, searchKey, searchValue) {

    if(searchKey && searchValue){
        openPopup(400, 255, "/front/product/searchProduct.do?searchType=" + searchType + "&returnFn=" + returnFn + "&searchKey=" + searchKey + "&searchValue=" + searchValue);
    }else{
        openPopup(400, 255, "/front/product/searchProduct.do?searchType=" + searchType + "&returnFn=" + returnFn);
    }
}

/*************************************
* 도서 검색
*************************************/
function goSearchBook(returnFn, searchKey, searchValue) {

    if (typeof(returnFn) == "undefined") {
        alert("반환받을 함수를 정의하세요");
        return;
    }
    
    if (typeof(searchKey) == "undefined") {
        searchKey = "";
    }
    
    if (typeof(searchValue) == "undefined") {
        searchValue = "";
    }
    
    goFrontSearchProduct('book', returnFn, searchKey, searchValue);
}

/*************************************
* 선택한 책 테마에 담기 팝업
*************************************/ 
function addThemaBookProd(prodId, grpSeq, limitProd, themaType) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    if (isLogin() == false) {
        alert('테마에 담기는 로그인후 이용가능합니다.');
        goLoginPopUp();
        return;
    }
        
    openPopup(400, 380, "/front/thema/themaBookProdForm.do?prodId=" + prodId+'&themaBookGrpSeq='+grpSeq+'&limitProd='+limitProd+'&themaType='+themaType);
}

/*************************************
* 테마 추가 팝업 (도서 상세에서 사용, 나만의 테마에만 도서를 담을 수 있음)
*************************************/ 
function addThemaBook(prodId) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    if (isLogin() == false) {
        alert('테마에 담기는 로그인후 이용가능합니다.');
        goLoginPopUp();
        return;
    }
    
    openPopup(400, 270, "/front/thema/themaBookForm.do?prodId=" + prodId);
}


/*************************************
* // event의 flash 표시, path가 이미지와 swf를 분리해서 자동으로 뿌려줌.
*************************************/ 
function showImgSwf(path) {
    exp = path.substring(path.lastIndexOf('.')+1,path.length);

    if(exp.toLowerCase() == 'swf') {            
        path = "\
            <object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' width='100%' height='100%' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab'>\
                <param name='movie' value='" + path + "' />\
                <embed src='" + path + "' width='100%' height='100%' quality='high' type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer' />\
            </object>\
        ";
    } else {
        path = "<img src='" + path + "'>";
    }
    document.write(path);
}

/*************************************
* // 업체검색
*************************************/ 
function  goSearchCompany(keyCompType) {
    /*
    if (isLogin() == false) {
        goLoginPopUp();
        return;
    }
    */
    openPopup(500, 500, "/admin/company/popUpCompSearch.do?keyCompType="+keyCompType , "Y");
}
/*************************************
* // 업체검색
*************************************/ 
function  goSearchComp(compType) {
    if (typeof(compType) == "undefined") {
        compType = "";
    }
    goSearchCompany(compType);
}
/*************************************
* // 출판사 검색
*************************************/ 
function  goSearhPub() {
    if (isLogin() == false) {
        goLoginPopUp();
        return;
    }
    openPopup(440, 380, "/front/common/pubSearchList.do", "Y");
}

/*************************************
* 스크랩 하기
*************************************/ 
function goScrap(prodId) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    openPopup(600, 620, "/front/product/scrapProduct.do?prodId=" + prodId, 'Y');
}

/*************************************
* 조르기
*************************************/ 
function goRequestProduct(prodId) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    if (isLogin() == false) {
        alert('조르기는 로그인후 이용가능합니다.');
        goLoginPopUp();
        return;
    }
    
    openPopup(520, 760, "/front/product/requestProduct.do?prodId=" + prodId, 'Y');
}

/*************************************
* 크게보기 (일반상품)
*************************************/ 
function goZoomProduct(prodId) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    openPopup(790, 585, "/front/product/zoomProduct.do?prodId=" + prodId, "Y");
}

/*************************************
* 상품문의/책정보 수정 요청
*************************************/ 
function goInquiry(prodId) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    var prodType = "";
    var prodStat = "";
    
    ajaxRequest("getProduct", {"prodId":prodId},  
        function (product) {
            
            if (product != null && typeof(product) == "object") {
            
                if (product.prodQaYn == null || product.prodQaYn == "" || product.prodQaYn == "N") {
                    alert("상품 문의가 불가능한 상품입니다.");
                    return;
                }
                
                prodType = product.prodType;
                prodStat = product.prodStat;
                
                var temp = "";
                
                if (prodType == "01" || prodType == "02") {
                    temp = "4019";
                } 
                else if (prodType == "03") {
                    temp = "4021";
                } 
                else if (prodType == "04") {
                    temp = "4022";
                } 
                if(prodStat == '02' || prodStat == '03' || prodStat == '04'){
                    temp = "4023";
                }
                
                if (temp == "") {
                    return;
                }
                
                // 1:1 고객상담으로 보낸다.
                document.location.href = "/front/help/helpContactUsForm.do?topCateId=4002&cateId=" + temp + "&prodId=" + prodId;
            }
        }
    );
}

/*************************************
* 쿠폰받기 
*
* multiYn : 복수발급여부
* cpnSeq  : 쿠폰번호    
*************************************/
function downCoupon(cpnSeq, prodId, salePrice)
{
    var memSeq  = sMemSeq;
    
    if (isLogin() == true && memSeq.length > 0 && isNumber(memSeq) == true) {
        ajaxRequest("downCoupon", {"cpnSeq":cpnSeq, "memSeq":memSeq, "prodId":(prodId ? prodId : ""), "salePrice":(salePrice ? salePrice : "0")}, 
                function(data){
                
                    if (data != null && typeof(data) == "object") {
                    
                        var resMsg = data.resMsg;
/*                        
                        if (typeof(data.discountPrice) != "undefined" && data.discountPrice != null && data.discountPrice != "") {
                            
                            var pSale = document.getElementById("pSale");
                            
                            if (pSale != null) {
                                pSale.innerHTML = "추가할인: <strong>" + jutil.string.comma(data.discountPrice) + "</strong>원&nbsp;";
                                pSale.style.display = "";
                            }
                        }
*/                        
                        alert(resMsg);
                    } 
                    else {
                        alert("쿠폰 발급에 오류가 발생했습니다. 관리자에게 문의하세요");
                    }
                }
            );
    }else{
        alert("로그인해주세요.");
        goLoginPopUp(); 
    }
}


function downCoupon2(cpnSeq, evtSeq, salePrice)
{
	var memSeq  = sMemSeq;
    
    if (isLogin() == true && memSeq.length > 0 && isNumber(memSeq) == true) {
        ajaxRequest("downCoupon", {"cpnSeq":cpnSeq, "memSeq":memSeq, "evtSeq":(evtSeq ? evtSeq : ""), "salePrice":(salePrice ? salePrice : "0")}, 
                function(data){
                
                    if (data != null && typeof(data) == "object") {
                    
                        var resMsg = data.resMsg;
                        alert(resMsg);
                    } 
                    else {
                        alert("쿠폰 발급에 오류가 발생했습니다. 관리자에게 문의하세요");
                    }
                }
            );
    }else{
        alert("로그인해주세요.");
        goLoginPopUp(); 
    }
}

function downCoupon3(cpnSeq, cateId, salePrice)
{
    var memSeq  = sMemSeq;
    
    if (isLogin() == true && memSeq.length > 0 && isNumber(memSeq) == true) {
        ajaxRequest("downCoupon", {"cpnSeq":cpnSeq, "memSeq":memSeq, "cateId":(cateId ? cateId : ""), "salePrice":(salePrice ? salePrice : "0")}, 
                function(data){
                
                    if (data != null && typeof(data) == "object") {
                    
                        var resMsg = data.resMsg;
                        alert(resMsg);
                    } 
                    else {
                        alert("쿠폰 발급에 오류가 발생했습니다. 관리자에게 문의하세요");
                    }
                }
            );
    }else{
        alert("로그인해주세요.");
        goLoginPopUp(); 
    }
}


function eBookDownCoupon(cpnSeq, cateId, salePrice)
{
	//전자책 최초구매 이벤트용
    var memSeq  = sMemSeq;
    
    if (isLogin() == true && memSeq.length > 0 && isNumber(memSeq) == true) {
    	if(cpnSeq == "16914"){
            ajaxRequest("eBookEventCoupon", {"memSeq":memSeq }, 
                    function(data){
                        if (data != null && typeof(data) == "object") {
                            var resMsg = data.resMsg;
                            //alert(resMsg);
                            if(resMsg=="Y"){
                            	downCoupon3(cpnSeq, cateId, salePrice);
                            }else{
                            	//alert("전자책 첫구매 쿠폰입니다.");
                            	alert("eBook 쿠폰 발급 대상자가 아닙니다.");
                            }
                        }else {
                            alert("쿠폰 발급에 오류가 발생했습니다. 관리자에게 문의하세요");
                        }
                    }
                );
    	}else{
    		downCoupon3(cpnSeq, cateId, salePrice);
    	}
    }else{
        alert("로그인해주세요.");
        goLoginPopUp(); 
    }
}
/*************************************
* 배너클릭시 관련 URL 이동 & 클릭로그 기록 
*
* url : 배너URL
* target  : 이동 URL target
* banSeq  : 배너SEQ
*************************************/
function goBannerUrl(url, target, banSeq)
{
    var frmObj  = jutil.e("bannerUrlClickLog");
    var memSeq  = sMemSeq;
        
    // form 생성
//  if(!frmObj)
//  {
        frmObj = document.createElement("FORM");
        frmObj.name = "bannerUrlClickLog";
        frmObj.id = "bannerUrlClickLog";
      
        document.body.appendChild(frmObj);
//  }
    if(memSeq == ""){
        memSeq = 0;
    }
    
    // 배너 클릭로그 등록
    if(banSeq != 'undefined' && banSeq != '')
    //ajaxRequest("createBannerClickLog", {"banSeq" : banSeq, "memSeq" : memSeq},
    //	function(banner){
			//배너로그분석(와이즈로그)
			n_click_logging(hostDomain+"/wiselog/bottonClick.aspx?button_id=" + banSeq);
    //	}
    //);
    //Banner.createBannerClickLog(banSeq, memSeq); 
  
    if (url != '')
    {
        frmObj.action = url;
        frmObj.method = "post";
        frmObj.target = target;
        frmObj.submit();
    }
}

/*************************************
* 리뷰쓰기 (블로그)
*************************************/ 
function goCreateReview(prodId, memId) {

    if (typeof(prodId) == "undefined" || prodId == "") {
        return;
    }
    
    if (memId == "") {
        alert('리뷰쓰기는 로그인후 이용가능합니다.');
        goLoginPopUp();
        return;
    }
    
    window.open(blogDomain + '/bandi_blog/blog/blogMain.do?blogId=' + memId + '&iframe=writePost.do&prod_id=' + prodId + '&dest=book', 'blog');
}

/*************************************
* 저자 검색 (검색 페이지로 보냄)
*************************************/
function goSearchAuthor(author) {

    if (typeof(author) == "undefined" || author == "") {
        return;
    }
    
    document.location.href = "/search/search.do?q=" + author;
}

/*************************************
* 음반 아티스트 검색 (검색 페이지로 보냄)
*************************************/
function goSearchArtist(author) {

    if (typeof(author) == "undefined" || author == "") {
        return;
    }
    
    document.location.href = "/search/search.do?q=" + author;
}

/*************************************
* 출판사 검색 (검색 페이지로 보냄)
*************************************/
function goSearchPublish(publish) {

    if (typeof(publish) == "undefined" || publish == "") {
        return;
    }
    
    document.location.href = "/search/search.do?q=" + publish;
}

/*************************************
* 음반 레이블 검색 (검색 페이지로 보냄)
*************************************/
function goSearchMaker(maker) {

    if (typeof(maker) == "undefined" || maker == "") {
        return;
    }
    
    document.location.href = "/search/search.do?q=" + maker;
}

/*************************************
* 태그 검색 (검색 페이지로 보냄)
*************************************/
function goSearchTag(tag, prodType) {

    if (typeof(tag) == "undefined" || tag == "") {
        return;
    }
    
    document.location.href = "/search/search.do?dt=tgl^"+tag;
}

/**************************************************************
* 포커스 이동 onKeyUp=nextFocus(this.value.length, 2, 'nextName');  
/**************************************************************/
function nextFocus(strLen, maxLen, nextName){
    if(strLen == maxLen){
        document.getElementsByName(nextName)[0].focus();
    }       
}

/**************************************************************
* 상품즉시구매
/**************************************************************/
// 바로구매
function goBuy(prodId, prodCnt, naverYn) {
	
	var arr_browser = new Array ("Phone","Mini","iPod","iPad","Android","BlackBerry","Windows CE","lgtelecom","SAMSUNG","MOT","SonyEricsson","Nokia");
	var userAgent   = navigator.userAgent;
	var isMobile	= false;
	
	for(var i=0;i<arr_browser.length;i++){
		if(userAgent.indexOf(arr_browser[i]) > -1){
			isMobile = true;
		}
	}
	
	if(isMobile){
        alert("모바일 기기에서 비 익스플로러 브라우저는 쇼핑카트를 통해서 주문해주시기 바랍니다.");
        return;
	}
	
	// LGU+ 결제모듈에 Non ActiveX 방식이 적용으로 인해 브라우저 제한 해제
    if(userAgent.indexOf("Firefox") > -1 && false){
        alert("파이어폭스에서는 주문이 불가능합니다.");
        return;
    }
	// LGU+ 결제모듈에 Non ActiveX 방식이 적용으로 인해 브라우저 제한 해제
    if(userAgent.indexOf("Safari") > -1 && userAgent.indexOf("Chrome") == -1  && false){
        alert("사파리에서는 주문이 불가능합니다.");
        return;
    }
    
    if(prodCnt == null || prodCnt == "" || prodCnt == "undefined"){
    	prodCnt = "1";
    }
    
    if (isLogin() == false) {
        goBuyLoginPopUp('goOrderPage(' + prodId + ', '+prodCnt+', \''+naverYn+'\')');
    } 
    else {
        document.location.href = hostDomains + '/front/order/order.do?prod_id=' + prodId + '&ord_cnt='+prodCnt+'&naverYn=' + naverYn;
    }
}

// 바로구매 (옵션상품)
function goBuyOpt(isbn, prodCnt) {
    
    ajaxRequest("existsProdOption", {
		"isbn" : isbn
	}, function(data) {
		if (data == -10 && optSeq == 0) {
			alert("옵션이 있는 상품은 상품상세에서 옵션 선택 후 주문이 가능합니다.");
			return;
		} else{
			if (isLogin() == false) {
		        goBuyLoginPopUp('goOrderPageOpt(' + isbn + ', ' + prodCnt + '\')');
		    } 
		    else {
		        document.location.href = hostDomains + '/order.action?isbn=' + isbn + '&ord_cnt=' + prodCnt;
		    }
		}
	});
}

// 로그인 후 바로구매 페이지로 이동
function goOrderPage(prodId, prodCnt, naverYn) {
    document.location = hostDomains + '/front/order/order.do?prod_id=' + prodId + '&ord_cnt=' + prodCnt +'&naverYn=' + naverYn;
}

// 로그인 후 바로구매 페이지로 이동 (옵션상품)
function goOrderPageOpt(prodId, prodCnt, optSeq, naverYn) {
    document.location = hostDomains + '/front/order/order.do?prod_id=' + prodId + '&ord_cnt=' + prodCnt + '&opt_seq=' + optSeq+'&naverYn=' + naverYn;
}

// 로그인 후 바로구매 페이지로 이동 (북셀프)
function goOrderPageBookSelf(prodId, prodCnt, gu) {
    opener.document.location = hostDomains + '/front/order/order.do?prod_id=' + prodId + '&ord_cnt=' + prodCnt + '&gu=' + gu;
    self.close();
}

/***********************************************************
    AJAX 인터페이스 구현 함수들...
***********************************************************/

/*  서버측에 데이터를 요청한다.
*/
function ajaxRequest(service, info, callBack_){
    jutil.xmlhttp.post("/webprojet/" + service + ".action", info, true, function(str){
        if(typeof(callBack_) == "function"){
            try{
                eval(str);
                callBack_(data);
            }catch(e){
                // 에러 발생시 에러 로그를 기록한다.
                //jutil.xmlhttp.post("/ajax/throwException.do", {"msg":str+"\n\n"+e}, true, null);
            }
        }
    });
}

/****************************
@ 숫자 천단위 콤마
*****************************/
function FormatNumber(val){

	if(val>-999 && val<999){
		return val;
	}else{
		var str = new String(val);
		var re = /(-?[0-9]+)([0-9]{3})/;
		while(re.test(str)){
			str = str.replace(re,"$1,$2");
		}
		return str;
	}
}

//3자리 마다 콤마 : onkeyup="this.value=FormatNumber3(this.value)"
function FormatNumber3(num){
	num=new String(num)
	num=num.replace(/,/gi,"")
	return FormatNumber2(num)
}

function FormatNumber2(num){
    
	fl=""
	if(isNaN(num)) { alert("문자는 사용할 수 없습니다.");return 0}
	if(num==0) return num
	 
	if(num<0){ 
	        num=num*(-1)
	        fl="-"
	}else{
	        num=num*1 //처음 입력값이 0부터 시작할때 이것을 제거한다.
	}
	num = new String(num)
	temp=""
	co=3
	num_len=num.length
	while (num_len>0){
		num_len=num_len-co
		if(num_len<0){co=num_len+co;num_len=0}
		temp=","+num.substr(num_len,co)+temp
	}
	return fl+temp.substr(1)
}

/****************************
@ C로그로 보내기
*****************************/
function goClog(url, prodName, prodImg, saleCost) {
	window.open('http://csp.cyworld.com/bi/bi_recommend_pop.php?url='+url+'&title_nobase64='+encodeURIComponent(prodName)+'&thumbnail='+prodImg+'&summary_nobase64='+encodeURIComponent(prodName)+'&writer='+encodeURIComponent("반디앤루니스")+'&corpid=bandinlunis&div_code=shop&tag4='+saleCost+'', 'recom_icon_pop', 'width=400,height=364,scrollbars=no,resizable=no');
}

/****************************
@ 북셀프 팝업
*****************************/
function popUpBookSelf(prodId) {		
	openPopup(630, 700, "/front/product/popUpBookSelf.do?prodId="+prodId, "Y");
}

/****************************
@ 계란한판 조각모으기
*****************************/
function createMemEggPiece(prodId) {
	if(isLogin()){
        ajaxRequest("createMemEggPiece", {"prodId":prodId},         
            function (data) {
	        	if (data != null && typeof(data) == "object") {
	        		var resValue = data.resValue;
	                var resMsg = data.resMsg;
	                var nextProdId = data.nextProdId;
	                if(resValue != null && resValue != ""){
	                	if(confirm(resMsg)){
		                	if(resValue == "getPiece" || resValue == "getAlreadyPiece"){
		                		location.href = "/front/product/detailProduct.do?prodId="+nextProdId;
		                	}else if(resValue == "getTenPiece"){
		                		location.href = "/front/event/egg/eggMain.do";
		                	}
	                	}
	                }else{
	                	alert(resMsg);
	                }
	            }
            }
        );
        return;
    }else{
        alert('로그인 후 조각을 받으실 수 있습니다.');
        goLoginPopUp();
        return;
    }	
}

/****************************
@ 로그인 리턴 펑션
 *****************************/
function resLoginPage(){
	var action  = "/front/formLogin.do";
	var path    = location.pathname;
	var param   = location.search.replace(/&/g, "|");
	
	if(path != "" && !(path.indexOf("/front/member") > -1) && !(path.indexOf("memLeave") > -1)){
		action += "?resPath=" + path;
		if(param != "" && !(param.indexOf(".do") > -1)) action += "&resParam=" + param.replace("?", "");
	} 
	
	document.location.href = action;
}

/****************************
@ 성인인증 리턴 펑션
 *****************************/
function resAdultCertPage(){
	var action  = "/front/member/adultCert.do";
    var path    = location.pathname;
    var param   = location.search.replace(/&/g, "|");

    if(path != "" && !(path.indexOf("/front/member") > -1) && !(path.indexOf("memLeave") > -1)){
        action += "?resPath=" + path;
        if(param != "" && !(param.indexOf(".do") > -1)) action += "&resParam=" + param.replace("?", "");
    } 
    
    document.location.href = action;
}

/****************************
@ LPAD
*****************************/
function LPAD(str, n, padding) {
	
	str = ""+str;
	if (str.length >= n) {
		return str;
	} else {
		var len = n - str.length;
		var pad_str = str;
		for (var i=0; i<len; i++) {
			pad_str = padding + pad_str;
		}
		return pad_str;
	}
}

function closePopLayerToday(layerId) {
	document.getElementById(layerId).style.display='none';
	setCookieToday(layerId, 1);
}

function setCookieToday(layerId, expiredays) {
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	todayDate.setHours(0,0,0,0);
	document.cookie=""+layerId+"=DONE; expires=" + todayDate.toGMTString() + ";"
}

function LPAD2(str) {
	if((""+str).length==1) {
		str = "0"+str;
	}
	return str;
}

function getUrl(){
	var path	= this.location.href;
	var pos		= path.indexOf("?");
	var url		= "";
	var param	= "";

	if(pos >= 0){
		url		= path.substring(0, pos);
		param	= path.substring(pos+1, path.length);
	}else{
		url		= path;
	}
	
	return {"url" : url, "param" : param}
}





