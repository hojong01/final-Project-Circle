<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/schedule/fullcalendar/fullcalendar.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/schedule/bootstrap/bootstrap.css">
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/schedule/jQuery/jquery-ui.css"> --%>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js'></script>
<script src="https://code.jquery.com/jquery-2.1.3.min.js" integrity="sha256-ivk71nXhz9nsyFDoYoGf2sbjrR9ddh+XDkCcfZxjvcM=" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>       
<script src='${pageContext.request.contextPath}/resources/js/schedule/fullcalendar.min.js'></script>
<script src="${pageContext.request.contextPath}/resources/js/schedule/ko.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/js/schedule/jquery-ui.js"></script> --%>
        
<!-- 주석커밋 -->
      <script>
      		var loginId = '200101090031'//${member.EMP_INFO_EMP_NO}	;//로그인 아이디
      		var nowEvent = "";									//클릭한 이벤트 정보 저장
      		var base = "${pageContext.request.contextPath}";	//rootdirectory 저장
      		
      		//좌측 메뉴바 일정종류 체크 변수
      		var myCalendarCheck = $('#myCalendar').prop('checked');
      		var pollCheck = $('#poll').prop('checked');
      		var projectCheck = $('#project').prop('checked');
      		var communityCheck = $('#community').prop('checked');
			      		
      		
      		//fullcalendar onload function
            $(document).ready(function() {
            	var base = "${pageContext.request.contextPath}";
            	
            	//풀캘린더 로드
                $("#calendar").fullCalendar({
                	defaultView			: 'month',	//기본 뷰 설정
               	    header				: {
               	    						left	: 'today', // month/week뷰 변환 버튼
               	    						center	: 'prev, title, next',
               	    						right  	: 'month,agendaWeek,agendaDay'
               							    
               		},
               		fixedWeekCount            : 'variable',
                	defaultDate			: moment(),//현재를 기준으로 생성
                	nextDayThreshold	: "00:00:00",
                	defaultAllDay		: false,
                	fixedWeekCount		: false,//6주 보기 고정 해제
                	editable			: true,
                	eventLimit			: true,//이벤트 개수가 표시칸을 벗어나면 더보기 버튼 생성
                	
                	//이벤트 목록 불러오기
                 	events				: function(start, end, timezone, callback) {
                 								
						                    	$.ajax({
						                    		url			:base+"/schAjax/id",
						                    		type		:"get",
						                    		async		: false,
						                    		traditional : true,
						                    		data: {id 		: loginId
						                    			  ,start	: start.format()
						                    			  ,end		: end.format() 
						                    			  ,myCalendarCheck : $('#myCalendar').prop('checked')
						                      		      ,pollCheck : $('#poll').prop('checked')
						                      		 	  ,projectCheck : $('#project').prop('checked')
						                      			  ,communityCheck : $('#community').prop('checked')
						                      			  ,vacationCheck : $('#vacation').prop('checked')
						                    		},
						                    		dataType:"json",
						                    		success:function(json){
						                    			
						        						events = [];
						        						$(json).each(function() {
						        							
						        							//이벤트 값 변수화
						        							var groupCode = $(this).prop('id').substr(0,4);
						        							var allDay = $(this).attr('allDay');
						        							var title = $(this).attr('title');
						        							var groupName = $(this).attr('groupName');
						        							var jobName = $(this).attr('jobName');
						        							var backgroundColor = $(this).attr('backgroundColor')
						        							
						        							//일정 종류에 따라 값 변형
						        							var randomNumber = Math.floor(Math.random() * 100); //컬러코드용 랜덤값 - 레드
						        							var randomNumber2 = Math.floor(Math.random() * 100); //컬러코드용 랜덤값 - 레드
						        							switch (groupCode) {
						        								case 'SCHN' :  break;
						        								default : allDay = 'on';
						        										   title = title + " " + jobName + " 휴가"; 
						        										   groupName = "휴가";
						        										   backgroundColor = "rgb(245,"+ randomNumber + "," + randomNumber2 + ")";
						        										   
						        										   break;
						        							}
						        							
						        							//allDay 데이터 가공
						        							var yn = false;
						        							var end = $(this).prop('end');
						        							var	start = $(this).prop('start');
						        							
						        							if(allDay == "on"){
						        								yn = true;
						        								if (start !== end) {
								                    	              end = moment(end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
								                    	        }
						        							}
						        							
						        							//events 객체에 주입
						        							events.push({
						        								id	  			: $(this).attr('id'),
						        								title 			: title,
						        								start 			: start,
						        								end	  			: end,
						        								allDay			: yn,
						        								repeat 			: $(this).attr('repeat'),
						        								endRepeat 		: $(this).attr('endRepeat'),
						        								content			: $(this).attr('content'),
						        								security		: $(this).attr('security'),
						        								stat			: $(this).attr('stat'),
						        								writer 			: $(this).attr('writer'),
						        								writeDate		: $(this).attr('writeDate'),
						        								modifyDate		: $(this).attr('modifyDate'),
						        								backgroundColor	: backgroundColor,
						        								writerName		: $(this).attr('writerName'),
						        								//캘린더에서 데이터를 받을때는 groupName으로 받고 서버로 보낼때는 groupCode로 보냄
						        								groupName		: groupName
						        							});
						        						});
						        						
						        						//월, 년 변경되었거나 자료 변경에 따라 다시 불러오기
														callback(events);
														console.log(events)
						                    		}
                 							});
                 	},
            	 	dayClick			: function(date, jsEvent, view) {//날짜 클릭 기능 설정
            	 							//input 값 비우기
            	 							$('#edit-title').val("");
            	 							$('#edit-groupCode option:eq(0)').prop('selected', 'selected');
            	 							$('#edit-allDay').prop('checked', true);
            	 							$('#edit-color option:eq(0)').prop('selected', true);
            	 							$('#edit-desc').val("");
            	 							
            	 							$('.time').hide();	
            	 							$('.input-check').hide();
            	 	
            	 							//현재 시간 넣기
            	 							$('#edit-start').val(date.format());
            	 							$('#edit-end').val(date.format());
            	 							$('#start-time').val(moment());
            	 							$('#end-time').val(moment());
            	 							
            	 							//color selector 글자색 변경
            	 						    $('#edit-color').css('color', $('#edit-color option:eq(0)').val());
            	 							
            	 							//modify-save button hide
            	 							$('.modalBtnContainer-modifyEvent').hide();
            	 							//add button show
            	 							$('.modalBtnContainer-addEvent').show();
            	 							
            	 							//모달 띄우기
            	 							$('#add-eventModal').modal('show');
            	 							
            	 							//title check hide
            	 							$('#title-check').hide();
            	 							
            	 							//일정명에 오토포커스
            	 							$(".modal").on("shown.bs.modal", function () {
            	 								$('#edit-title').focus();
            	 							});

       				},
       				//event 클릭시 실행코드
                	eventClick			: function(event, jsEvent, view) {
                												
                							nowEvent = event;
                							console.log(nowEvent);
                							var entry=[];
                							
                							//참여자 데이터 불러오기
                							$.ajax({
                								url			: base + "/schAjax/entry",
                								type		: 'post',
                								data		: nowEvent.id,
                								dataType	: 'json',
                								contentType : "application/json; charset=utf-8;",
                   			                	error		: function(request,status,error){
                			                		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                			                	},
                			                	success		: function(json){
                			                		
                			                		console.log(json);
                        							$(json).each(function(){
                        								$('#view-entry').append("<span style=display:inline-block>" + $(this).prop('EMP_INFO_NAME') + "<span>&nbsp");
                        							});
                			                	} 
                							});
                							
                							console.log(entry);
                		
                							//empty input value
                							$('#view-sch-id').val("");
                							$('#view-title').empty();
                							$('#view-start').empty();
                							$('#view-end').empty();
                							$('#view-groupCode').empty();
                							$('#view-writer').empty();
                							$('#view-desc').empty();
                							$('#view-entry').empty();
                							$('.input-check').hide();
                							
                							//fill input value
                							$('#view-sch-id').val(event.id);
                							$('#view-title').text(event.title);
                							if(event.allDay) {
                								$('#view-start').text(event.start.format('YYYY-MM-DD'));
                    							if(event.end != null) {
                    								$('#view-end').text(event.end.format('YYYY-MM-DD'));
                    							}	
                							} else {
                    							$('#view-start').text(event.start.format('YYYY-MM-DD HH:mm'));
                    							if(event.end != null) {
                    								$('#view-end').text(event.end.format('YYYY-MM-DD HH:mm'));	
                    							}               								
                							}
                							$('#view-groupCode').text(event.groupName);
                							

                							$('#view-writer').text(event.writerName);
                							$('#view-desc').text(event.content);
                							
                							//autority check
                							if(event.writer != loginId) {
												console.log("wrong id");
												
												$(".modalBtnContainer-viewEvent").hide();
                							} else {
                								$(".modalBtnContainer-viewEvent").show();
                							}
                							
                							//modal on
                							$('#eventModal').modal();
           			},
                		
                });
            });
      		
        //event insert script
        $(function () {
        	
        	//insert form-data serialize transform
        	jQuery.fn.serializeObject = function() {
        	    var obj = null;
        	    try {
        	        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
        	            var arr = this.serializeArray();
        	            if (arr) {
        	                obj = {};
        	                jQuery.each(arr, function() {
        	                    obj[this.name] = this.value;
        	                });
        	            }//if ( arr ) {
        	        }
        	    } catch (e) {
        	        alert(e.message);
        	    } finally {
        	    }
        	 
        	    return obj;
        	};
        	
        	//save button ckick function
            $('#save-event').on('click', function (e) {
				
            	//input title check
            	if($('#edit-title').val() == '' ) {
					$('#edit-title').focus();
					return;
				}
            	
				if(!dateTimeCheck()){
					return;          	
				}
            	
                var startDateTime = $('#edit-start').val();
                var endDateTime = $('#edit-end').val();
                
                //input date check
                if(startDateTime > endDateTime){
                	$('#date-check').show();
                	return;
                }
                
                
            	console.log("button click success");
            	
                // input emp.no 
                $("#insertId").val(loginId);
                
                //concat date time
                if($('edit-allDay').is('checked')) {
                	var date = $('#edit-start').substr(0,10);
        			$('#edit-start').prop(date);
                	
                } else {
                	startDateTime = startDateTime.concat(" ", $('#start-time').val());
                	endDateTime = endDateTime.concat(" ", $('#end-time').val());
                	
                	$('#start-dateTime').val(moment(startDateTime).format('YYMMDDHHMMSS'));
                	$('#end-dateTime').val(moment(endDateTime).format('YYMMDDHHMMSS'));
                	
                	if($('#end-time') == null) {
                		console.log('end is null');
                	}
                	
                }
                
                var insertEvent = $("form[name=insert-event]").serializeObject();
                
                console.log("insertEvent : " + JSON.stringify(insertEvent));
                
                $.ajax({
                	type 		: 'post',
                	traditional : true,
                	url 		: base+"/schAjax/schInsert", 
                	data		: JSON.stringify(insertEvent),
                	dataType	: 'text',
                	contentType	:"application/json; charset=utf-8;",
                	error		: function(request,status,error){
                		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                	},
                	success		: function(){
                        //modal close
                        $("#add-eventModal").modal("hide");
                        
                        //refresh calendar
                        $('#calendar').fullCalendar('refetchEvents');
                	}
                })

            });
        	
        	//allDay checked click function
        	$('#edit-allDay').on('change', function(){
        		if($(this).is(':checked')) {
        			$('.time').hide();		
        		} else {
        			$('.time').show();
        		}
        	});
        	
        	//title-insert-check blur function
        	$(document).ready(function() {
        		$('#edit-title').blur(function(){
        			if($('#edit-title').val() == '') {
        				$('#title-check').show();
        			} else {
        				$('#title-check').hide();
        			}
        		});
        	});
        	
        	//dateTime check function
        	$('.input-date-time').change( function(){
        		dateTimeCheck();
        	});
        	
        	function dateTimeCheck() {
        		var startDate = $('#edit-start').val();
        		var startTime = $('#start-time').val();
        		var endDate = $('#edit-end').val();
        		var endTime = $('#end-time').val();
        		
        		if(startDate > endDate) {
        			$('#date-check').show();	
        			return false;
        		} else	if(startDate < endDate){
        			$('#date-check').hide();
            		$('#time-check').hide();  
            		return true;
        		} else {
            		$('#date-check').hide();
            		$('#time-check').hide(); 
					if(startTime != '' && endTime != ''){
					
	        			if(startTime > endTime) {
	        				$('#time-check').show();
	        				return false;
	        			}       		
					}
        		}
        		

        		
        	};
        	
        	//delete button click function
        	$('#deleteEvent').on('click', function(){
				
        		var id = $('#view-sch-id').val();
        		
        		console.log(id);
				
				var deleteConfirm = confirm('정말로 삭제하시겠습니까?');
				if(deleteConfirm) {
					console.log('delete ajax on');
					
					$.ajax({
						url			: base+'/schAjax/schDelete',
						type		: 'post',
						async		: false,
						data		: id,
						dataType	: 'text',
						contentType	: "application/json; charset=utf-8;",
	                	error		: function(request,status,error){
	                					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	                				  },
	                	success		: function(){
	                        //refresh calendar
	                        $('#calendar').fullCalendar('refetchEvents');	 
	                        
	                        //close modal
	                		$('#eventModal').modal("hide");
	                	},
					});
				} else {
					console.log('delete cancle');
				}
        	})
        	
        	//modify button click function
        	$('#updateEvent').on('click', function() {
        		
        		//view-modal close
        		$('#eventModal').modal('hide');
        		
        		//input modal view controll
        		$('.modalBtnContainer-addEvent').hide();
        		$('.modalBtnContainer-modifyEvent').show();
        		$('.input-check').hide();
        		
        		//data input
        		$('#insertCode').val(nowEvent.id);
				$('#edit-title').val(nowEvent.title);
				$('#edit-desc').val(nowEvent.content);
					//groupName => groupCode transfer				
				var groupCode = $('#edit-groupCode option:contains('+ nowEvent.groupName +')').val();
				$('#edit-groupCode').val(groupCode).prop('selected', true);
				
					//color input
				$('#edit-color').val(nowEvent.backgroundColor);
				$('#edit-color').css('color',nowEvent.backgroundColor);
				
					//allDay process	
				if(nowEvent.allDay == true){
					$('#edit-allDay').prop('checked', true);
					$('.time').hide();
				} else {
					$('#edit-allDay').prop('checked', false);
					$('#start-time').val(nowEvent.start.format('HH:mm'));
					if($('#end-time').val() != ''){
						$('#end-time').val(nowEvent.end.format('HH:mm'));		
					}
					$('.time').show();
				};
				
				$('#edit-start').val(nowEvent.start.format('YYYY-MM-DD'));
				
				if(nowEvent.end != null) {
					$('#edit-end').val(nowEvent.end.format('YYYY-MM-DD'));
				} else {
					$('#edit-end').val(nowEvent.start.format('YYYY-MM-DD'));
				}
				
				//modify-save button show
				$('.modalBtnContainer-modifyEvent').show();
				//add button hide
				$('modalBtnContainer-addEvent').hide();
				
				//title check hide
				$('#title-check').hide();
				
				//일정명에 오토포커스
				$(".modal").on("shown.bs.modal", function () {
					$('#edit-title').focus();
				});
        		        		
        		//input modal on
        		$('#add-eventModal').modal();
        		
        	})
        	
        	//modify-save button click function
        	$('#modify-save-event').on('click', function(){
                	
                	console.log("button click success");

                	//input title check
                	if($('#edit-title').val() == '' ) {
    					$('#edit-title').focus();
    					return;
    				}
                	
					if(!dateTimeCheck()){
						return;          	
					}
                	
                	
                    // input emp.no 
                    $("#insertId").val(loginId);

    				//date time combine process                
                    var startDateTime = $('#edit-start').val();
                    var endDateTime = $('#edit-end').val();
	                    //concat date time
                    if($('edit-allDay').is('checked')) {
                    	var date = $('#edit-start').substr(0,10);
            			$('#edit-start').prop(date);
                    } else {
                    	startDateTime = startDateTime.concat(" ", $('#start-time').val());
                    	endDateTime = endDateTime.concat(" ", $('#end-time').val());
                    	
                    	$('#start-dateTime').val(moment(startDateTime).format('YYMMDDHHMMSS'));
                    	$('#end-dateTime').val(moment(endDateTime).format('YYMMDDHHMMSS'));
                    	
                    	if($('#end-time') == null) {
                    		console.log('end is null');
                    	}
                    	
                    }
	                    
                    var updateEvent = $("form[name=insert-event]").serializeObject();
                    
                    console.log("updateEvent : " + JSON.stringify(updateEvent));
                    
                     $.ajax({
                    	type 		: 'post',
                    	traditional : true,
                    	url 		: base+"/schAjax/schUpdate", 
                    	data		: JSON.stringify(updateEvent),
                    	dataType	: 'text',
                    	contentType	:"application/json; charset=utf-8;",
                    	error		: function(request,status,error){
                    		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    	},
                    	success		: function(){
                            //modal close
                            $("#add-eventModal").modal("hide");
                            
                            //refresh calendar
                            $('#calendar').fullCalendar('refetchEvents');
                    	}
                    }) 
        	});
        	
        	//color selector onchange function
        	$('#edit-color').on('change', function(){
        		var selectedColor = $('#edit-color option:selected').val();
        		$('#edit-color').css('color', selectedColor);
        	});
        	
        	//grouping checkbox onchange function
        	$('#myCalendar').change(function(){
        		console.log($('#myCalendar').prop('checked'));
                //refresh calendar
                $('#calendar').fullCalendar('refetchEvents');        		
        	});
        	$('#poll').change(function(){
        		console.log($('#poll').prop('checked'));
                //refresh calendar
                $('#calendar').fullCalendar('refetchEvents');        		
        	});
        	$('#project').change(function(){
        		console.log($('#project').prop('checked'));
                //refresh calendar
                $('#calendar').fullCalendar('refetchEvents');        		
        	});
        	$('#community').change(function(){
        		console.log($('#community').prop('checked'));
                //refresh calendar
                $('#calendar').fullCalendar('refetchEvents');        		
        	});
        	$('#vacation').change(function(){
        		console.log($('#vacation').prop('checked'));
                //refresh calendar
                $('#calendar').fullCalendar('refetchEvents');        		
        	});
        	
        	
        });
        
