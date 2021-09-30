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
<title>공지사항 등록</title>
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
		<form id="notice-form" name="insertForm" method="get" action="../notice/insert">
			<div style="padding:80px">
				<div class="mb-3">
		 			<label for="exampleFormControlInput1" class="form-label">제목</label>
		  			<input type="text" class="form-control" id="title" name="title">
		  			<p id="textCount" name="textCount">글자수</p>
				</div>
				<div class="mb-3">
				  <label for="exampleFormControlTextarea1" class="form-label">내용</label>
				  <textarea class="form-control" id="content" name ="content" rows="3"></textarea>
				  <p id="textCount1" name="textCount1">글자수</p>
				</div>
				<h5 class="mb-3">고객정보(*필수입력사항입니다)</h5>
				          <div class="row g-5" style="background: #f5f5f5;">
				            <div class="col-sm-6">
				            	<div class="form-floating mb-3">
  									<input type="text" class="form-control" id="noticeId" name="noticeId" placeholder="">
  									<label for="floatingInput">아이디</label>
								</div>
								<div class="form-floating">
 									 <input type="password" class="form-control" id="noitcePwd" name="noitcePwd" placeholder="">
 									 <label for="floatingPassword">비밀번호</label>
								</div>
				           </div>
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
		}
		var content = $("#content").val();
		if (!content) {
			alert("내용을 입력해주세요.");
			$("#content").focus();
			return false;
		}
		var noticeId = $("#noticeId").val();
		if(noticeId==""){
	        alert("아이디를 입력해주세요.");
	        $("#noticeId").focus();
	        return false;
		}
	     var noitcePwd = $("#noitcePwd").val();
	     if(noitcePwd==""){
	        alert("비밀번호를 입력해주세요.");
	        $("#noitcePwd").focus();
	        return false;
	     }else if(noitcePwd.length<4 || noitcePwd.length>8){
	    	 alert("비밀번호는 4자리에서 8자리 이내로 입력해주세요");
	    	 return false;
	     }
		return true;
		
	});
})

$("#title").keyup(function(e) {
      var content = $(this).val();
      $("#textCount").text("(" + content.length + "/ 80)"); //실시간 글자수 카운팅 */ 
      if (content.length > 80) {
    	  alert("최대 80자까지 입력 가능합니다.");
         $(this).val(content.substring(0, 80));
         $('#textCount').text("(80 / 최대 80자)");

        
      }
   });

$("#content").keyup(function(e) {
   var content1 = $(this).val();
   $("#textCount1").text("(" + content1.length + "/ 1200)"); //실시간 글자수 카운팅 */
   if (content.length > 1200) {
 	  alert("최대 1200자까지 입력 가능합니다.");
      $(this).val(content.substring(0, 1200));
      $('#textCount1').text("(1200 / 최대 1200자)");
   }
});


</script>
</body>
</html>