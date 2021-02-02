<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<%-- <jsp:include page="../common/header_resource.jsp"></jsp:include> --%>
<script src="/share/js/amchart4/core.js"></script>
<script src="/share/js/amchart4/charts.js"></script>
<script src="/share/js/amchart4/animated.js"></script>
<script src="/share/js/amchart4/ko_KR.js"></script>
<script src="/share/js/page.js"></script>
<link rel="stylesheet" type="text/css" href="//map.seoul.go.kr/smgis/apps/mapsvr.do?cmd=gisMapCss">
<script type="text/javascript" src="//map.seoul.go.kr/smgis/apps/mapsvr.do?cmd=gisMapJs&key=602b16c4fd474adf90d815a063051fc3"></script>
<script src='../../share/js/map/api.js'></script>
<script src="/share/js/sensor/map.js"></script>

<script src="/share/js/sensor/total.js"></script>
<style>
.info-wrap {
	border: 1px solid #c9c9c9;
	padding: 15px;
	background: white;
	margin-left: 30px;
	height: 690px;
}
 
.tree2 {
	height: 690px;
	overflow-y: auto;
	background: white;
	border: 1px solid #c9c9c9;
	padding: 15px;
}

.tree_s {
	background: #0c82e9 !important;
	color: white;
}

.sub_title+.row {
	margin-bottom: 60px;
}

.row .title {
	text-align: center;
}

#totalCount {
	width: 100%;
	height: 40%;
	text-align: center;
	font-size: xx-large;
	padding: 4px;
	color: black !important;
}

#receiveCount {
	color: #69A2ED !important;
}

#unreceiveCount {
	color: #FA8072 !important;
}

.countBox {
	display: inline-block;
	width: 48%;
	height: 100%;
	border-radius: 20%;
	background: #E1F8E1;
	padding: 4px;
}

#wareDataArea {
	font-size: xx-large;
	color: black !important;
}

#wareDataTb td, th {
	padding-bottom: 7px;
}

/* .countBox:hover {
	box-shadow: 200px 0 0 0 rgba(0, 0, 0, 0.25) inset, -200px 0 0 0
		rgba(0, 0, 0, 0.25) inset;
} */

#modalFormDiv {
	border: none;
	margin-left: 0;
	padding-left:40px;
	padding-right:40px;
	height: 500px;
	overflow-y: auto;
	background: #f7f8fa;
}

.modalTable td, th {
	padding-bottom: 6px;
}

.msgDiv {
	text-align: center;
	color: red;
}
</style>
<div id="sensor" class="body_wrap">
	<div class="container">
		<div class="sub_title">
			<h1 class="main_co">통합 상태 정보 조회</h1>
		</div>
		<div class="row">
			<div class="col-xs-14"">
				<div style="width: 99%; height: 260px; display: inline-block; margin-bottom: 70px;">
					<hr/>
					<!-- 영역 1. BEGGIN -->
					<div id="areaOne" style="width: 25%; height: 100%; display: inline-block; border: 1px solid #ebedf2; background: #f7f8fa; border-radius: 1.25rem; padding: 20px;">
						<div id = "totalCount">
							<strong style="line-height: 80px;">총 기기 <span></span>대</strong>
						</div>
						<div style=" font-size: x-large; text-align: center; height: 40%;">
							<hr/>
							<div id = "receiveCount" class="countBox">
								<strong style="line-height: 80px;">수신 <span></span>대</strong>
							</div>
							<div id = "unreceiveCount" class="countBox">
								<strong style="line-height: 80px;">미수신 <span></span>대</strong>
							</div>
						</div>
					</div>
					<!-- 영역 1. END -->

					<!-- 영역 2. BEGGIN -->
					<div id="areaWareChartBar" style="width: 73%; height: 100%; display: inline-block; border: 1px solid #ebedf2; background: #f7f8fa; border-radius: 1.25rem; float: right;"></div>
					<!-- 영역 2. END -->
				</div>
				<div style="width: 99%; height: 360px;">
					<!-- 영역 3. BEGGIN -->
					<div id="areaThree" style="width: 25%; height: 100%; display: inline-block; border: 1px solid #ebedf2; background: #f7f8fa; border-radius: 1.25rem; padding: 20px; padding-left: 50px;">
						<h4 id="wareDataMsg"><strong>측정 데이터 상태</strong></h4>
						<hr/>
						<div id="wareDataDiv" style="width: 100%; height: 80%; overflow-y: auto; padding-bottom: 3px;">
							<table id="wareDataTb">
							</table>
						</div>
					</div>
					<!-- 영역 3. END -->

					<!-- 영역 4. BEGGIN -->
					<div id="statusWareChartBar" style="width: 73%; height: 100%; display: inline-block; border: 1px solid #ebedf2; background: #f7f8fa; border-radius: 1.25rem; padding: 20px; float: right;"></div>
					<!-- 영역 4. END -->
				</div>
			</div>
		</div>
	</div>
	<!-- container -->
</div>
<jsp:include page="./totalModal.jsp"></jsp:include>

<script src="/share/js/sensor/index.js"></script>
<jsp:include page="../common/footer.jsp"></jsp:include>