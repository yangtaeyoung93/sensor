<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>

<script type="text/javascript" src="/share/js/amchart/amcharts.js"></script>
<script type="text/javascript" src="/share/js/amchart//lang/ko.js"></script>
<script type="text/javascript" src="/share/js/amchart/pie.js"></script>
<script type="text/javascript" src="/share/js/amchart/serial.js"></script>
<script type="text/javascript" src="/share/js/amchart4/core.js"></script>
<script type="text/javascript" src="/share/js/amchart4/charts.js"></script>
<script type="text/javascript" src="/share/js/amchart4/animated.js"></script>
<script type="text/javascript" src="/share/js/amchart4/ko_KR.js"></script>
<script src="/share/js/page.js"></script>

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
	#board {
		width: 49%;
		display: inline-block;
	}
	#column {
	    position: relative;
	    width: 50%;
	    display: inline-block;
	    vertical-align: top;
		height: 300px;
	}
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
			width: 100%;
			height: 500px;
			font-size:12px;
		}
	
		.data-list>.header {
			height: 57px;
		}
		.body {
			height: calc(500px - 57px);
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
			width: calc((100% / 7) - 1px);
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
	</style>
	
<div id="sensor" class="body_wrap">

			<div class="container">
				
				<div class="sub_title">
					<h1 class="main_co">보정데이터 확인</h1>
				</div>

				<div class="row array">
					
					<div class="col-xs-12">
							<form>
								<div class="form-group">
									<ul class="row">
										<li class="col-xs-1 title">기간</li>
										<li class="col-xs-4">
											<div class="col-xs-5">
												<input type="text" id="to" autocomplete=off placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
											<div class="col-xs-2" style="text-align: center; line-height: 30px;">
												~
											</div>
											<div class="col-xs-5">
												<input type="text" id="from" autocomplete=off placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
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
														
														count = 2;
														$('.list').html('');
														if(to!='' && from!='' && gu!='구 선택' && equi!='기기 선택') {
															var pageNum = "${param.page}";
															if(pageNum == "") pageNum = "1";
															
															$.ajax({
																url: '/api/sensor/equiSearchListCorrection',
																type: 'POST',
																data: {
																	"toDate":toDate, "fromDate":fromDate, "gu":gu, "equiInfoKey": equi,
																	"${_csrf.parameterName}" : "${_csrf.token}",
																	"pageStart": 1
																},
																beforeSend: function() {
																	$('.loader').show();
																},
																success: function(r) {
																	$('.loader').hide();
																	sensor.rowSetCorrection(r.data);
																	am4GenerateColumn(r.data)
																	var rows = r.allData
																	am4Generate(r.allData, {"pm10" : "미세먼지(전)",  "pm10Std" : "미세먼지(후)", "pm25": "초미세먼지(전)", "pm25Std": "초미세먼지(후)"} )
																	if (r.data.length == 0) {
																		alert("조건에 만족하는 데이터가 없습니다.");
																	}
																}
															})
															
														} else {
															alert('비어있는 값이 있습니다.')
														}
														
													})
												})
													
												
											</script>
										</li>
									</ul>
								</div>
							</form>
							<div class="test" style="height: 400px; width:100%;">
								<div style="height: 400px; width:100%;" id="amChart"></div>
							</div>
					</div>
					
					
				
				</div><!-- array -->
				<div class="loader" id="loader-1"></div>
				<div id="column">
					
					</div>
				<div id="board">
					<div class="data-list">
					    <div class="header">
					        <ul>
					            <li><div>순번</div></li>
					            <li><div>기기번호</div></li>
					            <li><div>데이터시각</div></li>
					            <li><div>미세먼지(전)<br>(㎍/㎥)</div></li>
					            <li><div>미세먼지(후)<br>(㎍/㎥)</div></li>
					            <li><div>초미세먼지(전)<br>(㎍/㎥)</div></li>
					            <li><div>초미세먼지(후)<br>(㎍/㎥)</div></li>
					        </ul>
					    </div>
					    <div class="body">
					    </div>
				    </div>

				</div><!-- board -->
			</div><!-- container -->

        </div><!-- sensor -->
        
    <script src="/share/js/sensor/index.js"></script>
    <script>
	function parse(str) {
	    var y = str.substr(0, 4);
	    var m = str.substr(5, 2);
	    var d = str.substr(8, 2);
	    console.log(y,m,d)
	    return new Date(y,m-1,d);
	}
	
	$(document).ready(function() {
		$('#to').change(function() {
			if($('#from').val() != ""){
				var to = parse($('#to').val());
				var from = parse($('#from').val());
				var result = (from - to)/(24 * 3600 * 1000);
				
				if(result < 0) {
					alert("잘못된 날짜 범위입니다.");
					$('#to').val('');
					$('#from').val('');
				}
				
				if(result > 5) {
					alert("날짜 범위는 최대 5일입니다.");
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
					alert("잘못된 날짜 범위입니다.");
					$('#to').val('');
					$('#from').val('');
				}
				
				if(result > 5) {
					alert("날짜 범위는 최대 5일입니다.");
					$('#to').val('');
				}
			}
		})
	})
	</script>
    <script>
	function ieTime(data) {
		var a = data.split(' ');
		var ymd = a[0].split('-');
		var hm = a[1].split(':');

		return new Date(ymd[0], Number(ymd[1])-1, ymd[2], hm[0], hm[1]);
	}
    function am4GenerateColumn(data) {
    	var chart = am4core.create("column", am4charts.XYChart);

		var parseData = [
			{
				"name" : "미세먼지(전)",
				"data": data[0].pm10
			},
			{
				"name" : "미세먼지(후)",
				"data": data[0].pm10Std
			},
			{
				"name" : "초미세먼지(전)",
				"data": data[0].pm25
			},
			{
				"name" : "초미세먼지(후)",
				"data": data[0].pm25Std
			}
		];
		
    	chart.data = parseData;

    	var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
    	categoryAxis.renderer.grid.template.location = 0;
    	categoryAxis.dataFields.category = "name";
    	categoryAxis.renderer.minGridDistance = 40;
    	categoryAxis.fontSize = 11;
    	categoryAxis.renderer.labels.template.dy = 5;

    	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
    	valueAxis.min = 0;
    	valueAxis.renderer.minGridDistance = 30;
    	valueAxis.renderer.baseGrid.disabled = true;


    	var series = chart.series.push(new am4charts.ColumnSeries());
    	series.dataFields.categoryX = "name";
    	series.dataFields.valueY = "data";
    	series.columns.template.tooltipText = "{valueY.value}";
    	series.columns.template.tooltipY = 0;
    	series.columns.template.strokeOpacity = 0;

    	// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
    	series.columns.template.adapter.add("fill", function(fill, target) {
	    	  console.log(chart.colors.getIndex(target.dataItem.index))
	    	  console.log(target.dataItem.index)
	    	  var interfaceColors = [
	    						"#5571c6",
	    						"#55c6c2",
	    						"#db9d61",
	    						"#0D8ECF"
	    				];
	    	  return interfaceColors[target.dataItem.index];
	    })
    }
	function am4Generate(data, field) {

		am4core.ready(function() {

		
			// Create chart instance
			var chart = am4core.create("amChart", am4charts.XYChart);
			chart.language.locale = am4lang_ko_KR;
			chart.colors.step = 0;
			$.each(data, function(a,b) {
				data[a]['tm8'] = ieTime(data[a]['tm8'])
				console.log(a, data[a]['tm8'])
			})
			// Add data
			chart.data = data;
			console.log(data);
			//Create axes
			var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
			dateAxis.renderer.grid.template.location = 2;
	// 		dateAxis.renderer.minGridDistance = 50;
			chart.dateFormatter.dateFormat = "MMM dd일 HH시";
			dateAxis.dateFormats.setKey("hour", "MMM dd일 HH시");
			dateAxis.periodChangeDateFormats.setKey("hour", "MMM dd일 HH시");
			dateAxis.dateFormats.setKey("minute", "dd일 HH시 mm분");
			dateAxis.periodChangeDateFormats.setKey("minute", "dd일 HH시 mm분");

			console.log(dateAxis);
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
			series.events.on("hit", toggleAxes);
			series.events.on("ready", toggleAxes2);
			return series;
			}
			var scrollbarX = new am4charts.XYChartScrollbar();
			var count = 0;
			$.each(field, function(a,b) {
				console.log(a,b)
				var series = createSeries(a, b, count);
				count++;
	// 			scrollbarX.series.push(series);
			})
			chart.scrollbarX = scrollbarX;
			

			

			function toggleAxes(ev) {
				  console.log(ev)
			}
			function toggleAxes2(ev) {
				  console.log("ready", ev.maxValue, valueAxis.max)
			}
			chart.legend = new am4charts.Legend();
			chart.cursor = new am4charts.XYCursor();

			}); // end am4core.ready()
	}
    </script>
<jsp:include page="../common/footer.jsp"></jsp:include>