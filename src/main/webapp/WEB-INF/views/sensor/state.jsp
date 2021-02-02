<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/charts.jsp"></jsp:include>

<script src="/share/js/page.js"></script>
<script src="/share/js/page/sensor/S104.js"></script>

<link rel="stylesheet" href="/share/css/page/sensor/S104.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

<script type='text/javascript'
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

<script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
<!-- datatables -->
<script type="text/javascript" src="../../share/js/datatable/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/buttons.flash.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/buttons.html5.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/buttons.print.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/jszip.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/pdfmake.min.js"></script>
<script type="text/javascript" src="../../share/js/datatable/vfs_fonts.js"></script>
<style>
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
		padding: 10px 0;
	}
	.dataTables_scrollBody tbody tr td {
		text-align: center;
		padding: 10px 0;
	}
	.dataTables_scrollBody {
		overflow-x: hidden !important;
	}
	#example_info {
		margin-top: 10px;
		margin-left: 3px;
	}
</style>
<div id="sensor" class="body_wrap">

	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">장비상태정보 조회</h1>
		</div>

		<div class="row array">

			<div class="col-xs-12">
				<form>
					<div class="form-group">
						<ul class="row">
							<li class="col-xs-1 title">기간</li>
							<li class="col-xs-4">
								<div class="col-xs-5">
									<input type="text" id="to" placeholder="날짜선택"
										class="form-control" autocomplete=off value=""><span style="display: none;"
										class="input-group-addon"></span>
								</div>
								<div class="col-xs-2"
									style="text-align: center; line-height: 30px;">~</div>
								<div class="col-xs-5">
									<input type="text" id="from" placeholder="날짜선택"
										class="form-control" autocomplete=off value=""><span style="display: none;"
										class="input-group-addon"></span>
								</div>
							</li>

							<li class="col-xs-1"><select id="gu">
									<option>구 선택</option>
									<c:forEach items="${gus}" var="gu">
										<option value="${gu.code}">${gu.codeNm}</option>
									</c:forEach>
							</select>
							<script>

							// 임시 엑셀 컬럼 등록용 Func ==> 컬럼 추가 시 삭제
							
							</script></li>
							<li class="col-xs-2"><select id="equi">
									<option>기기 선택</option>

							</select></li>

							<li class="col-xs-1"><input
								class="equi_search_btn search_btn" type="submit" value="검색">
								
							</li>
							<li class="col-xs-3">
								<p id="sensorInfo"
									style="margin: 0; padding: 0; font-size: 14px; line-height: 30px; color: red;">※ 기기별로 측정센서가 다르게 설치되어 있습니다. <br>설치되지 않은 측정항목은 –로 표시됨</p>
							</li>
						</ul>
					</div>
				</form>
			</div>

		</div>
		<!-- array -->
		<div class="loader" id="loader-1"></div>
		<table id="example" class="display" width="100%"></table>
		<div id="messageDiv" style="text-align: center; display: none;">
			<hr />
			<h3>
				<strong style="color: red;">조회 범위 내 미수신</strong>
			</h3>
			<hr />
			<span id="lastUpdateDate"></span>
		</div>
		<!-- board -->
	</div>
	<!-- container -->

</div>

<script>
	$(document).ready(function() {
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
		var table =  $("#example").DataTable({
			paging: false,
			searching: false,
			sorting: false,
			scrollY: 500,
			scrollCollapse: true,
			dom: "Bfrtip",
			language: {
				info: "데이터 총 _TOTAL_개",
				emptyTable: "현재 검색된 데이터가 없습니다.",
				infoEmpty: "",
			},
			buttons: [
				{
				extend: "excel",
				title: "장비 상태 정보 조회_" + getFormatDate(new Date()),
				text: "데이터 EXPORT",
				className: "exBtn",
				enabled: false
				},
			],
			columns: [
				{ data: 'equiInfoKey' , title: '기기번호'},
				{ data: 'tm8' , title: '데이터시각'},
				{ data: 'currVer' , title: '프로토콜버전'},
				{ data: 'pm10Stat' , title: '미세먼지<br />(㎍/㎥)'},
				{ data: 'pm25Stat' , title: '초미세먼지<br />(㎍/㎥)'},
				{ data: 'noiseStat' , title: '소음<br />(dB)'},
				{ data: 'tempStat' , title: '온도<br />(℃)'},
				{ data: 'effeTempStat' , title: '흑구<br />(℃)'},
				{ data: 'humiStat' , title: '습도<br />(%)'},
				{ data: 'gustDireStat' , title: '풍향<br />'},
				{ data: 'gustSpeedStat' , title: '풍속<br />(㎧)'},
				{ data: 'inteIlluStat' , title: '조도<br />(lx)'},
				{ data: 'ultraRaysStat' , title: '자외선<br />(UVI)'},
				{ data: 'vibrXStat' , title: '진동<br />-X축(g)'},
				{ data: 'vibrYStat' , title: '진동<br />-Y축(g)'},
				{ data: 'vibrZStat' , title: '진동<br />-Z축(g)'},
				{data: 'co', title:'일산화탄소<br />(ppm)'},
				{data: 'no2', title:'이산화질소<br />(ppm)'},
				{data: 'so2', title:'이산화황<br />(ppm)'},
				{data: 'nh3', title:'암모니아<br />(ppm)'},
				{data: 'h2s', title:'황화수소<br />(ppm)'},
				{data: 'o3', title:'오존<br />(ppm)'}

			],
			columnDefs: [
				{
					targets: [8,9],
					render: function (data, type, row) {
						console.log(data, type, row);
						if (row.guTp == 25 || row.guTp == "25") {
							if (data == 1 || data == "1") {
								return "<span style='color:#44c7f4;'>정상</span>";
							} else {
								return "<span style='color:#ff0000;'>-</span>";
							}
						} else {
							return "-"
						}
					},
				},
				{
					targets: [0,2],
					render: function(data, type, row) {
						return "<span style='font-size: 11px;'>"+data+"</span>";
					}
				},
				{
					targets: [1],
					render: function(data, type, row) {
						function parseDate(date) {
							var year = date.substr(0, 4);
							var month = date.substr(4, 2);
							var day = date.substr(6, 2);
							var hour = date.substr(8, 2);
							var minute = date.substr(10, 2);

							return year + "-" + month + "-" + day + " " + hour;
						}
						return "<span>" + parseDate(row.tm8) + "<br/>" + 
                        row.tm6.substr(0, 2) +
                        "시 " +
                        row.tm6.substr(2, 2) +
                        "분</span>"
					}
				},
				{
					targets: "_all",
					render: function (data, type, row) {
						if (data == 1 || data == "1") {
							return "<span style='color:#44c7f4;'>정상</span>";
						} else {
							return "<span>-</span>";
						}
					},
					
				},
			]
		});
		table.on( 'draw', function () {
			var rows = table.data().length;
			table.button( 0 ).enable( rows > 0 );
		} );
	})
</script>
<script src="/share/js/sensor/index.js"></script>

<jsp:include page="../common/footer.jsp"></jsp:include>