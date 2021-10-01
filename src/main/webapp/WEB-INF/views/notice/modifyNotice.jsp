<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/cinemabox/resources/css/common.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="/cinemabox/resources/js/common.js"></script>
<title>공지사항 수정</title>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: #ecbd35; text-decoration: underline;}
</style>
</head>
<body>
<div class="container-fluid">
	<%@ include file="../common/header.jsp"%>
		<div class="top" style="margin-left:150px;  margin-top:50px;">
			<h3 >공지사항</h3>
		</div>
		<div style="padding:80px">
			<form id="notice-form" name="update" action="../notice/newModify" method="post" onsubmit="return check()">
				<div class="mb-3">
				  <label for="exampleFormControlInput1" class="form-label">제목</label>
				  <input type="text" class="form-control" id="title" name="title" value="${noticeDetail.title }"/>
				  <p id="textCount" name="textCount">글자수</p>
				</div>
				<div class="mb-3">
				  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
				   <textarea class="form-control" id="content" name ="content" rows="3">${noticeDetail.content }</textarea>
				    <p id="textCount1" name="textCount1">글자수</p>
				  <input type="hidden" name="no" id="no" value="${noticeDetail.no }"> 
				</div>
				<div style="text-align: right;">
	                <input type=submit value="수정" onclick="checkForm()"/>
	                <input type=button value="목록" onclick="location.href='list'"/>
	            </div>
	   		</form>
		</div>
	<%@ include file="../common/footer.jsp"%>	
</div>
<script type="text/javascript">
$(function() {
	// 입력값 유효성 체크해서 전부 값이 입력되어 있을 때만 폼 입력값이 서버로 제출되게 하기
	$("#notice-form").submit(function() {
		
		var title = $("#title").val();
		if (!title) {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return false;
		}else if(title.search(/\s/) != -1){
			 alert("제목에 공백 없이 입력해주세요.");
	    	  return false;
	    }
		var content = $("#content").val();
		if (!content) {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}else if(content.search(/\s/) != -1){
			 alert("내용에 공백 없이 입력해주세요.");
	    	  return false;
		}
		return true;
    	alert("글이 등록됩니다!");
	});
})

$("#title").keyup(function(e) {
    var content = $(this).val();
    $("#textCount").text("(" + content.length + "/ 50자)"); //실시간 글자수 카운팅 */ 
    if (content.length > 50) {
  	  alert("최대 50자까지 입력 가능합니다.");
       $(this).val(content.substring(0, 80));
       $('#textCount').text("(50 / 최대 50자)");
		return false;
    }
    return true;
 });

$("#content").keyup(function(e) {
 var content1 = $(this).val();
 $("#textCount1").text("(" + content1.length + "/ 1000자)"); //실시간 글자수 카운팅 */
 if (content1.length > 1000) {
	  alert("최대 1000자까지 입력 가능합니다.");
    $(this).val(content1.substring(0, 1200));
    $('#textCount1').text("(1000 / 최대 1000자)");
 }
});
		
</script>
</body>
</html>