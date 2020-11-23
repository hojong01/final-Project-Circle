<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Circle</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sign/signWrite.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<body>		
	<div class="wrap">
		<jsp:include page="../common/menuTopBar.jsp" />
		<jsp:include page="../common/menuAlertBar.jsp" />
	</div>
		<div class="leftBar">
				<jsp:include page="../sign/signLeftBar.jsp" />
			</div>
			<div class="container">
				<form role="form" method="post" action="/sign/signWrite">
					<div class="contentBar">
						<jsp:include page="../sign/signWriteBar.jsp" />
						<div class="signHomeListBar">
							<button class="signListBtn" type="submit">작성하기</button>
						</div>
						<div class="content">
							<div class="formBox">
							<table>
								<tr>
									<th class="formBox1">작성자</th>
									<th class="formBox2">
									<input type="text" class="formInput1" id="emp_info_name" value="${member.EMP_INFO_NAME}" readonly>
									<input type="text" class="formInput1" id="sign_emp_code" value="${member.EMP_INFO_EMP_NO}" readonly>
									<input type="text" class="formInput1" id="sign_count" value="" readonly>
									</th>
									<th class="formBox1">직급</th>
									<th class="formBox2"><input type="text" class="formInput1" id="job_info_name" value="${member.EMP_INFO_JOB_CODE}" readonly></th>
								</tr>
								<tr>
									<th class="formBox1">보존 연한</th>
									<th class="formBox2">
										<select class="formSelect1" id="sign_keep" name="sign_keep">
											<option value="365">1 년</option>
											<option value="1095">3 년</option>
											<option value="1825">5 년</option>
											<option value="3650">10 년</option>
											<option value="null">영구</option>
										</select>
									</th>
									<th class="formBox1">보안 등급</th>
									<th class="formBox2">
										<select class="formSelect1" id="sign_acc" name="sign_acc">
											<option value="1">S 등급</option>
											<option value="2">A 등급</option>
											<option value="3">B 등급</option>
											<option value="4">C 등급</option>
										</select>
									</th>
								</tr>
								<tr>
									<th class="formBox1">문서 유형</th>
									<th class="formBox4" colspan="3">
										<select class="formSelect2" id="signType" name="signType">
												<option value="0">문서 유형을 선택하세요</option>
											<c:forEach var="item" items="${list}">
												<option value="${item.sign_type_code}">${item.sign_type_name}</option>
											</c:forEach>
										</select>
									</th>
								</tr>
								<tr>
									<th class="formBox1">제목</th>
									<th class="formBox4" colspan="3"><input type="text" class="formInput2" id="sign_title" name="sign_title"></th>
								</tr>
								<tr>
									<th class="formBox0"></th>
								</tr>
							</table>							
							<div class="formBox5" id="editor" class="sign_note">
							</div>
						</div>
						<div class="formRight">
							<div>
								<div class="formBtn1" id="signJoinerBtn" onclick="signJoiner();">결재자 등록</div>
								<div class="joinAlert">결재자가 저장되었습니다</div>
								<div class="joinForm1">
									<div>
										<img src="${pageContext.request.contextPath}/resources/img/sign/arrow2.png" class="joinArrow">
									</div>
									<div class="joinForm2">
										<div class="joinForm3">
											<!-- <input type="text" class="joinerSearchBox" placeholder="&nbsp;사번/이름/직급/부서 검색"> -->
											<input type="text" class="searchTitle" value="결재자를 왼쪽으로 드래그해서 등록하세요" readonly>
										</div>
										<div class="joinForm4">
											<div class="joinForm5">
												<div class="joinForm7">
													<div class="joinForm8">
														<input type="text" class="joinInput1" value="구성원 목록" readonly>
													</div>
													<div class="joinForm9">
													<!-- 구성원 출력될 자리 -->
														<div id="resultBox1" class="connectedSortable">
															<c:forEach var="emp" items="${list2}">
																	<ul class="resultBackground">
																		<li class="result0"><img src="${pageContext.request.contextPath}/resources/img/test/user.png" class="resultImg"></li>
																		<li class="result1"><c:out value="${emp.emp_info_emp_no}"/></li>
																		<li class="result2"><c:out value="${emp.emp_info_name}"/></li>
																		<li class="result3"><c:out value="${emp.job_info_name}"/>/<c:out value="${emp.dept_info_name}"/></li>
																	</ul>
															</c:forEach>
														</div>
													</div>
												</div>
											</div>
											<div class="joinForm6">
