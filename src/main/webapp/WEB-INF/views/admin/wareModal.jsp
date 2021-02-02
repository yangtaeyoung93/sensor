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
						<form id="wareForm" class="needs-validation">
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
								
									<div class="col-xs-1 title">구분</div>
									<div class="col-xs-3">
									<select id="swHwTp">
										<option>선택</option>
										<c:forEach items="${one }" var="one">
											<option value="${one.code }">${one.codeNm }</option>
										</c:forEach>
									</select>
									</div>
									<div class="col-xs-1 title">변동구분</div>
									<div class="col-xs-3">
									<select id="chgTp">
										<option>선택</option>
										<c:forEach items="${two }" var="two">
											<option value="${two.code }">${two.codeNm }</option>
										</c:forEach>
									</select>
									</div>
									<div class="col-xs-1 title">  기기명</div>
									<div class="col-xs-3">
										<input class="form-control" id="equiInfoKey" name="equiInfoKey" type="text" />
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
									<div class="col-xs-1 title">변동사유</div>
									<div class="col-xs-11">
										<textarea rows="6" class="form-control" id="chgReason" name="chgReason" type="text" required/></textarea>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">비고</div>
									<div class="col-xs-11">
										<textarea rows="4" class="form-control" id="bigo" name="bigo" type="text" required/></textarea>
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
$().ready(function() {
	$('#workDt').datepicker({
    	calendarWeeks: false,
    	todayHighlight: true,
    	autoclose: true,
    	format: "yyyy/mm/dd",
    	language: "kr"
	});

	// $('#workTm').timepicker({
	// 	timeFormat: "H:i",    //시간:분 으로표시
	// 	step: 5,
	//     defaultTime: new Date(),
	//     dynamic: true,
	//     dropdown: true,
	//     scrollbar: true
	// }); 

	// insert
	$('#m-save').click(function(e) {
		e.preventDefault();
		var year = new Date().getFullYear();
		var month = new Date().getMonth()+1;
		var day = new Date().getDate();
		var hour = new Date().getHours();
		var minute = new Date().getMinutes();
		var data = $('#wareForm').serializeObject();

		$.each(data, function(a,b) {
			if(b.length == 0) {
				alertify.alert('비어있는 값이 있습니다.')
			}
		})
		var workDt = $("#workDt").val();
		var workTm = $('#workTm').val();
		

		workDt = workDt.substr(0,4) + workDt.substr(5, 2) + workDt.substr(8, 2)

		data['workDt'] = workDt;
		data['workTm'] = workTm;
		data['swHwTp'] = $('#swHwTp option:selected').val();
		data['chgTp'] = $('#chgTp option:selected').val();
		// data['chgReason'] = $('#chgReason').val();
		// data['bigo'] = $('#bigo').val();
		// data['equiInfoKey'] = $('#equiInfoKey').val();

		console.log('data : ', data);
		$.ajax({
			url: '/api/admin/ware/save',
			type: 'POST',
			data: data,
			success: function(r) {
				if(r.result == "success") {
					alertify.confirm("성공", "입력하신 정보가 저장되었습니다. 추가로 입력하시겠습니까?", function(){
						$('#wareForm')[0].reset();
					}, function(){
						location.reload();
					})
				}
			}
		})
	})

	function uploadFile() {
		if($('input[name=filename]')[0].files[0] == undefined) {
			alertify.alert('에러', '선택된 파일이 없습니다.');
		} else {
			var form = $('#upload')[0];
			var formData = new FormData(form);
			formData.append("filename", $('input[name=filename]')[0].files[0]);

			$.ajax({
				url: '/api/admin/equiExcel',
				type: 'POST',
				processData: false,
				contentType: false,
				data: formData,
				success: function(r) {
					if(r) {
						alertify.alert('성공', '기기 추가가 성공적으로 되었습니다.', function() {location.reload();})
						
					} else {
						alertify.alert('에러', '기기추가 실패. 엑셀파일을 확인해주세요.')
					}
				} 
			})
		}

	}
})

</script>