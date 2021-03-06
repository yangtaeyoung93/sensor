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
</style>
<%
String grant = (String)request.getAttribute("grant"); 
pageContext.setAttribute("grant", grant);
%>
<div id="sensor" class="body_wrap">

	<div class="container">

		<div class="sub_title">
			<h1 class="main_co">???????????? ??? ????????????</h1>
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
					<div class="row" style="text-align: right;">
							<c:if test="${grant eq 'Y'}">
								<input class="modify_btn col-xs-1" type="button" value="??????" style="background: white; color: #666; border: 1px solid #c9c9c9; display: block; float: right; overflow:auto; margin-left: 10px; margin-right:30px; margin-bottom: 15px;"/>
								<input class="search_btn col-xs-1" id="addWares" type="button" data-toggle="modal" data-target=".upload" value="?????? ????????????" style="margin-left: 10px; float: right; background: white; color: #666; border: 1px solid #c9c9c9;"/>
								<input class="search_btn col-xs-offset-1 col-xs-1" id="export" type="button" value="Export" style="margin-left: 10px; float: right; background: white; color: #666; border: 1px solid #c9c9c9;"/>
								<select class="col-xs-1"  style="float: right;" id="gu">
									<option>??? ??????</option>
									<c:forEach items="${gus}" var="gu">
										<option value="${gu.code}">${gu.codeNm}</option>
									</c:forEach> 
								</select>
							</c:if>
					</div>
					<div class="row col-xs-6">
						<table class="table user-table" style="overflow-x: hidden; overflow-y: auto; height: 100%;">
							<tr>
								<th>????????????</th>
								<td colspan="3"><span id="staName">????????????</span></td>
							</tr>
							<tr>
								<th>?????????</th>
								<td colspan="3">2019.11.27</td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><span id="instLoc">????????? ?????? ???????????? 110</span></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><span id="equiStru">??????</span><input style="display:none;" type="text" name="equiStru" value=""></td>
							</tr>
							<tr>
								<th>?????????</th>
								<td><span id="superDeptCd">WSG 84</span><input style="display:none;" type="text" name="superDeptCd" value=""></td>
								<th>????????????</th>
								<td><span id="deptCd">??????????????????</span><input style="display:none;" type="text" name="deptCd" value=""></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><span id="gpsAbb">37.551186</span></td>
							</tr>
							<tr>
								<th>??????</th>
								<td colspan="3"><span id="gpsLat">126.987604</span></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td colspan="3"><span id="mngNmJung">4.3M</span><input style="display:none;" type="text" name="mngNmJung" value=""></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td colspan="3"><span id="mngNmJungTel">?????? ?????????????????????</span><input style="display:none;" type="text" name="mngNmJungTel" value=""></td>
							</tr>
							<tr>
								<th>??????????????????</th>
								<td colspan="3"><span id="mngNmBu">200</span><input style="display:none;" type="text" name="mngNmBu" value=""></td>
							</tr>
							<tr>
								<th class="v_middle">????????????</th>
								<td colspan="3">
									<span id="useTp"></span>
								</td>
							</tr>
							<tr>
								<th class="v_middle">?????? ??????</th>
								<td colspan="3">
									<ul class="list-inline">
										<li><label class="choice-label"><input class="sensorSelect" id="testUse" name="useYn" value="" type="radio" disabled><i></i>  ????????????</label><span>(???????????? ?????????: <span class="date">2019. 11. 27</span>)</span></li>
									</ul>
									<ul class="list-inline mt10">
										<li><label class="choice-label"><input class="sensorSelect" id="use" name="useYn" value="" type="radio" disabled><i></i>  ????????????</label></li>
									</ul>
								</td>
							</tr>
							<tr>
								<th colspan="4">??????????????? ?????? ????????? ???????????? ??? ????????????</th>
							</tr>
							<tr>	
								<td colspan="4" style="height:200px;">
									<span id="totOpin">??????????????? ?????? ????????? ???????????? ??? ????????????</span><textarea style="display:none;" name="totOpin"></textarea>
								</td>
							</tr>
						</table>
					</div>
					<div class="row col-xs-6" style="margin-left:10px;">
						<table class="table user-table" style="overflow-x: hidden; overflow-y: auto; height: 100%;">
							<tr>
								<th class="rows_title" rowspan="4"> ??????<br/>?????????</th>
							</tr>
							<tr>
								<th>??????</th>
								<td>???</td>
								<td>???</td>
								<td>???</td>
								<td>???</td>
							</tr>
							<tr>
								<th>??????</th>
								<td id="pollution01"><span></span><input type="text" style="display: none;" name="peastRel1"/></td>
								<td id="pollution02"><span></span><input type="text" style="display: none;" name="pwestRel1"/></td>
								<td id="pollution03"><span></span><input type="text" style="display: none;" name="psouthRel1"/></td>
								<td id="pollution04"><span></span><input type="text" style="display: none;" name="pnorthRel1"/></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td id="pollution11"><span></span><input type="text" style="display: none;" name="peastRel2"/></td>
								<td id="pollution12"><span></span><input type="text" style="display: none;" name="pwestRel2"/></td>
								<td id="pollution13"><span></span><input type="text" style="display: none;" name="psouthRel2"/></td>
								<td id="pollution14"><span></span><input type="text" style="display: none;" name="pnorthRel2"/></td>
							</tr>
							<tr>
								<th class="rows_title" rowspan="4">??????<br/>??????</th>
							</tr>
							<tr>
								<th>??????</th>
								<td>???</td>
								<td>???</td>
								<td>???</td>
								<td>???</td>
							</tr>
							<tr>
								<th>??????</th>
								<td id="building01"><span></span><input type="text" style="display: none;" name="beastRel1"/></td>
								<td id="building02"><span></span><input type="text" style="display: none;" name="bwestRel1"/></td>
								<td id="building03"><span></span><input type="text" style="display: none;" name="bsouthRel1"/></td>
								<td id="building04"><span></span><input type="text" style="display: none;" name="bnorthRel1"/></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td id="building11"><span></span><input type="text" style="display: none;" name="beastRel2"/></td>
								<td id="building12"><span></span><input type="text" style="display: none;" name="bwestRel2"/></td>
								<td id="building13"><span></span><input type="text" style="display: none;" name="bsouthRel2"/></td>
								<td id="building14"><span></span><input type="text" style="display: none;" name="bnorthRel2"/></td>
							</tr>
							<tr>
								<th class="rows_title" rowspan="4">??????</th>
							</tr>
							<tr>
								<th>??????</th>
								<td>???</td>
								<td>???</td>
								<td>???</td>
								<td>???</td>
							</tr>
							<tr>
								<th>??????</th>
								<td id="tree01"><span></span><input type="text" style="display: none;" name="teastRel1"/></td>
								<td id="tree02"><span></span><input type="text" style="display: none;" name="twestRel1"/></td>
								<td id="tree03"><span></span><input type="text" style="display: none;" name="tsouthRel1"/></td>
								<td id="tree04"><span></span><input type="text" style="display: none;" name="tnorthRel1"/></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td id="tree11"><span></span><input type="text" style="display: none;" name="teastRel2"/></td>
								<td id="tree12"><span></span><input type="text" style="display: none;" name="twestRel2"/></td>
								<td id="tree13"><span></span><input type="text" style="display: none;" name="tsouthRel2"/></td>
								<td id="tree14"><span></span><input type="text" style="display: none;" name="tnorthRel2"/></td>
							</tr>
							<tr>
								<th class="rows_title" rowspan="4">??????<br/>??????</th>
							</tr>
							<tr>
								<th>??????</th>
								<td>???</td>
								<td>???</td>
								<td>???</td>
								<td>???</td>
							</tr>
							<tr>
								<th>??????</th>
								<td id="load01"><span></span><input type="text" style="display: none;" name="leastRel1"/></td>
								<td id="load02"><span></span><input type="text" style="display: none;" name="lwestRel1"/></td>
								<td id="load03"><span></span><input type="text" style="display: none;" name="lsouthRel1"/></td>
								<td id="load04"><span></span><input type="text" style="display: none;" name="lnorthRel1"/></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td id="load11"><span></span><input type="text" style="display: none;" name="leastRel2"/></td>
								<td id="load12"><span></span><input type="text" style="display: none;" name="lwestRel2"/></td>
								<td id="load13"><span></span><input type="text" style="display: none;" name="lsouthRel2"/></td>
								<td id="load14"><span></span><input type="text" style="display: none;" name="lnorthRel2"/></td>
							</tr>
							<tr>
								<th class="rows_title" rowspan="4">??????<br/>?????????</th>
							</tr>
							<tr>
								<th>??????</th>
								<td>???</td>
								<td>???</td>
								<td>???</td>
								<td>???</td>
							</tr>
							<tr>
								<th>??????</th>
								<td id="etc01"><span></span><input type="text" style="display: none;" name="eeastRel1"/></td>
								<td id="etc02"><span></span><input type="text" style="display: none;" name="ewestRel1"/></td>
								<td id="etc03"><span></span><input type="text" style="display: none;" name="esouthRel1"/></td>
								<td id="etc04"><span></span><input type="text" style="display: none;" name="enorthRel1"/></td>
							</tr>
							<tr>
								<th>????????????</th>
								<td id="etc11"><span></span><input type="text" style="display: none;" name="eeastRel2"/></td>
								<td id="etc12"><span></span><input type="text" style="display: none;" name="ewestRel2"/></td>
								<td id="etc13"><span></span><input type="text" style="display: none;" name="esouthRel2"/></td>
								<td id="etc14"><span></span><input type="text" style="display: none;" name="enorthRel2"/></td>
							</tr>
							<tr>
								<th colspan="6">??????</th>
							</tr>
							<tr>	
								<td colspan="6" style="height:163px;">
								<span id="etc">??????????????? ?????? ????????? ???????????? ??? ????????????</span><textarea style="display:none;" name="etc"></textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="equiInfoKey" value=""/>
