<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
				 <pre style="margin:0px; overflow: auto; white-space: pre-wrap;">
				 <textarea class="form-control" id="title" name ="title" rows="1" maxlength="30" autofocus="autofocus"><c:out value="${noticeDetail.title}"/></textarea></pre>
				  <p id="textCount" name="textCount">(${fn:length(noticeDetail.title) } / 최대 30자)</p>
				</div>
				<div class="mb-3">
				  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
				   <pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><textarea class="form-control" id="content" name ="content" rows="3" maxlength="1000" autofocus="autofocus"><c:out value="${noticeDetail.content}"/></textarea></pre>
				    <p id="textCount1" name="textCount1">(${fn:length(noticeDetail.content) } / 최대 1000자)</p>
				     <input type="hidden" name="content99" id="content99" value="${noticeDetail }"> 
				  <input type="hidden" name="no" id="no" value="${noticeDetail.no }"> 
				</div>
				<h5 class="mb-3">고객정보(필수입력사항입니다)</h5>
				          <div class="row g-5" style="background: #f5f5f5;">
				            <div class="col-sm-6">
				            	<div class="form-floating mb-3">
  									<input type="text" class="form-control" id="noticeId" name="noticeId" value="${noticeDetail.noticeId }" maxlength="4" placeholder="" autofocus="autofocus">
  									<label for="floatingInput">작성자</label>
  									<p>**공백없이 4자리까지 작성해주세요</p>
								</div>
								<div class="form-floating">
 									 <input type="password" class="form-control" id="noitcePwd" name="noitcePwd" value="${noticeDetail.noitcePwd }" maxlength="10" placeholder="" autofocus="autofocus">
 									 <label for="floatingPassword">비밀번호</label>
 									 <p>**6~10자리로 공백없이 영문,숫자,특수문자를 포함해주세요</p>
								</div>
				           </div>
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
/* window.onload = function(){
	console.log("test :",content99);
	var a = content99;
	debugger;
	$('#content').val(content99.value);

} */
$(function() {
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
		var noticeId = $("#noticeId").val();
		if(!noticeId){
	        alert("작성자를 입력해주세요.");
	        $("#noticeId").focus();
	    	  return false;
		}
	     var noitcePwd = $("#noitcePwd").val();
	     var num = noitcePwd.search(/[0-9]/g);
	     var eng = noitcePwd.search(/[a-z]/ig);
	     var spe = noitcePwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	     if(!noitcePwd){
	    	 alert("비밀번호를 입력해주세요.");
		        $("#noitcePwd").focus();
		        return false;
		     }
		     else if(noitcePwd.search(/\s/) != -1){
		    	 alert("비밀번호는 공백 없이 입력해주세요.");
		    	 $(this).val("");
		    	 $(this).focus();
		    	 return false; 
		     }else if(noitcePwd.length<6 || noitcePwd.length>10){
		    	  alert("비밀번호는 6자리에서 10자리 이내로 입력해주세요");
		    	  $(this).val("");
		     	  $(this).focus();
		    	  return false;
		     }else if(num < 0 || eng < 0 || spe < 0){
		    	  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
		     	 $(this).val("");
		    	 $(this).focus();
		    	  return false;
		    	 }
		return true;
    	alert("글이 등록됩니다!");
	});
})

$("#noitcePwd").on('blur',function(){
	 var noitcePwd = $("#noitcePwd").val();
     var num = noitcePwd.search(/[0-9]/g);
     var eng = noitcePwd.search(/[a-z]/ig);
     var spe = noitcePwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
     if(noitcePwd.length==0){
    	 return true
     }
     else if(noitcePwd.search(/\s/) != -1){
    	 alert("비밀번호는 공백 없이 입력해주세요.");
    	 $(this).val("");
    	 $(this).focus();
    	 return false; 
     }else if(noitcePwd.length<6 || noitcePwd.length>10){
    	  alert("비밀번호는 6자리에서 10자리 이내로 입력해주세요");
    	  $(this).val("");
     	  $(this).focus();
    	  return false;
     }else if(num < 0 || eng < 0 || spe < 0){
    	  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
     	 $(this).val("");
    	 $(this).focus();
    	  return false;
    	 }
})

$("#noitcePwd").keyup(function(e) {
	 var noitcePwd = $("#noitcePwd").val();
		 if(noitcePwd.search(/\s/) != -1){
	    	  alert("비밀번호는 공백 없이 입력해주세요.");
	    	  $(this).focus();
	    	  return false;
		}
  });  

$("#noticeId").keyup(function(e) {
	 var noticeId = $("#noticeId").val();
		if(noticeId.length>4){
			$(this).val(noticeId.substring(0, 4));
	    	 alert("작성자는 4자리 이내로 입력해주세요");
	    	 $(this).focus();
	    	 return false;
		}else if(noticeId.search(/\s/) != -1){
	    	  alert("작성자는 공백 없이 입력해주세요.");
	    	  $(this).focus();
	    	  return false;
		}
   });  


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