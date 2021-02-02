<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<link href="../../share/css/visitor.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="//map.seoul.go.kr/smgis/apps/mapsvr.do?cmd=gisMapCss">
<script type="text/javascript" src="//map.seoul.go.kr/smgis/apps/mapsvr.do?cmd=gisMapJs&key=602b16c4fd474adf90d815a063051fc3"></script>
<script src='../../share/js/map/api.js'></script>
<link href="../../share/css/sensor.css" rel="stylesheet" />
<style>
.leaflet-marker-icon {
	width: 36px !important;
}
.leaflet-popup-content-wrapper {
	background: none;
	box-shadow: none;
}
</style>
<script src="/share/js/sensor/index.js"></script>
<script src="/share/js/sensor/map.js"></script>
<script type="text/javascript">
	
	var	map = null;
	var miniMap = null;
	var markerInfo = [];
	
	var mapInit = function(){
		map = L.map('map', {
			continuousWorld: true
			,worldCopyJump: false
			,zoomControl: true
			,zoomAnimation: true
			,markerZoomAnimation: true
			,fadeAnimation : true
			,inertia : false
			,closePopupOnClick : false
			,attributionControl : true
		});
		
		map.setView([37.5302862, 126.9854131], 6);  //지도 좌표 이동
		
		BaseMapChange(map, L.Dawul.BASEMAP_GEN);  // 일반지도
		
		// 스케일바
		var scaleBar = new L.Control.Scale({position:'bottomright'});
		map.addControl(scaleBar);
		
		return map;
	};
	var moveMap = function(map,t,a,b) {
		markerInfo[t-1].openPopup()
		
		map.setView([a,b], 10);
	}

	$(document).ready(function() {
		var map = mapInit();
		$.ajax({
			url: '/api/statistic/getSensData',
			type: 'GET',
			dataType: 'json',
			success: function(r) {
				console.log(r.data)
				var count = 1;
				var text = 
					'<tr>'+
					'    <th>기기번호</th>'+
					'    <th>날짜</th>'+
					'    <th>체류인원</th>'+
					'</tr>'
				;
				$.each(r.data, function(a,b) {
					var year = b.vistorTm10.substring(0,4);
					var month = b.vistorTm10.substring(4,6);
					var day = b.vistorTm10.substring(6,8);
					var hour = b.vistorTm10.substring(8.10);
					var dateText = year+"년 "+month+"월 "+day+"일 "+hour.substring(0,2)+"시 "+hour.substring(2,4)+"분";
					var content = '<div class="info" style="top: -127px; left: -173px;">'+
	                '	<div class="close" onclick="map.closePopup();"><i class="xi-close"></i></div>'+
	                '	<h3>'+b.equiInfoKeyHan+'('+b.equiInfoKey+')</h3>'+
	                '<table class="list">'+
	                '    <tr>'+
	                '        <th>기준시간</th>'+
	                '        <th>위도</th>'+
	                '        <th>경도</th>'+
	                '        <th>체류인원</th>'+
	                '    </tr>'+
	                '    <tr>'+
	                '        <td>'+dateText+'</td>'+
	                '        <td>'+b.gpsAbb+'</td>'+
	                '        <td>'+b.gpsLat+'</td>'+
	                '        <td>'+b.vistorCnt+'명</td>'+
	                '    </tr>'+
	                '</table>'+
	                '</div>';
					var icon = "";
	                icon="visitor.png"
	                
	                markerInfo.push(setPoint(map, "a"+i, b.gpsAbb, b.gpsLat, content, icon))
					  if(count <= 10) {
						  var cnt = b.vistorCnt;
							text += 
								'<tr>'+
								'    <td><span style="cursor: pointer;" onclick="moveMap(map, '+count+','+b.gpsAbb+', '+b.gpsLat+')">'+b.equiInfoKeyHan+'<span></td>'+
								'    <td>'+dateText+'</td>'+
								'    <td>'+b.vistorCnt+'명</td>'+
								'</tr>'
							
						}
						if(r.data.length < 5 && count == r.data.length) {
							$('.list1').html(text)
						}
						if(count == 5) {
							$('.list1').html(text);
							text = 
								'<tr>'+
								'    <th>기기번호</th>'+
								'    <th>날짜</th>'+
								'    <th>체류인원</th>'+
								'</tr>'
							;
						}
						if(count == 10) {
							$('.list2').html(text);
							text = 
								'<tr>'+
								'    <th>기기번호</th>'+
								'    <th>날짜</th>'+
								'    <th>체류인원</th>'+
								'</tr>'
							;
						}
					count++;
				})
			}
		})
		

	});

</script>
<div id="sensor" class="body_wrap">

			<div class="container">

				<div class="sub_title">
					<h1 class="main_co">실시간 체류 인원 조회</h1>
				</div><!-- sub_title -->

				<div class="map_wrap" style="height:400px;">
					<div id="map" class="map" style="min-height:400px;" >
					</div><!-- map -->
				</div><!-- map_wrap -->

				<div id="board" class="pb_b5">
					<h5 class="pb_t2 pb_b2">지점별 Top 10</h5>
					<ul class="row">
						<li class="col-xs-6">
							<table class="list list1">
								
							</table>
						</li>
						<li class="col-xs-6">
							<table class="list list2">
								
							</table>
						</li>
					</ul>

				</div><!-- board -->
			</div><!-- container -->

		</div><!-- sensor -->
<jsp:include page="../common/footer.jsp"></jsp:include>