/**
 * 
 */

/*************************************
* 도서 상품 미리보기 팝업
*************************************/ 
function popPreview(isbn) {

    if (typeof(isbn) == "undefined" || isbn == "") {
        return;
    }
    
    window.open("/webproject/book_preview.action?isbn=" + isbn, "preview", "width="+screen.availWidth+",height="+screen.availHeight+",resizable=yes,scrollbars=yes");
}