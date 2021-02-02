<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-KR">
<head>
<title>장비현황</title>
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

<!-- datatables -->
<script type="text/javascript" src="../../share/js/datatable/jquery.dataTables.min.js"></script>
<style>
	.fhBtn {
	   color: #0c82e9;
	   border: 1px solid #0c82e9;
	   background: #f3f9fe;
	   padding: 6px 20px;
	   margin-bottom: 10px;
	   position: absolute;
	   top: 367px;
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
	.sorting {
		font-weight: normal;
		font-size: 0.875em;
		color: #0c82e9;
		padding-top: 5px;
		width: calc(100% / 3) !important;
	}
	.dataTables_wrapper.no-footer {
		position:relative;
	}
	.display.dataTable.no-footer {
		border-collapse: collapse;
	}
	.display.dataTable.no-footer thead tr th {
		text-align: center;
		padding: 7px;
	}
	.dataTables_scrollBody tbody tr td {
		text-align: center;
		font-size: 0.875em;
	}
	.dataTables_scrollBody tbody tr td.dataTables_empty {
		padding-top: 5px;
	}
	.display.dataTable.no-footer tbody tr {
		height: 34px;
		border-bottom: 1px solid #d7d7d7;
	}
	.dataTables_paginate.paging_simple_numbers {
		overflow: auto;
		clear: both;
		text-align: right;
		margin-top: 15px;
		height: 33px;
		padding: 3px;
			padding-right: 3px;
		padding-right: 15px;
	}
	.paginate_button {
		color: #666666;
		padding: 4px 12px;
		transition: background-color 0.3s;
		font-size: 0.875em;
		border-top: 1px solid #d7d7d7;
		border-bottom: 1px solid #d7d7d7;
		border-left: 1px solid #d7d7d7;
		cursor: pointer;
		-webkit-touch-callout: none;
		-webkit-user-select: none;
		-khtml-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	.paginate_button.next {
		border-right: 1px solid #d7d7d7;
	}
	.dataTables_info {
		font-size: 0.875em;
	}
	.ellipsis {
		color: #666666;
		padding: 4px 12px;
		transition: background-color 0.3s;
		font-size: 0.875em;
		border-top: 1px solid #d7d7d7;
		border-bottom: 1px solid #d7d7d7;
		border-left: 1px solid #d7d7d7;
		-webkit-touch-callout: none;
		-webkit-user-select: none;
		-khtml-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	.paginate_button.current {
		background-color: #0c82e9;
		color: #fff;
		border: 1px solid #0c82e9;
	}
	.dim {
		width: 100%;
		height: 100%;
	}
	.dim::before {
		content: ' ';
		background: rgba(0,0,0,0.9);
		width: 100%;
		height: 100%;
		position: absolute;
		z-index: 998;
	}
	.dim::after {
		content: '데이터를 준비중입니다.';
		color: white;
		position: absolute;
		top: 50%;
		left: 50%;
		z-index: 999;
		transform: translate(-50%, -50%);
		animation: blinker 1.7s linear infinite;
	}

	@keyframes blinker {
		50% {
			opacity: 0;
		}
	}
</style>
</head>

<body>
<div class="wrap">
	<div class="tab_bt">
		<a href="/popup01"><div class="tab_menuon">
		장비 현황
		</div></a>
		<a href="/popup02"><div class="tab_menuoff">
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
<!-- 총 설치장비 및 이상장비 -->
		<div class="con01" id="totalCnt">
			<div class="total01">
				<div class="title1">
				총 설치장비
				</div>
				<div class="number">
				1,100대
				</div>
			</div>
			<div class="total02">
				<div class="title1">
				총 이상장비
				</div>
				<div class="number">
				80대
				</div>
			</div>
		</div>
<!-- 이상장비현황 리스트 -->
		<div class="con02">
			<div class="con_title1">
				<div class="tt">
				이상장비 현황
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
					구분
					</div>
					<div class="thead_td">
					설치현황
					</div>
					<div class="thead_td">
					정상장비
					</div>
					<div class="thead_td">
					이상장비
					</div>
				</div>
				<div id="listCnt">
                    
                </div>
			</div>		
		</div>
<!-- 이상장비상세현황 -->
		<div class="con03">
			<div class="con03_title">
				<div class="tt2">
				이상장비 상세현황
				</div>
				<div class="element_select" style="width: 160px;">				
					<select id="element">
						<option value="pm10">미세먼지</option>
						<option value="pm25">초미세먼지</option>
						<option value="temp">온도</option>
						<option value="humi">습도</option>
						<option value="noise">소음</option>
						<option value="vibr">진동</option>
						<option value="inteIllu">조도</option>
						<option value="ultraRays">자외선</option>
						<option value="windDire">풍향</option>
						<option value="windSpeed">풍속</option>
						<option value="co">일산화탄소</option>
						<option value="no2">이산화질소</option>
						<option value="so2">이산화황</option>
						<option value="nh3">암모니아</option>
						<option value="h2S">황화수소</option>
						<option value="o3">오존</option>
						<option value="effeTemp">흑구</option>
					</select>
				</div>
				<div class="notice" style="float: left;padding-top: 8px;font-size: 0.875em;">(해당 기간중 한번도 데이터가 안들어온 기기 목록입니다.)</div>
			</div>
			<div class="con03_list">
				<table id="example" class="display" width="100%"></table>
				<script>
					$(document).ready(function() {

						$('.cookieBtn').on('click', function() {
							setCookie('popup', false, 1);
							window.close();
						})

						function getFormatDate(date) {
							var year = date.getFullYear(); //yyyy
							var month = 1 + date.getMonth(); //M
							month = month >= 10 ? month : "0" + month; //month 두자리로 저장
							var day = date.getDate(); //d
							day = day >= 10 ? day : "0" + day; //day 두자리로 저장
							var hour =
								new Date().getHours() >= 10
								? new Date().getHours()
								: "0" + new Date().getHours();
							var minutes =
								new Date().getMinutes() >= 10
								? new Date().getMinutes()
								: "0" + new Date().getMinutes();
							return year + "" + month + "" + day + "" + hour + "" + minutes; //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
						}

						function getTitle() {
							$('#sel-1 option').each(function() {
								if($('#sel-1').val() == $(this).val()) {
									return $(this).text() + "_";
								}
							})
						}
						var table =  $("#example").DataTable({
						pageLength: 5,
						paging: true,
						searching: false,
						sorting: false,
						scrollY: 500,
						scrollCollapse: true,
						searchPanes: {
							dataLength: false
						},    
						dom: "Bfrtip",
						language: {
							info: "현재 _START_ - _END_ / _TOTAL_건",
							emptyTable: "현재 검색된 데이터가 없습니다.",
							infoEmpty: "",
							paginate: {
								next : "다음",
								previous: "이전"
							}
						},

						columns: [
							{ data: "guTp", title: "지역" },
							{ data: "equiInfoKeyHan", title: "관리번호" },
							{ data: "equiInfoKey", title: "시리얼" },
						],
						columnDefs: [
							{
								targets: 0,
								render: function(data, type, row) {
									var filter = code.filter(function(list) {
										return list.code == data;
									})
									// console.log(filter[0].relCd1);
									return filter[0].relCd1;
								}
							},
							{
								targets: 1,
								render: function(data, type, row) {
									var filter = code.filter(function(list) {
										return list.code == row.guTp;
									})
									// console.log(filter[0].relCd1);
									return filter[0].relCd1+'-'+data;
								}
							}
						]
						});

						
					})
				</script>
			</div>
		</div>
	</div>
</div>

<script>
	var code;
    $(document).ready(function() {
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

		$('#element').change(function() {
			var toDate = $('#toDate').val();
			var fromDate = $('#fromDate').val();
			var type = $(this).val();
            if(toDate.length == 0 || fromDate.length == 0) {
                alert('날짜를 선택해주세요.')
            } else {
				searchEqui(toDate, fromDate, type);
            }
		})
        $('#dateBtn').click(function() {
            var toDate = $('#toDate').val();
            var fromDate = $('#fromDate').val();
            if(toDate.length == 0 || fromDate.length == 0) {
                alert('날짜를 선택해주세요.')
            } else {
				searchDate(toDate.replace(/-/g,""), fromDate.replace(/-/g,""));
				searchEqui(toDate, fromDate, $('#element').val());
            }


		})
		function searchEqui(toDate, fromDate, type) {
			$.ajax({
					url: '/api/sensor/getDailyCntForEquiSensor',
					method: 'POST',
					async: true,
					data: {
						toDate: toDate.replace(/-/g,""),
						fromDate: fromDate.replace(/-/g,""),
						type: type
					}, success: function(r) {
						code = r.code;
						$("#example").DataTable().clear().draw();
          				$("#example").DataTable().rows.add(r.list).draw();
					}, beforeSend: function() {
						$('.dataTables_wrapper.no-footer').toggleClass('dim')
					}, complete: function() {
						$('.dataTables_wrapper.no-footer').toggleClass('dim')
					}
				})
		}
        function searchDate(toDate, fromDate) {
            $.ajax({
                url: '/api/sensor/getDailyCntForEqui',
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
                                '<div class="total01">'+
                                '    <div class="title1">'+
                                '    총 설치장비'+
                                '    </div>'+
                                '    <div class="number">'+
                                '    '+numberWithCommas(list.equiCnt)+'대'+
                                '    </div>'+
                                '</div>'+
                                '<div class="total02">'+
                                '    <div class="title1">'+
                                '    총 이상장비'+
                                '    </div>'+
                                '    <div class="number">'+
                                '        '+bad+'대'+
                                '    </div>'+
                                '</div>'
                            )
                        } else {

                            $('#listCnt').append(
                                '<div class="tbody_tr">'+
                                '    <div class="tbody_td1">'+
                                '    '+equiTypeName[list.equiType]+''+
                                '    </div>'+
                                '    <div class="tbody_td1">'+
                                '    '+numberWithCommas(list.equiCnt)+''+
                                '    </div>'+
                                '    <div class="tbody_td2">'+
                                '    '+numberWithCommas(list.normalEquiCnt)+''+
                                '    </div>'+
                                '    <div class="tbody_td3">'+
                                '    '+bad+''+
                                '    </div>'+
                                '</div>'
                            )
                        }
                    })

                }
            })
		}
		function init() {
			var month = (new Date().getMonth() + 1) < 10 ? '0' + (new Date().getMonth() + 1) : (new Date().getMonth() + 1);
			var day = (new Date().getDate()) < 10 ? '0' + (new Date().getDate()) : (new Date().getDate());
			var date = new Date().getFullYear().toString() + "-" +
						month + "-" +
						day;
			$('#toDate').val(date)
			$('#fromDate').val(date)
			
			$('#element').val('pm10')
			searchDate(date.replace(/-/g,""), date.replace(/-/g,""));
			searchEqui(date.replace(/-/g,""), date.replace(/-/g,""), "pm10");
		}

		init();
    })
</script>
</body>
</html>