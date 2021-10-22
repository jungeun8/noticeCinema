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
    						 <input type="hidden" name="parNo" id="parNo" value="${noticeDetail.parNo }"> 
    						 <input type="hidden" name="seq" id="seq" value="${noticeDetail.seq }"> 
    						 <input type="hidden" name="depth" id="depth" value="${noticeDetail.depth }"> 
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
									<c:forEach items="${list }" var="list" varStatus="status">
										<tr class="content">
											<td colspan="3" >
											<div style="display: flex; justify-content: end">
											<button style="position: absolute;" class="btn btn-sm" onclick="moreClick(this);">더보기</button>
											</div>
											 <input type="hidden" name="deleteNo" id="deleteNo" value="${noticeDetail.no }"> 
											  <input type="hidden" name="listNo" id="listNo" value="${list.no }"> 
											  <input type="hidden" name="answerNo" id="answerNo" value="${list.answerNo }"> 
											<h6>작성자:${list.id }</h6>
											<div id="contentAnswer" name="contentAnswer"><pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${list.content }"/></pre></div>
											<h6><fmt:formatDate value="${list.answerDate }" pattern="yyyy.MM.dd"/></h6></td>	
											
										</tr>
										</c:forEach>
									</tbody>
								</table>
								<div class="" style="padding-bottom: 60px;">
  									<label for="exampleFormControlTextarea1" class="form-label">댓글을 달아주세요 ** 작성자와 비밀번호를 입력해주세요**</label>
		  							<form id="notice-form" name="insertForm" method="post" action="../notice/answerInsert">
		  							<div>
			  							<input type="text" id="id" name="id" placeholder="작성자" value=""  maxlength="4">
			  							<input type="password" id="pwd" name="pwd" placeholder="비밀번호" value=""  maxlength="10">
			  							<input type="hidden" name="no" id="no" value="${no }"> 
			  							 <input type="hidden" name="detailNo" id="detailNo" value="${noticeDetail.no }"> 
		  							</div>
	  								<textarea class="form-control" id="content" name="content" maxlength="300" rows="3"></textarea>
	  								<button type="submit" class="btn btn-light" style="float: right;" onclick="checkForm()">등록</button>
	  								<p id="textCount" name="textCount">(0 / 최대 300자)</p>
	  								</form>
								</div>
							</div>
						</div>
				<div style="text-align: right;">
					<button type="button" class="btn btn-warning"  onclick="location.href='addAnswer?no=${noticeDetail.no}&parNo=${noticeDetail.parNo}&seq=${noticeDetail.seq}&depth=${noticeDetail.depth}'">답글</button>
					<button type="button" class="btn btn-warning" onclick="location.href='list'">목록</button>
					<button type="button" class="btn btn-warning"  onclick="location.href='confirm?no=${noticeDetail.no}'">수정</button>
					<button type="button" class="btn btn-warning" id="delete" onclick="">삭제</button>
				</div>
				
					<div style="margin-left: 30%; margin-top: 15px;"> 
						<nav aria-label="Page navigation example">
		 					<ul class="pagination" >
		 					<% 
		 					int nowPage = (int)request.getAttribute("page"); // 현재페이지 
		 					int pageAllCnt =(int)request.getAttribute("pageAllCnt");	// 총페이지
		 					int firstPage = (((nowPage-1)/10)*10)+1; // 각 행의 첫번째 페이지 계산
		 					%>
		 					<li class="page-item" id="paging"><a class="page-link" href="../notice/detail?page=1"  aria-label="firstPrevious"><span aria-hidden="true">처음</span></a></li>
							<li class="page-item"><a class="page-link" href="../notice/detail?page=<%=firstPage-10<1?1:firstPage-10 %>" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						  	 	<% 
						  	 		/* int firstPage = (int)request.getAttribute("startPage"); */
									/* int pageAllCnt123 =(int)request.getAttribute("pageAllCnt");	// 총페이지 */
						  	  		/* int nowPage = (int)request.getAttribute("page"); // 현재페이지  */
						  	 	 /* 	String searchWord = (String)request.getAttribute("searchWord"); */
						  	 	 /* 	int startPage = ((nowPage/5)*5)+1; // 첫번째 페이지 계산 */
									for(int i=firstPage; i<firstPage+10; i++){ 
										if(i>pageAllCnt) break;	// 만약에 총페이지 수보다 커지면 중지
										if(nowPage==i){
											%>
											<li class="page-item" id="paging"><a class="page-link" style="background-color:#ffc007" href="../notice/detail?page=<%=i%>"><%=i%></a></li>
											<%
										}else{
											%>
											<li class="page-item" id="paging"><a class="page-link" href="../notice/detail?page=<%=i%>"><%=i%></a></li>
											<%
										}
									}
								%>
								<% System.out.println("nowPage : " + nowPage); %>
								<% System.out.println("pageAllCnt123 : " + pageAllCnt); %>
								<% if((( (nowPage-1)/10 ) *10 )+10 < pageAllCnt){ // 맨 마지막 페이지가 화면에 보여지는 마지막 페이지보다 클 경우에만 보이도록 %> 
		    				<li class="page-item" id="paging"><a class="page-link" href="../notice/detail?page=<%=firstPage+10>pageAllCnt?pageAllCnt:firstPage+10 %>" aria-label="Next"><span aria-hidden="true">
		    				&raquo;
		    				</span></a></li> <% } %>
		    				<li class="page-item" id="paging"><a class="page-link" href="../notice/detail?page=<%=pageAllCnt %>"  aria-label="lastNext"><span aria-hidden="true">끝</span></a></li> 
		  					</ul>
						</nav>
					</div>
							<% 
		 					int answerNo =(int)request.getAttribute("answerNo");	
		 					%>
		 			<!--모달창 -->
					<div class="modal fade" id="form-more-modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalLabel">수정/삭제</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
							
								<div class="modal-body">
									 <form id="form-movie">
										<div class="row px-3 mb-3">
											<label for="floatingInput">수정하기</label>	
											 <input type="text" class="form-control" id="modifyContent" name="modifyContent" value=""/>
										</div>
										<div class="row px-3 mb-3">
											<label for="floatingInput">비밀번호 입력</label>
											<input type="password" class="form-control" id="passwordModal" name="passwordModal" placeholder="비밀번호">
											 <input type="hidden" name="deleteNo1" id="deleteNo1" value="<%=answerNo %>">
											 <input type="hidden" name="answerNowNo" id="answerNowNo" value="">  
										</div>
									</form>
								</div>
						
								
					<div class="modal-footer">
						<button type="button" class="btn btn-warning" id="insert-modal">등록</button>
						<button type="button" class="btn btn-warning" id="delete-modal">삭제 </button>
				</div>
			</div>
		</div>
	</div>
					
					
					
					
			</div>		
	</div>
	<%@ include file="../common/footer.jsp"%>
	
