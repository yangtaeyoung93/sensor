<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<title>보고서생성</title>
	<meta charset="UTF-8">
	<meta name="description" content="Free Web tutorials">
	<meta name="keywords" content="HTML,CSS,XML,JavaScript">
	<meta name="author" content="KimEunjin">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<link href="../../share/css/popup.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<![endif]-->
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<script type="text/javascript" src="../../share/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="../../share/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../../share/js/popup.js"></script>
<style>
	@media print {
		.tab_bt, .printbt {
			display: none;
		}
	}
</style>
</head>

<body>
<div class="wrap">
	<div class="tab_bt">
		<a href="/popup01"><div class="tab_menuoff">
			장비 현황
		</div></a>
		<a href="/popup02"><div class="tab_menuoff">
		데이터 현황
		</div></a>
		<a href="/popup03"><div class="tab_menuon">
		보고서 생성
		</div></a>
		<div class="datebt cookieBtn" style="cursor: pointer; width: 160px;position: relative;left: 35px;top: 5px;">
			오늘 하루 보지 않기
		</div>
	</div>
	<div class="contents">	
<!-- 도시데이터센서 현황 보고서 -->
		<div class="con06">
			<div class="con_title1">
				<div class="tt" style="width: 210px;">
				도시데이터센서 현황 보고서
				</div>
				<div class="datett" style="width:345px;">
					<form class="date_time">
						<input type="date" id="toDate">
					</form>
					<div class="date_time2">
					~
					</div>
					<form class="date_time">
						<input type="date" id="fromDate">
					</form>
					<div class="datebt" id="dateBtn" style="cursor: pointer;">
					검색
					</div>					
				</div>
			</div>
			<div class="con_listday" id="dayText">
			</div>
		</div>
<!-- 장비&데이터현황 -->
		<div class="con07">
			<div class="con07_title">
				<div class="con07_tt">
				장비 현황
				</div>
				<div class="thead_tr3">
					<div class="thead_td2">
					총 설치 장비
					</div>
					<div class="thead_td2">
					총 이상 장비
					</div>
					<div class="thead_td2">
					총 가동률
					</div>
				</div>
				<div id="totalCntEqui">

				</div>
			</div>
			<div class="con07_title_right">
				<div class="con07_tt">
				데이터 현황
				</div>
				<div class="thead_tr3">
					<div class="thead_td2">
					총 수집 데이터
					</div>
					<div class="thead_td2">
					총 누락 건수
					</div>
					<div class="thead_td2">
					총 수집률
					</div>
				</div>
				<div id="totalCntData">

				</div>
			</div>
		</div>
