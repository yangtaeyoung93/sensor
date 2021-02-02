<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

    <script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
	<script src="/share/js/sensor/item.js"></script>
	<script src="/share/js/page/sensor/S103.js"></script>
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
.datepicker {
	width: 220px;
}
#to, #from {
	height: 30px;
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
					<h1 class="main_co">항목별 측정자료 조회</h1>
				</div><!-- sub_title -->

				<div class="row array">
					
					<div class="col-xs-8">
						<form>
							<div class="form-group">
								<dl>
									<dt class="title">측정요소</dt>
									<dd>
										<select id="sel-1">
											<option>측정요소 선택</option>
										</select>
									</dd>
									<dt class="title">날짜</dt>
									<dd>
										<input type="text" id="to" autocomplete=off placeholder="날짜선택" value="" class="form-control"><span style="display: none;" class="input-group-addon"></span>
									</dd>
									<dt class="title">부터</dt>
									<dd>
										<input type="text" id="from" autocomplete=off placeholder="날짜선택" value="" class="form-control"><span style="display: none;" class="input-group-addon"></span>
									</dd>
									<dt class="title">까지</dt>
									<dt>
										<input class="search_btn" type="submit" value="검색">
										<script>
												
													
											</script>
									</dt>
									<dt class="title" style="color:red;">(※ 평균값입니다.)</dt>
								</dl>
							</div>
						</form>
					</div>				
				</div><!-- array -->

				<div class="dim_search">
					<div class="loader" id="loader-1" style="display: none; position: absolute; left: 50%; z-index: 99; top: 50%;"></div>
				</div>
				<!-- <div id="board" class="pb_b5" style="overflow: auto; height: 500px;">
					<table class="list" style="margin-bottom: 60px;">
						<tr style="position: sticky; top:0; left:0; z-index: 9;">
							<th>데이터시각</th>
							<th>강남구</th>
							<th>강동구</th>
							<th>강북구</th>
							<th>강서구</th>
							<th>관악구</th>
							<th>광진구</th>
							<th>구로구</th>
							<th>금천구</th>
							<th>노원구</th>
							<th>도봉구</th>
							<th>동대문구</th>
							<th>동작구</th>
							<th>마포구</th>
							<th>서대문구</th>
							<th>서초구</th>
							<th>성동구</th>
							<th>성북구</th>
							<th>송파구</th>
							<th>양천구</th>
							<th>영등포구</th>
							<th>용산구</th>
							<th>은평구</th>
							<th>중랑구</th>
							<th>중구</th>
							<th>종로구</th>
						</tr>
					</table>
					
				</div>board -->
				<div id="board"></div>
				<table id="example" class="display" width="100%"></table>
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

						function getTitle() {
							$('#sel-1 option').each(function() {
								if($('#sel-1').val() == $(this).val()) {
									return $(this).text() + "_";
								}
							})
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
							title: "항목별 측정자료 조회_" + getTitle() + getFormatDate(new Date()),
							text: "데이터 EXPORT",
							className: "exBtn",
							enabled: false
							},
						],
						columns: [
							{ data: "tm8", title: "데이터시각" },
							{ data: "gn", title: "강남구" },
							{ data: "gd", title: "강동구" },
							{ data: "gb", title: "강북구" },
							{ data: "gs", title: "강서구" },
							{ data: "ga", title: "관악구" },
							{ data: "gi", title: "광진구" },
							{ data: "gr", title: "구로구" },
							{ data: "gc", title: "금천구" },
							{ data: "no", title: "노원구" },
							{ data: "db", title: "도봉구" },
							{ data: "ddm", title: "동대문구" },
							{ data: "dj", title: "동작구" },
							{ data: "mp", title: "마포구" },
							{ data: "sdm", title: "서대문구" },
							{ data: "sc", title: "서초구" },
							{ data: "sd", title: "성동구" },
							{ data: "sb", title: "성북구" },
							{ data: "sp", title: "송파구" },
							{ data: "yc", title: "양천구" },
							{ data: "ydp", title: "영등포구" },
							{ data: "ys", title: "용산구" },
							{ data: "ep", title: "은평구" },
							{ data: "jr", title: "중랑구" },
							{ data: "jg", title: "중구" },
							{ data: "jn", title: "종로구" },
						],
						});

						
						// table.on( 'draw', function () {
						// 	console.log('draw')
						// 	var rows = table.data().length;
						// 	table.button( 0 ).enable( rows > 0 );
						// } );
					})
				</script>
			</div><!-- container -->

		</div><!-- sensor -->

<jsp:include page="../common/footer.jsp"></jsp:include>