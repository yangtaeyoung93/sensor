<%@page import="com.seoulsi.dto.MemberDto"%>
<%@page import="java.util.Optional"%>
<%@page import="com.seoulsi.util.AES256Util"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<%-- <jsp:include page="../common/header_resource.jsp"></jsp:include> --%>
<link rel="stylesheet" type="text/css" href="//map.seoul.go.kr/smgis/apps/mapsvr.do?cmd=gisMapCss">
<script type="text/javascript" src="//map.seoul.go.kr/smgis/apps/mapsvr.do?cmd=gisMapJs&key=602b16c4fd474adf90d815a063051fc3"></script>
<script src='../../share/js/map/api.js'></script>
<link href="../../share/css/sensor.css" rel="stylesheet" />
<link href="../../share/css/page/sensor/S102.css" rel="stylesheet" />

<script src="/share/js/sensor/index.js"></script>
<script src="/share/js/sensor/map.js"></script>
<script src="/share/js/popup.js"></script>
<!-- <script src="/share/js/page/sensor/S102.js"></script> -->
<%
	String userName = (String)request.getAttribute("userName"); 
	Boolean popup = (Boolean)request.getAttribute("900");
	pageContext.setAttribute("popup", popup);
%>
<div id="sensor" style="height: calc(100vh - 185px)">
	<div class="loader" id="loader-1" style="z-index:99; position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%);"></div>
	<div class="map_wrap">
