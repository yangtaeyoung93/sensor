<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
	min-height: 690px;
}
#tree li strong {
	cursor: pointer;
}
.tree {
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
	display: block;
	padding-bottom: 6px;
	border-bottom: 1px solid #c9c9c9;
}
.datagrid-header-inner {
	width: 100%;
}
.datagrid-btable tr, .datagrid-btable td, .datagrid-btable th {
	border: 1px solid #d9d9d9 !important;
	text-align: center !important;
	height: 35px !important;
}
.datagrid-row-checked {
    background:  #f9f9f9;
}
.datagrid-btable tbody tr td div, .datagrid-htable tbody tr td div {
	width: 100% !important;
}
.datagrid-htable tr, .datagrid-htable td, .datagrid-htable th {
	border: 1px solid #d9d9d9 !important;
	text-align: center !important;
	height: 35px !important;
}
.datagrid-htable th {
	background: #f3f9fe !important;
	border-top:1px solid #0c82e9 !important;
	background-clip: padding-box !important;
}
.datagrid-htable tbody tr td:first-child {
	background: #f3f9fe !important;
}

.datagrid-htable tbody tr {
	cursor: pointer !important;
}
.datagrid-view1 {
	display: none;
}
.datagrid-view2 {
	width: 100% !important;
}
.datagrid-view2 > div:first-child {
	width: 100% !important;
}

.panel.window.panel-htop.messager-window {
    position: absolute;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%);
    padding: 30px;
    border: 1px solid 
    #c9c9c9;
}
.messager-window {
	min-width: 351px !important;
}
</style>
<div id="sensor" class="body_wrap">
	
	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">공통 코드 관리</h1>
		</div>
		<!-- sub_title -->
		<div class="row">
			<div class="col-xs-2 tree">
				<ul id="tree">
					<c:forEach items="${codes}" var="code" varStatus="status">
						<li id="tree-${status.index}" data-code="${code.sortCd}"><strong>${code.sortCd}</strong></li>
					</c:forEach>
				</ul>
			</div>
			<div class="col-xs-10 info">
				<div class="info-wrap">
					<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
						<div class="col-xs-8" id="equiName" style="line-height: 30px;">
						</div>
						<div class="col-xs-4" id="toolbar">
							<input class="search_btn col-xs-2" type="button" plain="true" onclick="javascript:$('#dg').edatagrid('addRow')" value="추가" style="background: white; color: #666; border: 1px solid #c9c9c9;"/>
							<input class="search_btn col-xs-offset-1 col-xs-2" id="delete" plain="true" onclick="javascript:$('#dg').edatagrid('destroyRow')" type="button" value="삭제" style="margin-left: 40px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
							<input class="search_btn col-xs-offset-1 col-xs-2" id="save" plain="true" onclick="javascript:$('#dg').edatagrid('saveRow')" type="submit" value="저장" style="margin-left: 40px;"/>
							<input class="search_btn col-xs-offset-1 col-xs-2" id="save" plain="true" onclick="javascript:$('#dg').edatagrid('cancelRow')" type="submit" value="취소" style="margin-left: 40px;"/>
						</div>
					</div>
					<div class="row">
						
					    <table id="dg" style="width:1200px; min-height: 690px;"
					             pagination="false" idField="id"
					            rownumbers="false" fitColumns="true" singleSelect="true" class="datagrid-htable">
					        <thead>
					            <tr>
					                <th field="sortCd" width="126" editor="{type:'validatebox', options: {readonly: true}}" >구분코드</th>
					                <th field="sortNm" width="126" editor="{type:'validatebox'}" >구분이름</th>
					                <th field="code" width="126" editor="{type:'validatebox'}">코드</th>
									<th field="codeNm" width="126" editor="{type:'validatebox'}">코드명</th>
									<th field="relCd1" width="126" editor="{type:'validatebox'}">부가정보1</th>
									<th field="relCd2" width="126" editor="{type:'validatebox'}">부가정보2</th>
									<th field="relCd3" width="126" editor="{type:'validatebox'}">부가정보3</th>
									<th field="editYn" width="126" editor="{type: 'validatebox' }">수정여부</th>
									<th field="hideYn" width="126" editor="{type:'validatebox'}">사용여부</th>
									<th field="bigo" width="126" editor="{type:'validatebox'}">비고</th>
									<th field="workUser" width="126" editor="{type:'validatebox'}">작업자</th>
									<th field="workTime" width="126">수정날짜</th>
					            </tr>
					        </thead>
					    </table>

					    <script type="text/javascript">
					        $(function(){
					        	$('#dg').edatagrid({
					                url: '/api/setting/code/list/기기종류',
					                saveUrl: '/api/setting/code/save/'+$('.tree_s').text(),
					                updateUrl: '/api/setting/code/update',
					                destroyUrl: '/api/setting/code/remove',
					                text: {
					                    setValue: function(target, value){
					                        console.log()
					                    }
					                },
				                    onSuccess: function(index, row) {
				                    	console.log(index,row)
				                    	if(row.result == "success") {
				                    		alertify.alert(row.msg, function() {
				                    			$('#dg').edatagrid('reload');
				                    		});
				                    	}
				                    }
					            });
					        	console.log($('td[field=editYn]').text())
					        });
					        $('#button').click(function(){
					        	$('#dg').edatagrid({
					                url: '/api/setting/code/list/기기종류',
					                saveUrl: '/api/setting/code/save/'+$('.tree_s').text(),
					                updateUrl: '/api/setting/code/update',
					                destroyUrl: '/api/setting/code/remove'
					            });
					        	console.log($('td[field=editYn] > div').text())
					        })
					    </script>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
<script>
function infoSet(target) {
	var id = $(target)[0].id;
	$('#tree li').removeClass('tree_s');
	$('#tree li strong').removeClass('tree_s');
	$('#'+id).addClass('tree_s');
	$('.table-row').hide();
	userSet(target);
}
function userSet(target) {
	console.log($('#form').serializeObject())

	var user = $($(target)[0]).data('user');
	
	$.ajax({
		url: '/api/setting/user/info/'+user,
		type: 'GET',
		success: function(r) {
			console.log(r)
			$.each(r.data, function(a,b) {
				$.each(b, function(c, d) {
					if($('#'+c).length > 0) {
						console.log($('#'+c)[0].type)
						var type = $('#'+c)[0].type
						
						if(type == "text" || type == "email") {
							$('#'+c).val(d);
						} else if(type == "select-one") {
							$('#'+c).val(d);
						} else if(type == "textarea") {
							$('#'+c).html(d);
						}
					}
					
				})
			})
		}
	})
}

$(document).ready(function() {
	

	$('#tree li strong').on('click', function() {
		$('#reset').trigger('click');
		$('#etc').val('');
		$('li.tree_s').removeClass('tree_s');
		$('.table-row').show();
		$('#tree li strong').removeClass('tree_s');
		$(this).addClass('tree_s')
		var code = $(this).text();
		$('#dg').edatagrid({
            url: '/api/setting/code/list/' + code,
            saveUrl: '/api/setting/code/save/'+$('.tree_s').text(),
            updateUrl: '/api/setting/code/update',
            destroyUrl: '/api/setting/code/remove'
        });
	    $.extend($.fn.datagrid.defaults.editors, {
	        text: {

	            getValue: function(target){
	            	console.log(target)
	                return $(target).val();
	            },
	            setValue: function(target, value){
	            	console.log(target, value)
	                $(target).val(value);
	            },

	        }
	    });
	})
	
	
})

</script>
<jsp:include page="./userModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>