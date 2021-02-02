<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="modal fade detail" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="transform: translateY(-50%);top: 50%;">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<div class="info-wrap" style="border: none; margin-left:0; height: auto;">
						<form id="departForm" class="needs-validation">
							<div class="form-group">
								<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
									<div class="col-xs-8" id="equiName" style="line-height: 30px;">
									.
									</div>
									<div class="col-xs-4">
										<input class="search_btn col-xs-offset-5 col-xs-3" id="m-save" type="submit" value="저장" style="margin-left: 40px;"/>
										<input class="search_btn col-xs-offset-1 col-xs-3" data-dismiss="modal" aria-label="Close" type="button" value="취소" style="margin-left: 40px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
									</div>
								</div>
								<div class="row">
								
									<div class="col-xs-1 title">기관</div>
									<div class="col-xs-3">
										<select name="instCd">
											<option value="">기관 선택</option>
											<c:forEach items="${orga }" var="orga">
											<option value="${orga.code}">${orga.relCd1 }</option>
										</c:forEach>
										</select>
									</div>
									<div class="col-xs-1 title">부서</div>
									<div class="col-xs-3">
										<!-- <select name="superDeptCd">
											<option value="">부서 선택</option>
											<c:forEach items="${dept }" var="dept">
												<option value="${dept.code}">${dept.relCd1 }</option>
											</c:forEach>
										</select> -->
										<input type="text" name="superDeptCd"/>
									</div>
									<div class="col-xs-1 title">팀</div>
									<div class="col-xs-3">
										<input type="text" name="deptCd"/>
										<!-- <select name="deptCd">
											<option value="">팀 선택</option>
											<c:forEach items="${team }" var="team">
												<option value="${team.code}">${team.relCd1 }</option>
											</c:forEach>
										</select> -->
										
									</div>
								</div>

								<div class="row">
									<div class="col-xs-1 title">변경날짜</div>
									<div class="col-xs-3">
										<input class="form-control" id="workDt" name="workDt" type="text" />
									</div>
									<div class="col-xs-1 title">변경일시</div>
									<div class="col-xs-3">
										<input class="form-control" id="workTm" name="workTm" type="text" placeholder="10시 20분 => 1020" />
									</div>
	
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">관리자(정)</div>
									<div class="col-xs-3">
										<input class="form-control" name="mngNmJung" type="text" />
									</div>
									<div class="col-xs-1 title">연락처</div>
									<div class="col-xs-3">
										<input class="form-control" name="mngNmJungTel" type="text" />
									</div>
	
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">관리자(부)</div>
									<div class="col-xs-3">
										<input class="form-control" name="mngNmBu" type="text" />
									</div>
									<div class="col-xs-1 title">연락처</div>
									<div class="col-xs-3">
										<input class="form-control" name="mngNmBuTel" type="text" />
									</div>
	
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">변경내용</div>
									<div class="col-xs-11">
										<textarea rows="6" class="form-control" id="" name="chgContent" type="text" required/></textarea>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">변경사유</div>
									<div class="col-xs-11">
										<textarea rows="4" class="form-control" id="" name="chgReason" type="text" required/></textarea>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">비고</div>
									<div class="col-xs-11">
										<textarea rows="4" class="form-control" id="" name="bigo" type="text" required/></textarea>
									</div>
								</div>
								
								
							</div>
						</form>
					</div>
				</div><!-- modal-body -->
			</div><!-- modal-content -->
		</div>
    </div>
    <script>
    	$(document).ready(function() {
    		$('#m-save').click(function(e) {
    			e.preventDefault();
    			var year = new Date().getFullYear();
				var month = new Date().getMonth()+1 < 10 ? "0"+(new Date().getMonth()+1) : new Date().getMonth()+1;
				var day = new Date().getDate() < 10 ? "0"+new Date().getDate() : new Date().getDate() ;
				
				var hour = new Date().getHours() < 10 ? "0"+new Date().getMinutes() : new Date().getMinutes() ;
				var minute = new Date().getMinutes() < 10 ? "0"+new Date().getMinutes() : new Date().getMinutes() ;
				var workDt = String(year)+String(month)+String(day);
				var workTm = String(hour)+String(minute)
	    		var data = $('#departForm').serializeObject();
				// data['workDt'] = workDt;
				// data['workTm'] = workTm;
				data['workDt'] = data['workDt'].split('/').join('');
				var flag = true;
				$.each(data, function(a,b) {
					if(b.length == 0) {
						alertify.alert('비어있는 값이 있습니다.')
						flag = false;
					}
				})
				if(flag) {
					$.ajax({
						url: '/api/admin/mngDept/save',
						type: 'POST',
						data: data,
						success: function(r) {
							if(r.result == "success") {
								alertify.confirm("성공", "입력하신 정보가 저장되었습니다. 추가로 입력하시겠습니까?", function(){
									$('#departForm')[0].reset();
								}, function(){
									location.reload();
								})
							}
						}
					})
				}
    		})
    	})
    </script>