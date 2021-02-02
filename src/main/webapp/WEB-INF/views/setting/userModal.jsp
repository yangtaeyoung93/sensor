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
						<form id="m-form" class="needs-validation">
						<div class="form-group">
							<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
								<div class="col-xs-8" id="equiName" style="line-height: 30px;">
								</div>
								<div class="col-xs-4">
										<input class="search_btn col-xs-offset-5 col-xs-3" id="m-save" type="submit" value="저장" style="margin-left: 40px;"/>
										<input class="search_btn col-xs-offset-1 col-xs-3" data-dismiss="modal" aria-label="Close" type="button" value="취소" style="margin-left: 40px; background: white; color: #666; border: 1px solid #c9c9c9;"/>
									</div>
							</div>
								<div class="row">
									
									<div class="col-xs-1 title">사용자 ID</div>
									<div class="col-xs-5">
										<input class="form-control" id="userId" name="userId" type="text" placeholder="사용자 ID" required/>
									</div>
									<div class="col-xs-1 title">성명</div>
									<div class="col-xs-5">
										<input class="form-control" id="userName" name="userName" type="text" placeholder="성명" required/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">비밀번호</div>
									<div class="col-xs-5">
										<input class="form-control" id="userPw" name="userPw" type="password" placeholder="비밀번호" required/>
									</div>
									<div class="col-xs-1 title">비밀번호 재입력</div>
									<div class="col-xs-5">
										<input class="form-control" id="userPwRe" type="password" placeholder="비밀번호 재입력" required/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">소속</div>
									<div class="col-xs-5">
										<select id="m-deptCd" name="deptCd">
											<option value="">소속 선택</option>
											<c:forEach items="${parts}" var="part">
												<option value="${part.code }">${part.codeNm}</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-xs-1 title">이메일</div>
									<div class="col-xs-5">
										<input class="form-control" id="emailAddr" name="emailAddr" type="email" aria-describedby="emailHelp" placeholder="이메일" required/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">휴대폰</div>
									<div class="col-xs-5">
										<input class="form-control" id="handPhone" name="handPhone" type="text" placeholder="전화번호" required/>
									</div>
									<div class="col-xs-1 title">전화번호</div>
									<div class="col-xs-5">
										<input class="form-control" id="telNo" name="telNo" type="text" placeholder="휴대폰" required/>
									</div>
								</div>
								
								<div class="row">
									
									<div class="col-xs-1 title">담당정보</div>
									<div class="col-xs-11">
										<textarea rows="6" class="form-control" id="etc" name="etc" type="text" placeholder="담당정보를 입력해주세요." required/></textarea>
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


		$('#userPwRe').keyup(function(e) {
// 			console.log($(this).text())
			if($('#userPw').val() == $(this).val()) {
				$(this).css('border-color', 'green')
			} else {
				$(this).css('border-color', 'red')
			}
		})
		$('#m-save').click(function(e) {
			e.preventDefault();
			var data = $('#m-form').serializeObject();
			data["${_csrf.parameterName}"] =  "${_csrf.token}"
			data["userId"] = $('input[name=userId]').val();
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
    	    if($('#m-deptCd').val() == "") {
    	    	alertify.alert("비어있는 필드값이 있습니다.");
    	    } else {
	    	    $.ajax({
					url: '/api/admin/user/insert',
					type: 'POST',
					data,
					success: function(r) {
						console.log(r)
						if(r.result == "fail") {
	    					alertify.alert("비어있는 필드값이 있습니다.");
						} else {
	    					alertify.alert(r.msg, function() {
	    						location.reload();
	    					});
						}
					}
				})
    	    }
		
	})
    </script>