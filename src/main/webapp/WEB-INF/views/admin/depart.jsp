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
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css"/>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js" type="text/javascript" ></script>

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
.historyTable thead tr th{
    font-family: "Noto Sans KR", sans-serif !important;
	   text-align: center;
	   color: #0c82e9;
	   border-top: 1px solid #0c82e9;
	   border-bottom: 1px solid #0c82e9;
	   background: #f3f9fe;
	   padding: 10px;
     font-size: 1.11em;
	}

  .historyTable tbody td{
    font-family: "Noto Sans KR", sans-serif !important;
    color: #000000;
		height: 22px;
    text-align: center;
		border-bottom: 1px solid #d7d7d7;
	}
  
  .dataTables_empty{
    border-bottom: 1px solid #d7d7d7;
  }

  input[type=search]{
    margin-bottom: 10px;
    float : right;
    width:122px;
  }
  select[name=historyTable_length]{
    width:57px;
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
			<h1 class="main_co">사용자 접속현황</h1>
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
														
							<li class="col-xs-1">
								<input id="userSearch" class="search_btn" type="submit" value="검색">
							</li>
						</ul>
						<!-- <div class="row array">	
							<div class="col-xs-4" style="float:right;text-align:right;">
								<c:if test="${grant eq 'Y'}">
									<input class="col-xs-offset-1 col-xs-2" id="csvDownload" type="button" value="CSV" style="background: white; color: #666; border: 1px solid #c9c9c9; float: none;"/>
								</c:if>
							</div>
						</div> -->
					</div>
				</form>
			</div>
		</div><!-- array -->
		<div class="row col-xs-10 ">
      <div class="col-xs-5" style="float:right;text-align:right;padding-bottom: 10px;">
        <c:if test="${grant eq 'Y'}">
          <input class="col-xs-offset-1 col-xs-3" id="csvDownload" type="button" value="CSV 다운로드" style="background: #f3f9fe; color: #0c82e9; border: 1px solid #0c82e9; float: none;"/>
        </c:if>
      </div>
     
      <!-- <table class="table table-hover user-table" table id="historyTable" style="margin-bottom: 60px;">
      <thead>
        <tr>
         <th style="width:33%"> 사용자 ID </th>
         <th style="width:33%"> 이름</th>
         <th style="width:33%"> 접속일시 </th>
        </tr>
       </thead>
       <tbody>
        <tr><td colspan="3"> 데이터가 없습니다.</td></tr>
      
       </tbody>
      </table> -->
     
     
      <table id="historyTable"  class="historyTable" >
				<thead>
				 <tr>
					<th> 사용자 ID </th>
					<th> 이름</th>
					<th> 접속일시 </th>
				 </tr>
				</thead>
	
				
			</table>
      
			</div>
	
	</div>
</div>
<script>
	
	$(document).ready(function() {
		
		var globalData;
		$('#userSearch').click(function(e) {
			e.preventDefault();
			var data = $('#searchForm').serializeObject();
			var flag = true;
			globalData = data;
			$.each(data, function(a,b) {
				if(b.length == 0) {
					alertify.alert("에러", "비어있는 값이 있습니다.")
					flag = false;
				} 
			})
			if(flag) {
				var to = $('#to').val();
				var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2);
				var from = $('#from').val();
				var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)+'2359';

				data['toDate'] = toDate;
				data['fromDate'] = fromDate; 

        //datatable 사용을 위한 ajax 
        $('#historyTable').DataTable().destroy();
        $('#historyTable').DataTable({
          language : lang_kor,
          ajax:{
            url: '/api/admin/user/history',
			      type: 'GET',
				    data: data
          },		 
			    columns:[
               {data : 'userId'},
               {data : 'userName'},
               {data : 'regDate'}
             ]
					
    });





				// $.ajax({
				//  	url: '/api/admin/user/history',
				//  	type: 'GET',
				//  	data: data,
				//  	success: function(r) {
				//  		if (r.length == 0) {
				//  			alert("조건에 만족하는 데이터가 없습니다.");
				//  		}
        //      var text;
        //      $.each(r.data, function(a,b) {
				// 	    console.log(b);
				//   	if(b.etc == null) {
				// 	  	b.etc = ''
				// 	  }
					  
        //     text += 
        //     '<tr>'+
				// 		'    <td>'+b.userId+'</td>'+
				// 		'    <td>'+b.userName+'</td>'+
				// 		'    <td>'+b.regDate+'</td></tr>';
        //     $('#historyTable tbody').html(text);
			  // 	})



				// 	},error:function(request,error){
				// 		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				// 	}
				//  })
			}
			
		})
		

    function getCSV(filename,date){
      var csv = [];
      var row = [];
      $.ajax({
				 	url: '/api/admin/user/history',
				 	type: 'GET',
          async:false,
				 	data: date,
				 	success: function(r) {
				 		
            if (r.length == 0) {
				 			alert("데이터를 불러오지 못했습니다.");
				 		}
            
          
            //csv로 만들기
            row.push("번호");
            row.push("사용자ID");
            row.push("이름");
            row.push("접속일시");  
            csv.push(row.join(","));

            $.each(r.data, function(a,b) {
              var row2 = [];
              row2.push(a+1);
              row2.push(b.userId);
              row2.push(b.userName);
              row2.push(b.regDate);
              csv.push(row2.join(","));
            })
  
          }
    })
      
      downloadCSV(csv.join("\n"),filename)

    }

    //csv 다운로드
    function downloadCSV(csv,filename){
      var csvFile;
      var downloadLink;
      console.log(csv);
      
      //한글 처리를 해주기 위해 BOM 추가하기
      const BOM = "\uFEFF";
      csv = BOM + csv;

      csvFile = new Blob([csv],{type : "text/csv"});
      downloadLink = document.createElement("a");
      downloadLink.download = filename;
      downloadLink.href = window.URL.createObjectURL(csvFile);
      downloadLink.style.display = "none";
      document.body.appendChild(downloadLink);
      downloadLink.click();

    }

		$('#csvDownload').click(function() {
      var to = $('#to').val();
			var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2);
			var from = $('#from').val();
			var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2);
      var filename = toDate+"_"+fromDate+".csv";
      date = globalData;
      getCSV(filename,date);
    })
    
    var lang_kor = {
        "decimal" : "",
        "emptyTable" : "데이터가 없습니다.",
        "info" : "_START_ - _END_ (총 _TOTAL_ 명)",
        "infoEmpty" : "0명",
        "infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "_MENU_ 개씩 보기",
        "loadingRecords" : "로딩중...",
        "processing" : "처리중...",
        "search" : "검색 : ",
        "zeroRecords" : "검색된 데이터가 없습니다.",
        "paginate" : {
            "first" : "첫 페이지",
            "last" : "마지막 페이지",
            "next" : "다음",
            "previous" : "이전"
        },
        "aria" : {
            "sortAscending" : " :  오름차순 정렬",
            "sortDescending" : " :  내림차순 정렬"
        }
    };


    $('#historyTable').DataTable({
      language : lang_kor
    });

    
  
    
	})
</script>
<jsp:include page="./departModal.jsp"></jsp:include>
<jsp:include page="./departAddModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>