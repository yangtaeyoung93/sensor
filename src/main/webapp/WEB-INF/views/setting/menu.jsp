<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
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
	overflow: auto;
}
#tree li strong {
	cursor: pointer;
}
.tree {
	min-height: 690px;
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
	background: #f3f9fe;
	border-top:1px solid #0c82e9 !important;
	background-clip: padding-box;
}
.user-table tbody tr td:first-child {
	background: #f3f9fe;
}

.user-table tbody tr {
	cursor: pointer;
}

</style>
<div id="sensor" class="body_wrap">

	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">메뉴 권한 설정</h1>
		</div>
		<!-- sub_title -->
		<div class="row">
			<div class="col-xs-2 tree">
				<ul id="tree">
					<c:forEach items="${lists}" var="list" varStatus="status">
						<li id="tree-${status.index}" data-code="${list.code}"><strong>${list.code}</strong></li>

						<script>

						
						function depth(arr) {
							var text = "<ul>"
							$.each(arr, function(a,b) {
								text += '<li style="cursor: pointer;" onclick="infoSet(this);" data-user="'+a2[a]+'" id="'+b+'">'+b+'</li>';
							})
							text+="</ul>"
							$('#tree-${status.index}').append(text)
						}
						
						depth(a);
					</script>
					</c:forEach>
				</ul>
			</div>
			<div class="col-xs-10 info">
				<div class="info-wrap">
					
					<form id="form">
						<div class="form-group">
							<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
								<div class="col-xs-8" id="equiName" style="line-height: 30px;">

								</div>
								<div class="col-xs-4">
									<c:if test="${grant eq 'Y'}">
										<input class="search_btn col-xs-offset-1 col-xs-3" id="save" type="submit" value="저장" style="margin-left: 40px;"/>
									</c:if>
								</div>
							</div>
							<div class="row table-row">
								<table class="table table-hover user-table userset">
								    <thead style="position: sticky; top:0; ">
								      <tr>
								        <th style="width: 34px;"></th>
								        <th>사용자</th>
								        <th>소속</th>
								        <th>전화번호</th>
								        <th>휴대폰</th>
								        <th>담당정보</th>
								        <th>이메일</th>
								      </tr>
								    </thead>
								    <tbody>
								    </tbody>
								</table>
							</div>
							<div class="row col-xs-6 ">
									<table class="table table-hover user-table" style="overflow-x: hidden; overflow-y: auto; height: 100%;">
									    <thead>
									      <tr>
									        <th>메뉴명</th>
									        <th>메뉴주소</th>
									        <th>권한여부</th>
									        <th>쓰기권한</th>
									      </tr>
									    </thead>
									    <tbody id="grantMenu">
									    	
									    </tbody>
									</table>
							</div>
								
								
							
						</div>
						<input type="reset" id="reset" style="display:none;"/>
					</form>
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
		userId = user;
		$.ajax({
			url: '/api/setting/menu/info/'+user,
			type: 'GET',
			success: function(r) {
				console.log(r)
				var text = "";
				
				var userId = "";
				$.each(r.data, function(a,b) {
					console.log(b.menuId)
					text += 
						'<tr>'+
							'<td>'+b.caption+'</td>'+
							'<td>'+b.path+'</td>'
							if(b.grantYn == 'Y'){
								text += '<td><label class="choice-label"><input id="m'+b.menuId+'" name="m'+b.menuId+'" type="checkbox" checked><i></i></label></td>'
							} else {
								text += '<td><label class="choice-label"><input id="m'+b.menuId+'" name="m'+b.menuId+'" type="checkbox"><i></i></label></td>'
							}
							
							if(b.writeGrantYn == 'Y'){
								text += '<td><label class="choice-label"><input name="writeGrant" id="m'+b.menuId+'" type="checkbox" checked><i></i></label></td></tr>'
							} else {
								text += '<td><label class="choice-label"><input name="writeGrant" id="m'+b.menuId+'" type="checkbox"><i></i></label></td></tr>'
							}
							
					userId = b.userId
				})
				$('#grantMenu').data('user', userId);
				$('#grantMenu').html(text);
			}
		})
	}
$(document).ready(function() {
	
	
	$('#save').click(function(e) {
		e.preventDefault();
		var data2 = $('#form').serializeObject();
		console.log(data2);
		if($('#grantMenu').data('user') == 0) {
			alertify.alert('에러', '선택된 유저가 없습니다.')
		} else {
			data2["userId"] = $('#grantMenu').data('user');
			$.each($('#grantMenu').find('input'), function(a, b) {

				if ($(b)[0].name == "writeGrant") {
					if($(b)[0].checked) {
						data2[$(b)[0].id] = checkStore + 'Y';
					} else {
						data2[$(b)[0].id] = checkStore + 'N';
					}
				} else {
					if($(b)[0].checked) {
						checkStore = 'Y_';
					} else {
						checkStore = 'N_';
					}
				}
			})
			console.log(data2);
			$.ajax({
				url: '/api/setting/menu/save',
				type:'POST',
				contentType: "application/json",
				data : JSON.stringify(data2),
				success: function(r) {
					alertify.alert(r.result, r.msg)
// 					$('strong.tree_s').trigger('click');
				}
			})
		}
	})
	
	$('#tree li strong').on('click', function() {
		$('#reset').trigger('click');
		$('#etc').val('');
		$('li.tree_s').removeClass('tree_s');
		$('.table-row').show();
		$('#tree li strong').removeClass('tree_s');
		$(this).addClass('tree_s')
		var code = $(this).text();
		$.ajax({
			url: '/api/setting/user/code/'+ code,
			type: 'GET',
			success: function(r) {
				console.log(r)
				var text = "";
				var count = 1;
				$.each(r.data, function(a,b) {
					console.log(b)
					if(b.etc == null) {
						b.etc = ''
					}
					text += 
						'<tr onclick="userSet(this)" data-user="'+b.userId+'">'+
						'    <td>'+count+'</td>'+
						'    <td>'+b.userId+'</td>'+
						'    <td>'+b.code+'</td>'+
						'    <td>'+b.telNo+'</td>'+
						'    <td>'+b.handPhone+'</td>'+
						'    <td>'+b.etc+'</td>'+
						'    <td>'+b.emailAddr+'</td>'+
						'</tr>';
					count++;
				})
				
				$('.userset tbody').html(text);
			}
		})
	})
	
})

</script>
<jsp:include page="../common/footer.jsp"></jsp:include>