<!-- 센서별 현황 -->
		<div class="con08">
			<div class="con08_title">
			센서별 현황
			</div>
			<div class="con05_list">
				<div class="thead_tr4">
					<div class="thead_td4">
					구분
					</div>
					<div class="thead_td5">
						<div class="thead_tr5">
						장비 현황
						</div>
						<div class="thead_tr6">
							<div class="thead_td7">
							설치현황
							</div>
							<div class="thead_td7">
							정상장비
							</div>
							<div class="thead_td7">
							이상장비
							</div>
							<div class="thead_td7">
							가동률
							</div>
						</div>
					</div>
					<div class="thead_td5">
						<div class="thead_tr5">
						데이터 현황
						</div>
						<div class="thead_tr6">
							<div class="thead_td7">
							총수집데이터
							</div>
							<div class="thead_td7">
							수집건수
							</div>
							<div class="thead_td7">
							누락건수
							</div>
							<div class="thead_td7">
							가동률
							</div>
						</div>
					</div>
				</div>
				<div id="listData">

				</div>
				

				<div class="tbody_bt">
					<div class="printbt" onclick="window.print()" style="cursor: pointer;">
					인쇄
					</div>	
				</div>
			</div>		
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('.cookieBtn').on('click', function() {
			setCookie('popup', false, 1);
			window.close();
		})
		$.datepicker.setDefaults({
			dateFormat: 'yy-mm-dd',
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear: true,
			yearSuffix: '년'
		});
		if ( $('[type="date"]').prop('type') != 'date' ) {
			$('[type="date"]').datepicker();
		}

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        $('#dateBtn').click(function() {
            var toDate = $('#toDate').val();
            var fromDate = $('#fromDate').val();
            if(toDate.length == 0 || fromDate.length == 0) {
                alert('날짜를 선택해주세요.')
            } else {
                searchDate(toDate.replace(/-/g,""), fromDate.replace(/-/g,""));
            }


        })
        function searchDate(toDate, fromDate) {
			
			

			function dayTextParse(toDate, fromDate) {
				$('#dayText').html(toDate.substr(0,4)+"년 "+toDate.substr(4,2)+"월 "+toDate.substr(6,2)+"일부터 "+fromDate.substr(0,4)+"년 "+fromDate.substr(4,2)+"월 "+fromDate.substr(6,2)+"일까지의 도시데이터센서 현황 보고서입니다.");
			}
			function searchEquiCnt(toDate, fromDate) {
				$.ajax({
					url: '/api/sensor/getDailyCntForEqui',
					method: 'POST',
					async: false,
					data: {
						toDate: toDate,
						fromDate: fromDate
					}, success: function(r) {
						equiCnt = r.data;
					}, complete: function() {
						equiCnt.map(function(list) {
							if(list.equiType == "all") {
								$('#totalCntEqui').html(
									'<div class="tbody_tr3">'+
									'	<div class="tbody_td4">'+
									'		'+numberWithCommas(list.equiCnt)+''+
									'	</div>'+
									'	<div class="tbody_td4">'+
									'		'+numberWithCommas(list.badEquiCnt)+''+
									'	</div>'+
									'	<div class="tbody_td4">'+
									'		'+Math.floor(list.normalEquiCnt/list.equiCnt*100)+'%'+
									'	</div>'+
									'</div>'
								);
							}
						})
					}
				})
			}

			function searchDataCnt(toDate, fromDate) {
				$.ajax({
					url: '/api/sensor/getDailyCntForData',
					method: 'POST',
					async: false,
					data: {
						toDate: toDate,
						fromDate: fromDate
					}, success: function(r) {
						dataCnt = r.data;
					}, complete: function() {
						dataCnt.map(function(list) {
							if(list.equiType == "all") {
								$('#totalCntData').html(
								'	<div class="tbody_tr3">'+
								'		<div class="tbody_td4">'+
								'			'+numberWithCommas(list.normalDataCnt)+''+
								'		</div>'+
								'		<div class="tbody_td4">'+
								'			'+numberWithCommas(list.badDataCnt)+''+
								'		</div>'+
								'		<div class="tbody_td4">'+
								'			'+Math.floor((list.dataCnt/list.normalDataCnt * 100))+'%'+
								'		</div>'+
								'	</div>'
								);
							}
						})
					}
				})
			}
			
			const equiTypeName = {"pm25" : "초미세먼지", "humi" : "습도", "o3" : "오존(O₃)", "wind_speed" : "풍속", "nh3" : "암모니아(NH₃)", "temp" : "온도", "inte_illu" : "조도", "so2" : "이산화황(SO₂)", "effe_temp" : "흑구", "pm10" : "미세먼지", "vibr" : "진동", "wind_dire" : "풍향", "h2s" : "황화수소(H₂S)", "noise" : "소음", "ultra_rays" : "자외선", "co" : "일산화탄소(CO)", "no2" : "이산화질소(NO₂)"};
			var equiCnt, dataCnt;
			$('#listData').html('');
			dayTextParse(toDate, fromDate);
			
			searchEquiCnt(toDate, fromDate);
			searchDataCnt(toDate, fromDate);
			// console.log(dataCnt, equiCnt);

			var mergeObj = [];
			dataCnt.map(function(list, index) {
				var equi = equiCnt[index];
				mergeObj.push({equiType: list.equiType, dataCnt: list.dataCnt, normalDataCnt: list.normalDataCnt, badDataCnt: list.badDataCnt, dataPercent: list.percent, equiCnt: equi.equiCnt, normalEquiCnt: equi.normalEquiCnt, badEquiCnt: equi.badEquiCnt, equiPercent: equi.percent})
			})


			mergeObj.map(function(obj) {
				if(obj.equiType != "all") {
					var percent = obj.normalDataCnt == 0 ? 0 : Math.floor((obj.dataCnt/obj.normalDataCnt * 100));
					var equiPercent = obj.normalEquiCnt == 0 ? 0 : Math.floor(obj.normalEquiCnt/obj.equiCnt*100);
					$('#listData').append(
						'<div class="tbody_tr4">'+
						'	<div class="tbody_td8" style="font-size:0.8em">'+
						'	'+equiTypeName[obj.equiType]+''+
						'	</div>'+
						'	<div class="tbody_td9">'+
						'		<div class="tbody_td10">'+
						'			'+numberWithCommas(obj.equiCnt)+''+
						'		</div>'+
						'		<div class="tbody_td11">'+
						'			'+numberWithCommas(obj.normalEquiCnt)+''+
						'		</div>'+
						'		<div class="tbody_td12">'+
						'			'+numberWithCommas(obj.badEquiCnt)+''+
						'		</div>'+
						'		<div class="tbody_td10">'+
						'			'+equiPercent+'%'+
						'		</div>'+
						'	</div>'+
						'	<div class="tbody_td9">'+
						'		<div class="tbody_td10">'+
						'			'+numberWithCommas(obj.normalDataCnt)+''+
						'		</div>'+
						'		<div class="tbody_td11">'+
						'			'+numberWithCommas(obj.dataCnt)+''+
						'		</div>'+
						'		<div class="tbody_td12">'+
						'			'+numberWithCommas(obj.badDataCnt)+''+
						'		</div>'+
						'		<div class="tbody_td10">'+
						'			'+Math.floor(percent)+'%'+
						'		</div>'+
						'	</div>'+
						'</div>'
					);
				}
			})


            
        }
        var month = (new Date().getMonth() + 1) < 10 ? '0' + (new Date().getMonth() + 1) : (new Date().getMonth() + 1);
		var day = (new Date().getDate()) < 10 ? '0' + (new Date().getDate()) : (new Date().getDate());
		var date = new Date().getFullYear().toString() + "-" +
					month + "-" +
					day;
		
		$('#toDate').val(date);
		$('#fromDate').val(date);
		searchDate(date.replace(/-/g,""), date.replace(/-/g,""));
    })
</script>
</body>
</html>