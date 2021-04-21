<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<script src="/share/js/page.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>

<script src="/share/js/jquery.timepicker.min.js" charset="UTF-8"></script>
<link href="/share/css/jquery.timepicker.css"  rel="stylesheet"></link>
<script type='text/javascript'>
$(function(){
    $('#to').datepicker({
        calendarWeeks: false,
        todayHighlight: true,
        autoclose: true,
        format: "yyyy/mm/dd",
        language: "kr"
    });
    
    $('#from').datepicker({
        calendarWeeks: false,
        todayHighlight: true,
        autoclose: true,
        format: "yyyy/mm/dd",
        language: "kr"

    });

});

$(document).ready(function() {
	$('#to').unbind('change');
	$('#from').unbind('change');
	$('#to').change(function() {
		if($('#from').val() != ""){
			var to = parse($('#to').val());
			var from = parse($('#from').val());
			var result = (from - to)/(24 * 3600 * 1000);
			
			if(result < 0) {
				$('#from').val('');
			}
			console.log($('#from').data('flag'))
			if(result > 366) {
				if( $('#from').data('flag') != false ) {
					$('#from').val('');
				}
			}
		}
	})
	
	$('#from').change(function() {
		if($('#to').val() != ""){
			var to = parse($('#to').val());
			var from = parse($('#from').val());
			var result = (from - to)/(24 * 3600 * 1000);
			
			if(result < 0) {
				$('#to').val('');
			}
			
			if(result > 366) {
				if($('#from').data('flag') != false) {
					alert("날짜 범위는 최대 365일입니다.");
					$('#from').val('');
				}
			}
		}
	})
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
#tree li strong {
	cursor: pointer;
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
	display: block;
	padding-bottom: 6px;
}
.user-table tr, .user-table td, .user-table th {
	border: 1px solid #d9d9d9;
	text-align: center;
}
.user-table th {
	background: #f3f9fe;
	border-top:1px solid #0c82e9 !important;
	background-clip: padding-box;
}
.user-table tbody tr {
	cursor: pointer;
}
.first{
	background-color:white !important;
}
input[type=checkbox] {
	position: absolute;
}
.user-table tr th:first-child {
	width: 40px;
}
</style>    
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
<div id="sensor" class="body_wrap">
	
	<div class="container">
		<div class="sub_title">
			<h1 class="main_co">도시데이터 센서 SW/HW 변동이력</h1>
		</div>
		<div class="row array">
					
			<div class="col-xs-14">
				<form id="searchForm">
					<div class="form-group">
						<ul class="row">
							<li class="col-xs-1 title">기간</li>
							<li class="col-xs-3">
								<div class="col-xs-5">
									<input type="text" autocomplete=off name="toDate" id="to"  placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
								</div>
								<div class="col-xs-2" style="text-align: center; line-height: 30px;">
									~
								</div>
								<div class="col-xs-5">
									<input type="text" autocomplete=off name="fromDate" id="from" placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
								</div>
							</li>
							<li class="col-xs-1 title">구분</li>
							<li class="col-xs-1">
								<select id="opt1" name="swHwTp">
									<option>선택</option>
									<option value="all">전체</option>
									<c:forEach items="${one }" var="one">
										<option value="${one.code }">${one.codeNm }</option>
									</c:forEach>
								</select>
								
							</li>
							<li class="col-xs-1 title">변동구분</li>
							<li class="col-xs-1">
								<select id="opt2" name="chgTp">
									<option>선택</option>
									<option value="all">전체</option>
									<c:forEach items="${two }" var="two">
										<option value="${two.code }">${two.codeNm }</option>
									</c:forEach>
								</select>
							</li>
							<li class="col-xs-1 title">기기명</li>
							<li class="col-xs-2">

									<input type="text" autocomplete=off name="equiInfoKey" id="equiInfoKey" placeholder="기기명" class="form-control"><span style="display: none;" class="input-group-addon"></span>

							</li>
							<li class="col-xs-1">
								<input class="ware_search_btn search_btn" type="submit" value="검색">
							</li>
						</ul>
						<div class="row array">
							<div class="col-xs-8" id="equiName" style="line-height: 30px;">
							</div>
							<div class="col-xs-4" style="float:right;text-align:right;">
								<c:if test="${grant eq 'Y'}">
									<input class="search_btn col-xs-offset-1 col-xs-2" id="export" type="button" value="Export" style="background: white; color: #666; border: 1px solid #c9c9c9; float: none;"/>
									<input class="search_btn col-xs-3" id="addWares" type="button" data-toggle="modal" data-target=".upload" value="다중 추가" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;float: none;"/>
									<input class="search_btn col-xs-3 col-xs-offset-1" id="addBtn" type="button" data-toggle="modal" data-target=".detail" value="추가" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;float: none;"/>
									<input class="search_btn col-xs-offset-1 col-xs-3" id="remove" type="button" value="삭제" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;float: none;"/>
									<!-- <input class="search_btn col-xs-offset-1 col-xs-3" id="save" type="submit" value="저장" style="margin-left: 10px;float: none;"/> -->
								</c:if>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div><!-- array -->
		<div class="row table-row">
			<table class="table table-hover user-table" style="margin-bottom: 60px;">
				<tr style="position: sticky; top:0; left:0; z-index: 9;">
					<th rowspan="2"></th>
	        	    <th colspan="2">변&nbsp;동&nbsp;내&nbsp;용</th>
	        	    <th rowspan="2" style="vertical-align: middle;">변&nbsp;동&nbsp;사&nbsp;유</th>
	        	    <th rowspan="2" style="vertical-align: middle;">비&nbsp;&nbsp;&nbsp;&nbsp;고</th>
	        	    <th rowspan="2" style="vertical-align: middle; width: 213px;">등&nbsp;&nbsp;&nbsp;&nbsp;록&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;&nbsp;&nbsp;자</th>
	        	</tr>
	        	<tr>
	        		<th>구&nbsp;&nbsp;&nbsp;&nbsp;분</th>
	        		<th>변&nbsp;&nbsp;&nbsp;&nbsp;동&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;&nbsp;&nbsp;자</th>
	        	</tr>
				<tr data-modify="false">
					<td colspan="9" style="text-align: center;">검색 조건을 선택 후 검색해주세요.</td>
				</tr>
			</table>
		</div><!-- board -->
	</div>
</div>
<script>
function spanDoubleClick(e) {
	var _this = $(e)[0];
	if($(_this).parent().data('mod') == 'span') {
		$(_this).parent().data('mod','input')
		$(_this).hide();
		$(_this).parent().find('input').val($(_this).text());
		$(_this).parent().find('input').show();
		$(_this).parent().parent().data('modify', 'true')
	} 
}

function inputDoubleClick(e) {
	var _this = $(e)[0];
	if($(_this).parent().data('mod') == 'input') {
		$(_this).parent().data('mod', 'span');
		$(_this).hide();
		$(_this).parent().find('span').text($(_this).val());
		$(_this).parent().find('span').show();
	}
}
	$(document).ready(function() {
		var globalData;

		$('#addBtn').click(function() {
			$('#chgReason').val("");
			$('#bigo').val("");
			$('#workDt').val("");
			$('#workTm').val("");
			$('#swHwTp').val("선택").attr("selected", "selected");
			$('#chgTp').val("선택").attr("selected", "selected");
		})

		// 검색
		$('.ware_search_btn').click(function(e) {
			e.preventDefault();

			var data = $('#searchForm').serializeObject();
			var flag = true;
			globalData = data;
			$.each(data, function(a,b) {
				if(a == "swHwTp" || a == "chgTp") {
					if(b == "선택") {
						alertify.alert("에러", "검색 조건을 확인해주세요.");
						flag = false;

					}
				} else if(a!="equiInfoKey" && b.length == 0) {
					alertify.alert("에러", "검색 조건을 확인해주세요.");
					flag = false;

				} 
			})

			if(flag) {
				var to = $('#to').val();
				var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2);
				var from = $('#from').val();
				var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2);

				data['toDate'] = toDate;
				data['fromDate'] = fromDate;
				$.ajax({
					url: '/api/admin/ware/search',
					type: 'GET',
					data: data,
					success: function(r) {
						if(r == ""){
							alert("데이터가 없습니다.");
						}
						var text = 
						'	<tbody><tr style="position: sticky; top:0; left:0; z-index: 9;">'+
						'		<th rowspan="2"></th>'+
						'   	<th colspan="3">변&nbsp;동&nbsp;내&nbsp;용</th>'+
						'   	<th rowspan="2" style="vertical-align: middle;">변&nbsp;동&nbsp;사&nbsp;유</th>'+
						'   	<th rowspan="2" style="vertical-align: middle;">비&nbsp;&nbsp;&nbsp;&nbsp;고</th>'+
						'   	<th rowspan="2" style="vertical-align: middle; width: 213px;">등&nbsp;&nbsp;&nbsp;&nbsp;록&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;&nbsp;&nbsp;자</th>'+								
						'	</tr>' +
						'	<tr>' +
						'		<th>기&nbsp;기&nbsp;명</th>'+
						'		<th>구&nbsp;&nbsp;&nbsp;&nbsp;분</th>'+
						'		<th>변&nbsp;&nbsp;&nbsp;&nbsp;동&nbsp;&nbsp;&nbsp;&nbsp;일&nbsp;&nbsp;&nbsp;&nbsp;자</th>'+
						'	</tr>';

						if (r.length == 0) {
							text += '<tr data-modify="false">' +
									'	<td colspan="9" style="text-align: center;">데이터가 없습니다.</td>' +
									'	</tr>';
						}

						$.each(r, function(a, b) {
							// var year = b.workDt.substr(0,4);
							// var month = b.workDt.substr(4,2);
							// var day = b.workDt.substr(6,2);
							// var hour = b.workTm.substr(0,2);
							// var minutes = b.workTm.substr(2,2);
							// var yyyymmddhhss = year+"-"+month+"-"+day+" "+hour+":"+minutes;
	
							text += 
							'<tr data-modify="false">'+						
							'	 <td><label style="padding-top: 30px;" class="col-xs-offset-1 choice-label"><input style="line-height: 70px;" class="setYn" type="checkbox"><i></i></label></td>'+
							'	 <td data-mod="span"<span style="line-height: 70px;">'+b.equiInfoKey+'</span><input ondblclick="" type="text" name="equiInfoKey" value="'+b.equiInfoKey+'" style="display:none;"/></td>'+
							'    <td data-mod="span"><span style="line-height: 70px;">'+b.chgTp+'</span><input ondblclick="" type="text" name="chgTp" value="'+b.chgTp+'" style="display:none;"/></td>'+
							'    <td data-mod="span"><span style="line-height: 70px;">'+b.workDt+'</span><input ondblclick="" name="workDt" type="text" value="'+b.workDt+'" style="display:none;"/></td>'+
							'    <td data-mod="span"><pre style="height:70px; overflow: auto; text-align: left;">'+b.chgReason+'</pre><input ondblclick="" type="text" name="chgReason" value="'+b.chgReason+'" style="display:none;"/></td>'+
							'    <td data-mod="span"><pre style="height:70px; overflow: auto; text-align: left;">'+b.bigo+'</pre><input ondblclick="" type="text" name="bigo" value="'+b.bigo+'" style="display:none;"/></td>'+
							'    <td data-mod="span"><span style="line-height: 70px;">'+b.workYmd+'</span><input ondblclick="" type="text" name="workYmd" value="'+b.workYmd+'" style="display:none;"/></td>'+
							'</tr>';

						})

						$('.user-table').html(text+"</tbody>");
					}
				})
			}
				

		})
		
		// 수정
		/* $('#save').click(function(e) {
			e.preventDefault();
			$('.user-table tr td').each(function(a,b){
				if($(this).data('mod') == "input") {
					inputDoubleClick($(this).find('input'))
				}
			})

			var deptData = $('#searchForm').serializeObject();
			var to = $('#to').val();
			var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
			var from = $('#from').val();
			var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)
			// deptData['toDate'] = toDate;
			// deptData['fromDate'] = fromDate;
			var data = [];
			
			$.each($('.user-table tr'), function(a,b){
				if($(b).data('modify') == 'true') {
					var setData = {};

					$.each($(b).find('td'), function(c,d) {
						
						var d = $(this).find('input').val();
						if(d.length == 0) {
							d = $(this).find('span').text();
						}

						if($($(this).find('input'))[0].name == "workDt") {
							var wdt = d;
							var workDt = wdt.substr(0,4)+wdt.substr(6,2)+wdt.substr(9,2)
							var workTm = wdt.substr(13,2)+wdt.substr(17,2)
							setData['workDt'] = workDt;
							setData['workTm'] = workTm;
							
						} else {
							if($($(this).find('input'))[0].name != "") {
								setData[$($(this).find('input'))[0].name] = d  

							}

						}
					})
					setData['chgTp'] = deptData['chgTp']
					data.push(setData)
				}
			})

			console.log("DATA : ", data);

			$.ajax({
				url: '/api/admin/ware/update',
				type: 'POST',
				data: JSON.stringify(data),
				headers: {
			        'Content-Type':'application/json'
			    },
				success: function(r) {
					if(r.result == "success") {
						alertify.alert("성공", "정보가 수정되었습니다.");
					} else {
						alertify.alert("실패", "정보 수정을 실패하였습니다.");
					}
				}
			})
		}) */
		
		// 삭제
		$('#remove').click(function() {
			alertify.confirm("경고", "선택한 정보를 삭제하시겠습니까?", function(){
				var data = [];
				
				var wdt,workDt,workTm;
				for(var i=2; i <$('table tr').size(); i++){
					if($('table tr').eq(i).children().find('input[type="checkbox"]').is(':checked')){
							console.log("i값: " + i);
							var setData = {};
							setData['equiInfoKey'] =  $('table tr').eq(i).find('input[type="text"]').eq(0).val();
							setData['chgTp'] = $('table tr').eq(i).find('input[type="text"]').eq(1).val();
							setData['chgReason'] = $('table tr').eq(i).find('input[type="text"]').eq(3).val();
							setData['bigo'] = $('table tr').eq(i).find('input[type="text"]').eq(4).val();
							setData['workYmd'] = $('table tr').eq(i).find('input[type="text"]').eq(5).val();
							
							var wdt = $('table tr').eq(i).find('input[type="text"]').eq(2).val();
							workDt = workDt = wdt.substr(0,4)+wdt.substr(5,2)+wdt.substr(8,2);
							workTm = wdt.substr(11,2)+wdt.substr(14,2);
							setData['workDt'] = workDt;
							setData['workTm'] = workTm;

							data.push(setData);
							
					}
					
				}console.log("data : " + data);
			
				// var deptData = $('#searchForm').serializeObject();
				// $('.setYn').each(function(){
				//     if($(this).prop('checked')) {
				//     	var setData = {};
				// 		$.each($(this).parent().parent().parent().find('td'), function(c,d) {
				// 			var d = $(this).find('input').val();
				// 			if(d.length == 0) {
				// 				d = $(this).find('span').text();
				// 			}
				// 			if($($(this).find('input'))[0].name == "workDt") {
				// 				var wdt = d;
				// 				var workDt = wdt.substr(0,4)+wdt.substr(6,2)+wdt.substr(9,2)
				// 				var workTm = wdt.substr(13,2)+wdt.substr(17,2)
				// 				setData['workDt'] = workDt;
				// 				setData['workTm'] = workTm;
								
				// 			} else {
				// 				if($($(this).find('input'))[0].name != "") {
				// 					setData[$($(this).find('input'))[0].name] = d  
				// 				}
				// 			}
				// 		})

				// 		// setData['workDt'] = globalData['workDt']
				// 		// setData['workTm'] = globalData['workTm']
				// 		// setData['chgTp'] = globalData['chgTp']
				// 		//
						
				// 	}
				// })

				console.log("DATA : ", data);

				$.ajax({
					url: '/api/admin/ware/delete',
					type: 'POST',
					data: JSON.stringify(data),
					headers: {
				        'Content-Type':'application/json'
				    },
					success: function(r) {
						if(r.result == "success") {
							alertify.alert("성공", "해당 정보가 삭제되었습니다.");
							$('.setYn').each(function(){
							    if($(this).prop('checked')) {
							    	$(this).parent().parent().parent().remove();	
							    }
						    })
						} else {
							alertify.alert("실패", "정보 삭제를 실패하였습니다.");
						}
					}
				})
			}, function() {
				alertify.error('취소되었습니다.')
			})
		})

		function parse(str) {
		    var y = str.substr(0, 4);
		    var m = str.substr(5, 2);
		    var d = str.substr(8, 2);
		    return new Date(y,m-1,d);
		}
		$('#export').click(function() {
			var to = $('#to').val();
			var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2);
			var from = $('#from').val();
			var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2);
			var instCd = $('select[name=instCd]').val();

			var data = $('#searchForm').serializeObject();
			var flag = true;
			$.each(data, function(a,b) {
				if(a == "swHwTp" || a == "chgTp") {
					if(b == "선택") {
						alertify.alert("에러", "검색 조건을 확인해주세요.");
						flag = false;

					}
				} else if(b.length == 0) {
					alertify.alert("에러", "검색 조건을 확인해주세요.");
					flag = false;

				} 
			})
			if(flag) {
				var title = "";
				$('#opt1 option').each(function(a,b) {
					if($('#opt1').val() == $(b).val()) {
						title = $(b).text();
					}
				})
				var options = 'top=0, left=0, width=0, height=0, status=no, menubar=no, toolbar=no, resizable=no';
				window.open('/api/admin/ware/excel?toDate='+toDate+'&fromDate='+fromDate+'&swHwTp='+$('#opt1').val()+'&chgTp='+$('#opt2').val()+'&equiInfoKey='+$('#equiInfoKey').val()+'&title='+title, '다운로드', options);
			}
		})
	})
</script>
<jsp:include page="./wareModal.jsp"></jsp:include>
<jsp:include page="./wareAddModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>