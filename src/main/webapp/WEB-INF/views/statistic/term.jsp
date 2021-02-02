<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<link href="../../share/css/visitor.css" rel="stylesheet" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script src="/share/js/amchart4/core.js"></script>
<script src="/share/js/amchart4/charts.js"></script>
<script src="/share/js/amchart4/animated.js"></script>
<script src="/share/js/amchart4/ko_KR.js"></script>
<script type='text/javascript' src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

<script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
<script src="/share/js/sensor/index.js"></script>
<script type='text/javascript'>



</script>
<style>
 .datepicker {
	width: 220px;
}
.t-box{
	overflow-x: auto;
}
.list th {
	width: 63px;
}
.list tbody{overflow-y:auto; overflow-x:hidden; float:left; width:100%; height:300px}

.t-box {
  width: 46%;
  display: inline-block;
}
.t-box:nth-child(2n-1) {
  margin-left: 4%;
}
#board .list tbody {
  width: 354px;
}
#board .list tbody td {
  width: calc(354px / 2);
}

</style>
    
<div id="sensor" class="body_wrap">
<div class="loader" id="loader-1" style="z-index:99; position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%);"></div>
			<div class="container">

				<div class="sub_title">
					<h1 class="main_co">기간별 방문자 조회</h1>
				</div><!-- sub_title -->

				<div class="row array">
					
					<div class="col-xs-12">
							<form>
								<div class="form-group">
									<ul class="row">
										<li class="col-xs-1 title">기간</li>
										<li class="col-xs-4">
											<div class="col-xs-5">
												<input autocomplete=off type="text" id="to" placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
											<div class="col-xs-2" style="text-align: center; line-height: 30px;">
												~
											</div>
											<div class="col-xs-5">
												<input autocomplete=off type="text" id="from" placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
										</li>
										
										<li class="col-xs-2">
											<select id="equi">
												<option>기기 선택</option>
												
											</select>
											<script>
											$(document).ready(function() {
												$("#equi").on('mouseenter','option',function(e) {
												    var $target = $(e.target);
												    console.log(e);
												});
												$("#equi").mouseenter(function() {
													$('#amChart').css('z-index', '-1').css('position', 'relative');
												})
												
											})
												$.ajax({
													url: '/api/statistic/getSensorList',
													success: function(r) {
														var text = '<option>기기 선택</option>';
														if(r.length != 0) {
															$.each(r.data, function(a,b) {
																text += '<option value="'+b.vistorSenId+'" data-key="'+b.equiInfoKey+'" data-inst="'+b.instLoc+'">'+b.vistorSenViewNm+'('+b.equiInfoKeyHan+')</option>';
															})
														}
														
														$('#equi').html(text);
													}
												})
											</script>
										</li>
										<li class="col-xs-1">
											<input class="person_search_btn search_btn" type="submit" value="검색">
											<script>
												function parse(str) {
												    var y = str.substr(0, 4);
												    var m = str.substr(5, 2);
												    var d = str.substr(8, 2);
												    console.log(y,m,d)
												    return new Date(y,m-1,d);
												}
												$(document).ready(function() {
													$('.test').hover(function() {
														$('#amChart').css('z-index', '0').css('position', 'unset');
													})
													$('#equi').change(function(){
														
														var data = $(this).val()
													    $('#equi option').each(function(){
													        if($(this).val() == data) {
													            console.log($(this).data('inst'))
													            if($(this).text() != "기기 선택"){
														            $('#sensorInfo').html('기기번호: '+$(this).data('key')+'  주소: '+$(this).data('inst') )
													            } else {
													            	$('#sensorInfo').html('');
													            }
													        }
													    })
													})
													$('#to').change(function() {
														if($('#from').val() != ""){
															var to = parse($('#to').val());
															var from = parse($('#from').val());
															var result = (from - to)/(24 * 3600 * 1000);
															
															if(result < 0) {
																$('#from').val('');
															}
															
															if(result > 5) {
																$('#from').val('');
															}
														}
													})
													
													$('#from').change(function() {
														if($('#to').val() != ""){
															var to = parse($('#to').val());
															var from = parse($('#from').val());
															var result = (from - to)/(24 * 3600 * 1000);
															
															if(result < 0) {
																$('#to').val('');
															}
															
															if(result > 5) {
																alert("날짜 범위는 최대 5일입니다.");
																$('#from').val('');
															}
														}
													})
												})
												$(document).ready(function() {
													sensor.amChartStatPerson('amChart', 'default')
													$('.person_search_btn').click(function(e) {
														e.preventDefault();
														var to = $('#to').val();
														var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
														var from = $('#from').val();
														var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)
														var gu = $('#gu').val();
														var equi = $('#equi').val();
														
														if(toDate.length == 0) {
														  alertify.alert("오류","날짜가 비어있습니다.");
														  return false;
														}
														$.ajax({
															url: '/api/statistic/getEquiPerson',
															type: 'GET',
															datType: 'json',
															data: {
																toDate:toDate, fromDate:fromDate, vistorSenId:equi
															},				
															beforeSend: function() {
																$('.loader').show();
																$('.dim').show();
															},
															success: function(r) {
																console.log(r.data)
																sensor.amChartStatPerson('amChart', r.hourData, r.data)
																var tableTime = '';
																var tablePerson = '';
																var gene = '';
																var timeSet = [];
																
																if (r.data.length == 0) {
																	alertify.alert("데이터 없음","조건에 만족하는 데이터가 없습니다.");
																}
																var timeDi = '';
																var timeCount = 0;
																var timeData = [];
																$.each(r.data, function(a,b) {
																	if(timeDi != b.vistorTm8 || a == r.data.length-1) {
																		//날짜 바뀌면 배열 값넣고 초기화
																		if(a != 0) {
																			timeData[timeCount] = timeSet;
																			timeSet = []
																			console.log(timeDi, timeData[timeCount])
																			timeCount++;
																		}
																	}
																	timeDi = b.vistorTm8
																	timeSet[b.vistorTm8+b.vistorTm4] = b.vistorCnt
																})
																for(var i=0; i < timeData.length; i++) {
																	var dateDefault = '';
																	for(var key in timeData[i]) {
// 																		201912311330
																		if(timeData[i][key] < 0) {
																			timeData[i][key] = '0'
																		}
																		dateDefault = key.substring(0,8);
																		tablePerson+="<tr><td>"+key.substring(8,10)+" : "+key.substring(10,12)+"</td><td>"+timeData[i][key]+"명</td></tr>";
																		
																	}
																	gene += '<div class="t-box"><p style="margin:10px 0; font-weight: bold;">'+dateDefault+'</p><table class="list" style="font-size: 14px;">'+
																				'<thead><tr class="tableTime">'+
																					'<th>방문시각</th><th>방문자수</th>'+
																				'</tr></thead>'+
																					tablePerson+
																			'</table></div>';
																	tablePerson = '';
																}
																$('.pb_b5').html('<h5 class="pb_t2 pb_b2">시간별 체류인원</h5>');
																$('.pb_b5').append(gene);
															},
															complete: function() {
																$('.loader').hide();
																$('.dim').hide();
															}
														})
													})
												})
											</script>
										</li>
										<li class="col-xs-4">
											<p id="sensorInfo" style="line-height:30px; margin: 0;padding: 0;font-size: 14px;"></p>
										</li>
									</ul>
								</div>
							</form>
							<div class="test" style="height: 400px;">
								<div style="height: 400px;" id="amChart"></div>
							</div>
					</div>		
				</div><!-- array -->

				<div class="row" style="margin: 30px 0;">
					<div class="col-xs-6 piechartDiv">
						
					</div>
					<div class="col-xs-6">
						<div id="board" class="pb_b5">
							<h5 class="pb_t2 pb_b2">시간별 체류인원</h5>
							<table class="list">
								<tr class="tableTime">
									
								</tr>
								<tr class="tablePerson">
									
								</tr>
							</table>
						</div><!-- board -->
					</div>
				</div>
			</div><!-- container -->

		</div><!-- sensor -->
<jsp:include page="../common/footer.jsp"></jsp:include>