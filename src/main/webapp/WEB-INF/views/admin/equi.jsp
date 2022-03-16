<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>

<link rel="stylesheet"
	href="../../share/treeview/css/jquery.treeview.css" />
<link rel="stylesheet" href="../../share/treeview/css/screen.css" />
<script src="../../share/treeview/lib/jquery.cookie.js"
	type="text/javascript"></script>
<script src="../../share/treeview/lib/jquery.treeview.js"
	type="text/javascript"></script>

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
.form-group .row {
    margin-bottom: 30px;
}
</style>
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
<div id="sensor" class="body_wrap">

	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">기기 등록</h1>
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
					<form>
						<div class="form-group">
							<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
								<div class="col-xs-6" id="equiName" style="line-height: 30px;">
								</div>
								<div class="col-xs-6">
									<c:if test="${grant eq 'Y'}">
										<select class="col-xs-2" id="gu">
											<option>구 선택</option>
											<c:forEach items="${gus}" var="gu">
												<option value="${gu.code}">${gu.codeNm}</option>
											</c:forEach> 
										</select>
										<input class="search_btn col-xs-offset-1 col-xs-2" id="export" type="button" value="Export" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-2" type="button" data-toggle="modal" data-target=".upload" value="다중 추가" style="margin-left: 20px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-1" type="button" data-toggle="modal" data-target=".detail" value="추가" style="margin-left: 20px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-1" id="remove" type="button" value="삭제" style="margin-left: 20px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-1" id="save" type="submit" value="저장" style="margin-left: 20px;"/>
									</c:if>
								</div>
							</div>
								<div class="row">
									
									<div class="col-xs-1 title">기기종류</div>
									<div class="col-xs-3">
										<select id="sel-2">
											<option>기기종류 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">스테이션명</div>
									<div class="col-xs-3">
										<input class="form-control" id="staName" type="text"/>
									</div>
									<div class="col-xs-1 title">센서코드</div>
									<div class="col-xs-3">
										<input class="form-control" id="equiInfoKey" type="text"/>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">위도</div>
									<div class="col-xs-3">
										<input id="gpsAbb" class="form-control" type="text"/>
									</div>
									<div class="col-xs-1 title">경도</div>
									<div class="col-xs-3">
										<input id="gpsLat" class="form-control" type="text"/>
									</div>
	
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">센서타입</div>
									<div class="col-xs-2">
										<select id="sel-3">
											<option>센서타입 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">용도1</div>
									<div class="col-xs-2">
										<select id="sel-4">
											<option>용도1 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">용도2</div>
									<div class="col-xs-2">
										<select id="sel-5">
											<option>용도2 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">용도3</div>
									<div class="col-xs-2">
										<select id="sel-6">
											<option>용도3 선택</option>
										</select>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">설치년도</div>
									<div class="col-xs-3">
										<select id="sel-7">
											<option>설치년도 선택</option>
										</select>
									</div>
									<div class="col-xs-3">
										<select id="instMonth" name="instMonth">
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
									<div class="col-xs-1 title">관리번호</div>
									<div class="col-xs-3">
										<input class="form-control" id="mngNum" type="text" numberOnly maxlength="4"/>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">행정구</div>
									<div class="col-xs-3">
										<select id="sel-8">
											<option>행정구 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">도로명</div>
									<div class="col-xs-3">
										<input class="form-control" id="instLoc" type="text"/>
									</div>
									<div class="col-xs-1 title">행정명</div>
									<div class="col-xs-3">
										<input class="form-control" id="instLoc2" type="text"/>
									</div>
								</div>
                                <div class="row">
                                    <div class="col-xs-1 title">행정동</div>
                                    <div class="col-xs-2">
                                        <input class="form-control" id="adminDong" type="text"/>
                                    </div>
                                    <div class="col-xs-1 title">법정동</div>
                                    <div class="col-xs-2">
                                        <input class="form-control" id="courtDong" type="text"/>
                                    </div>
                                    <div class="col-xs-1 title">cctv 고유번호</div>
                                    <div class="col-xs-2">
                                        <input class="form-control" id="cctvNumber" type="text"/>
                                    </div>
                                    <div class="col-xs-1 title">설치 장소</div>
                                     <div class="col-xs-2">
                                        <input class="form-control" id="instplace" type="text"/>
                                    </div>
                                </div>

								<div class="row">
									<label class="col-xs-offset-1 choice-label"><input id="setYn" type="checkbox"><i></i>  설치여부</label>
									<label class="choice-label"><input id="useYn" value="day" type="checkbox"><i></i>  완료여부</label>
									<label class="choice-label"><input id="BaramYn" type="checkbox"  onchange="checkedChange(this)"><i></i>  바람길여부</label>
									<input type="text" id="baramMngNum" maxlength="4" style="display:none; width: 100px;" placeholder="관리번호" numberOnly maxlength="4"/>
									<input type="text" id="baramNm" style="display:none; width: 100px;" placeholder="센터명"/>
									<label class="choice-label"><input id="AirYn" type="checkbox" onchange="checkedChange(this)"><i></i>  대기측정소여부</label>
									<input type="text" id="airMngNum" maxlength="4" style="display:none; width: 100px;" placeholder="관리번호" numberOnly maxlength="4"/>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">방문자 센서코드</div>
									<div class="col-xs-3">
										<input id="vistorSenId" class="form-control" type="text" numberOnly maxlength="4"/>
									</div>
									<div class="col-xs-1 title">방문자 센서명</div>
									<div class="col-xs-3">
										<input id="vistorSenViewNm" class="form-control" type="text"/>
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
	$('.easyui-tree').tree({
		onClick: function(node){
			if(!node.children) {
				var id = node.text
				$.ajax({
					url: "/api/admin/equi/info/"+id,
					type: "GET",
					dataType: "json",
					success: function(r) {
						var result = r.data[0];
						
						//기기명
						$('#equiName').text('기기명 - '+ result.equiInfoKey)
						$('#equiInfoKey').val(result.equiInfoKey);
						
						//기기 종류
						infoSelectSet('sel-2', result.equiType)
						
						//센서타입 선택
						infoSelectSet('sel-3', result.senseTp)
						
						//용도
						infoSelectSet('sel-4', result.useTp1)
						infoSelectSet('sel-5', result.useTp2)
						infoSelectSet('sel-6', result.useTp3)
						
						//설치년도
						infoSelectSet('sel-7', result.instYear)
						
						//구
						infoSelectSet('sel-8', result.guTp)
						infoSelectSet('instMonth', result.instMonth)
						
						//스테이션 명
						$('#staName').val(result.staName);
						
						//위도, 경도
						$('#gpsAbb').val(result.gpsAbb);
						$('#gpsLat').val(result.gpsLat);
						
						//관리번호
						$('#mngNum').val(result.mngNum);
						
						//도로명, 행정명
						$('#instLoc').val(result.instLoc);
						$('#instLoc2').val(result.instLoc2);

						//행정동, 법정동, cctv 고유번호, 설치 장소
						$('#adminDong').val(result.adminDong);
                        $('#courtDong').val(result.courtDong);
                        $('#cctvNumber').val(result.cctvNumber);
                        $('#instPlace').val(result.instPlace);

						if(result.setYn == 'Y' || result.setYn == 'y') {
							$('#setYn').prop('checked', true)
						} else {
						$('#setYn').prop('checked', false)
						}
						if(result.useYn == 'Y' || result.useYn == 'y') {
							$('#useYn').prop('checked', true)
						} else {
						$('#useYn').prop('checked', false)
						}
						if(result.baramYn == 'Y' || result.baramYn == 'y') {
							$('#BaramYn').prop('checked', true)
							$('#baramMngNum').css('display', 'inline-block')
							$('#baramMngNum').val(result.baramMngNum)
							$('#baramNm').css('display', 'inline-block')
							$('#baramNm').val(result.baramNm)
						} else {
							$('#BaramYn').prop('checked', false)
							$('#baramMngNum').hide();
							$('#baramNm').hide();
						}
						if(result.airYn == 'Y' || result.airYn == 'y') {
							$('#AirYn').prop('checked', true)
							$('#airMngNum').css('display', 'inline-block')
							$('#airMngNum').val(result.airMngNum)
						} else {
							$('#AirYn').prop('checked', false)
							$('#airMngNum').hide();
						}
						$('#vistorSenId').val(result.vistorSenId);
						$('#vistorSenViewNm').val(result.vistorSenViewNm);
					}
				})
			}
		}
	});
})
	function infoSelect(target, data, parse) {
		var text = "";
		$.each(data, function(a,b) {
			console.log(a, b);
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
		var adminDong;
		var courtDong;
		var cctvNumber;
		var instPlace;
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
		var msetYn = $('#m-setYn')[0].checked ? 'Y' : 'N';
		var museYn = $('#m-useYn')[0].checked ? 'Y' : 'N';
		var setYn = $('#setYn')[0].checked ? 'Y' : 'N';
		var useYn = $('#useYn')[0].checked ? 'Y' : 'N';
		var baramYn = $('#BaramYn')[0].checked ? 'Y' : 'N';
		var airYn = $('#AirYn')[0].checked ? 'Y' : 'N';
		var mbaramYn = $('#mBaramYn')[0].checked ? 'Y' : 'N';
		var mairYn = $('#mAirYn')[0].checked ? 'Y' : 'N';
		var regDate;
		console.log(option)
		if(option == "modal") {
			return {equiInfoKey: $('#m-equiInfoKey').val(), equiType : $('#m-sel-2').val() , staName : $('#m-staName').val(), instLoc : $('#m-instLoc').val(), instLoc2 : $('#m-instLoc2').val(),adminDong : $('#m-adminDong').val(),courtDong : $('#m-courtDong').val(),cctvNumber : $('#m-cctvNumber').val(),instPlace : $('#m-instPlace').val(), gpsAbb : $('#m-gpsAbb').val(), gpsLat : $('#m-gpsLat').val(), senseTp : $('#m-sel-3').val(), useTp1 : $('#m-sel-4').val(), useTp2 : $('#m-sel-5').val(), useTp3 : $('#m-sel-6').val(), guTp : $('#m-sel-8').val(), instYear : $('#m-sel-7').val(), mngNum : $('#m-mngNum').val(), "setYn":msetYn , "useYn":museYn, "baramYn":mbaramYn, "airYn":mairYn, baramMngNum: $('#mbaramMngNum').val(), airMngNum: $('#mairMngNum').val(), baramNm: $('#mbaramNm').val(), instMonth: $('#instMonth2').val(), vistorSenId: $('#m-vistorSenId').val(), vistorSenViewNm: $('#m-vistorSenViewNm').val(),"${_csrf.parameterName}" : "${_csrf.token}",}
		} else {
			return {equiInfoKey : $('.tree-node-selected .tree-title').text() , equiType : $('#sel-2').val() , staName : $('#staName').val(), instLoc : $('#instLoc').val(), instLoc2 : $('#instLoc2').val(),adminDong : $('#adminDong').val(),courtDong : $('#courtDong').val(),cctvNumber : $('#cctvNumber').val(),instPlace : $('#instPlace').val(), gpsAbb : $('#gpsAbb').val(), gpsLat : $('#gpsLat').val(), senseTp : $('#sel-3').val(), useTp1 : $('#sel-4').val(), useTp2 : $('#sel-5').val(), useTp3 : $('#sel-6').val(), guTp : $('#sel-8').val(), instYear : $('#sel-7').val(), mngNum : $('#mngNum').val(), "setYn":setYn , "useYn":useYn, "baramYn":baramYn, "airYn":airYn,baramMngNum: $('#baramMngNum').val(), airMngNum: $('#airMngNum').val(), baramNm: $('#baramNm').val(), instMonth: $('#instMonth').val(), vistorSenId: $('#vistorSenId').val(), vistorSenViewNm: $('#vistorSenViewNm').val(),"${_csrf.parameterName}" : "${_csrf.token}",}
		}
	}
	function checkedChange(t, option) {
		if(option == null) {
			option = '';
		}
		if($(t)[0].checked) {
			if($(t)[0].id == option+"BaramYn") {
				$('#'+option+'AirYn').prop('checked', false)
				$($('#'+option+'AirYn').parent()[0].nextElementSibling).hide();
				$('#'+option+'baramNm').css('display', 'inline-block');
				$('#'+option+'baramNm').show();
			} else {
				$('#'+option+'BaramYn').prop('checked', false)
				$($('#'+option+'BaramYn').parent()[0].nextElementSibling).hide();
				$('#'+option+'baramNm').hide();
			}
			$($(t).parent()[0].nextElementSibling).css('display', 'inline-block');
			$($(t).parent()[0].nextElementSibling).val('');
			$('#'+option+'baramNm').val('');
		} else {
			$($(t).parent()[0].nextElementSibling).hide();
			$('#'+option+'baramNm').hide();
		}
	}
	$(document).ready(function() {
		
		$.ajax({
			url: '/api/admin/equiCommon',
			type: 'GET',
			success: function(r) {
// 				infoSelect("sel-1", r.data, "측정요소")
				infoSelect("sel-2", r.data, "기기종류")
				infoSelect("sel-3", r.data, "센서유형")
				infoSelect("sel-4", r.data, "용도1")
				infoSelect("sel-5", r.data, "용도2")
				infoSelect("sel-6", r.data, "용도3")
				infoSelect("sel-7", r.data, "설치년도")
				infoSelect("sel-8", r.data, "서울시구정의")

				infoSelect("m-sel-2", r.data, "기기종류")
				infoSelect("m-sel-3", r.data, "센서유형")
				infoSelect("m-sel-4", r.data, "용도1")
				infoSelect("m-sel-5", r.data, "용도2")
				infoSelect("m-sel-6", r.data, "용도3")
				infoSelect("m-sel-7", r.data, "설치년도")
				infoSelect("m-sel-8", r.data, "서울시구정의")
			}
		})
		
		$('#save').click(function(e) {
			e.preventDefault();
			if($('.tree-node-selected .tree-title').text().length == 0) {
				alertify.alert('에러', '선택된 기기가 없습니다.')
			} else {
				var data = dataInit();
				console.log(data)
				$.ajax({
					url: '/api/admin/equi/save',
					type: 'POST',
					data: dataInit(),
					success: function(r) {
						alertify.alert('성공', r.msg);
					}
				})
			}
		})
		
		$('#remove').click(function() {
				if($('.tree-node-selected .tree-title').text().length == 0) {
					alertify.alert('에러', '선택된 기기가 없습니다.')
				} else {
					alertify.confirm($('.tree-node-selected .tree-title').text() ,$('.tree-node-selected .tree-title').text()+'를 삭제하시겠습니까?', function(){
							$.ajax({
								url: '/api/admin/equi/remove',
								type: 'POST',
								data: {
									equiInfoKey: $('.tree-node-selected .tree-title').text(),
									"${_csrf.parameterName}" : "${_csrf.token}"
								},
								success: function(r) {
									alertify.alert('삭제', r.msg, function(){
										location.reload();
									});
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
				window.open('/admin/equi/excel/'+$('#gu').val(), '다운로드', options);
			}
		})
	})
</script>
<jsp:include page="./equiModal.jsp"></jsp:include>
<jsp:include page="./equiAddModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>