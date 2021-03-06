<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>

<script src="../../share/js/admin/trouble.js"></script>
<script src="../../share/js/page.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="/share/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
<script type ='text/javascript'>
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
    
    $('#obst_date').datepicker({

        calendarWeeks: false,

        todayHighlight: true,

        autoclose: true,

        format: "yyyy/mm/dd",

        language: "kr"

    });
    
    $('#obst_reco_date').datepicker({

        calendarWeeks: false,

        todayHighlight: true,

        autoclose: true,

        format: "yyyy/mm/dd",

        language: "kr"

    });

});
</script>
<style>
.datepicker {
	width: 220px;
}
#to, #from {
	height: 30px;
}

.modal-dialog{
	width: 70%;
}
.info-wrap {
	border: 1px solid #c9c9c9;
	padding: 15px;
	background: white;
	margin-left: 30px;
	height: 690px;
}

.tree {
	height: 690px;
	overflow-y: auto;
	background: white;
	border: 1px solid #c9c9c9;
	padding: 15px;
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
					<h1 class="main_co">?????? ?????? ??????</h1>
				</div>

				<div class="row array" style='margin-bottom:0px;'>
					<div class="col-xs-6">
						<h5>?????? ?????? ??????</h5>
					</div>
					<div class="col-xs-8">
						<form>
							<div class="form-group" >
								<dl>
									<dd>
										<input type="text" id='to' autocomplete=off placeholder="????????????">
									</dd>
									<dt class="title">??????</dt>
									<dd>
										<input type="text" id='from' autocomplete=off placeholder="????????????" >
									</dd>
									
									<dt>
										<input class="search_btn btn" type="submit" value="??????">
									</dt>
									
								</dl>
								
							</div>
						</form>
					</div>				
					<div class="col-xs-offset-1 col-xs-3">
									<div class="form-group">
										<ul class="row" >
											<li  class="col-xs-offset-8 col-xs-4">
												<button class=" btn-default search_btn" data-backdrop="static" data-target="#layerpop" data-toggle="modal"
												style ="width:110px; height:30px;">??????????????????</button><br/>
												<div class="modal fade" id="layerpop" >
												  <div class="modal-dialog">
												    <div class="modal-content">
												      <!-- header -->
												      <div class="modal-header">
												        <!-- ??????(x) ?????? -->
												        <button type="button" class="close" data-dismiss="modal">??</button>
												        <!-- header title -->
												        <h4 class="main_co">?????? ?????? ??????</h4>
												      </div>
												      <!-- body -->
													      <div class="modal-body">
													            <div id="board" class="pb_b5">
																	<form>
																	<div class="form-group">
																		<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
																			
																			<div class="col-xs-4">
																				<input class="search_btn col-xs-offset-1 col-xs-3" type="button" value="??????" style="margin-left: 40px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
																				<input class="search_btn col-xs-offset-1 col-xs-3" type="submit" id='insert' value="??????" style="margin-left: 40px;"/>
																			</div>
																		</div>
																		<div class="row">
																			<div class="col-xs-1 title">????????????</div>
																			<div class="col-xs-3">
																				<input class="form-control" id='obst_text' type="text"/>
																			</div>
																			
																			<div class="col-xs-1 title">????????????</div>
																			<div class="col-xs-3">
																				<input class="form-control" id='obst_mgr_key'type="text"/>
																			</div>
																			<div class="col-xs-1 title">?????????</div>
																			<div class="col-xs-3">
																				<input class="form-control"  id='obst_model'  type="text"/>
																			</div>
																		</div>
																		
																		<div class="row">
																			
																			<div class="col-xs-1 title">????????????</div>
																			<div class="col-xs-3">
																				<input type="text" id='obst_date'  autocomplete=off placeholder="????????????" >
																			</div>
																			<div class="col-xs-1 title">????????????</div>
																			<div class="col-xs-3">
																				<input type="text" id='obst_reco_date' autocomplete=off placeholder="????????????" >
																			</div>
																			
																			<div class="col-xs-1 title">???????????????</div>
																			<div class="col-xs-2">
																				<select id="sel-3">
																					<option id='equi_info_key'>????????? ??????</option>
																				</select>
																			</div>
																		</div>
																		
																		<div class="row">
																			<div class="col-xs-1 title">????????????</div>
																			<div class="col-xs-3">
																				<input class="form-control" id='obst_reco_text' type="text"/>
																			</div>
																			
																			<div class="col-xs-1 title">????????????</div>
																			<div class="col-xs-3">
																				<input class="form-control" id='obst_reco_comp' type="text"/>
																			</div>
																			
																			<div class="col-xs-1 title">?????????</div>
																			<div class="col-xs-3">
																				<input class="form-control" id='obst_reco_man' type="text"/>
																			</div>
																		</div>
																		
																		<div class="row">
																			<div class="col-xs-1 title">????????????</div>
																				<div class="filebox bs3-primary">
																					<input class="upload-name" id='obst_file_root' value="????????? ?????? ??????" disabled="disabled">
												
																					<label for="ex_filename">?????? ????????????</label> 
																					<input type="file" id="ex_filename" class="upload-hidden"> 
																				</div>
																		</div>
																</form>
																</div><!-- board -->
													      </div>
												      <!-- Footer -->
												      <div class="modal-footer">
												        <button type="button" class="btn-default" data-dismiss="modal">??????</button>
												      </div>
												    </div>
												  </div>
												</div>
											
											
											</li>
										</ul>
									</div>
								</div>
									    
				</div><!-- array -->

				<div class="loader" id="loader-1"></div>
				<div id="board" class="pb_b5 board" style="overflow: auto; height: 500px;">
					<table class="list" style="margin-bottom: 60px;">
						<tr style="position: sticky; top:0; left:0; z-index: 9;">
							<th>?????? ??????</th>
							<th>????????????</th>
							<th>?????????</th>
							<th>???????????????</th>
							<th>????????????</th>
							<th>????????????</th>
							<th>?????? ??????</th>
							<th>????????????</th>
							<th>?????????</th>
						</tr>
						<!-- <tr>
							<td>????????? ?????????</td>
							<td>SA-0001 (?????? 1)</td>
							<td>AirSeoul-01</td>
							<td>S000001</td>
							<td>2019. 11. 1. 00:00</td>
							<td>2019. 11. 1. 01:00</td>
							<td>?????? ?????????</td>
							<td>????????????</td>
							<td>?????????</td>
						</tr> -->
					</table>
					
					<script>
												
												
													</script>
				</div><!-- board -->
				
			</div><!-- container -->

		</div><!-- sensor -->
		<script>
		$('#insert').on('click',function(e){
			e.preventDefault();
   			var obst_text = $('#obst_text').val();
			var obst_mgr_key = $('#obst_mgr_key').val();
			var obst_date = $('#obst_date').val();
			var obst_model = $('#obst_model').val();
			var obst_reco_date = $('#obst_reco_date').val();
			var obst_reco_text = $('#obst_reco_text').val();
			var obst_reco_comp = $('#obst_reco_comp').val();
			var obst_reco_man = $('#obst_reco_man').val();
			var obst_file_root = $('#obst_file_root').val();
			//var equi_info_key = $('#equi_info_key').val();
	 		
			$.ajax({
				url: '/api/admin/modal',
				type: 'POST',
					data: {
						obst_text,
						obst_mgr_key,
						obst_date,
						obst_model,
						obst_reco_date,
						obst_reco_text,
						obst_reco_comp,
						obst_reco_man,
						obst_file_root,
						//equi_info_key,
						"${_csrf.parameterName}" : "${_csrf.token}",
					},
				success: function(r) {
					console.log(r);
					if(r==1){
						alert("?????? ???????????????.");
					}
					else{
						alert("?????? ?????? ???????????????.");
					}
				},
				error: function(e){
					console.log(e)
				}
			})
       	});
		$(document).ready(function() {
			var count = 2;
			$('.btn').click(function(e) {
				e.preventDefault();
				var to = $('#to').val();
				var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
				var from = $('#from').val();
				var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)
				
				count = 2;
				if(to!='' && from!='') {
					var pageNum = "${param.page}";
					if(pageNum == "") pageNum = "1";
					
					$.ajax({
						url: '/api/admin/adminList',
						type: 'POST',
						data: {
							toDate, fromDate,
							"${_csrf.parameterName}" : "${_csrf.token}",
							"pageStart": 1
						},
						success: function(r) {
							trouble.rowTroubleSet(r.data)
						}
						
					})
					
				} else {
					alert('???????????? ?????? ????????????.')
				}
			})

			$('.board').bind('scroll', function(){
				   if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight){
					   var to = $('#to').val();
						var toDate = to.substr(0,4)+to.substr(5, 2)+to.substr(8, 2)
						var from = $('#from').val();
						var fromDate = from.substr(0,4)+from.substr(5, 2)+from.substr(8, 2)

					   $.ajax({
						  	url: '/api/admin/adminList',
							type: 'POST',
							data: {
								toDate, fromDate,
								"${_csrf.parameterName}" : "${_csrf.token}",
								"pageStart": count
							},
							success: function(r) {
//									sensor.rowSetList(r.data);
								trouble.rowTroubleList(r.data)
								count++;
								console.log(count)
							}
				   		})
				   }
			})
			
			$('#to').change(function() {
				if($('#from').val() != ""){
					var to = parse($('#to').val());
					var from = parse($('#from').val());
					var result = (from - to)/(24 * 3600 * 1000);
					
					if(result < 0) {
						alert("????????? ?????? ???????????????.");
						$('#to').val('');
						$('#from').val('');
					}
					
					if(result > 5) {
						alert("?????? ????????? ?????? 5????????????.");
						$('#from').val('');
					}
				}
			})
			
			$('#from').change(function() {
				if($('#to').val() != ""){
					var to = parse($('#to').val());
					var from = parse($('#from').val());
					var result = (from - to)/(24 * 3600 * 1000);
					
					if(result < 0) {
						alert("????????? ?????? ???????????????.");
						$('#to').val('');
						$('#from').val('');
					}
					
					if(result > 5) {
						alert("?????? ????????? ?????? 5????????????.");
						$('#to').val('');
					}
				}
			})
		})
			function parse(str) {
			    var y = str.substr(0, 4);
			    var m = str.substr(5, 2);
			    var d = str.substr(8, 2);
			    console.log(y,m,d)
			    return new Date(y,m-1,d);
			}
		
			
		</script>

<jsp:include page="../common/footer.jsp"></jsp:include>