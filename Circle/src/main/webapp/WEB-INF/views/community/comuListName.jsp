<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Circle</title>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/community/comuList.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<style>
#listArea{

 color:black;
 font-size: 17px;
	font-weight: bolder;
}
#listbar{
 background:#D8D8D8;
 height:25px;
		border:1px solid silver;
		margin: auto;
}
td{
		width:500px;
		height:50px;
		border:1px solid black;
		font-weight: bolder;
		margin:0 auto ;
		 background:#E8F0FD;
		 margin-top:2px auto;
	}
</style>

<script type="text/javascript">
	function list(page){
		location.href = "comuList?curPage="+page
	}
</script>

</head>
<body>
	<div class="wrap">
		<jsp:include page="../common/menuTopBar.jsp" />
		<jsp:include page="../common/menuAlertBar.jsp" />
		<div class="container">
			<div class="navLeft">
				<jsp:include page="../community/comuLeftBar.jsp" />
			</div>
			<div class="content">
				<div>
					<jsp:include page="../community/comuHomeBar.jsp"/>
					<jsp:include page="../community/comuHomeListBar.jsp"/>
				</div>
				
				<div class="comuList">
				<br>
			<form>				
			<table id="listArea" style="text-align: center; border: 1px solid #FFOODD;">
				<tr id="listbar">
					<!-- <th width="100px" style="background-color:#eeeeee; text-align: center; color:#black; ">글번호</th> -->
					<th width="100px" style="background-color:#eeeeee; text-align: center; color:#black; ">동호회 이름</th>
					<th width="300px" style="background-color:#eeeeee; text-align: center; color:#black; ">동호회 대표</th>
					<th width="100px" style="background-color:#eeeeee; text-align: center; color:#black; ">직급</th>
					<th width="100px" style="background-color:#eeeeee; text-align: center; color:#black; ">가입신청</th>
					<!-- <th width="150px" style="background-color:#eeeeee; text-align: center; color:#black; ">작성일</th> -->
				<!-- width="150px" -->
				</tr>
				<tr>
					<th><hr></th>
				</tr>
				<tbody>
					
						
				<c:forEach var="comuListName" items="${comuListName}"> 
					<th><input type="hidden" name="comu_list_code" value="${comuListName.comu_list_code}"><th>
					<tr id="ListName">
						<td ><br><a href='<c:url value='/community/comuListPost?comu_list_code=${comuListName.comu_list_code}'/>'>${comuListName.comu_list_name}</a></td>
						<td><br>${comuListName.emp_info_name}</td>
						<td><br>${comuListName.job_info_name}</td>
						<td><br><a href='<c:url value='/community/comuApp?comu_list_code=${comuListName.comu_list_code}'/>'>가입신청하기</a></td>
						<%-- <td><br>${comuList.comu_post_view}</td>
						<td><br>${comuList.comu_post_dat}</td> --%>
						<%-- <td><c:out value="${ comuList.comu_post_dat }"/></td> --%>
					</tr>
				 </c:forEach> 
				</tbody>
				<!-- 주석주석 -->
				
				
				
				<!-- 페이지 구현 -->
				<%-- <tr>
					<td colspan="5" align="center">
				<!-- 현재 페이지 블럭이 1보다 크면 처음 페이지로 이동 -->
					<c:if test="${map.pager.curBlock > 1}">
					<a href="javascript:list('1')">[처음]</a>
					</c:if>
				<!-- 현재 페이지 블럭이 1보다크면 [이전]을 출력 -->
					<c:if test="${map.pager.curBlock > 1}">
					<a href="javascript:list('${map.pager.prevPage}')">[이전]</a>
					</c:if>
				<!-- 페이지블럭 처음부터 마지막 블럭까지 1 씩 증가하는 페이지 출력 -->
					<c:forEach var="comu_post_ordr"
					begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
						<c:choose>
							<c:when test="${comu_post_ordr == map.pager.curPage}">
								<span style="color: #D9418C;">${comu_post_ordr}</span>&nbsp;
								
							</c:when>				
								<c:otherwise>
									<a href="javascript:list('${comu_post_ordr}')">${comu_post_ordr}</a>&nbsp;
								</c:otherwise>
						</c:choose>
					</c:forEach>
					<!-- 다음 페이지 블록으로 이동 -->
						<c:if test="${map.pager.curBlock <=map.pager.totBlock}">
						<a href="javascript:list('${map.pager.nextPage}')">[다음]</a>
						</c:if>
					<!-- 끝 페이지로 이동 -->
						<c:if test="${map.pager.curBlock <=map.pager.totPage}">
						<a style="color:#D9418C;"
							href="javascript:list('${map.pager.totPage}')">[끝]</a>			
						</c:if>	
					</td>
				</tr> --%>
				
			</table>
			</form>
			
				</div>		
			</div>
		</div>
	</div>

</body>
</html>