<!-- 												<div class="joinBtn1">>></div>
												<div class="joinBtn1"><<</div> -->
											</div>
											<div class="joinForm5">
												<div class="joinForm7">
													<div class="joinForm8">
														<input type="text" class="joinInput1" value="결재자 목록" readonly>
													</div>
													<div class="joinForm9">
													<!-- 구성원 출력될 자리 -->
														<div id="resultBox2" class="connectedSortable">
															<table>
																<tbody>
																</tbody>
															</table>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="formResult1">
								<table id="joiner">
									<tbody>
									</tbody>
								</table>
							</div>
							<div>
								<br>
							</div>
							<div>
								<div class="formBtn1">참조자 등록</div>
							</div>
							<div class="formResult1">
								<table>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        var editor = new toastui.Editor({
            el:document.querySelector("#editor"),
            height: "630px",
            initialEditType:"wysiwyg",
            hooks:{
                "addImageBlobHook":function(blob, callback){
                    var fd = new FormData();
                    fd.append("im", blob);

                    $.ajax({
                        url:"http://localhost:8089/spring18/toast/upload",
                        type:"post",
                        data:fd,
                        processData:false,
                        contentType:false,
                        success:function(result){
                            callback(result);
                        }
                    });
                }
            },
        });        
    </script>
<!-- 왼쪽바 고정 추가 옵션 시작 -->
	<script>
		$(function() {
    		var leftBar = $(".leftBar").offset().top;
    			$(window).scroll(function() {
    		var window = $(this).scrollTop();
    		if(leftBar <= window) {
    			$(".leftBar").addClass("fixed");
    		} else {
    			$(".leftBar").removeClass("fixed");
    			}
    		})
    	});
    </script>
<!-- 문서 종류 옵션 시작 -->
	<script>
			$("#signType").on("change", function() {
				var base = "${pageContext.request.contextPath}";				
				var typeCode = $("#signType").val();
				$.ajax({
					url: base + "/signResult/signTypeContent",
					type : "get",
					data : {typeCode : typeCode},
					success : function(data) {
						editor.setHtml(data.result);
					}
				});
			});
	</script>
<!-- 결재자 추가 시작 -->
	<script>
		function signJoiner() {
			$(".joinForm1").fadeIn(100);
		};
	</script>
	<script>
		$(function() {
		    $("#resultBox1, #resultBox2").sortable({
		      connectWith: ".connectedSortable"
		    		}).disableSelection();
		  });
	</script>
<script>
	 $(document).on('click', function() {
		 if($(".joinForm1").css("display") != "none") {
			 $(".joinForm1").mouseleave(function(e) {
				if(!$(e.target).is(".joinForm1")) {
					var tag1 = $("#resultBox2").children();
					var joinerLength = tag1.length;
					
					var joiner = new Array();
					
						for(var i = 1; i < joinerLength; i++) {
							var data = new Object();
							data.jCode = tag1.eq(i).children().eq(1).text();
							data.jName = tag1.eq(i).children().eq(2).text();
							data.jJob = tag1.eq(i).children().eq(3).text();

							joiner.push(data);
						}
					
					sessionStorage.setItem('joiner', JSON.stringify(joiner));
					
					showList();
					
					$(".joinForm1").fadeOut(100);
					$(".joinAlert").fadeIn(1000);
					$(".joinAlert").fadeOut(1000);
					location.redirect();
				 }
			 });
		 };
	 });
</script>
<script>
	function showList() {
		var jsonData = sessionStorage.getItem("joiner");
		var data = JSON.parse(jsonData);
		console.log(data);
		console.log(jsonData);
		var $joiner = $("#joiner tbody");
		$joiner.html('');
		
		for(var key in data) {
			var $tr = $("<tr class='resultList'>");
			var $jCode = $("<td class='jCode'>").text(data[key].jCode);
			var $jName = $("<td class='jName'>").text(data[key].jName); 
			var $jJob = $("<td class='jJob'>").text(data[key].jJob); 
			
			/* $tr.append($jCode); */
			$tr.append("<td class='jImg'><img src='${pageContext.request.contextPath}/resources/img/test/user.png' class='resultImg1'></td>");
			$tr.append($jName);
			$tr.append($jJob);
			
			$joiner.append($tr);
		}
	}
</script>
<!--   	<script>
		$(function() {	
			var tag1 = $("#resultBox1").children();
			var joinerLength = tag1.length;
			var joinerCode = new Array();
			var joinerName = new Array();
			var joinerLevel = new Array();
			
				for(var i = 0; i < joinerLength; i++) {
					joinerCode[i] = tag1.eq(i).children().eq(1).text();
					joinerName[i] = tag1.eq(i).children().eq(2).text();
					joinerLevel[i] = tag1.eq(i).children().eq(3).text();
					
				}
			console.log(joinerCode);
			console.log(joinerName);
			console.log(joinerLevel);
		});
	</script>
 -->
<!-- 참여자 추가 시작 -->
</body>
</html>