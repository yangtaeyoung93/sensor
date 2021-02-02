<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/charts.jsp"></jsp:include>
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
	.display.dataTable.no-footer thead tr th {
		text-align: center;
		padding: 10px;
	}
	.dataTables_scrollBody tbody tr td {
		text-align: center;
		padding: 10px 6px;
	}
</style>
<script src="/share/js/page.js"></script>
<script src="/share/js/page/sensor/S101.js"></script>
<link rel="stylesheet" href="/share/css/page/sensor/S101.css">

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">

<script type='text/javascript' src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

<script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>

<div id="sensor" class="body_wrap">

			<div class="container">
				
				<div class="sub_title">
					<h1 class="main_co">수치/농도 현황 조회</h1>
				</div>

				<div class="row array">
					
					<div class="col-xs-12">
							<form>
								<div class="form-group">
									<ul class="row">
										<li class="col-xs-1 title">기간</li>
										<li class="col-xs-4">
											<div class="col-xs-5">
												<input value="" type="text" id="to" autocomplete=off placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
											</div>
											<div class="col-xs-2" style="text-align: center; line-height: 30px;">
												~
											</div>
											<div class="col-xs-5">
												<input value="" type="text" id="from" autocomplete=off placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
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
											<script>
												$(document).ready(function() {
													$("#equi").on('mouseenter','option',function(e) {
													    var $target = $(e.target);
													    console.log(e);
													});
													$("#equi").mouseenter(function() {
														$('#amChart').css('z-index', '-1').css('position', 'relative');
													})
													$('.tg').hover(function() {
														$('#amChart').css('z-index', '0').css('position', 'unset');
													})
												})
											</script>
										</li>
										<li class="col-xs-1">
											<input class="equi_search_btn search_btn" type="submit" value="검색">
											<script>
											
												
													
												
											</script>
										</li>
									</ul>
								</div>
							</form>
					</div>
					
					
				
				</div><!-- array -->
				<div class="dim_search">
					<div class="loader" id="loader-1" style="display: block; position: absolute; left: 50%; z-index: 99; top: 50%;"></div>
				</div>
				<div id="board">
					<div class="test tg" style="height: 400px; width:100%;">
						<div style="height: 400px; width:100%;" id="amChart"></div>
					</div>
					<div class="test" style="width:100%; margin-top: 30px; visibility: hidden; height:0;">
						<div style="height: 300px; width:100%;" id="amChart2"></div>
					</div>
					<div>
				    	<button data-target="2" class="fhBtn" onclick="hideFade(this)">조도 그래프 보기</button>
				    </div>
				    <script>
					function hideFade(e) {
						console.log(e)
						var t = $(e).data('target');
						var d = $('#amChart'+t).parent().css('visibility');
						if(d == "hidden"){
							$(e).html('조도 그래프 감추기')
							$('#amChart'+t).parent().css('visibility', 'visible');
							$('#amChart'+t).parent().css('height', '300px');
						} else {
							$(e).html('조도 그래프 보기')
							$('#amChart'+t).parent().css('visibility', 'hidden');
							$('#amChart'+t).parent().css('height', '0');
						}
					}
					</script>
					<!-- datatable -->
					<table id="example" class="display" width="100%"></table>
					<script>
						
						
						$(document).ready(function() {
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

							
							var option = {
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
										filename: function() {
											var equi = '';
											$('#'+'equi'+' option').each(function(a,b) {
												if($('#'+'equi').val() == $(b).val()) {
													equi = $(b).text();
												}
											})

											var gu = '';
											$('#'+'gu'+' option').each(function(a,b) {
												if($('#'+'gu').val() == $(b).val()) {
													gu = $(b).text();
												}
											})

											return '수치/농도 현황 조회_'+getFormatDate(new Date())+'_'+gu+' ('+equi+')';
										},
										title: function() {
											var equi = '';
											$('#'+'equi'+' option').each(function(a,b) {
												if($('#'+'equi').val() == $(b).val()) {
													equi = $(b).text();
												}
											})

											var gu = '';
											$('#'+'gu'+' option').each(function(a,b) {
												if($('#'+'gu').val() == $(b).val()) {
													gu = $(b).text();
												}
											})

											return '수치/농도 현황 조회_'+getFormatDate(new Date())+'_'+gu+' ('+equi+')';
										},
										enabled: false,
										text: '데이터 EXPORT',
										className: 'exBtn'
									}
								],
								columns: [
									{data:"equiInfoKey", title:"기기번호"},
									{data:"tm8", title:"데이터시각"},
									{data:"pm10", title:"미세먼지<br>(㎍/㎥)"},
									{data:"pm25", title:"초미세먼지<br>(㎍/㎥)"},
									{data:"noise", title:"소음<br>(dB)"},
									{data:"temp", title:"온도<br>(℃)"},
									{data:"humi", title:"습도<br>(%)"},
									{data:"windDire", title:"풍향"},
									{data:"windSpeed", title:"풍속<br>(㎧)"},
									{data:"inteIllu", title:"조도<br>(lx)"},
									{data:"ultraRays", title:"자외선<br>(UVI)"},
									{data:"vibrX", title:"진동 -X축<br>(g)"},
									{data:"vibrY", title:"진동 -Y축<br>(g)"},
									{data:"vibrZ", title:"진동 -Z축<br>(g)"},
									{data:"effeTemp", title:"흑구<br>(℃)"},
									{data: "co", title: "일산화탄소<br>(ppm)"},
									{data: "no2", title: "이산화질소<br>(ppb)"},
									{data: "so2", title: "이산화황<br>(ppb)"},
									{data: "nh3", title: "암모니아<br>(ppb)"},
									{data: "h2s", title: "황화수소<br>(ppb)"},
									{data: "o3", title: "오존<br>(ppb)"},
									{data : "etc1", title: "기타1"},
									{data : "etc2", title: "기타2"},
									{data : "etc3", title: "기타3"}
								],
								columnDefs: [
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
										targets: [5, 14],
										render: function(data, type, row) {
											return (data/10 - 100).toFixed(1) <= -100 ? "-" : (data/10 - 100).toFixed(1);
										}
									},
									{
										targets: [7,8],
										render: function(data, type, row) {
											if($('#gu').val() != "25") {
												return "-"
											}
											return data;
										}
									},
									{
										targets: 10,
										render: function(data, type, row) {
											return data == null ? "-" : data.toFixed(1);
										}
									},
									{
										targets: '_all',
										render: function(data, type, row) {
											return data == null ? "-" : data;
										}
									}					
								]
							};
							var table = $('#example').DataTable(option);
							table.on( 'draw', function () {
								console.log('draw')
								var rows = table.data().length;
								table.button( 0 ).enable( rows > 0 );
							} );
							
						} );
					</script>
					<!-- datatable -->	

				</div><!-- board -->
			</div><!-- container -->

        </div><!-- sensor -->
        <div class="modal fade detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<div class="array row">
						<form>
							<div class="form-group col-xs-7">
								<ul class="row">
									<li class="col-xs-2 title">측정요소 및 날짜</li>
									<li class="col-xs-2">
										<select>
											<option value="pm10">미세먼지</option>
										</select>
									</li>
									<li class="col-xs-2">
										<select id="year">
											<option value="2019" selected>2019년</option>
										</select>
									</li>
									<li class="col-xs-2">
										<select id="month">
											<option value="7">07월</option>
										</select>
									</li>
									<li class="col-xs-2">
										<select id="day">
											<option>23월</option>
										</select>
									</li>
									<li class="col-xs-2">
										<input class="search_btn" type="submit" value="검색">
									</li>
								</ul>
							</div><!-- form-group -->
						</form>
					</div><!-- array -->
					
					<table class="info">
						<tr>
							<th>스테이션명</th>
							<td id="m_station"></td>
							<th>시리얼넘버</th>
							<td id="m_serial"></td>
							<th>등록일자</th>
							<td id="m_reg_date"></td>
						</tr>
					</table>
					<h5 class="tt">미세먼지 데이터 그래프</h5>
					<div class="graph">
						<!-- <canvas id="graph" ></canvas> -->
						<div id="amChart" style="height:400px;"></div>
					</div>
					<div class="down">
						<ul class="row">
							<li class="col-xs-6">
								<h5 id="m_date">2019년 7월 23일</h5>
							</li>
							<li class="col-xs-6 text-right">
								<input type="text" name="">&nbsp; 부터 &nbsp;
								<input type="text" name="">&nbsp; 까지 &nbsp;&nbsp;&nbsp;&nbsp;
								<a href="#">다운로드</a>
							</li>
						</ul>
					</div>
					<div id="board" class="detail-box">
						<table class="list-detail">
							<tr>
								<th>데이터시각</th>
								<th>미세먼지<br/>(㎍/㎥)</th>
								<th>초미세먼지<br/>(㎍/㎥)</th>
								<th>소음<br/>(dB)</th>
								<th>온도<br/>(℃)</th>
								<th>습도<br/>(%)</th>
								<th>풍향<br/></th>
								<th>풍속<br/>(㎧)</th>
								<th>조도<br/>(lx)</th>
								<th>자외선<br/>(UVI)</th>
								<th>진동<br/>-X축(g)</th>
								<th>진동<br/>-Y축(g)</th>
								<th>진동<br/>-Z축(g)</th>
							</tr>
							
						</table>
					</div>
				</div><!-- modal-body -->
			</div><!-- modal-content -->
		</div>
	</div>

	<script>
		function uploadFile() {
			var form = $('#upload')[0];
			var formData = new FormData(form);
			formData.append("filename", $('input[name=filename]')[0].files[0]);

			$.ajax({
				url: '/api/admin/excelTest',
				type: 'POST',
				processData: false,
				contentType: false,
				data: formData,
				success: function(r) {
					if(r) {
						alertify.alert('성공', '기기 추가가 성공적으로 되었습니다.')
					} else {
						alertify.alert('에러', '기기추가 실패. 엑셀파일을 확인해주세요.')
					}
				} 
			})
		}
	</script>
    <script src="/share/js/sensor/index.js"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>