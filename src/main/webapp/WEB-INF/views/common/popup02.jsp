<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<title>데이터현황</title>
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
</head>

<body>
<div class="wrap">
	<div class="tab_bt">
		<a href="/popup01"><div class="tab_menuoff">
			장비 현황
		</div></a>
		<a href="/popup02"><div class="tab_menuon">
		데이터 현황
		</div></a>
		<a href="/popup03"><div class="tab_menuoff">
		보고서 생성
		</div></a>
		<div class="datebt cookieBtn" style="cursor: pointer; width: 160px;position: relative;left: 35px;top: 5px;">
			오늘 하루 보지 않기
		</div>
	</div>
	<div class="contents">	
<!-- 데이터 수집 현황 -->
		<div class="con04">
			<div class="con_title1">
				<div class="tt">
				데이터 수집 현황
				</div>
				<div class="datett" style="width:345px;">
					<!-- <div class="date_select">
						<select id="day">
							<option value="">주간</option>
							<option value="">월간</option>
						</select>
					</div> -->
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
			<div class="con_list1">
				<div class="thead_tr">
					<div class="thead_td">
					총 설치 장비
					</div>
					<div class="thead_td">
					총 수집 데이터
					</div>
					<div class="thead_td">
					수집 건수
					</div>
					<div class="thead_td">
					누락 건수
					</div>
				</div>
				<div id="totalCnt">

				</div>
				
			</div>
		</div>
<!-- 센서별 데이터 수집 현황 -->
		<div class="con05">
			<div class="con_title1">
				<div class="tt">
				센서별 데이터 수집 현황
				</div>
			</div>
			<div class="con05_list">
				<div class="thead_tr">
					<div class="thead_td3">
					구분
					</div>
					<div class="thead_td3">
					장비 수
					</div>
					<div class="thead_td3">
					총 수집 데이터
					</div>
					<div class="thead_td3">
					수집건수
					</div>
					<div class="thead_td3">
					누락 건수
					</div>
				</div>
				<div id="listCnt">
                    
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
            $.ajax({
                url: '/api/sensor/getDailyCntForData',
                method: 'POST',
                data: {
                    toDate: toDate,
                    fromDate: fromDate
                }, success: function(r) {
                    const equiTypeName = {"pm25" : "초미세먼지", "humi" : "습도", "o3" : "오존", "wind_speed" : "풍속", "nh3" : "암모니아", "temp" : "온도", "inte_illu" : "조도", "so2" : "이산화황", "effe_temp" : "흑구", "pm10" : "미세먼지", "vibr" : "진동", "wind_dire" : "풍향", "h2s" : "황화수소", "noise" : "소음", "ultra_rays" : "자외선", "co" : "일산화탄소", "no2" : "이산화질소"};
                    // console.log(r.data);
                    var totalBadCnt = 0;
                    $('#listCnt').html('');
                    $('#totalCnt').html('');
                    r.data.map(function(list) {
                        var bad = list.badEquiCnt < 0 ? 0 : list.badEquiCnt;

                        if(list.equiType == "all") {
                            $('#totalCnt').html(
								'<div class="tbody_tr">'+
								'	<div class="tbody_td1">'+
								'		'+numberWithCommas(list.equiCnt)+''+
								'	</div>'+
								'	<div class="tbody_td1">'+
								'		'+numberWithCommas(list.normalDataCnt)+''+
								'	</div>'+
								'	<div class="tbody_td2">'+
								'		'+numberWithCommas(list.dataCnt)+''+
								'	</div>'+
								'	<div class="tbody_td3">'+
								'		'+numberWithCommas(list.badDataCnt)+''+
								'	</div>'+
								'</div>'
                            )
                        } else {

                            $('#listCnt').append(
								'<div class="tbody_tr">'+
								'	<div class="tbody_td5">'+
								'	'+equiTypeName[list.equiType]+''+
								'	</div>'+
								'	<div class="tbody_td5">'+
								'		'+numberWithCommas(list.equiCnt)+''+
								'	</div>'+
								'	<div class="tbody_td5">'+
								'		'+numberWithCommas(list.normalDataCnt)+''+
								'	</div>'+
								'	<div class="tbody_td6">'+
								'		'+numberWithCommas(list.dataCnt)+''+
								'	</div>'+
								'	<div class="tbody_td7">'+
								'		'+numberWithCommas(list.badDataCnt)+''+
								'	</div>'+
								'</div>'
                            )
                        }
                    })

                }
            })
		}
		
		var month = (new Date().getMonth() + 1) < 10 ? '0' + (new Date().getMonth() + 1) : (new Date().getMonth() + 1);
			var day = (new Date().getDate()) < 10 ? '0' + (new Date().getDate()) : (new Date().getDate());
			var date = new Date().getFullYear().toString() + "-" +
						month + "-" +
						day;
			$('#toDate').val(date)
			$('#fromDate').val(date)
        	searchDate(date.replace(/-/g,""), date.replace(/-/g,""));
    })
</script>
</body>
</html>