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

<title>공지사항</title>
<style type="text/css">
 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: #ecbd35; text-decoration: underline;}
 
 table{
 	table-layout:fixed;
 }
</style>
</head>
<body>
<div class="container-fluid">
	<%@ include file="../common/header.jsp"%>
		<div class="top" style="margin-left:150px;  margin-top:50px;">
			<h3>공지사항</h3>
		</div>
		<div class="row mb-3" style="padding:55px; margin-left:50px;">
			<div class="col-2">
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
				<nav class="navbar">
		  			<div class="container-fluid">
		   				 <form class="d-flex"id="search" method="get" action="../notice/list">
		   				 	 <input type="hidden" name="page" id="page" value="1">
		     				 <input class="form-control me-2 " type="search" id="searchWord" name="searchWord" value="${searchWord }" placeholder="제목을 검색해주세요" aria-label="Search">
		     				 <button class="btn btn-outline-dark" style="width: 100px;" onclick="serch_click()">검색</button>
		    			</form>
		    			<%-- div>(총: ${searchCnt }개)</div> --%>
		  			</div>
				</nav>
			
					<div class=" mb-3">
						<table class="table">
							<colgroup>
								<col width="10%">
								<col width="*">
								<col width="12%">
								<col width="12%">
								<col width="7%">
								<col width="8%">
							</colgroup>
							<thead style="background: #fbe5a5;">
								<tr class="text-center">
									<th>번호</th>
									<th>제목</th>
									<th>등록일</th>
									<th>작성자</th>
									<th>파일</th>
									<th class="text-end">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="noticeList" items="${noticeList }" varStatus="cnt">
									<tr>
										<input type="hidden" name=noticeNo id="noticeNo" value="${noticeList.no }"/>
												<!-- 검색조건일 경우 순번과 전체일경우 순번 -->
												<c:choose >
													<c:when test="${searchWord == ''}">
														<c:choose >
															<c:when test="${noticeList.parNum == 0 }"><td class="text-center"></td></c:when>
															<c:otherwise><td class="text-center">${noticeList.parNum }</td></c:otherwise >
														</c:choose> 
													</c:when>
													<c:otherwise>
															<td class="text-center">${searchCnt-((page-1)*10+cnt.index)}</td>
													</c:otherwise>	
													</c:choose> 
													<!-- 번호 끝!! -->
												<!-- 제목 -->
												<c:choose>
													<c:when test="${noticeList.status == 0 }">									
														<td style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; ">
														<pre style="margin:0px; overflow: auto; white-space: pre-wrap; color:blue"><c:out value="${noticeList.title }"/>
														<%-- <c:choose >
														<c:when test="${noticeList.getFileAllCnt > 0 }">
														<img src="/resources/images/notice/파일다운.png" width="17px"height="17px">
														</c:when>
														</c:choose> --%></pre></td>
													</c:when>
													<c:when test="${noticeList.status == 1 }"><td style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap; "><a href="detail?no=${noticeList.no }">
													<pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${noticeList.title }"/>
														<%-- <c:choose >
														<c:when test="${noticeList.getFileAllCnt> 0 }">
														<img src="/resources/images/notice/파일다운.png" width="17px"height="17px">
														</c:when>
														</c:choose>
													<c:choose ><c:when test="${noticeList.anwserCount != 0 }">(${noticeList.anwserCount })</c:when>
													<c:otherwise></c:otherwise></c:choose> --%></pre></a></td></c:when>
											</c:choose>
											<!-- 제목 끝 -->
										<td class="text-center"><fmt:formatDate value="${noticeList.creatDate }" pattern="yy.MM.dd"/></td>
										<td class="text-center"><pre style="margin:0px; overflow: auto; white-space: pre-wrap;"><c:out value="${noticeList.noticeId }"/></pre></td>
										<td class="text-center">
										<c:choose >
											<c:when test="${noticeList.getFileAllCnt> 0 }">
												📮
											</c:when><c:otherwise></c:otherwise>
										</c:choose>
										</td>
										<td class="text-end">${noticeList.hits }</td>
										
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div style="text-align: right;">
						<button type="button" class="btn btn-warning" onclick="location.href='list'">목록</button>
						<button type="button" class="btn btn-warning" onclick="location.href='add'">글쓰기</button>
						<button type="submit" class="btn btn-warning" onclick="location.href='excel/download?searchData=${searchWord }'">엑셀로 내려받기</button>
					</div>	
					<div style="margin-left: 30%; margin-top: 15px;"> 
						<nav aria-label="Page navigation example">
		 					<ul class="pagination" >
		 					<% 
		 					int nowPage = (int)request.getAttribute("page"); // 현재페이지 
		 					String searchWord = (String)request.getAttribute("searchWord");
		 					int pageAllCnt =(int)request.getAttribute("pageAllCnt");	// 총페이지
		 					int firstPage = (((nowPage-1)/5)*5)+1; // 각 행의 첫번째 페이지 계산
		 					%>
		 					<li class="page-item" id="paging"><a class="page-link" href="../notice/list?page=1&searchWord=<%=searchWord%>"  aria-label="firstPrevious"><span aria-hidden="true">처음</span></a></li>
							<li class="page-item"><a class="page-link" href="../notice/list?page=<%=firstPage-5<1?1:firstPage-5 %>&searchWord=<%=searchWord%>" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						  	 	<% 
						  	 		/* int firstPage = (int)request.getAttribute("startPage"); */
									/* int pageAllCnt123 =(int)request.getAttribute("pageAllCnt");	// 총페이지 */
						  	  		/* int nowPage = (int)request.getAttribute("page"); // 현재페이지  */
						  	 	 /* 	String searchWord = (String)request.getAttribute("searchWord"); */
						  	 	 /* 	int startPage = ((nowPage/5)*5)+1; // 첫번째 페이지 계산 */
									for(int i=firstPage; i<firstPage+5; i++){ 
										if(i>pageAllCnt) break;	// 만약에 총페이지 수보다 커지면 중지
										if(nowPage==i){
											%>
											<li class="page-item" id="paging"><a class="page-link" style="background-color:#ffc007" href="../notice/list?page=<%=i%>&searchWord=<%=searchWord%>"><%=i%></a></li>
											<%
										}else{
											%>
											<li class="page-item" id="paging"><a class="page-link" href="../notice/list?page=<%=i%>&searchWord=<%=searchWord%>"><%=i%></a></li>
											<%
										}
									}
								%>
								<% System.out.println("nowPage : " + nowPage); %>
								<% System.out.println("pageAllCnt123 : " + pageAllCnt); %>
								<% if((( (nowPage-1)/5 ) *5 )+5 < pageAllCnt){ // 맨 마지막 페이지가 화면에 보여지는 마지막 페이지보다 클 경우에만 보이도록 %> 
		    				<li class="page-item" id="paging"><a class="page-link" href="../notice/list?page=<%=firstPage+5>pageAllCnt?pageAllCnt:firstPage+5 %>&searchWord=<%=searchWord %>" aria-label="Next"><span aria-hidden="true">
		    				&raquo;
		    				</span></a></li> <% } %>
		    				<li class="page-item" id="paging"><a class="page-link" href="../notice/list?page=<%=pageAllCnt %>&searchWord=<%=searchWord %>"  aria-label="lastNext"><span aria-hidden="true">끝</span></a></li> 
		  					</ul>
						</nav>
					</div>
				</div>	
			<div>
		</div>	
 	</div>
	<%@ include file="../common/footer.jsp"%>
</div>
<script type="text/javascript">
$(function() {
	$("#search").submit(function() {
	var searchWord = $("#searchWord").val();
		if(searchWord.trim() == ""){
			alert("검색어를 한글자 이상 입력해주세요");
	    	  return false;
			}
	});		
})
</script>
</body>
<style>
	#top{
	margin:0 auto;
	
	}
</style>
</html>