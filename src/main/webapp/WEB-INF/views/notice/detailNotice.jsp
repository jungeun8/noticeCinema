<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
     <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>공지사항 상세</title>
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
		<div class="row mb-3" style="padding:65px">
			<div class="col-2" style="margin-left:50px;">
				<table class="table">
					<tbody>
						<tr>
							<td><a href="../customerCenter/main">고객센터 메인</a></td>
						</tr>
						<tr>
							<td><a href="list">공지사항</a></td>
						</tr>
						<tr>
							<td><a href="../customerCenter/userInfo">1:1 문의</a></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-9">
				<table class="table mb-3" style="margin:auto">
					<colgroup>
						<col width="*">
						<col width="25%">
						<col width="15%">
					</colgroup>
					<thead style="background: #fbe5a5;">
						<tr>
							<th><pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${noticeDetail.title }"/></pre></th>
							<th>등록일<span><fmt:formatDate value="${noticeDetail.creatDate }" pattern="yyyy.MM.dd"/></span></th>
							<th style="text-end">조회수<span>${noticeDetail.hits }</span></th>
						</tr>
					</thead>
					<tbody>
						<tr class="content">
							<%-- <td colspan="3" style="padding:35px;"><xmp>${noticeDetail.content }</xmp></td>	 --%>
							<td colspan="3" style="padding:35px;"><pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${noticeDetail.content}"/></pre></td>
						</tr>
						<tr>
							<td colspan="3">
								<span style="margin-right:20px">다음글</span><a style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;" 
								href="detail?no=${noticeDetail.nextNo }"><pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${noticeDetail.nextTitle }"/></pre></a>
								
							</td>
							</tr>
							<tr>
								<td colspan="3">
									<span style="margin-right:20px">이전글</span><a style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;" 
									href="detail?no=${noticeDetail.preNo }"><pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${noticeDetail.preTitle }"/></pre></a>
								</td>
							</tr>
						</tbody>
				</table>
						 <div class="col-4  mb-5">
    						<label for="inputPassword" class="visually-hidden">비밀번호</label>
    						 <input type="hidden" name="deleteNo" id="deleteNo" value="${noticeDetail.no }"> 
    						<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">**삭제시 비밀번호를 입력하세요
 						</div>
 					<!-- 댓글 구현 -->
 						<div class="row mb-3">
							<div class="col-12">
								<table class="table mb-3" style="margin:auto">
									<thead>
										<tr>
											<th>댓글</th>
										</tr>
									</thead>
									<tbody>
										<tr class="content">
											<td colspan="3" >
											<h6>작성자</h6>
											<div class="btn-group">
											  <button style="float: right;" class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">더보기</button>
											  <ul class="dropdown-menu">
											   <li>수정</li>
											   <li>삭제</li>
											  </ul>
											</div>
											<pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value=""/>댓글 내용</pre>
											<h6><fmt:formatDate value="${noticeDetail.creatDate }" pattern="yyyy.MM.dd"/></h6></td>	
										</tr>
									</tbody>
								</table>
								<div class="" style="padding-bottom: 60px;">
  							<label for="exampleFormControlTextarea1" class="form-label">댓글을 달아주세요 ** 작성자와 비밀번호를 입력해주세요**</label>
  							<div>
  							<input type="text" id="noticeId" name="noticeId" placeholder="작성자" value=""  maxlength="4" autofocus="autofocus">
  							<input type="password" id="noitcePwd" name="noitcePwd" placeholder="비밀번호" value=""  maxlength="10" autofocus="autofocus">
  							</div>
  							<textarea class="form-control" id="content" name="content" maxlength="300" rows="3"  autofocus="autofocus"></textarea>
  							<button type="button" class="btn btn-light" style="float: right;" onclick="checkForm()">등록</button>
  							<p id="textCount" name="textCount">(0 / 최대 300자)</p>
						</div>
							</div>
						</div>
				<div style="text-align: right;">
					<button type="button" class="btn btn-warning"  onclick="location.href='addAnswer?no=${noticeDetail.no}&parNo=${noticeDetail.parNo}&seq=${noticeDetail.seq}&depth=${noticeDetail.depth}'">답글</button>
					<button type="button" class="btn btn-warning" onclick="location.href='list'">목록</button>
					<button type="button" class="btn btn-warning"  onclick="location.href='confirm?no=${noticeDetail.no}'">수정</button>
					<button type="button" class="btn btn-warning" id="delete" onclick="">삭제</button>
				</div>
			</div>		
	</div>
	<%@ include file="../common/footer.jsp"%>
	
</div>
<script type="text/javascript">
$("#delete").click(function() {
	if($("#password").val()==""){ // 비밀번호가 없는 경우
		alert("비밀번호를 입력해주세요!!");
		$("#password").focus();
		return;
	}$.ajax({
		type: "POST",
		url: "/cinemabox/notice/deleteList",
		data: {noitcePwd: $("#password").val(),
				no: $("#deleteNo").val()},
		error : function(error) {
	        alert("Error!");
	    },
		success : function(result){
			if(result) { 
			location.href='delete?no='+$("#deleteNo").val();
			alert("삭제되었습니다");
		}else {
			alert("비밀번호가 틀렸습니다"); 
			}
		},
	    complete : function() {
	      /*   alert("삭제되었습니다."); 
	        location.href='delete?no='+no; */
	    }
	})
});

 
 $(function() {
		// 입력값 유효성 체크해서 전부 값이 입력되어 있을 때만 폼 입력값이 서버로 제출되게 하기
		$("#notice-form").submit(function() {
			
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
			
		});
	})

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

	$("#noitcePwd").keyup(function(e) {
		 var noitcePwd = $("#noitcePwd").val();
			 if(noitcePwd.search(/\s/) != -1){
		    	  alert("비밀번호는 공백 없이 입력해주세요.");
		    	  $(this).focus();
		    	  return false;
			}
	  });  
	  
	   

	 $("#content").keydown(function(e) {
	      var content = $(this).val();
	      $("#textCount").text("(" + content.length + "/ 300자)"); //실시간 글자수 카운팅
	   }); 

	$("#content").keyup(function(e) {
	      var content = $(this).val();
	      $("#textCount").text("(" + content.length + "/ 300자)"); //실시간 글자수 카운팅 */ 
	      if (content.length > 300) {
	    	if( !alert("최대 300자까지 입력 가능합니다. (현재 글자수 : "+ content.length+")")){
	    		$(this).val(content.substring(0, 300));
	            $('#textCount').text("(300 / 최대 300자)");
	    	}
	      }else if(content.trim() ==""){
	   	   if(content.length==0){
		    	 return true
		     }
			 alert("내용을 공백없이 입력해주세요!!");
			 $("#content").focus();
	  	  return false;
		}
	   });
	   
	   
	$("#content").on('blur',function(){
		var content = $(this).val();
		if (content.length > 300) {
	    	if( !alert("최대 100자까지 입력 가능합니다. (현재 글자수 : "+ content.length+")")){
	    		$(this).val(content.substring(0, 300));
	            $('#textCount').text("(300 / 최대 300자)");
	    	}
	      }
	});
	   


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
</script>
</body>
</html>