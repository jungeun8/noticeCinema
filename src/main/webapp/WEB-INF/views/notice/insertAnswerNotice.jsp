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
<title>공지사항 답변 등록</title>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: #ecbd35; text-decoration: underline;}
</style>
</head>
<body>
<div class="container">
	<%@ include file="../common/header.jsp"%>
		<div class="top" style="margin-left:150px;  margin-top:50px;">
			<h3 >공지사항</h3>
		</div>
		<form id="notice-form" name="insertForm" method="post" action="../notice/insert/answer">
			<div style="padding:80px">
				<div class="mb-3">
		 			<label for="exampleFormControlInput1" class="form-label">제목</label>
		 			<input type="hidden" name="parNo" id="parNo" value="${parNo }"> 
		 			<input type="hidden" name="seq" id="seq" value="${seq }"> 
		  			<input type="text" class="form-control" id="title" name="title" maxlength="31" autofocus="autofocus">
		  			<p id="textCount" name="textCount">(0 / 최대 30자)</p>
				</div>
				<div class="mb-3">
				  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
				  <textarea class="form-control" id="content" name ="content" rows="3" maxlength="1000" autofocus="autofocus"></textarea>
				  <p id="textCount1" name="textCount1">(0 / 최대 1000자)</p>
				</div>
				<div style="text-align: right;">
					<button type="button" class="btn btn-warning" onclick="location.href='list'">목록</button>
					<button type="submit" id="insertBt" class="btn btn-warning"  onclick="checkForm()">등록</button>
				</div>	
			</div>
		</form>
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
		}else if(title.trim() == ""){
			 alert("제목을 공백없이 입력해주세요!!");
			 $("#title").focus();
	    	  return false;
		}
		var content = $("#content").val();
		if (!content) {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}else if(content.trim() ==""){
			 alert("내용을 공백없이 입력해주세요!!");
			 $("#content").focus();
	    	  return false;
		}
		return true;
		
	});
})

 $("#title").keydown(function(e) {
      var content = $(this).val();
      $("#textCount").text("(" + content.length + "/ 30자)"); //실시간 글자수 카운팅
   }); 

$("#title").keyup(function(e) {
      var content = $(this).val();
      $("#textCount").text("(" + content.length + "/ 30자)"); //실시간 글자수 카운팅 */ 
      if (content.length > 30) {
    	if( !alert("최대 30자까지 입력 가능합니다. (현재 글자수 : "+ content.length+")")){
    		$(this).val(content.substring(0, 30));
            $('#textCount').text("(30 / 최대 30자)");
    	}
      }else if(content.trim() ==""){
   	   if(content.length==0){
	    	 return true
	     }
		 alert("제목을 공백없이 입력해주세요!!");
		 $("#title").focus();
  	  return false;
	}
   });
   
   
$("#title").on('blur',function(){
	var content = $(this).val();
	if (content.length > 30) {
    	if( !alert("최대 30자까지 입력 가능합니다. (현재 글자수 : "+ content.length+")")){
    		$(this).val(content.substring(0, 30));
            $('#textCount').text("(30 / 최대 30자)");
    	}
      }
});
   
$("#content").keydown(function(e) {
    var content1 = $(this).val();
    $("#textCount1").text("(" + content1.length + "/ 1000자)"); //실시간 글자수 카운팅 */
 }); 
   

$("#content").keyup(function(e) {
   var content1 = $(this).val();
   $("#textCount1").text("(" + content1.length + "/ 1000자)"); //실시간 글자수 카운팅 */
   if (content1.length > 1000) {
	   if( !alert("최대 1000자까지 입력 가능합니다. (현재 글자수 : "+ content1.length+")")){
      $(this).val(content1.substring(0, 1000));
      $('#textCount1').text("(1000 / 최대 1000자)");
	   }
   }else if(content1.trim() ==""){
	   if(content1.length==0){
	    	 return true
	     }
		 alert("내용을 공백없이 입력해주세요!!");
		 $("#content").focus();
    	  return false;
	}
});

</script>
</body>
</html>