<script>
$(document).ready(function() {
	$('.easyui-tree').tree({
		onClick: function(node){
			$('.modify_btn').removeClass('save_btn').val('??????');
			$('td > span').each(function() {
				if($($(this)[0].nextElementSibling).length > 0) {
					var value = $(this).text();
					$(this).show();
					$(this).text($($(this)[0].nextElementSibling).val())
					console.log($($(this)[0].nextElementSibling).hide())
				}
			})
			console.log(node)
			if(!node.children) {
				function null2Escape(value) {
					if(value == "null") {
						return " ";
					}
					if(!value) {
						return " ";
					}
					
					return value;
				}
				console.log(node)
				var id = node.text;
				$.ajax({
					url: "/api/admin/cardLoc/"+id,
					type: "GET",
					dataType: "json",
					success: function(r) {
						var leftResult = r[0];
						console.log(r);
						//**?????? ??????
						$('#equiInfoKey').val(node.text);
						//????????????
						$('#staName').text(leftResult.staName)
						//?????? ??????
						$('#instLoc').text(leftResult.instLoc)
						$('#equiStru').text(leftResult.equiStru)
						//?????????
						$('#superDeptCd').text(leftResult.superDeptCd)
						//????????????
						$('#deptCd').text(leftResult.deptCd)
						//??????
						$('#gpsAbb').text(leftResult.gpsAbb)
						//??????
						$('#gpsLat').text(leftResult.gpsLat)
						//????????????
						$('#mngNmJung').text(leftResult.mngNmJung)
						//????????????
						$('#mngNmJungTel').text(leftResult.mngNmJungTel)
						//??????????????????
						$('#mngNmBu').text(leftResult.mngNmBu)
						//????????????
						$('#totOpin').text(leftResult.totOpin)
						//??????
						$('#etc').text(leftResult.etc)
						//????????????
						$("#useTp").text(leftResult.useTp2 + ", "+ leftResult.useTp3)
						if(leftResult.useYn == 'Y') {
							$('#use').prop('checked', true)
							$('span.date').text('');
						} else {
							$('span.date').text('2019.12.03')
						}
// 						0:???????????????, 1:????????????, 2:??????, 3:????????????, 4:???????????????		
// 						pollution, building, tree, load, etc

						var count = 0;
						for(count; count < r.length; count++) {
							var type = "";
							if(r[count].locDetailTp == 0) {
								type = "pollution"
							}
							if(r[count].locDetailTp == 1) {
								type = "building"
							}
							if(r[count].locDetailTp == 2) {
								type = "tree"
							}
							if(r[count].locDetailTp == 3) {
								type = "load"
							}
							if(r[count].locDetailTp == 4) {
								type = "etc"
							}
							$('#'+type+'01 span').text(null2Escape(r[count].eastRel1));
							$('#'+type+'02 span').text(null2Escape(r[count].westRel1));
							$('#'+type+'03 span').text(null2Escape(r[count].southRel1));
							$('#'+type+'04 span').text(null2Escape(r[count].northRel1));
							
							$('#'+type+'11 span').text(null2Escape(r[count].eastRel2));
							$('#'+type+'12 span').text(null2Escape(r[count].westRel2));
							$('#'+type+'13 span').text(null2Escape(r[count].southRel2));
							$('#'+type+'14 span').text(null2Escape(r[count].northRel2));
							$('#etc').html(null2Escape(r[count].bigo))
						}
						
					}
				})
			}
		}
	});
	
	$('#testUse').change(function() {
		if($(this).prop('checked')) {
			$('span.date').hide();
			$($('span.date')[0].nextElementSibling).val($('span.date').text()).show();
			
		}
	})
	
	$('.modify_btn').click('click',function() {
		if(!$(this).hasClass('save_btn')) {
			$('.modify_btn').addClass('save_btn').val('??????');
			$('td > span').each(function() {
				if($($(this)[0].nextElementSibling).length > 0) {
					var value = $(this).text();
					$(this).hide();
					console.log($($(this)[0].nextElementSibling).val(value).show())
					console.log(value)
				}
			})
		} else {
			if($('#equiInfoKey').val().length == 0) {
				alertify.alert("??????", "????????? ??????????????????.", function() {
					$('.modify_btn').removeClass('save_btn').val('??????');
					$('td > span').each(function() {
						if($($(this)[0].nextElementSibling).length > 0) {
							var value = $(this).text();
							$(this).show();
							console.log($($(this)[0].nextElementSibling).hide())
						}
					})
				})
				
				return ;
			}
			alertify.confirm("??????", "?????????????????????????", function() {
				//ajax
				$.ajax({
					url: '/api/admin/leftCardInsert',
					type: 'POST',
					data: {
						equiStru : $('input[name=equiStru]').val(),
						superDeptCd : $('input[name=superDeptCd]').val(),
						deptCd : $('input[name=deptCd]').val(),
						mngNmJung : $('input[name=mngNmJung]').val(),
						mngNmJungTel : $('input[name=mngNmJungTel]').val(),
						mngNmBu : $('input[name=mngNmBu]').val(),
						totOpin : $('textarea[name=totOpin]').val(),
						equiInfoKey: $('#equiInfoKey').val()
					},
					success: function(r) {
						var type = "";
						var msg = "";
						for(var i=0; i < 5; i++) {
							if(i == 0) {
							    type = "p"
							}
							if(i == 1) {
							    type = "b"
							}
							if(i == 2) {
							    type = "t"
							}
							if(i == 3) {
							    type = "l"
							}
							if(i == 4) {
							    type = "e"
							}
							$.ajax({
								url: '/api/admin/rightCardInsert/',
								type: 'POST',
								data: {
									eastRel1 : $('input[name='+type+'eastRel1]').val(),
									westRel1 : $('input[name='+type+'westRel1]').val(),
									northRel1 : $('input[name='+type+'northRel1]').val(),
									southRel1 : $('input[name='+type+'southRel1]').val(),
									eastRel2 : $('input[name='+type+'eastRel2]').val(),
									westRel2 : $('input[name='+type+'westRel2]').val(),
									northRel2 : $('input[name='+type+'northRel2]').val(),
									southRel2 : $('input[name='+type+'southRel2]').val(),
									bigo: $('textarea[name=etc]').val(),
									equiInfoKey : $('#equiInfoKey').val(),
									locDetailTp: i
								}, success: function(r) {
									msg = r.msg
								}
							})
						}
						
						if(r.msg == "success"){
							alertify.alert("??????", "?????????????????????.")
							$('.modify_btn').removeClass('save_btn').val('??????');
							$('td > span').each(function() {
								if($($(this)[0].nextElementSibling).length > 0) {
									var value = $(this).text();
									$(this).show();
									$(this).text($($(this)[0].nextElementSibling).val())
									console.log($($(this)[0].nextElementSibling).hide())
								}
							})
						} else {
							
						}
					}
				})
				//ajax
				
			}, function() {
				$('.modify_btn').removeClass('save_btn').val('??????');
				$('td > span').each(function() {
					if($($(this)[0].nextElementSibling).length > 0) {
						var value = $(this).text();
						$(this).show();
						console.log($($(this)[0].nextElementSibling).hide())
					}
				})
			})
			
			
		}
	})

	$('#export').click(function() {
		var guTp = $('#gu').val();
		if($('#gu').val() == "??? ??????") {
			alertify.alert('??????', 'Export??? ?????? ??????????????????.')
		}  else {
			var options = 'top=0, left=0, width=0, height=0, status=no, menubar=no, toolbar=no, resizable=no';
			window.open('/admin/cardLoc/excel/'+$('#gu').val(), '????????????', options);
		}
	})
})
</script>
<jsp:include page="./cardLocAddModal.jsp"></jsp:include>
<jsp:include page="../common/footer.jsp"></jsp:include>