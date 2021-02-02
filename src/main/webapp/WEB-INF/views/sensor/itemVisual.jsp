<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<jsp:include page="../common/charts.jsp"></jsp:include>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>

    <script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
	<script src="/share/js/sensor/itemVisual.js"></script>
<style>
.datepicker {
	width: 220px;
}
#to, #from {
	height: 30px;
}
</style>

<div id="sensor" class="body_wrap">

			<div class="container">

				<div class="sub_title">
					<h1 class="main_co">수치/농도 지역별 평균 조회</h1>
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
				<div id="chartdiv" style="width: 100%; height: 400px"></div>
				<div style="height: 300px; width:100%;" id="amChart"></div>
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
				
			</div><!-- container -->

		</div><!-- sensor -->

<jsp:include page="../common/footer.jsp"></jsp:include>