</div>
<script type="text/javascript">
var listModal = new bootstrap.Modal(document.getElementById("form-more-modal"), {
	keyboard: false
})

//더보기 버튼을 클릭했을 때 실행된다.
function moreClick(e){
	$("#modifyContent").val(e.parentElement.parentElement.children[5].children[0].textContent);
	$("#passwordModal").val("");
	$("#answerNowNo").val(e.parentElement.parentElement.children[3].value);
	listModal.show();
}

//모달창에서 등록 버튼을 클릭했을 때 실행된다.
$("#insert-modal").click(function() {
	var passwordModal = $.trim($("#passwordModal").val());
	if (!passwordModal) {
		alert("비밀번호를 입력해주세요.");
		$("#passwordModal").focus();
		return false;
	}
	$.ajax({
		type: "POST",
		url: "/cinemabox/notice/modifyList",
		data: {pwd: $("#passwordModal").val(),
				answerNo: $("#answerNowNo").val(),
				content: $("#modifyContent").val()},
		error : function(error) {
	        alert("Error!");
	    },
		success : function(result){
			if(result) { 
			alert("등록되었습니다.");
			listModal.hide();
		}else {
			alert("비밀번호가 틀렸습니다"); 
			}
		},
	    complete : function() {
	      /*   alert("삭제되었습니다."); 
	        location.href='delete?no='+no; */
	    }
	});
})

