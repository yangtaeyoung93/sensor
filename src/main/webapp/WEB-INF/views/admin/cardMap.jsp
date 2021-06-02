<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>

<link rel="stylesheet" 	href="../../share/treeview/css/jquery.treeview.css" />
<link rel="stylesheet" href="../../share/treeview/css/screen.css" />
<script src="../../share/treeview/lib/jquery.cookie.js" 	type="text/javascript"></script>
<script src="../../share/treeview/lib/jquery.treeview.js" 	type="text/javascript"></script>

<script type="text/javascript">
        $(function() {
            $("#tree").treeview({
                collapsed: true,
                animated: "medium",
                control:"#sidetreecontrol",
                persist: "location"
            });
        })
	</script>
	
	
<style>
.datepicker {
	width: 220px;
}
.info-wrap {
	border: 1px solid #c9c9c9;
	padding: 15px;
	background: white;
	margin-left: 30px;
/* 	height: 800px; */
	overflow:auto;
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
.form-group .row {
    margin-bottom: 30px;
}
.user-table {
	border-collapse: collapse;
}
.table-row {
	display: none;
	max-height: 207px;
	overflow-y: auto;
	padding-bottom: 6px;
	border-bottom: 1px solid #c9c9c9;
}
.user-table tr, .user-table td, .user-table th {
	border: 1px solid #d9d9d9;
	text-align: center;
}
.user-table th {
	width:33%;
	background: #f3f9fe;
	background-clip: padding-box;
}
.user-table tbody tr {
	cursor: pointer;
}

.list-inline{
	padding:0;
	margin:0;
	list-style:none;
}
.list-inline li{
	display:inline-block;
	padding: 0px 10px;
	float: left;
}
.mt10{
	margin-top : 10px !important;
}
.alCneter{
	text-align:center;
}
.rows_title{
	vertical-align:middle !important;	
	width:20% !important;
}
.v_middle{
	vertical-align:middle !important;
}
.frow p {
	border-bottom: 1px solid #d9d9d9;
	text-align: center;
	background: #f3f9fe;
	color: #0c82e9;
	padding: 10px;
	overflow: auto;
	height: auto;
}
.frow {
	border: 1px solid #d9d9d9;
	min-height: 615px;
	padding: 0;
	margin: 5px;
	position: relative;
}

.map_container{
	width:546px;
	margin:0 auto;
	height:575px;
}

.formation{
	width:546px; 
	margin:0 auto; 
	padding:20px 0px; 
	position:relative;
	text-align:center;
}

.formation > div {
    width: 49%;
    float: left;
    height: 270px;
    margin-left: 5px;
    margin-bottom: 5px;
    border: 1px solid black;
	text-align:center;
}

.location_container{
	width:253px;
	height:260px;
	margin:0 auto;
	text-align:center;
}
</style>
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
<div id="sensor" class="body_wrap">
<div class="loader" id="loader-1" style="z-index:99; position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%);"></div>
	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">약도 및 사진</h1>
		</div>
		<!-- sub_title -->
		<div class="row">
			<div class="col-xs-2 tree2">
				<ul class="easyui-tree" data-options="
			    url:'/api/admin/guEqui',
			    method:'get',
			    animate:true,
			    "></ul>
			</div>
			<div class="col-xs-10 info">
				<form id="form">
					<div class="info-wrap">
						<div class="row" style="text-align: right;">
								<c:if test="${grant eq 'Y'}">
										<input class="save_btn col-xs-1" type="button" value="저장" style="background: white; color: #666; border: 1px solid #c9c9c9; display: block; float: right; overflow:auto; margin-right:30px; margin-bottom: 15px;"/>
								</c:if>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<div class="frow" style="text-align:center;">
									<p>설치 위치</p>
									<div class="map_container">
										설치 위치 <label for="equiInsLoc" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
										<input type="file" accept="image/*" name="equiInsLoc" id="equiInsLoc">
										<%-- <div id="equiInsLocMap" style="height: calc(100% - 20px);width: 100%;"></div> --%>
										<img id="equiInsLocImg" src="" style="height: calc(100% - 20px);width: 100%;">

									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="frow">
									<p>도시데이터 센서 주변사진</p>
									<div class="formation">
										<div class="formation_east">
											동 
											<label for="equiArdEast" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="equiArdEast" id="equiArdEast">
											<img id="equiArdEastImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
										<div class="formation_west">
											서 
											<label for="equiArdWest" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="equiArdWest" id="equiArdWest">
											<img id="equiArdWestImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
										<div class="formation_south">
											남 
											<label for="equiArdSouth" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="equiArdSouth" id="equiArdSouth">
											<img id="equiArdSouthImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
										<div class="formation_north">
											북 
											<label for="equiArdNorth" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="equiArdNorth" id="equiArdNorth">
											<img id="equiArdNorthImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6">
								<div class="frow" style="min-height: auto; overflow: auto;">
									<p>설치장소 사진 (설치 전)</p>
									
									<div class="col-xs-6" style="padding:0; height: 301.65px; border-right:1px solid #d9d9d9;">
										<p>전면</p>
										<div class="location_container">
											전면 <label for="instBefFrt" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="instBefFrt" id="instBefFrt">
											<img id="instBefFrtImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
									</div>
								
									<div class="col-xs-6" style="padding:0; height: 301.65px;">
										<p>후면</p>
										<div class="location_container">
											후면 <label for="instBefBack" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="instBefBack" id="instBefBack">
											<img id="instBefBackImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="frow" style="min-height: auto; overflow: auto;">
									<p>설치장소 사진 (설치 후)</p>
									<div class="col-xs-6" style="padding:0; height: 301.65px; border-right:1px solid #d9d9d9;">
										<p>전면</p>
										<div class="location_container">
											전면 <label for="instAftFrt" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="instAftFrt" id="instAftFrt">
											<img id="instAftFrtImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
									</div>
									<div class="col-xs-6" style="padding:0; height: 301.65px;">
										<p>후면</p>
										<div class="location_container">
											후면 <label for="instAftBack" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
											<input type="file" accept="image/*" name="instAftBack" id="instAftBack">
											<img id="instAftBackImg" src="" style="height: calc(100% - 20px);width: 100%;">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="equiInfoKey" value=""/>
<script>
var fileForm = new FormData();
var equiInfoKey = '';
$(document).ready(function() {
	var markers = [];
	$('.easyui-tree').tree({
		onClick: function(node){
			console.log(node)
			if(!node.children) {
				var id = node.text;
				console.log(id)
				equiInfoKey = id;
					$.ajax({
						url: '/api/admin/cardLoc/img/'+id,
						beforeSend: function() {
							$('#equiArdWestImg').attr('src', '')
							$('#equiArdEastImg').attr('src', '')
							$('#equiArdSouthImg').attr('src', '')
							$('#equiArdNorthImg').attr('src', '')
							$('#instBefFrtImg').attr('src', '')
							$('#instBefBackImg').attr('src', '')
							$('#instAftFrtImg').attr('src', '')
							$('#instAftBackImg').attr('src', '')
							$('#equiInsLocImg').attr('src', '')
						},
						success: function(r) {
							if(r.data.equiArdWest != null) {
							    $('#equiArdWestImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.equiArdWest+"."+r.data.equiArdWestTp+"?tm="+new Date().getTime())
							}
							if(r.data.equiArdEast != null) {
							    $('#equiArdEastImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.equiArdEast+"."+r.data.equiArdEastTp+"?tm="+new Date().getTime())
							}
							if(r.data.equiArdSouth != null) {
							    $('#equiArdSouthImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.equiArdSouth+"."+r.data.equiArdSouthTp+"?tm="+new Date().getTime())
							}
							if(r.data.equiArdNorth != null) {
							    $('#equiArdNorthImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.equiArdNorth+"."+r.data.equiArdNorthTp+"?tm="+new Date().getTime())
							}
							if(r.data.instBefFrt != null) {
							    $('#instBefFrtImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.instBefFrt+"."+r.data.instBefFrtTp+"?tm="+new Date().getTime())
							}
							if(r.data.instBefBack != null) {
							    $('#instBefBackImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.instBefBack+"."+r.data.instBefBackTp+"?tm="+new Date().getTime())
							}
							if(r.data.instAftFrt != null) {
							    $('#instAftFrtImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.instAftFrt+"."+r.data.instAftFrtTp+"?tm="+new Date().getTime())
							}
							if(r.data.instAftBack != null) {
							    $('#instAftBackImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.instAftBack+"."+r.data.instAftBackTp+"?tm="+new Date().getTime())
							}
							if(r.data.equiInsLoc != null) {
							    $('#equiInsLocImg').attr('src', '/api/admin/cardLoc/img/'+id+"/"+r.data.equiInsLoc+"."+r.data.equiInsLocTp+"?tm="+new Date().getTime())
							}

							//찍혀있는 마커 삭제
							for(i in markers) {
								markers[i].setMap(null);
							}
							var moveLatLon = new kakao.maps.LatLng(r.data.gpsAbb, r.data.gpsLat)
							//지도 이동
							map.setCenter(moveLatLon)
							map.setLevel(3);


							var imageSrc = '/share/img/visitor.png', // 마커이미지의 주소입니다    
								imageSize = new kakao.maps.Size(50, 54), // 마커이미지의 크기입니다
								imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
								
							// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
							var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
								markerPosition = new kakao.maps.LatLng(37.54699, 127.09598); // 마커가 표시될 위치입니다

							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								position: moveLatLon, 
								image: markerImage // 마커이미지 설정 
							});

							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map); 
							markers.push(marker);
						}
					})
			}
		}
	});
	
	$('input[type=file]').change(function(e) {
		console.log(e.target.files[0])
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		var id = e.target.id;
		
		filesArr.forEach(function(r) {
			if(!r.type.match("image.*")) {
				return;
			}
			sel_file = r;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#'+id+'Img').attr('src', e.target.result)
			}
			fileForm.append(id,$('#'+id).val())
			reader.readAsDataURL(r);
		})
	})
	
	$('.save_btn').click(function(e){
		e.preventDefault();
		var form = $('#form')[0];
  		var formData = new FormData(form);
  			formData.append("equiInfoKey",equiInfoKey)
		var data = $('#form').serializeObject();
  		 $.ajax({
  			 url: '/api/admin/cardLoc/file',
  			contentType : false,
	        processData: false,
	        enctype: "multipart/form-data",
	        type:'POST',
  			 data: formData,
  			beforeSend: function() {
				$('.loader').show();
				$('.dim').show();
			},
  			 success: function(r) {
  				 if(r.result == "success") {
  					 alertify.alert('성공', '저장되었습니다.')
  				 }
  			 },
  			complete: function() {
				$('.loader').hide();
				$('.dim').hide();
			}
  		 
  		 })
	})
})
</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4cb52cd84311965f100e95f39f303c9"></script>
<script>
	var container = document.getElementById('equiInsLocMap');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	var map = new kakao.maps.Map(container, options);
</script>
<jsp:include page="../common/footer.jsp"></jsp:include>