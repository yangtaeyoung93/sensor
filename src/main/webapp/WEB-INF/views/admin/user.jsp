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
	height: 690px;
}
#tree li strong {
	cursor: pointer;
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
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
<div id="sensor" class="body_wrap">
	
	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">????????? ??????</h1>
		</div>
		<!-- sub_title -->
		<div class="row">
			<div class="col-xs-2 tree2">
			    <ul class="easyui-tree" data-options="
			    url:'/api/admin/getUser',
			    method:'get',
			    animate:true,
			    "></ul>
			</div>
			<div class="col-xs-10 info">
				<div class="info-wrap">
					
					<form id="form">
						<div class="form-group">
							<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
								<div class="col-xs-8" id="equiName" style="line-height: 30px;">
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<input class="search_btn col-xs-2" type="button" id="clearPass" value="???????????? ?????????" style="background: white; color: #f04949; border: 1px solid #f04949;"/>
									</sec:authorize>

								</div>
								<div class="col-xs-4">
									<c:if test="${grant eq 'Y'}">
										<input class="search_btn col-xs-3" type="button" data-toggle="modal" data-target=".detail" value="??????" style="background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-3" id="delete" type="button" value="??????" style="margin-left: 40px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
										<input class="search_btn col-xs-offset-1 col-xs-3" id="save" type="submit" onclick="userSave()" value="??????" style="margin-left: 40px;"/>
									</c:if>
								</div>
							</div>
							<div class="row table-row">
<!-- 								<ul class="table-head"> -->
<!-- 									<li></li> -->
<!-- 									<li>?????????</li> -->
<!-- 									<li>??????</li> -->
<!-- 									<li>????????????</li> -->
<!-- 									<li>?????????</li> -->
<!-- 									<li>????????????</li> -->
<!-- 									<li>?????????</li> -->
<!-- 								</ul> -->
								<table class="table table-hover user-table">
								    <thead style="position: sticky; top:0; ">
								      <tr>
								        <th style="width: 34px;"></th>
								        <th>?????????</th>
								        <th>??????</th>
								        <th>????????????</th>
								        <th>?????????</th>
								        <th>????????????</th>
								        <th>?????????</th>
								      </tr>
								    </thead>
								    <tbody>
								    </tbody>
								</table>
							</div>
								<div class="row">
									
									<div class="col-xs-1 title">????????? ID</div>
									<div class="col-xs-5">
										<input class="form-control" id="userId" type="text" placeholder="????????? ID" disabled/>
									</div>
									<div class="col-xs-1 title">??????</div>
									<div class="col-xs-5">
										<input class="form-control" id="userName" name="userName" type="text" placeholder="??????" disabled/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">??????</div>
									<div class="col-xs-5">
										<select id="deptCd" name="deptCd">
											<option>?????? ??????</option>
											<c:forEach items="${parts}" var="part">
												<option value="${part.code }">${part.codeNm}</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-xs-1 title">?????????</div>
									<div class="col-xs-5">
										<input class="form-control" id="emailAddr" name="emailAddr" type="email" aria-describedby="emailHelp" placeholder="?????????"/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">?????????</div>
									<div class="col-xs-5">
										<input class="form-control" id="handPhone" name="handPhone" type="text" placeholder="????????????"/>
									</div>
									<div class="col-xs-1 title">????????????</div>
									<div class="col-xs-5">
										<input class="form-control" id="telNo" name="telNo" type="text" placeholder="?????????"/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">????????????</div>
									<div class="col-xs-11">
										<textarea rows="6" class="form-control" id="etc" name="etc" type="text" placeholder="??????????????? ??????????????????."/></textarea>
									</div>
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
	
	$.ajax({
		url: '/api/admin/user/info/'+user,
		type: 'GET',
		success: function(r) {
			console.log(r)
			if(r.data[0].regDate == "change") {
				alertify.alert("???????????? ??????", "???????????? ??????????????? ???????????????.");
			}
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
function userSave() {
	
}
$(document).ready(function() {
	
	$('#save').click(function(e) {
		e.preventDefault();
		var data = $('#form').serializeObject();
		data["${_csrf.parameterName}"] =  "${_csrf.token}"
		data["userId"] = $('#userId').val();
		console.log(data);
		if($('#userId').val().length == 0) {
			alertify.alert('??????', '????????? ????????? ????????????.')
		} else {
			$.ajax({
				url: '/api/admin/user/save',
				type:'POST',
				data: data,
				success: function(r) {
					alertify.alert(r.result, r.msg)
					$('strong.tree_s').trigger('click');
				}
			})
		}
	})
	
	$('#clearPass').click(function(e) {
		e.preventDefault();
		var data = $('#form').serializeObject();
		data["${_csrf.parameterName}"] =  "${_csrf.token}"
		data["userId"] = $('#userId').val();
		console.log(data);
		if($('#userId').val().length == 0) {
			alertify.alert('??????', '????????? ????????? ????????????.')
		} else {
			$.ajax({
				url: '/api/admin/user/clear/'+$('#userId').val(),
				type:'GET',
				data: data,
				success: function(r) {
					alertify.alert(r.result, r.msg)
					$('strong.tree_s').trigger('click');
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
			url: '/api/admin/user/code/'+ code,
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
				
				$('.user-table tbody').html(text);
			}
		})
	})
	
	$('#delete').click(function() {
		if($('#userId').val().length == 0) {
			alertify.alert('??????', '????????? ????????? ????????????.')
		} else {
			alertify.confirm("??????", $('#userId').val()+" ????????? ?????????????????????????", function() {
				$.ajax({
					url: '/api/admin/user/delete',
					type:'POST',
					data: {
						"${_csrf.parameterName}" :"${_csrf.token}",
						userId: $('#userId').val()
					},
					success: function(r) {
						alertify.alert(r.result, r.msg, function() {
							location.reload();
						})
					
					}
				})
			}, function() {alertify.error('?????????????????????.')})
			
		}
	})
})
$(document).ready(function() {
	$('.easyui-tree').tree({
		onClick: function(node){
			if(!node.children) {
				var user = node.attributes.userId;
				$.ajax({
					url: '/api/admin/user/info/'+user,
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
						$('.table-row').hide();
					}
				})
			} else {
				var code = node.text;
				$.ajax({
					url: '/api/admin/user/code/'+ code,
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
						$('.table-row').show();
						$('.user-table tbody').html(text);
					}
				})
			}
			
		}
	})
})
</script>
<jsp:include page="./userModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>