//모달창에서 삭제 버튼을 클릭했을 때 실행된다.
$("#delete-modal").click(function() {
	var passwordModal = $.trim($("#passwordModal").val());
	if (!passwordModal) {
		alert("비밀번호를 입력해주세요.");
		$("#passwordModal").focus();
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/cinemabox/notice/deleteAnswer",
		data: {pwd: $("#passwordModal").val(),
			answerNo: $("#answerNowNo").val()},
		error : function(error) {
	        alert("비밀번호가 틀렸습니다");
	    },
		success : function(result){
			if(result) { 
			alert("삭제되었습니다");
			listModal.hide();
		}else {
			alert("비밀번호가 틀렸습니다"); 
			}
		},
	    complete : function() {
	      /*   alert("삭제되었습니다."); 
	        location.href='delete?no='+no; */
	    }
	});
})



// 글 삭제
$("#delete").click(function() {
	if($("#password").val()==""){ // 비밀번호가 없는 경우
		alert("비밀번호를 입력해주세요!!");
		$("#password").focus();
		return;
	}$.ajax({
		type: "POST",
		url: "/cinemabox/notice/deleteList",
		data: {noitcePwd: $("#password").val(),
				no: $("#deleteNo").val(),
				parNo : $("#parNo").val(),
				depth : $("#depth").val(),
				seq : $("#seq").val()},
		error : function(error) {
	        alert("Error!");
	    },
		success : function(result){
			switch(result){
				case "existComment" :
					alert("댓글이 존재하는 게시글은 삭제가 불가능합니다.");
					break;
					
				/* case "existAnswer" :
					alert("답글이 존재하는 게시글은 삭제가 불가능합니다.");
					break; */
				case "notPwd" :
					alert("비밀번호가 일치하지 않습니다.");
					break;
				case "success" :
					location.href='delete?no='+$("#deleteNo").val();
					alert("삭제 되었습니다.");
					break;
				default :
					alert("오류가 발생하였습니다. 관리자에게 문의하여 주십시오."+result);
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
			var id = $("#id").val();
			if(!id){
		        alert("작성자를 입력해주세요.");
		        $("#id").focus();
		    	  return false;
			}
		     var pwd = $("#pwd").val();
		     var num = pwd.search(/[0-9]/g);
		     var eng = pwd.search(/[a-z]/ig);
		     var spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		     if(!pwd){
		        alert("비밀번호를 입력해주세요.");
		        $("#pwd").focus();
		        return false;
		     }
		     else if(pwd.search(/\s/) != -1){
		    	 alert("비밀번호는 공백 없이 입력해주세요.");
		    	 $(this).val("");
		    	 $(this).focus();
		    	 return false; 
		     }else if(pwd.length<6 || pwd.length>10){
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

	 $("#id").keyup(function(e) {
		 var id = $("#id").val();
			if(id.length>4){
				$(this).val(id.substring(0, 4));
		    	 alert("작성자는 4자리 이내로 입력해주세요");
		    	 $(this).focus();
		    	 return false;
			}else if(id.search(/\s/) != -1){
		    	  alert("작성자는 공백 없이 입력해주세요.");
		    	  $(this).focus();
		    	  return false;
			}
	   }); 

	$("#pwd").keyup(function(e) {
		 var pwd = $("#pwd").val();
			 if(pwd.search(/\s/) != -1){
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
	   


	$("#pwd").on('blur',function(){
		 var pwd = $("#pwd").val();
	     var num = pwd.search(/[0-9]/g);
	     var eng = pwd.search(/[a-z]/ig);
	     var spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	     if(pwd.length==0){
	    	 return true
	     }
	     else if(pwd.search(/\s/) != -1){
	    	 alert("비밀번호는 공백 없이 입력해주세요.");
	    	 $(this).val("");
	    	 $(this).focus();
	    	 return false; 
	     }else if(pwd.length<6 || pwd.length>10){
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