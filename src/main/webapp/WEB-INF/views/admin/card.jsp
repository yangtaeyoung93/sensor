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
.d-inline{
	display:inline-block;	
}
.list-inline{
	padding:0;
	margin:0;
	list-style:none;
}
.list-inline li{
	width:16%;
	display:inline-block;
	padding: 0px 10px;
}
.mt10{
	margin-top : 10px !important;
}
.alCneter{
	text-align:center;
}
.searchForm{
	text-align: right;
	border-bottom: 1px solid #c9c9c9;
	padding-bottom: 15px;
	width: 95.8%;
	margin-bottom: 15px;
}

#search_text{
	display: inline-block;
	width: 18.7%;
	padding: 0px;
	border: 1px solid #c9c9c9;
	margin-right: 6px;
}
#search_button{
	border: 1px solid #c9c9c9;
	width: 7.3%;

}
.inspHis th, .inspHis td{
	border: 1px solid #666;
}
</style>
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
<div id="sensor" class="body_wrap">

	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">센서 관리 카드</h1>
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
				<div class="info-wrap">
					<form id="form">
						<div class="form-group">
							<div class="row array">
								<div class="col-xs-7" id="equiName" style="line-height: 30px;">
								</div>
								<div class="col-xs-5">
									<c:if test="${grant eq 'Y'}">
										<select class="col-xs-3" id="gu">
											<option>구 선택</option>
											<c:forEach items="${gus}" var="gu">
												<option value="${gu.code}">${gu.codeNm}</option>
											</c:forEach> 
										</select>
										<input class="search_btn col-xs-offset-1 col-xs-2" id="export" type="button" value="Export" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-3" id="addWares" type="button" data-toggle="modal" data-target=".upload" value="다중 업데이트" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-2" id="save" type="submit" value="저장" style="margin-left: 10px;"/>
									</c:if>
								</div>
								
							</div>
							<div class="searchForm">
								<select>
									<option value="">선택</option>
									<option value="0">주소</option>
								</select>
								<input type="text" value="" id="search_text"/>
								<input type="button" value="검색" id="search_button"/>
							</div>
							    <form>
								<div class="row">
									<div class="col-xs-1 title"><label for="">제품명</label></div>
									<div class="col-xs-3">
										<input class="form-control" id="equiInfoKey" name="equiInfoKey" type="text" disabled/>
									</div>
									<div class="col-xs-1 title"><label for="">관리번호</label></div>
									<div class="col-xs-3">
										<input class="form-control" id="equiKey" name="equiKey" type="text" disabled/>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title"><label for="serialNm">S/N</label></div>
									<div class="col-xs-6">
										<input class="form-control" id="serialNm" type="text" value="" disabled/>
										<input class="form-control" id="serialNm2" name="serialNm" type="hidden" value=""/>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title"><label for="instMonth">제작년도</label></div>
									<div class="col-xs-2">
										<select id="sel-7" disabled>
											<option>설치년도 선택</option>
										</select>
									</div>
									<div class="col-xs-2" >
										<select id="instMonth" disabled>
											<option>설치월 선택</option>
											<option value="1">1월</option>
											<option value="2">2월</option>
											<option value="3">3월</option>
											<option value="4">4월</option>
											<option value="5">5월</option>
											<option value="6">6월</option>
											<option value="7">7월</option>
											<option value="8">8월</option>
											<option value="9">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title"><label for="manuCom">제조사</label></div>
									<div class="col-xs-3">
										<input class="form-control" id="manuCom" name="manuCom" type="text" value="" placeholder="ex) 케이웨더"/>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title"><label for="sizeWidth">제품크기</label></div>
									<div class="col-xs-7"> 
										<div class="col-xs-1 title"><label for="sizeWidth">가로: </label></div>
										<div class="col-xs-2">
											<input class="form-control" id="sizeWidth" name="sizeWidth" type="text" value=""/>
										</div>
										<div class="col-xs-1 title"><label for="sizeHeight">세로: </label></div>
										<div class="col-xs-2">
											<input class="form-control" id="sizeHeight" name="sizeHeight" type="text" value=""/>
										</div>
										<div class="col-xs-1 title"><label for="sizeThick">두께: </label></div>
										<div class="col-xs-2">
											<input class="form-control" id="sizeThick" name="sizeThick" type="text" value=""/>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title">측정센서</div>
									<div class="col-xs-9">
										<ul class="list-inline">
											<li><label class="col-xs-offset-1 choice-label"><input class="sensorSelect" id="sensorPm10" name="sensorPm10" value="Y" type="checkbox"><i></i>  PM10</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorPm25" name="sensorPm25" value="Y" type="checkbox"><i></i>  PM2.5</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorWind" name="sensorWind" value="Y" type="checkbox"><i></i>  풍향</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorWindSp" name="sensorWindSp" value="Y" type="checkbox"><i></i>  풍속</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorTemp" name="sensorTemp" value="Y" type="checkbox"><i></i>  온도</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorHumi" value="Y" name="sensorHumi" type="checkbox"><i></i>  습도</label></li>
										</ul>
										<ul class="list-inline mt10">
											<li><label class="col-xs-offset-1  choice-label"><input class="sensorSelect" id="sensorCo" name="sensorCo" value="Y" type="checkbox"><i></i>  일산화탄소</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorNo2" name="sensorNo2" value="Y" type="checkbox"><i></i>  이산화질소</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorSo2" name="sensorSo2" value="Y" type="checkbox"><i></i>  이산화황</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorNh3" name="sensorNh3" value="Y" type="checkbox"><i></i>  암모니아</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorH2S" name="sensorH2S" value="Y" type="checkbox"><i></i>  황화수소</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorO3" name="sensorO3" value="Y" type="checkbox"><i></i>  오존</label></li>
										</ul>
										<ul class="list-inline mt10">
											<li><label class="col-xs-offset-1  choice-label"><input class="sensorSelect" id="sensorIllu" name="sensorIllu" value="Y" type="checkbox"><i></i>  조도</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorEffeTemp" name="sensorEffeTemp" value="Y" type="checkbox"><i></i>  흑구</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorVibr" name="sensorVibr" value="Y" type="checkbox"><i></i>  진동</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorNoise" name="sensorNoise" value="Y" type="checkbox"><i></i>  소음</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorUv" name="sensorUv" value="Y" type="checkbox"><i></i>  자외선</label></li>
											<li><label class="choice-label"><input class="sensorSelect" id="sensorVisitor" name="sensorVisitor" value="Y" type="checkbox"><i></i>  방문자수</label></li>
										</ul>
										<ul class="list-inline mt10">
											<li><label class="col-xs-offset-1 choice-label"><input class="sensorSelect" id="sensorEtc" name="sensorEtc" value="Y" type="checkbox"><i></i>  기타</label></li>
										</ul>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title">통신방법</div>
									<div class="col-xs-9">
										<ul class="list-inline">
											<li><label class="col-xs-offset-1 choice-label"><input id="commTp" name="commTp" value="0" type="radio"><i></i>  유선</label></li>
											<li><label class="choice-label"><input id="commTp1" name="commTp" value="1" type="radio"><i></i>  WiFi</label></li>
											<li><label class="choice-label"><input id="commTp2" name="commTp" value="2" type="radio"><i></i>  LTE</label></li>
											<li><label class="choice-label"><input id="commTp3" name="commTp" value="3" type="radio"><i></i>  3G</label></li>
											<li><label class="choice-label"><input id="commTp4" name="commTp" value="4" type="radio"><i></i>  LTE-M</label></li>
										</ul>
										<ul class="list-inline mt10">
											<li><label class="col-xs-offset-1 choice-label"><input id="commTp5" name="commTp" value="5"type="radio"><i></i>  LoRa</label></li>
											<li><label class="choice-label"><input id="commTp6" name="commTp" value="6" type="radio"><i></i>  NB-ioT</label></li>
											<li><label class="choice-label"><input id="commTp7" name="commTp" value="7" type="radio"><i></i>  Bluetooth</label></li>
											<li><label class="choice-label"><input id="commTp8" name="commTp" value="8" type="radio"><i></i>  zigbee</label></li>
											<li><label class="choice-label"><input id="commTp9" name="commTp" value="9" type="radio"><i></i>  기타</label></li>
										</ul>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title"><label for="">전력공급</label></div>
									<div class="col-xs-2" id="volt">
										<label class="col-xs-offset-1 choice-label"><input id="elecTp" name="elecTp" value="0" type="radio"><i></i>  상전</label>
										<label class="choice-label" style="margin-left:20px;"><input id="elecTp1" name="elecTp" value="1" type="radio"><i></i>  배터리</label>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title"><label for="">SW Version</label></div>
									<div class="col-xs-3">
										<input class="form-control" id="swVersion" name="swVersion" type="text" value=""/>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-1 title">제품사진</div>
									<div class="col-xs-3 alCneter file" style="height:300px;border:1px solid black;" id="front">
									정면 <label for="picFront" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
									<input type="file" name="picFront" id="picFront"/>
									<img id="picFrontImg" src="" style="height: calc(100% - 20px);width: 100%;">
									</div>
									<div class="col-xs-3 alCneter file" style="height:300px;border:1px solid black;" id="side">
									측면 <label for="picSide" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
									<input type="file" name="picSide" id="picSide"/>
									<img id="picSideImg" src="" style="height: calc(100% - 20px);width: 100%;">
									</div>
									<div class="col-xs-3 alCneter file" style="height:300px;border:1px solid black;" id="back">
									후면 <label for="picBack" style="curosr:pointer; margin-left: 10px; color: #0c82e9">파일 업로드</label>
									<input type="file" name="picBack" id="picBack"/>
									<img id="picBackImg" src="" style="height: calc(100% - 20px); width: 100%;">
									</div>
									<script>
										$(document).ready(function(){
											$('.sensorSelect').each(function() {
												if($(this).prop('checked')){
													console.log($(this)[0].id)
												}
											})
											$('input[type=file]').on("change", function(e) {
												console.log(e.target);
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
													reader.readAsDataURL(r);
												})
											})
										})
									</script>
								</div>
								<div class="row">
                                    <div class="col-xs-1 title"><label for="">점검이력</label></div>
                                    <div class="col-xs-9">
                                       <table class="inspHis" >
										   <colgroup>
												<col style= "width:5%">
												<col style= "width:20%">
												<col style= "width:10%">
												<col style= "width:20%">
											</colgroup>
										   <thead>
												<tr style="border: 1px solid #4b4949;">
													<th width="10%">번호</th>
													<th width="20%">접수일자</th>
													<th width="50%">점검이유</th>
													<th width="50%">점검내용</th>
													<th width="20%">작업일자</th>
												</tr>
											</thead>
											<tbody></tbody>
									   </table>
                                    </div>
                                </div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	$('#addWares').click(function() {
		$('.upload-name').val('파일선택')
	})
	searchEqui();

	$('#search_button').click(function(){
		const id = $('#search_text').val();
		searchEqui(id);	
	});
	
})

	function searchEqui(val){
		$('.easyui-tree').tree({
			onClick: function(node){
			if(!node.children) {
				console.log(node)
				var id = node.text;
				go(id);
			}
			}
		});
		go(val);
	}

	function go(id){
		$.ajax({
			url: "/api/admin/card/info/"+id,
			type: "GET",
			dataType: "json",
			success: function(r) {
				var result = r.data;
				console.log(result);
				$.each(result, function(a,b) {
					if($('#'+a)[0] != undefined){
						if($('#'+a)[0].type == "checkbox") {
							if(b == 'Y') {
								$('#'+a).prop('checked', true)
							}
							if(b == 'N' || b == null){
								$('#'+a).prop('checked', false)
							}
						}
						else if($('#'+a)[0].type == "radio") {
							if(b == 0) {
								$('#'+a).prop('checked', true)
							} else {
								$('#'+a+b).prop('checked', true);
							}
						}
						else if($('#'+a)[0].type == "select-one") {
							$('#'+a).val(b)
						}
						else if(a == "serialNm"){
							$('#serialNm').val(b)
							$('#serialNm2').val(b)
						} 
						else if(a == "picFront"){
							$('#'+a+'Img').attr('src', '/api/admin/cardLoc/img/'+r.data.equiInfoKey+"/"+r.data.picFront+"."+r.data.picFrontTp+"?tm="+new Date().getTime())
						}
						else if(a == "picBack"){
							$('#'+a+'Img').attr('src', '/api/admin/cardLoc/img/'+r.data.equiInfoKey+"/"+r.data.picBack+"."+r.data.picBackTp+"?tm="+new Date().getTime())
						}
						else if(a == "picSide"){
							$('#'+a+'Img').attr('src', '/api/admin/cardLoc/img/'+r.data.equiInfoKey+"/"+r.data.picSide+"."+r.data.picSideTp+"?tm="+new Date().getTime())
						}
						else {
							$('#'+a).val(b);
						}
					}
				})
				//설치년도
				infoSelectSet('sel-7', result.instYear)
					}
				})

				$.ajax({
					url: "/api/admin/card/inspHis/"+id,
					type: "GET",
					dataType: "json",
					success : function(data){
						var html = "";
						for(var i = 0; i < data.length; i += 1){
							html += "<tr>";
							html += "<td>";
							html += data[i].id;
							html += "</td>";
							html += "<td>";
							html += data[i].workDt;
							html += "</td>";
							html += "<td>";
							html += data[i].chgReason;
							html += "</td>";
							html += "<td>";
							html += data[i].bigo;
							html += "</td>";
							html += "<td>";
							html += data[i].workYmd;
							html += "</td>";
							html += "</tr>";
						}
						$(".inspHis tbody").html(html);
					}
				});
	}	
	function infoSelect(target, data, parse) {
		var text = "";
		$.each(data, function(a,b) {
			if(b != null) {
				if(b.sortCd == parse) {
					if(b.relCd1 == "null") {
						text += "<option value='"+b.code+"'>"+b.codeNm+"</option>"
					} else {
						text += "<option value='"+b.code+"'>"+b.relCd1+"</option>"
					}
				}
			}
		})
		
		$("#"+target).append(text)
	}
	
	function infoSelectSet(target, data) {
		$('#'+target).val(data)
// 		$('#'+target+' option').each(function(a,b){
// 				$(b).attr('selected', false)
// 		})
// 		$('#'+target+' option[value="'+data+'"]').attr('selected', true);
	}
	
	function dataInit(option) {
		var equiInfoKey;
		var equiType;
		var staName;
		var instLoc;
		var instLoc2;
		var locInfo;
		var gpsAbb;
		var gpsLat;
		var senseTp;
		var useTp1;
		var useTp2;
		var useTp3;
		var guTp;
		var instYear;
		var mngNum;
		var etc;
		var setYn = $('#m-setYn')[0].checked ? 'Y' : 'N';
		var useYn = $('#m-useYn')[0].checked ? 'Y' : 'N';
		var regDate;
		console.log(option)
		if(option == "modal") {
			return {equiInfoKey: $('#m-equiInfoKey').val(), equiType : $('#m-sel-2').val() , staName : $('#m-staName').val(), instLoc : $('#m-instLoc').val(), instLoc2 : $('#m-instLoc2').val(), gpsAbb : $('#m-gpsAbb').val(), gpsLat : $('#m-gpsLat').val(), senseTp : $('#m-sel-3').val(), useTp1 : $('#m-sel-4').val(), useTp2 : $('#m-sel-5').val(), useTp3 : $('#m-sel-6').val(), guTp : $('#m-sel-8').val(), instYear : $('#m-sel-7').val(), mngNum : $('#m-mngNum').val(), "setYn":setYn , "useYn":useYn, "${_csrf.parameterName}" : "${_csrf.token}",}
		} else {
			return {equiInfoKey : $('.tree_s').text() , equiType : $('#sel-2').val() , staName : $('#staName').val(), instLoc : $('#instLoc').val(), instLoc2 : $('#instLoc2').val(), gpsAbb : $('#gpsAbb').val(), gpsLat : $('#gpsLat').val(), senseTp : $('#sel-3').val(), useTp1 : $('#sel-4').val(), useTp2 : $('#sel-5').val(), useTp3 : $('#sel-6').val(), guTp : $('#sel-8').val(), instYear : $('#sel-7').val(), mngNum : $('#mngNum').val(), "setYn":setYn , "useYn":useYn, "${_csrf.parameterName}" : "${_csrf.token}",}
		}
	}
	
	$(document).ready(function() {
		$.fn.serializeObject = function() {
		    var obj = null;
		    try {
		        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
		            var arr = this.serializeArray();
		            if (arr) {
		                obj = {};
		                jQuery.each(arr, function() {
		                    obj[this.name] = this.value;
		                });
		            }
		        }
		    } catch (e) {
		        alert(e.message);
		    } finally {
		    }
		 
		    return obj;
		};
		$.ajax({
			url: '/api/admin/equiCommon',
			type: 'GET',
			success: function(r) {
				infoSelect("sel-2", r.data, "기기종류")
				infoSelect("sel-3", r.data, "센서유형")
				infoSelect("sel-4", r.data, "용도1")
				infoSelect("sel-5", r.data, "용도2")
				infoSelect("sel-6", r.data, "용도3")
				infoSelect("sel-7", r.data, "설치년도")
				infoSelect("sel-8", r.data, "서울시구정의")
			}
		})
		$('#save').click(function(e) {
			e.preventDefault();
			var data = $('#form').serializeObject();
			$('.sensorSelect').each(function() {
				if(!$(this).prop('checked')){
					console.log($(this)[0].id)
					data[$(this)[0].id] = 'N'
				}
			})
			console.log(data)
			var form = $('#form')[0];
	   		 var formData = new FormData(form);
			console.log(formData)
			$.ajax({
				url: '/api/admin/card/update',
				type: 'POST',
				data: data ,
				success: function(r) {
					if($('#picFront').val().length > 0||
					$('#picSide').val().length > 0||
					$('#picBack').val().length > 0) {
						$.ajax({
							url: '/api/admin/card/file',
							contentType : false,
					        processData: false,
					        enctype: "multipart/form-data",
					        type : "POST",
					        data: formData,
					        success:function(r) {
					        	alertify.alert('성공', '저장하였습니다.', function() {
					        		location.reload();	
					        	})
					        }
				
				
						})
					} else {
						alertify.alert('성공', '저장하였습니다.', function() {
			        		location.reload();	
			        	})
					}
				}
			})
		
		})
		
		
		$('#remove').click(function() {
				if($('.tree_s').text().length == 0) {
					alertify.alert('에러', '선택된 기기가 없습니다.')
				} else {
					alertify.confirm($('.tree_s').text() ,$('.tree_s').text()+'를 삭제하시겠습니까?', function(){
							$.ajax({
								url: '/api/admin/equi/remove',
								type: 'POST',
								data: {
									equiInfoKey: $('.tree_s').text(),
									"${_csrf.parameterName}" : "${_csrf.token}"
								},
								success: function(r) {
									alertify.alert('삭제', r.msg);
								}
							})
						}, function(){ alertify.error('취소되었습니다.')});
				}
		})

		$('#export').click(function() {
			var guTp = $('#gu').val();
			if($('#gu').val() == "구 선택") {
				alertify.alert('실패', 'Export할 구를 선택해주세요.')
			}  else {
				var options = 'top=0, left=0, width=0, height=0, status=no, menubar=no, toolbar=no, resizable=no';
				window.open('/admin/card/excel/'+$('#gu').val(), '다운로드', options);
			}
		})
	})
</script>
<jsp:include page="./cardAddModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>