/*         $(document).ready(function(){
        	$('#mydate').datepicker();
        }); */
        
        </script>


        
</head>
<body>
	<!-- <div id='mydate' style="height:200px;"></div> --> <!-- 사이드바용 datepicker (jquery-ui 사용) --> 
	<div id="calendar"></div>
		
	<!-- 간단 일정보기 MoDal -->
		
     <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">
                    	<i class="icon modal-title-planner"></i>
                    	일정
                    </h4>
                </div>
                <div class="modal-body">
                	<input type="hidden" name="id" id="view-sch-id"/>
                    <div class="row">
                        <div class="col-xs-12">
							<div>
								<label class="col-xs-4" for="view-title">[일정명]</label>
							</div>
							<div>
								 <span class="inputModal" id="view-title"></span>
							</div>                        	
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-start">[시작]</label>
                            <span class="inputModal" id="view-start" ></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-end">[끝]</label>
                            <span class="inputModal" id="view-end" ></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-groupCode">[구분]</label>
                            <span class="inputModal" id="view-groupCode">부서 일정</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                        	<div class="view-modal-header">
                        		<label class="col-xs-4" for="view-entry" id="entry">[참가자]</label>
                        	</div>
                        	<div class="view-modal-content">
                        		<span class="inputModal" id="view-entry"></span>
                        	</div>
                            
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-writer">[작성자]</label>
                            <span class="inputModal" id="view-writer"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="view-desc">[설명]</label>
                            <textarea rows="4" cols="50" class="inputModal" name="view-desc"
                                id="view-desc" readonly="readonly">내용 삭제가 안됐을때 나오는 내용</textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer modalBtnContainer-viewEvent">
                    <button type="button" class="btn btn-primary" id="updateEvent">수정</button>
                    <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    		
    <!-- 일정 추가 MODAL -->
    <div class="modal fade" tabindex="-1" role="dialog" id="add-eventModal">
        <div class="modal-dialog" role="document">
        	
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">
                    	<i class="icon modal-title-planner"></i>
                    	일정
                    </h4>
                </div>
                
                <form method="post" name="insert-event">
	                <div class="modal-body">
		                    <div class="row">
		                    	<input type="hidden" name="id" id="insertId"/>
		                    	<input type="hidden" name="code" id="insertCode">
		                        <div class="col-xs-12" id="insert-title-div">
		                            <label class="col-xs-4" for="edit-title">일정명</label>
		                            <input class="inputModal" type="text" name="title" id="edit-title"
		                                required="required" placeholder="일정 제목을 입력해주세요."/>
		                            <span type="hidden" style="color:red;" class="input-check"id="title-check">일정명은 필수 입력사항입니다.</span>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <label class="col-xs-4" for="edit-groupCode">구분</label>
		                            <select class="inputModal" type="text" name="groupCode" id="edit-groupCode">
		                                <option value="SCHG000001" select="selected">내 일정</option>
		                                <option value="SCHG000002">부서 일정</option>
		                                <option value="SCHG000003">동호회 일정</option>
		                                <option value="SCHG000004" hidden>프로젝트 일정</option>
		                                <option value="SCHG000005" hidden>내 휴가</option>
		                            </select>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <label class="col-xs-4" for="edit-start">시작</label>
		                            <input class="inputModal input-date-time" type="date" name="edit-start" id="edit-start" />
		                            <input class="inputModal input-date-time time" type="time" name="start-time" id="start-time"/>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <label class="col-xs-4" for="edit-end">끝</label>
		                            <input class="inputModal input-date-time" type="date" name="edit-end" id="edit-end" />
		                            <input class="inputModal input-date-time time" type="time" name="end-time" id="end-time"/>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                        	<label class="input-check hide-label"></label>
			                        <div id="date-check" class="input-check" style="color:red;">시작일은 종료일보다 작거나 같아야합니다</div>
			                        <div id="time-check" class="input-check" style="color:red;">시작시간은 종료시간보다 작거나 같아야합니다</div>
		                        </div>
		                    </div>
	                        <div class="row">
							    <div class='col-xs-12'>
							        <input type='hidden' class="inputModal select time" name='start' id='start-dateTime' />
						        </div>
						    </div>
	                        <div class="row">
							    <div class='col-xs-12'>
							        <input type='hidden' class="inputModal select time" name='end' id='end-dateTime' />
						        </div>
						    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <label class="col-xs-4" for="edit-allDay">하루종일</label>
		                            <input class='allDayNewEvent' id="edit-allDay" type="checkbox" name="allDay" checked="checked">
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <label class="col-xs-4" for="edit-color">색상</label>
		                            <select class="inputModal" name="backgroundColor" id="edit-color">
		                                <option value="#000080" style="color:#000080;">남색</option>
		                                <option value="#0080ff" style="color:#0080ff;">바다색</option>
		                                <option value="#50bcdf" style="color:#50bcdf;">하늘색</option>
		                                <option value="#3e91b5" style="color:#3e91b5;">담청색</option>
		                                <option value="#4aa8d8" style="color:#4aa8d8;">밝은파랑</option>
		                                <option value="#437299" style="color:#437299;">셰필드 스틸</option>
		                                <option value="#5e7e9b" style="color:#5e7e9b;">아쿠아마린</option>
		                                <option value="#00498c" style="color:#00498c;">코발트블루</option>
		                                <option value="#003458" style="color:#003458;">프러시안블루</option>
		                            </select>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-xs-12">
		                            <label class="col-xs-4" for="edit-desc">설명</label>
		                            <textarea rows="4" cols="50" class="inputModal" name="content"
		                                id="edit-desc"></textarea>
		                        </div>
		                    </div>
	                    
	                </div>
                </form>
                <div class="modal-footer modalBtnContainer-addEvent">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary" id="save-event" name="save-event">저장</button>
                </div>
                <div class="modal-footer modalBtnContainer-modifyEvent">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary" id="modify-save-event" name="modify-save-event">저장</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    
</div>

</body>
</html>