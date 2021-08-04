<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<%-- <jsp:include page="../common/header_resource.jsp"></jsp:include> --%>

<script type="text/javascript" src="/share/js/amchart/amcharts.js"></script>
<script type="text/javascript" src="/share/js/amchart/lang/ko.js"></script>
<script type="text/javascript" src="/share/js/amchart/pie.js"></script>
<script type="text/javascript" src="/share/js/amchart/serial.js"></script>
<script type="text/javascript" src="/share/js/amchart4/core.js"></script>
<script type="text/javascript" src="/share/js/amchart4/charts.js"></script>
<script type="text/javascript" src="/share/js/amchart4/animated.js"></script>
<script type="text/javascript" src="/share/js/amchart4/ko_KR.js"></script>
<script src="/share/js/page.js"></script>

<!-- datatables -->
<script type="text/javascript" src="../../share/js/datatable/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/buttons.flash.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/buttons.html5.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/buttons.print.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/jszip.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/pdfmake.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/vfs_fonts.js"></script>

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

    <script type='text/javascript' src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

    <script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>

    <script type='text/javascript'>

    $(function(){

        $('#to').datepicker({

            calendarWeeks: false,

            todayHighlight: true,

            autoclose: true,

            format: "yyyy/mm/dd",

            language: "kr"

        });
        
        $('#from').datepicker({

            calendarWeeks: false,

            todayHighlight: true,

            autoclose: true,

            format: "yyyy/mm/dd",

            language: "kr"

        });

    });

    </script>
<style>
#page {
	padding-bottom: 60px;
}
.detail-box {
	height:250px;
	overflow-y: auto;
}
.list-detail * {
    text-align: center;
    padding: 3px;
}
.detail .graph {
	background: transparent;
}
.datepicker {
	width: 220px;
}
#to, #from {
	height: 30px;
}
    .data-list {
        width: 1580px;
        font-size:12px;
        display: none;
    }

    .data-list>.header {
        height: 57px;
    }
    .body {
        height: calc(200px - 57px);
        overflow:auto;
    }
    .body > div{
        height:45px;
    }
    .data-list .header {
        text-align: center;
        color:#0c82e9;
        border-top: 1px solid #0c82e9;
        border-bottom: 1px solid #0c82e9;
        background: #f3f9fe;
    }
    .data-list ul {
        padding:0;
        margin:0;
        height:100%;
    }
    .data-list ul li {
        list-style: none;
        display: block;
        float:left;
        width: calc((100% / 16) - 1px);
        position: relative;
        height: 100%;
    }
    .data-list ul li div {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 100%;
        text-align: center;
    }
	.header > ul {
		overflow-y: scroll;
		overflow-x: hidden;
	}
	
    .loader {
      position: absolute;
      transform: translate(-50%, -50%);
      top:50%;
      left: 50%;
    }
    .fhBtn {
    	color: #0c82e9;
		border: 1px solid #0c82e9;
		background: #f3f9fe;
		padding: 6px 20px;
		margin-bottom: 10px;
		position: absolute;
		top: 440px;
    }
    #board, #board2, #board3 {
    	position: relative;
	    border-top: 1px solid #c9c9c9;
		padding: 10px 0;
		margin-bottom: 30px;
	}

   .exBtn {
		color: #0c82e9;
		border: 1px solid #0c82e9;
		background: #f3f9fe;
		color: #0c82e9;
		border: 1px solid #0c82e9;
		background: #f3f9fe;
		padding: 5px 10px;
		float: right;
		margin-bottom: 20px;
		margin-right: 18px;
   }
   .display.dataTable.no-footer:not(#example) thead tr {
	   text-align: center;
	   color: #0c82e9;
	   border-top: 1px solid #0c82e9;
	   border-bottom: 1px solid #0c82e9;
	   background: #f3f9fe;
	   padding: 10px;
	   text-align: center;
	}
	.display.dataTable.no-footer thead tr th {
		text-align: center;
		padding: 10px;
	}
	.dataTables_scrollBody tbody tr td {
		text-align: center;
		padding: 10px 6px;
	}
	#example1 > thead {
		display: none;
	}
	#example2 > thead {
		display: none;
	}
	#example3 > thead {
		display: none;
	}
