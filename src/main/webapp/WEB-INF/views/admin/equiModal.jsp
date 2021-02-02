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
						<form class="needs-validation">
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
								
									<div class="col-xs-1 title">기기종류</div>
									<div class="col-xs-3">
										<select id="m-sel-2">
											<option value="">기기종류 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">기기코드</div>
									<div class="col-xs-3">
										<input class="form-control" id="m-equiInfoKey" type="text" required/>
									</div>
									<div class="col-xs-1 title">스테이션명</div>
									<div class="col-xs-3">
										<input class="form-control" id="m-staName" type="text" required/>
									</div>
									
								</div>
								
								<div class="row">

									<div class="col-xs-1 title">위도</div>
									<div class="col-xs-3">
										<input id="m-gpsAbb" class="form-control" type="text" required/>
									</div>
									<div class="col-xs-1 title">경도</div>
									<div class="col-xs-3">
										<input id="m-gpsLat" class="form-control" type="text" required/>
									</div>
	
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">센서타입</div>
									<div class="col-xs-2">
										<select id="m-sel-3">
											<option value="">센서타입 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">용도1</div>
									<div class="col-xs-2">
										<select id="m-sel-4">
											<option value="">용도1 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">용도2</div>
									<div class="col-xs-2">
										<select id="m-sel-5">
											<option value="">용도2 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">용도3</div>
									<div class="col-xs-2">
										<select id="m-sel-6">
											<option value="">용도3 선택</option>
										</select>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">설치년도</div>
									<div class="col-xs-3">
										<select id="m-sel-7">
											<option value="">설치년도 선택</option>
										</select>
									</div>
									<div class="col-xs-3">
										<select id="instMonth2" name="instMonth">
											<option>설치월 선택</option>
											<option value="1">1월</option>
											<option value="2">2월</option>
											<option value="3">3월</option>
											<option value="4">4월</option>
											<option value="5">5월</option>
											<option value="6">6월</option>
											<option value="7">7월</option>
											<option value="8">8월</option>
											<option value="9">9월</option>
											<option value="10">10월</option>
											<option value="11">11월</option>
											<option value="12">12월</option>
										</select>
									</div>
									<div class="col-xs-1 title">관리번호</div>
									<div class="col-xs-3">
										<input class="form-control" id="m-mngNum" type="text" maxlength="4" required numberOnly/>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-1 title">행정구</div>
									<div class="col-xs-3">
										<select id="m-sel-8">
											<option value="">행정구 선택</option>
										</select>
									</div>
									<div class="col-xs-1 title">도로명</div>
									<div class="col-xs-3">
										<input class="form-control" id="m-instLoc" type="text" required/>
									</div>
									<div class="col-xs-1 title">행정명</div>
									<div class="col-xs-3">
										<input class="form-control" id="m-instLoc2" type="text" required/>
									</div>
								</div>
								
								<div class="row">
									<label class="col-xs-offset-1 choice-label"><input id="m-setYn" type="checkbox"><i></i>  설치여부</label>
									<label class="choice-label"><input id="m-useYn" value="day" type="checkbox"><i></i>  완료여부</label>
									<label class="choice-label"><input id="mBaramYn" type="checkbox"  onchange="checkedChange(this, 'm')"><i></i>  바람길여부</label>
									<input type="text" id="mbaramMngNum" maxlength="4" style="display:none; width: 100px;" placeholder="관리번호" numberOnly maxlength="4"/>
									<input type="text" id="mbaramNm" style="display:none; width: 100px;" placeholder="센터명"/>
									<label class="choice-label"><input id="mAirYn" type="checkbox" onchange="checkedChange(this, 'm')"><i></i>  대기측정소여부</label>
									<input type="text" id="mairMngNum" maxlength="4" style="display:none; width: 100px;" placeholder="관리번호" numberOnly maxlength="4"/>
								</div>
								
								<div class="row">

									<div class="col-xs-1 title">방문자 센서코드</div>
									<div class="col-xs-3">
										<input id="m-vistorSenId" class="form-control" maxlength="4" numberOnly />
									</div>
									<div class="col-xs-1 title">방문자 센서명</div>
									<div class="col-xs-3">
										<input id="m-vistorSenViewNm" class="form-control" type="text"/>
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
			var data = dataInit("modal");
			console.log(data)
			var flag = true;
			var forms = document.getElementsByClassName('needs-validation');
    	    // Loop over them and prevent submission
    	    var validation = Array.prototype.filter.call(forms, function(form) {
    	      form.addEventListener('submit', function(event) {
    	    	
    	        if (form.checkValidity() === false) {
    	          event.stopPropagation();
    	          event.preventDefault();
    	        }
    	      }, false);
    	    });
    	    if($('#m-sel-2').val() == "" ||
    	    	$('#m-sel-3').val() == "" ||
    	    	$('#m-sel-4').val() == "" ||
    	    	$('#m-sel-5').val() == "" ||
    	    	$('#m-sel-6').val() == "" ||
    	    	$('#m-sel-7').val() == "" ||
    	    	$('#m-sel-8').val() == "" ||
    	    	$('#instMonth2').val().length > 1) {
    	    	e.preventDefault();
    	    	alertify.alert("비어있는 필드값이 있습니다.");
    	    } else {
    	    	e.preventDefault();
	    	    $.ajax({
					url: '/api/admin/equi/insert',
					type: 'POST',
					data: data,
					success: function(r) {
						console.log(r)
						if(r.result == "fail") {
	    					alertify.alert("오류가 발생하였습니다.");
						} else {
	    					alertify.alert(r.msg, function(){
	    						location.reload();
	    					});
						}
					}
				})
    	    }
		})
		
	})
    </script>