<!-- 			센서 현황/초미세먼지/미세먼지 -->
				<div class="map-control">
					<div class="btn-group">
						<a class="leaflet-bar" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">구별 데이터 <span class="caret"></span></a>
						<ul class="dropdown-menu">
						    <li data-tp="all"><a>전체</a></li>
						  <c:forEach items="${gu}" var="gu">
						  	<li data-tp="${gu.guTp}"><a >${gu.gu}</a></li>
						  </c:forEach>
						</ul>
					</div>
					<div class="btn-group">
						<a class="leaflet-bar" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">년도 선택 <span class="caret"></span></a>
						<ul class="dropdown-menu year">
						    <li data-tp="all"><a>전체</a></li>
						    <li data-tp="19"><a>2019년</a></li>
						    <li data-tp="20"><a>2020년</a></li>
						    <li data-tp="21"><a>2021년</a></li>
						</ul>
					</div>
					<a class="leaflet-bar" id="sensorStatus">센서 현황</a>
					<a class="leaflet-bar" id="pm25Status">초미세먼지</a>
					<a class="leaflet-bar" id="pm10Status">미세먼지</a>
				</div>
				<div id="top">
					<div class="marker-count leaflet-bar">총 <span></span>대</div>
					<div id = "receive_count" class="leaflet-bar">수신 <span></span>대</div>
					<div id = "unreceive_count" class="leaflet-bar">미수신 <span></span>대</div>
				</div>
				
				<div class="notice">
				  <p>이 자료는 미세먼지 간이측정기(2등급)을 사용하여 측정된 자료입니다.&nbsp;&nbsp;<a>상세내용 확인</a></p>
				</div>
				<div class="notice-box">
				  <p>* 대기환경보전법 제3조에 따른 측정망을 통해 측정된 대기오염도를 나타내는 것 아닙니다.</p>
				  <p>** 간이측정기(2등급) 권장 사용처: <br>
				  - 1등급에 비해 신뢰도는 낮지만, 초미세먼지(PM-2.5) 농도의 상대적인 농도차이를 구분할 수 있는 수준의 측정장비<br>
				  - 지역 내 대형 공장 등 배출원의 주변 영향 인지, 미세먼지 지도제작 등 미세먼지 농도의 단계적 확인을 위한 용도
				  
				  
				  </p>
				  
				</div>
				<div class="pm-divide pm25Table">
				  <table>
				    <thead>
				      <tr>
				        <th id="good" data-toggle="modal" data-target=".goodList">좋음</th>
				        <th id="normal" data-toggle="modal" data-target=".normalList">보통</th>
				        <th id="bad" data-toggle="modal" data-target=".badList">나쁨</th>
				        <th id="crit" data-toggle="modal" data-target=".critList">매우나쁨</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td>0~15</td>
				        <td>16~35</td>
				        <td>36~75</td>
				        <td>76~</td>
				      </tr>
				    </tbody>
				  </table>
				</div>
				<div class="pm-divide pm10Table">
				  <table>
				    <thead>
				      <tr>
				        <th id="good" data-toggle="modal" data-target=".goodList">좋음</th>
				        <th id="normal" data-toggle="modal" data-target=".normalList">보통</th>
				        <th id="bad" data-toggle="modal" data-target=".badList">나쁨</th>
				        <th id="crit" data-toggle="modal" data-target=".critList">매우나쁨</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td>0~30</td>
				        <td>31~80</td>
				        <td>81~150</td>
				        <td>151~</td>
				      </tr>
				    </tbody>
				  </table>
				  
				</div>
				<div id="map" class="map">
				</div><!-- map -->

		

				<div class="state" style="display: none;">
					<div class="board">
						<form>
							<div class="form-group">
								<ul>
									<li class="col-xs-2 title pd_0">측정소 종합현황</li>
									<li class="col-xs-1 title">정렬</li>
									<li class="col-xs-3">
										<select>
											<option>등급</option>
										</select>
									</li>
									<li class="col-xs-1 title pd_0">측정요소</li>
									<li class="col-xs-3">
										<select>
											<option>미세먼지</option>
										</select>
									</li>
									<li class="col-xs-2 pd_0">
										<input class="search_btn" type="submit" value="검색">
									</li>
								</ul>
							</div>
						</form>

						<table class="list">
							<tr>
								<th>설치 측정소</th>
								<th>수신 측정소</th>
								<th>미수신 측정소</th>
							</tr>
							<tr>
								<td id="numInfo01"></td>
								<td id="numInfo02"></td>
								<td id="numInfo03"></td>
							</tr>
						</table>
					</div>
				</div><!-- state -->
				
				<div class="note" style="display:none;">
					<ul class="row">
						<li class="col-xs-2"><a class="on" href="#">미세먼지</a></li>
						<li class="col-xs-2"><a href="#">초미세먼지</a></li>
						<li class="col-xs-2"><a href="#">소음</a></li>
						<li class="col-xs-2"><a href="#">온도</a></li>
						<li class="col-xs-2"><a href="#">습도</a></li>
						<li class="col-xs-2"><a href="#">풍향/풍속</a></li>
						<li class="col-xs-2"><a href="#">조도</a></li>
						<li class="col-xs-2"><a href="#">자외선</a></li>
						<li class="col-xs-2"><a href="#">진동-X축</a></li>
						<li class="col-xs-2"><a href="#">진동-Y축</a></li>
						<li class="col-xs-2"><a href="#">진동-Z축</a></li>
					</ul>
					<h5>등급별 측정소 분포</h5>
					<div class="graph">
						<table id="gradeInfo">
							<tr>
								
							</tr>
							<tr>
								<th class="co_step00">미수신</th>
								<th class="co_step01">매우나쁨<br/>0~19</th>
								<th class="co_step02">나쁨<br/>20~39</th>
								<th class="co_step03">약간나쁨<br/>40~59</th>
								<th class="co_step04">보통<br/>60~79</th>
								<th class="co_step05">좋음<br/>80~100</th>
							</tr>
						</table>
					</div><!-- graph -->
					<h5>공기질별 측정소 Top 10
						<div>
							<a href="#">best</a>
							<a class="on" href="#">worst</a>
						</div>
					</h5>
					<div class="board">
						<table class="list top10">
							<colgroup>
								<col style="width: 20%" />
								<col style="width: 40%" />
								<col style="width: 20%" />
								<col style="width: 20%" />
							</colgroup>
							
						</table>
					</div>
				</div>
				<!-- note -->
			<!-- BEGIN :: goodList Modal -->
					<div class="modal fade goodList" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg"
							style="transform: translateY(-50%); top: 50%; padding: 20px; width: 600px;">
							<div class="modal-content" style="padding: 16px;">
								<div class="modal-body">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h3><strong id="goodListMsg">기기 리스트</strong></h3>
									<hr/>
									<div id="goodListmodalFormDiv" class="info-wrap">
										<table id="goodListTable" class="modalTable">
										</table>
										<div id="goodListDiv" class="msgDiv"></div>
									</div>
									<hr/>
								</div>
								<!-- modal-body -->
							</div>
							<!-- modal-content -->
						</div>
					</div>
					<!-- END :: goodList Modal -->
					<!-- BEGIN :: normalList Modal -->
					<div class="modal fade normalList" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg"
							style="transform: translateY(-50%); top: 50%; padding: 20px; width: 600px;">
							<div class="modal-content" style="padding: 16px;">
								<div class="modal-body">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h3><strong id="normalListMsg">기기 리스트</strong></h3>
									<hr/>
									<div id="normalListmodalFormDiv" class="info-wrap">
										<table id="normalListTable" class="modalTable">
										</table>
										<div id="normalListDiv" class="msgDiv"></div>
									</div>
									<hr/>
								</div>
								<!-- modal-body -->
							</div>
							<!-- modal-content -->
						</div>
					</div>
					<!-- END :: normalList Modal -->
					<!-- BEGIN :: badList Modal -->
					<div class="modal fade badList" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg"
							style="transform: translateY(-50%); top: 50%; padding: 20px; width: 600px;">
							<div class="modal-content" style="padding: 16px;">
								<div class="modal-body">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h3><strong id="badListMsg">기기 리스트</strong></h3>
									<hr/>
									<div id="badListmodalFormDiv" class="info-wrap">
										<table id="badListTable" class="modalTable">
										</table>
										<div id="badListMsgDiv" class="msgDiv"></div>
									</div>
									<hr/>
								</div>
								<!-- modal-body -->
							</div>
							<!-- modal-content -->
						</div>
					</div>
					<!-- END :: badList Modal -->
					<!-- BEGIN :: critList Modal -->
					<div class="modal fade critList" tabindex="-1" role="dialog"
						aria-labelledby="myLargeModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg"
							style="transform: translateY(-50%); top: 50%; padding: 20px; width: 600px;">
							<div class="modal-content" style="padding: 16px;">
								<div class="modal-body">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h3><strong id="critListMsg">기기 리스트</strong></h3>
									<hr/>
									<div id="critListmodalFormDiv" class="info-wrap">
										<table id="critListTable" class="modalTable">
										</table>
										<div id="critListDiv" class="msgDiv"></div>
									</div>
									<hr/>
								</div>
								<!-- modal-body -->
							</div>
							<!-- modal-content -->
						</div>
					</div>
					<!-- END :: Receive Ware List Modal -->
			</div><!-- map -->
		</div><!-- sensor -->
		<script>

		var	map = null;
		var miniMap = null;

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

		$(document).ready(function() {

			function popupCreate() {
				var popupWidth = 780;
				var popupHeight = 1000;

				var popupX = (window.screen.width / 2) - (popupWidth / 2);
				// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

				var popupY= (window.screen.height / 2) - (popupHeight / 2);
				// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음

				window.open('/popup01', '', 'scrollbars=yes,status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
			}
			<c:if test="${popup}">
				if(getCookie('popup') != 'false') {
					popupCreate();
				}
			</c:if>
			
				
			function receivedCount(totalData) {
				var timeDiff;
				var receiveNum = 0;
				var unreceiveNum = 0;
				var recentDate = new Date();

				for (var i in totalData) {
					// timeDiff = recentDate.getTime() - new Date(totalData[i].regDate);

					// if ((timeDiff/1000/60) >= 10) {
					// 	unreceiveNum++;
					// }
					if(totalData[i].timeCheck == 0){
						unreceiveNum++;
					}
				}

				receiveNum = totalData.length - unreceiveNum;

				return [receiveNum, unreceiveNum];
			}
			function loader(flag) {
				if (flag) {
				$(".loader").show();
				$(".dim").show();
				} else {
				$(".loader").hide();
				$(".dim").hide();
				}
			}
			var map = mapInit();
		    var parseData = [];
		    var recCount = [];
				$.ajax({
					url:'/api/equiGps',
					type: 'GET',
					dataType: 'json',
					beforeSend: function(){
						loader(true);
					},
					success: function(r) {
						console.log(r.data);
						mapjs.data.data = r.data;
						
						<c:choose>
							<c:when test="${id eq rid}">
								mapjs.marker(r.data, "sensor");
							</c:when>
						</c:choose>
						parseData = r.data;

						recCount = receivedCount(parseData);

						// count 표출 부분
						$('#receive_count span').html(recCount[0]);
						$('#unreceive_count span').html(recCount[1]);

						$('.marker-count span').html(parseData.length)
						map.setView([37.5302862, 126.9854131], 6);
						mapjs.marker(parseData, "sensor");
					},
					complete: function() {
						loader(false);
					}
				})
				$('.notice a').click(function() {
				  $('.notice-box').toggle();
				})
				$('#sensorStatus').click(function() {
					loader(true);
					map.setView([37.5302862, 126.9854131], 6);
					map.closePopup()
					$('.pm25Table').hide();
					$('.pm10Table').hide();
					$('.notice').hide();
					$('.notice-box').hide();
					$('.leaflet-marker-icon').remove()

					recCount = receivedCount(parseData);
					$('#receive_count span').html(recCount[0]);
					$('#unreceive_count span').html(recCount[1]);

					$('.marker-count span').html(parseData.length)
					mapjs.marker(parseData, "sensor");
					loader(false);
				})
				$('#pm10Status').click(function() {
				  $('.notice').show();
				  $('.notice-box').hide();
				  $('.pm25Table').hide();
					$('.pm10Table').show();
					map.setView([37.5302862, 126.9854131], 6);
					map.closePopup()

					recCount = receivedCount(parseData);
					$('#receive_count span').html(recCount[0]);
					$('#unreceive_count span').html(recCount[1]);
					console.log(parseData)
					$('.marker-count span').html(parseData.length)
					$('.leaflet-marker-icon').remove()
					var parseNum = mapjs.marker(parseData, "pm10");
					console.log(parseNum)
					<c:choose>
						<c:when test="${id eq rid}">
								setTimeout(function() {
									listSet('good', parseNum)
									listSet('normal', parseNum)
									listSet('bad', parseNum)
									listSet('crit', parseNum)
								}, 3000);
								$('.pm10Table thead th:nth-child(1)').text('좋음 ('+parseNum.good.num+')')
								$('.pm10Table thead th:nth-child(2)').text('보통 ('+parseNum.normal.num+')')
								$('.pm10Table thead th:nth-child(3)').text('나쁨 ('+parseNum.bad.num+')')
								$('.pm10Table thead th:nth-child(4)').text('매우나쁨 ('+parseNum.crit.num+')')
							</c:when>
					</c:choose>
				})
				
				function listSet(target, data) {
						$('#'+target+'ListTable').html('');
						var tableNo = 0;
						text = "<tr><th style='width: 60px;'><h5><strong>NO</strong></h5></th>" +
						"<th><h5><strong>기기 코드</strong></h5></th>" + 
						"<th><h5><strong>기기 명</strong></h5></th>";
						$.each(data[target].data, function(a,b) {
							tableNo++;
							text += "<tr><td><strong>" + tableNo + 
								"</strong></td><td><strong>" + b.equiInfoKey +
								"</strong></td><td><strong>" + b.equiInfoKeyHan + 
								"</strong></td></tr>";
							$('#'+target+'ListTable').html(text);
						})
						
				}
				
				$('#pm25Status').click(function() {
				  $('.notice').show();
				  $('.notice-box').hide();
				  $('.pm25Table').show();
					$('.pm10Table').hide();
					map.setView([37.5302862, 126.9854131], 6);
					map.closePopup()

					recCount = receivedCount(parseData);
					$('#receive_count span').html(recCount[0]);
					$('#unreceive_count span').html(recCount[1]);

					$('.marker-count span').html(parseData.length)
					$('.leaflet-marker-icon').remove()
					var parseNum =  mapjs.marker(parseData, "pm25");
					console.log(parseNum)
					<c:choose>
						<c:when test="${id eq rid}">
								setTimeout(function() {
									listSet('good', parseNum)
									listSet('normal', parseNum)
									listSet('bad', parseNum)
									listSet('crit', parseNum)
								}, 3000);
								$('.pm25Table thead th:nth-child(1)').text('좋음 ('+parseNum.good.num+')')
								$('.pm25Table thead th:nth-child(2)').text('보통 ('+parseNum.normal.num+')')
								$('.pm25Table thead th:nth-child(3)').text('나쁨 ('+parseNum.bad.num+')')
								$('.pm25Table thead th:nth-child(4)').text('매우나쁨 ('+parseNum.crit.num+')')
						</c:when>
					</c:choose>
				})
				$('.dropdown-menu.year li').click(function() {
					map.setView([37.5302862, 126.9854131], 6);
					$('.notice').hide();
					$('.notice-box').hide();
					$('.pm25Table').hide();
					$('.pm10Table').hide();
					map.closePopup()
					$('.leaflet-marker-icon').remove()
					console.log($(this).data('tp'))
					var tp = $(this).data('tp')
					if(tp == "all"){
					  	parseData = mapjs.data.data;
						recCount = receivedCount(parseData);
						$('#receive_count span').html(recCount[0]);
						$('#unreceive_count span').html(recCount[1]);

						$('.marker-count span').html(parseData.length)
					  	mapjs.marker(mapjs.data.data, "sensor");
					} else {
						parseData = mapjs.data.data;
						parseData = parseData.filter(function(list) {
							return list.toDate == tp;
						});
						recCount = receivedCount(parseData);
						$('#receive_count span').html(recCount[0]);
						$('#unreceive_count span').html(recCount[1]);

						$('.marker-count span').html(parseData.length)
					  	mapjs.marker(parseData, "sensor");
					}
				})
				$('.dropdown-menu:not(.year) li').click(function() {
					map.setView([37.5302862, 126.9854131], 6);
					$('.notice').hide();
					$('.notice-box').hide();
					$('.pm25Table').hide();
					$('.pm10Table').hide();
					map.closePopup()
					$('.leaflet-marker-icon').remove()
					console.log($(this).data('tp'))
					var tp = $(this).data('tp')
					if(tp == "all"){
					  	parseData = mapjs.data.data;
						recCount = receivedCount(parseData);
						$('#receive_count span').html(recCount[0]);
						$('#unreceive_count span').html(recCount[1]);

						$('.marker-count span').html(parseData.length)
					  	mapjs.marker(mapjs.data.data, "sensor");
					} else {
					  parseData = [];
					  console.log(parseData);
		  			$.each(mapjs.data.data, function(a,b) {
		  				if(tp == "baramYn=Y") {
		  					if(b.baramYn=="Y") {
			  					parseData.push(mapjs.data.data[a]);	
		  					}
		  				}
		  				if(tp == "airYn=Y") {
		  					if(b.airYn=="Y") {
			  					parseData.push(mapjs.data.data[a]);	
		  					}
		  				}
		  				if(b.guTp == tp) {
		  					if(b.baramYn != "Y" && b.airYn != "Y"){
			  					parseData.push(mapjs.data.data[a]);
		  					}
		  					if(b.airYn == "Y") {
			  					parseData.push(mapjs.data.data[a]);
		  					}
		  				}
		  			})

		  			recCount = receivedCount(parseData);
					$('#receive_count span').html(recCount[0]);
					$('#unreceive_count span').html(recCount[1]);

		  			$('.marker-count span').html(parseData.length)
		  			mapjs.marker(parseData, "sensor");
					}
					
					
				})

			});

			
		</script>
<jsp:include page="../common/footer.jsp"></jsp:include>