</style>
<div id="sensor" class="body_wrap">

			<div class="container">
				
				<div class="sub_title">
					<h1 class="main_co">수치/농도 통계 조회</h1>
				</div>

				<div class="row array">
					
					<div class="col-xs-12">
							<form>
								<div class="form-group">
									<ul class="row">
										<li class="col-xs-1 title">기간</li>
										<li class="col-xs-4">
											<div class="col-xs-5">
												<input type="text"  value="" id="to" autocomplete=off placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
											<div class="col-xs-2" style="text-align: center; line-height: 30px;">
												~
											</div>
											<div class="col-xs-5">
												<input type="text"  value="" id="from" autocomplete=off placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
										</li>
										<li class="col-xs-1">
											<select id="type">
												<option>시간 선택</option>
												<option value="10">10분</option>
												<option value="60">60분</option>
												<option value="24">1일</option>
											</select>
										</li>
										<li class="col-xs-1">
											<select id="gu">
												<option>구 선택</option>
												<c:forEach items="${gus}" var="gu">
													<option value="${gu.code}">${gu.codeNm}</option>
												</c:forEach>
											</select>
											<script>
												$('#gu').change(function() {
													var value = $(this).val();
													$.ajax({
														url: '/api/sensor/list/'+value,
														type: 'GET',
														success: function(r) {
															var text = '<option>기기 선택</option>';
															console.log(r.length);
															if(r.length != 0) {
																$.each(r, function(a,b) {
																	text += '<option value="'+b.equiInfoKey+'">'+b.equiInfoKeyHan+'</option>';
																})
															}
															
															$('#equi').html(text);
														}
													})
												})
											</script>
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
														$('#amChart1').css('z-index', '-1').css('position', 'relative');
													})
													$('.tg').hover(function() {
														$('#amChart1').css('z-index', '0').css('position', 'unset');
													})
												})
											</script>
										</li>
										<li class="col-xs-1">
											<input class="equi_search_btn search_btn" type="submit" value="검색">
											<script>
											
												$(document).ready(function() {
// 													sensor.amChart('amChart', '');
													var count = 2;
													$('.equi_search_btn').click(function(e) {
														e.preventDefault();
														var to = $('#to').val();
														var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
														var from = $('#from').val();
														var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)
														var gu = $('#gu').val();
														var equi = $('#equi').val();
														var type = $('#type').val();
														var statisticType = $('#statisticType').val();
														
														count = 2;
														$('.list').html('');
														if(to!='' && from!='' && gu!='구 선택' && equi!='기기 선택') {
															var pageNum = "${param.page}";
															if(pageNum == "") pageNum = "1";
															
															// 검색전 데이터 테이블 초기화
															if ($.fn.dataTable.isDataTable("#example1")) {
																$("#example1").html('');
																$("#example1").DataTable().destroy();
															}
															if ($.fn.dataTable.isDataTable("#example2")) {
																$("#example2").html('');
																$("#example2").DataTable().destroy();
															}
															if ($.fn.dataTable.isDataTable("#example3")) {
																$("#example3").html('');
																$("#example3").DataTable().destroy();
															}
															getData(toDate, fromDate, gu, type, "avg", equi, "1");
															getData(toDate, fromDate, gu, type, "max", equi, "2");
															getData(toDate, fromDate, gu, type, "min", equi, "3");
														} else {
															alert('비어있는 값이 있습니다.')
														}
														
													})
													
													
												})
												function getFormatDate(date){
													var year = date.getFullYear();              //yyyy
													var month = (1 + date.getMonth());          //M
													month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
													var day = date.getDate();                   //d
													day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
													var hour = new Date().getHours() >= 10 ? new Date().getHours() : '0' + new Date().getHours();
													var minutes = new Date().getMinutes() >= 10 ? new Date().getMinutes() : '0' + new Date().getMinutes();
													return  year + '' + month + '' + day +''+hour+''+minutes;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
												}
												function getData(toDate, fromDate, gu, type, statisticType, equi, num) {
													
													$.ajax({
														url: '/api/sensor/statistic',
														type: 'POST',
														data: {
															"toDate":toDate, "fromDate":fromDate, "gu":gu, "equiInfoKey": equi,
															"type": type, "statisticType": statisticType,
															"${_csrf.parameterName}" : "${_csrf.token}",
															"pageStart": 1
														},
														beforeSend: function() {
															$('.loader').show();
														},
														success: function(r) {

															$('.loader').hide();
															console.log("text",sensor.rowSetType(r.data));
															var rows = r.allData
															console.log(r.allData)
															//데이터 그리드 부분
															// $('.body'+num).html(sensor.rowSetType(r.data));
															$('#example'+num).DataTable({
																paging: false,
																searching: false,
																sorting: false,
																scrollY: 500,
																scrollCollapse: true,
																dom: 'Bfrtip',
																language: {
																	"info": "데이터 총 _TOTAL_개",
																	"emptyTable": "현재 검색된 데이터가 없습니다.",
																	"infoEmpty": ''
																},
																buttons: [
																	{
																		extend: 'excel',
																		title: '수치/농도 통계 조회('+statisticType+')_'+getFormatDate(new Date()),
																		text: '데이터 EXPORT',
																		className: 'exBtn',
																		enabled: false
																	}
																],
																columns: [
																	{data:"equiInfoKey", title:"기기번호"},
																	{data:"tm8", title:"데이터시각"},
																	{data:"pm10", title:"미세먼지 (㎍/㎥)"},
																	{data:"pm25", title:"초미세먼지 (㎍/㎥)"},
																	{data:"noise", title:"소음 (dB)"},
																	{data:"temp", title:"온도 (℃)"},
																	{data:"humi", title:"습도 (%)"},
																	{data:"windDire", title:"풍향 "},
																	{data:"windSpeed", title:"풍속 (㎧)"},
																	{data:"inteIllu", title:"조도 (lx)"},
																	{data:"ultraRays", title:"자외선 (UVI)"},
																	{data:"vibrX", title:"진동 -X축(g)"},
																	{data:"vibrY", title:"진동 -Y축(g)"},
																	{data:"vibrZ", title:"진동 -Z축(g)"},
																	{data:"effeTemp", title:"흑구"},
																	{data: "co", title: "일산화탄소"},
																	{data: "no2", title: "이산화질소"},
																	{data: "so2", title: "이산화황"},
																	{data: "nh3", title: "암모니아"},
																	{data: "h2s", title: "황화수소"},
																	{data: "o3", title: "오존"}
																],
																columnDefs: [
																	{
																		targets: 1,
																		render: function(data, type, row) {
																			console.log(row);
																			var tm6 = data+row.tm6;
																			return tm6.substring(0,4)+"-"+
																			tm6.substring(4,6)+"-"+
																			tm6.substring(6,8)+" "+
																			tm6.substring(8,10)+":"+
																			tm6.substring(10,12)+":"+
																			tm6.substring(12,14)
																		}
																	},
																	{
																		targets: 2,
																		render: function(data, type, row) {
																			if (data >= 151) {
																				color = "01";
																			} else if (data >= 81) {
																				color = "02";
																			} else if (data >= 31) {
																				color = "04";
																			} else if (data > 0) {
																				color = "05";
																			} else {
																				color = "00";
																			}

																			return "<span class='co_step"+color+"'>"+data+"</span>"
																		}
																	},
																	{
																		targets: 3,
																		render: function(data, type, row) {
																			if (data >= 76) {
																				color = "01";
																			} else if (data >= 36) {
																				color = "02";
																			} else if (data >= 16) {
																				color = "04";
																			} else if (data > 0) {
																				color = "05";
																			} else {
																				color = "00";
																			}
																			return "<span class='co_step"+color+"'>"+data+"</span>"
																		}
																	},
																	{
																		targets: [10,11,12,13],
																		render: function(data, type, row) {
																			if(data[0] == '.') {
																				return '0'+data;
																			} else {
																				return data;
																			}
																		}
																	},
																	{
																		targets: 5,
																		render: function(data, type, row) {
																			
																			if(data) {
																				return (data/10 - 100).toFixed(1);
																			} else {
																				return "-"
																			}
																		}
																	},	
																	{
																		targets: 7,
																		render: function(data, type, row) {
																			
																			return '('+data+'°)'
																		}
																	},	
																	{
																		targets: '_all',
																		render: function(data, type, row) {
																			
																			return data == null ? "-" : data;
																		}
																	}					
																]
															});
															$("#example"+num).DataTable().clear().draw();
          													$("#example"+num).DataTable().rows.add(r.data).draw();

															$("#example"+num).DataTable().on( 'draw', function () {
																console.log('draw')
																// var rows = table.data().length;
																// table.button( 0 ).enable( rows > 0 );
															} );

															am4Generate(r.allData, {"pm10" : "미세먼지", "pm25": "초미세먼지", "temp" : "온도", "effeTemp": "흑구", "noise" : "소음", "humi": "습도", "ultraRays": "자외선", "vibrX": "진동 X축", "vibrY": "진동 Y축", "vibrZ": "진동 Z축", "co": "일산화탄소",
																					"no2": "이산화질소",
																					"so2": "이산화황",
																					"nh3": "암모니아",
																					"h2s": "황화수소",
																					"o3": "오존"}, "amChart"+num )
															am4Generate(r.allData, {"inteIllu":"조도"}, "amChartInte"+num )
															
															var recreateFlag ;
															
															if (r.data.length == 0) {
																alert("조건에 만족하는 데이터가 없습니다.");
															}
														}
													})
												}
											</script>
										</li>
									</ul>
								</div>
							</form>
					</div>
					
					
				
				</div><!-- array -->
				<div class="loader" id="loader-1"></div>
				<div id="board">
					<div class="test tg" style="height: 400px;">
						<p style="text-weight: bold">평균값</p>
						<div style="height: 400px;" id="amChart1"></div>
					</div>
					<div class="test" style="width:100%; margin-top: 30px; visibility: hidden; height:0;">
						<div style="height: 300px; width:100%;" id="amChartInte1"></div>
					</div>
					<button data-target="1" class="fhBtn" onclick="hideFade(this)">감추기</button>
					<button data-target="1" class="fhBtn" onclick="hideFadeInte(this)" style="left:87px;">조도 그래프보기</button>
					<div class="data-grid-example">
						<table id="example1" class="display" width="100%"></table>
					</div>
					
				</div><!-- board -->
				<div id="board2">
					<div class="test" style="height: 400px;">
						<p style="text-weight: bold">최대값</p>
						<div style="height: 400px;" id="amChart2"></div>
					</div>
					<div class="test" style="width:100%; margin-top: 30px; visibility: hidden; height:0;">
						<div style="height: 300px; width:100%;" id="amChartInte2"></div>
					</div>
					<div>
				    	<button data-target="2" class="fhBtn" onclick="hideFade(this)">보기</button>
				    	<button data-target="2" class="fhBtn" onclick="hideFadeInte(this)" style="left:87px;">조도 그래프보기</button>
				    </div>
					<div class="data-grid-example">
						<!-- datatable -->
						<table id="example2" class="display" width="100%"></table>
					</div>

				</div><!-- board -->
				<script>
				function hideFade(e) {
					console.log(e)
					var t = $(e).data('target');
					var d = $('#example'+t+'_wrapper').parent().css('display');
					if(d == "none")
						$(e).html('감추기')
					else
						$(e).html('보기')
						
					$('#example'+t+'_wrapper').parent().toggle();
				}
				function hideFadeInte(e) {
					console.log(e)
					var t = $(e).data('target');
					var d = $('#amChartInte'+t).parent().css('visibility');
					if(d == "hidden") {
						$(e).html('조도 그래프 감추기')
						$('#amChartInte'+t).parent().css('visibility', 'visible');
						$('#amChartInte'+t).parent().css('height', '300px');
					}
					else {
						$(e).html('조도 그래프 보기')
						$('#amChartInte'+t).parent().css('visibility', 'hidden');
						$('#amChartInte'+t).parent().css('height', '0');
					}
				}
				</script>
				
				<div id="board3">
					<div class="test" style="height: 400px;">
						<p style="text-weight: bold">최소값</p>
						<div style="height: 400px;" id="amChart3"></div>
					</div>
					<div class="test" style="width:100%; margin-top: 30px; visibility: hidden; height:0;">
						<div style="height: 300px; width:100%;" id="amChartInte3"></div>
					</div>
					<button data-target="3" class="fhBtn" onclick="hideFade(this)">보기</button>
					<button data-target="3" class="fhBtn" onclick="hideFadeInte(this)" style="left:87px;">조도 그래프보기</button>
					
					<div class="data-grid-example">
						<!-- datatable -->
						<table id="example3" class="display" width="100%"></table>
					</div>
				</div><!-- board -->
			</div><!-- container -->

        </div><!-- sensor -->
    <script src="/share/js/sensor/index.js"></script>
    
