<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<script src="/share/js/page.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
<script src="/share/js/bootstrap-datetimepicker.js"></script>
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<style>
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
.bootstrap-datetimepicker-widget {
  list-style: none;
}
.bootstrap-datetimepicker-widget.dropdown-menu {
  margin: 2px 0;
  padding: 4px;
  width: 19em;
}
@media (min-width: 2px) {
  .bootstrap-datetimepicker-widget.dropdown-menu.timepicker-sbs {
    width: 38em;
  }
}
@media (min-width: 992px) {
  .bootstrap-datetimepicker-widget.dropdown-menu.timepicker-sbs {
    width: 38em;
  }
}
@media (min-width: 1200px) {
  .bootstrap-datetimepicker-widget.dropdown-menu.timepicker-sbs {
    width: 38em;
  }
}
.bootstrap-datetimepicker-widget.dropdown-menu:before,
.bootstrap-datetimepicker-widget.dropdown-menu:after {
  content: '';
  display: inline-block;
  position: absolute;
}
.bootstrap-datetimepicker-widget.dropdown-menu.bottom:before {
  border-left: 7px solid transparent;
  border-right: 7px solid transparent;
  border-bottom: 7px solid #cccccc;
  border-bottom-color: rgba(0, 0, 0, 0.2);
  top: -7px;
  left: 7px;
}
.bootstrap-datetimepicker-widget.dropdown-menu.bottom:after {
  border-left: 6px solid transparent;
  border-right: 6px solid transparent;
  border-bottom: 6px solid white;
  top: -6px;
  left: 8px;
}
.bootstrap-datetimepicker-widget.dropdown-menu.top:before {
  border-left: 7px solid transparent;
  border-right: 7px solid transparent;
  border-top: 7px solid #cccccc;
  border-top-color: rgba(0, 0, 0, 0.2);
  bottom: -7px;
  left: 6px;
}
.bootstrap-datetimepicker-widget.dropdown-menu.top:after {
  border-left: 6px solid transparent;
  border-right: 6px solid transparent;
  border-top: 6px solid white;
  bottom: -6px;
  left: 7px;
}
.bootstrap-datetimepicker-widget.dropdown-menu.pull-right:before {
  left: auto;
  right: 6px;
}
.bootstrap-datetimepicker-widget.dropdown-menu.pull-right:after {
  left: auto;
  right: 7px;
}
.bootstrap-datetimepicker-widget .list-unstyled {
  margin: 0;
}
.bootstrap-datetimepicker-widget a[data-action] {
  padding: 6px 0;
}
.bootstrap-datetimepicker-widget a[data-action]:active {
  box-shadow: none;
}
.bootstrap-datetimepicker-widget .timepicker-hour,
.bootstrap-datetimepicker-widget .timepicker-minute,
.bootstrap-datetimepicker-widget .timepicker-second {
  width: 54px;
  font-weight: bold;
  font-size: 1.2em;
  margin: 0;
}
.bootstrap-datetimepicker-widget button[data-action] {
  padding: 6px;
}
.bootstrap-datetimepicker-widget .btn[data-action="incrementHours"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Increment Hours";
}
.bootstrap-datetimepicker-widget .btn[data-action="incrementMinutes"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Increment Minutes";
}
.bootstrap-datetimepicker-widget .btn[data-action="decrementHours"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Decrement Hours";
}
.bootstrap-datetimepicker-widget .btn[data-action="decrementMinutes"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Decrement Minutes";
}
.bootstrap-datetimepicker-widget .btn[data-action="showHours"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Show Hours";
}
.bootstrap-datetimepicker-widget .btn[data-action="showMinutes"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Show Minutes";
}
.bootstrap-datetimepicker-widget .btn[data-action="togglePeriod"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Toggle AM/PM";
}
.bootstrap-datetimepicker-widget .btn[data-action="clear"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Clear the picker";
}
.bootstrap-datetimepicker-widget .btn[data-action="today"]::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Set the date to today";
}
.bootstrap-datetimepicker-widget .picker-switch {
  text-align: center;
}
.bootstrap-datetimepicker-widget .picker-switch::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Toggle Date and Time Screens";
}
.bootstrap-datetimepicker-widget .picker-switch td {
  padding: 0;
  margin: 0;
  height: auto;
  width: auto;
  line-height: inherit;
}
.bootstrap-datetimepicker-widget .picker-switch td span {
  line-height: 2.5;
  height: 2.5em;
  width: 100%;
}
.bootstrap-datetimepicker-widget table {
  width: 100%;
  margin: 0;
}
.bootstrap-datetimepicker-widget table td,
.bootstrap-datetimepicker-widget table th {
  text-align: center;
  border-radius: 4px;
}
.bootstrap-datetimepicker-widget table th {
  height: 20px;
  line-height: 20px;
  width: 20px;
}
.bootstrap-datetimepicker-widget table th.picker-switch {
  width: 145px;
}
.bootstrap-datetimepicker-widget table th.disabled,
.bootstrap-datetimepicker-widget table th.disabled:hover {
  background: none;
  color: #777777;
  cursor: not-allowed;
}
.bootstrap-datetimepicker-widget table th.prev::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Previous Month";
}
.bootstrap-datetimepicker-widget table th.next::after {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
  content: "Next Month";
}
.bootstrap-datetimepicker-widget table thead tr:first-child th {
  cursor: pointer;
}
.bootstrap-datetimepicker-widget table thead tr:first-child th:hover {
  background: #eeeeee;
}
.bootstrap-datetimepicker-widget table td {
  height: 54px;
  line-height: 54px;
  width: 54px;
}
.bootstrap-datetimepicker-widget table td.cw {
  font-size: .8em;
  height: 20px;
  line-height: 20px;
  color: #777777;
}
.bootstrap-datetimepicker-widget table td.day {
  height: 20px;
  line-height: 20px;
  width: 20px;
}
.bootstrap-datetimepicker-widget table td.day:hover,
.bootstrap-datetimepicker-widget table td.hour:hover,
.bootstrap-datetimepicker-widget table td.minute:hover,
.bootstrap-datetimepicker-widget table td.second:hover {
  background: #eeeeee;
  cursor: pointer;
}
.bootstrap-datetimepicker-widget table td.old,
.bootstrap-datetimepicker-widget table td.new {
  color: #777777;
}
.bootstrap-datetimepicker-widget table td.today {
  position: relative;
}
.bootstrap-datetimepicker-widget table td.today:before {
  content: '';
  display: inline-block;
  border: 0 0 7px 7px solid transparent;
  border-bottom-color: #337ab7;
  border-top-color: rgba(0, 0, 0, 0.2);
  position: absolute;
  bottom: 4px;
  right: 4px;
}
.bootstrap-datetimepicker-widget table td.active,
.bootstrap-datetimepicker-widget table td.active:hover {
  background-color: #337ab7;
  color: #ffffff;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
}
.bootstrap-datetimepicker-widget table td.active.today:before {
  border-bottom-color: #fff;
}
.bootstrap-datetimepicker-widget table td.disabled,
.bootstrap-datetimepicker-widget table td.disabled:hover {
  background: none;
  color: #777777;
  cursor: not-allowed;
}
.bootstrap-datetimepicker-widget table td span {
  display: inline-block;
  width: 54px;
  height: 54px;
  line-height: 54px;
  margin: 2px 1.5px;
  cursor: pointer;
  border-radius: 4px;
}
.bootstrap-datetimepicker-widget table td span:hover {
  background: #eeeeee;
}
.bootstrap-datetimepicker-widget table td span.active {
  background-color: #337ab7;
  color: #ffffff;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
}
.bootstrap-datetimepicker-widget table td span.old {
  color: #777777;
}
.bootstrap-datetimepicker-widget table td span.disabled,
.bootstrap-datetimepicker-widget table td span.disabled:hover {
  background: none;
  color: #777777;
  cursor: not-allowed;
}
.bootstrap-datetimepicker-widget.usetwentyfour td.hour {
  height: 27px;
  line-height: 27px;
}
.bootstrap-datetimepicker-widget.wider {
  width: 21em;
}
.bootstrap-datetimepicker-widget .datepicker-decades .decade {
  line-height: 1.8em !important;
}
.input-group.date .input-group-addon {
  cursor: pointer;
}
</style>
<script type='text/javascript'>
$(function(){
    $('#workDt').datepicker({
        calendarWeeks: false,
        todayHighlight: true,
        autoclose: true,
        format: "yyyy/mm/dd",
        language: 'kr'
    });
    
    $('#workTm').datetimepicker({
        format: "HHmm",
    });

});

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
			<h1 class="main_co">관리부서 관리</h1>
		</div>
		<div class="row array">
					
			<div class="col-xs-12">
				<form id="searchForm">
					<div class="form-group">
						<ul class="row">
							<li class="col-xs-1 title">기간</li>
							<li class="col-xs-3">
								<div class="col-xs-5">
									<input data-flag="false" autocomplete=off type="text" name="toDate" id="to" placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
								</div>
								<div class="col-xs-2" style="text-align: center; line-height: 30px;">
									~
								</div>
								<div class="col-xs-5">
									<input data-flag="false" autocomplete=off type="text" name="fromDate" id="from" placeholder="날짜선택" class="form-control"><span style="display: none;" class="input-group-addon"></span>
								</div>
							</li>
							<li class="col-xs-1 title">기관</li>
							<li class="col-xs-1">
								<select id="opt1" name="instCd">
									<option value="all">전체</option>
									<c:forEach items="${orga }" var="orga">
										<option value="${orga.code}">${orga.relCd1 }</option>
									</c:forEach>
								</select>
								
							</li>
							<li class="col-xs-1">
								<input class="depart_search_btn search_btn" type="submit" value="검색">
							</li>
						</ul>
						<div class="row array">
							<div class="col-xs-8" id="equiName" style="line-height: 30px;">
							</div>
							<div class="col-xs-4" style="float:right;text-align:right;">
								<c:if test="${grant eq 'Y'}">
									<input class="search_btn col-xs-offset-1 col-xs-2" id="export" type="button" value="Export" style="background: white; color: #666; border: 1px solid #c9c9c9; float: none;"/>
									<input class="search_btn col-xs-2" type="button" data-toggle="modal" data-target=".upload" value="다중 추가" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9; float:right;float: none;"/>
									<input class="search_btn col-xs-offset-1 col-xs-2" type="button" data-toggle="modal" data-target=".detail" value="추가" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9; float:right;float: none;"/>
									<input class="search_btn col-xs-offset-1 col-xs-2" id="remove" type="button" value="삭제" style="margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;float:right;float: none;"/>
									<input class="search_btn col-xs-offset-1 col-xs-2" id="save" type="submit" value="저장" style="margin-left: 10px;float:right;float: none;"/>
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
	        	    <th></th>
	        	    <th>날짜</th>
	        	    <th>관리자(정)</th>
	        	    <th>전화번호</th>
	        	    <th>관리자(부)</th>
	        	    <th>전화번호</th>
	        	    <th>변경내역</th>
	        	    <th>변경사유</th>
	        	    <th>비고</th>
	        	</tr>
				<!-- #data input -->
				<tr data-modify="false">
					<td colspan="9" style="text-align: center;">검색 조건을 선택 후 검색해주세요.</td>
				</tr>
				
				<!-- data input# -->
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
		$('.depart_search_btn').click(function(e) {
			e.preventDefault();
			
			var data = $('#searchForm').serializeObject();
			var flag = true;
			globalData = data;
			$.each(data, function(a,b) {
				// if(a == "instCd" || a == "deptCd" || a == "superDeptCd") {
				// 	if(b != "전체") {
				// 		alertify.alert("에러", "비어있는 값이 있습니다.")
				// 		flag = false;
				// 	}
				// } else 
				if(b.length == 0) {
					alertify.alert("에러", "비어있는 값이 있습니다.")
					flag = false;
				} 
				
			})
			if(flag) {
				var to = $('#to').val();
				var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
				var from = $('#from').val();
				var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)
				data['toDate'] = toDate;
				data['fromDate'] = fromDate;
				$.ajax({
					url: '/api/admin/mngDept/search',
					type: 'GET',
					data: data,
					success: function(r) {
						if (r.length == 0) {
							alert("조건에 만족하는 데이터가 없습니다.");
						}

						console.log(r);
						var text = '<tr style="position: sticky; top:0; left:0; z-index: 9;">'+
						'    <th></th>'+
						'    <th>날짜</th>'+
						'    <th>관리자(정)</th>'+
						'    <th>전화번호</th>'+
						'    <th>관리자(부)</th>'+
						'    <th>전화번호</th>'+
						'    <th>변경내역</th>'+
						'    <th>변경사유</th>'+
						'    <th>비고</th>'+
						'</tr>';
						$.each(r, function(a, b) {
							var year = b.workDt.substr(0,4);
							var month = b.workDt.substr(4,2);
							var day = b.workDt.substr(6,2);
							var hour = b.workTm.substr(0,2);
							var minutes = b.workTm.substr(2,2);
							text += '<tr data-modify="false">'+
							'	 <td><label class="col-xs-offset-1 choice-label"><input class="setYn" type="checkbox"><i></i></label></td>'+
							'    <td data-mod="span"><span>'+year+'년 '+month+'월'+day+'일 '+hour+'시 '+minutes+'분</span><input ondblclick="inputDoubleClick(this)" type="text" name="workDt" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.mngNmJung+'</span><input ondblclick="inputDoubleClick(this)" name="mngNmJung" type="text" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.mngNmJungTel+'</span><input ondblclick="inputDoubleClick(this)" type="text" name="mngNmJungTel" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.mngNmBu+'</span><input ondblclick="inputDoubleClick(this)" type="text" name="mngNmBu" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.mngNmBuTel+'</span><input ondblclick="inputDoubleClick(this)" type="text" name="mngNmBuTel" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.chgContent+'</span><input ondblclick="inputDoubleClick(this)" type="text" name="chgContent" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.chgReason+'</span><input ondblclick="inputDoubleClick(this)" type="text" name="chgReason" style="display:none;"/></td>'+
							'    <td data-mod="span"><span ondblclick="spanDoubleClick(this)">'+b.bigo+'</span><input ondblclick="inputDoubleClick(this)" type="text" name="bigo" style="display:none;"/><input type="hidden" name="instCd" value="'+b.instCd+'"><input type="hidden" name="superDeptCd" value="'+b.superDeptCd+'"><input type="hidden" name="deptCd" value="'+b.deptCd+'"></td>'+
							'</tr>';
						})
						$('.user-table').html(text);
					}
				})
			}
			
		})
		
		
		$('#save').click(function(e){
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
			deptData['toDate'] = toDate;
			deptData['fromDate'] = fromDate;
			console.log(deptData)
			var data = [];
			
			
			$.each($('.user-table tr'), function(a,b){ 
				if($(b).data('modify') == 'true') {
					var setData = {};
					console.log($(b).find('td'))
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
						setData['deptCd'] = $(this).find('input[name=deptCd]').val();
						setData['instCd'] = $(this).find('input[name=instCd]').val();
						setData['superDeptCd'] = $(this).find('input[name=superDeptCd]').val();
						
					})
					
					setData['toDate'] = deptData['toDate']
					setData['fromDate'] = deptData['fromDate']
					data.push(setData)
				}
			})
			$.ajax({
				url: '/api/admin/mngDept/update',
				type: 'POST',
				data: JSON.stringify(data),
				headers: {
			        'Content-Type':'application/json'
			    },
				success: function(r) {
					console.log(r)
					if(r.result == "success") {
						alertify.alert("성공", "정보가 수정되었습니다.");
					} else {
						alertify.alert("실패", "정보 수정을 실패하였습니다.");
					}
				}
			})
			console.log(data)
		})
		
		$('#remove').click(function() {
			alertify.confirm("경고", "선택한 정보를 삭제하시곘습니까?", function(){
				var data = [];
				var deptData = $('#searchForm').serializeObject();
				$('.setYn').each(function(){
				    if($(this).prop('checked')) {
				    	var setData = {};
						$.each($(this).parent().parent().parent().find('td'), function(c,d) {
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
							
							setData['deptCd'] = $(this).find('input[name=deptCd]').val();
							setData['instCd'] = $(this).find('input[name=instCd]').val();
							setData['superDeptCd'] = $(this).find('input[name=superDeptCd]').val();
						})
						data.push(setData)
				    }
				})
				console.log(data, globalData);
				$.ajax({
					url: '/api/admin/mngDept/delete',
					type: 'POST',
					data: JSON.stringify(data),
					headers: {
				        'Content-Type':'application/json'
				    },
					success: function(r) {
						console.log(r)
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

		$('#export').click(function() {
			var to = $('#to').val();
			var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2);
			var from = $('#from').val();
			var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2);
			var instCd = $('select[name=instCd]').val();

			var data = $('#searchForm').serializeObject();
			var flag = true;
			$.each(data, function(a,b) {
				// if(a == "instCd" || a == "deptCd" || a == "superDeptCd") {
				// 	if(b != "전체") {
				// 		alertify.alert("에러", "비어있는 값이 있습니다.")
				// 		flag = false;
				// 	}
				// } else 
				if(b.length == 0) {
					alertify.alert("에러", "비어있는 값이 있습니다.")
					flag = false;
				} 
				
			})
			if(flag) {
				var options = 'top=0, left=0, width=0, height=0, status=no, menubar=no, toolbar=no, resizable=no';
				window.open('/api/admin/mngDept/excel?toDate='+toDate+'&fromDate='+fromDate+'&instCd='+instCd, '다운로드', options);
			}
			// $.ajax({
			// 	url: '/api/admin/mngDept/excel',
			// 	method: 'post',
			// 	data: {
			// 			toDate:toDate,
			// 			fromDate:fromDate,
			// 			instCd:instCd,
			// 		},
			// 	success: function(data, status, xhr) {
			// 		var filename = xhr.getResponseHeader("X-Filename");
			// 		var _blob = new Blob([data], {type : 'Application/Msexcel'});
			// 		var link = document.createElement('a');
			// 		link.href = window.URL.createObjectURL(_blob);
			// 		// link.download = 'text.xlsx';
			// 		link.download = filename;
			// 		link.click();
			// 	}
			// })
		})
	})
</script>
<jsp:include page="./departModal.jsp"></jsp:include>
<jsp:include page="./departAddModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>