<script>
function ieTime(data) {
	if(typeof data == "object") {
		return data;
	}
	
	var a = data.split(' ');
	var ymd = a[0].split('-');
	var hm = a[1].split(':');

	return new Date(ymd[0], Number(ymd[1])-1, ymd[2], hm[0], hm[1]);
}
function am4Generate(data, field, target) {
	
	am4core.ready(function() {

	
		// Create chart instance
		var chart = am4core.create(target, am4charts.XYChart);
		chart.language.locale = am4lang_ko_KR;
		$.each(data, function(a,b) {
			data[a]['tm8'] = ieTime(data[a]['tm8'])
			console.log(a, data[a]['tm8'], data[a]['temp'])
		})
		//2019-11-08 00:01
		// Increase contrast by taking evey second color
		chart.colors.step = 0;
		
		// Add data
		chart.data = data;

		//Create axes
		var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
		dateAxis.renderer.grid.template.location = 2;
		// dateAxis.renderer.minGridDistance = 50;
		chart.dateFormatter.dateFormat = "MMM dd일 HH시";
	     dateAxis.dateFormats.setKey("hour", "MMM dd일 HH시");
	     dateAxis.periodChangeDateFormats.setKey("hour", "MMM dd일 HH시");
	     dateAxis.dateFormats.setKey("minute", "dd일 HH시 mm분");
	     dateAxis.periodChangeDateFormats.setKey("minute", "dd일 HH시 mm분");
		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

		// Create series
		function createSeries(field, name, count) {
		  var interfaceColors = [
				"#5571c6",
				"#55c6c2",
				"#db9d61",
				"#0D8ECF",
				"#2A0CD0",
				"#CD0D74",
				"#CC0000",
				"#00CC00",
				"#0000CC",
				"#DDDDDD",
				"#999999",
				"#333333",
				"#990000"
		  ];
		  var series = chart.series.push(new am4charts.LineSeries());
		  series.dataFields.valueY = field;
		  series.dataFields.dateX = "tm8";
		  series.name = name;
		  series.tooltipText = name+": [b]{valueY}[/]";
		  series.strokeWidth = 2;
		  series.minBulletDistance = 100;
		  series.fill = interfaceColors[count];
          series.stroke = interfaceColors[count];
// 		  if(name != "미세먼지" || name != "초미세먼지") {
		  if(count > 1) {
			  series.hidden = true;
		  }
		  var bullet = series.bullets.push(new am4charts.CircleBullet());
		  bullet.circle.stroke = interfaceColors[count];
		  bullet.circle.strokeWidth = 2;
		  
		  
		  return series;
		}
		var scrollbarX = new am4charts.XYChartScrollbar();
		var count = 0;
		$.each(field, function(a,b) {
			console.log(a,b)
			var series = createSeries(a, b, count);
			$('#asd').click(function() {
				  series.reinit();
			  })
			  series.events.on("shown", function(ev) {
			  // Show axis
				  console.log(chart.groupFields)
				  console.log(ev.target.end);
				  console.log(ev.target.axisRanges);
			}); 
			count++;
// 			scrollbarX.series.push(series);
		})
		chart.scrollbarX = scrollbarX;
		chart.legend = new am4charts.Legend();
		chart.cursor = new am4charts.XYCursor();

		}); // end am4core.ready()
}
</script>
<!-- <div id="chartdiv" style="height: 400px;"></div> -->
<jsp:include page="../common/footer.jsp"></jsp:include>