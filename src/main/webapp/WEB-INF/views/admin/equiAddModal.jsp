<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
}

.filebox.bs3-primary label {
  color: #fff;
	background-color: #337ab7;
	border-color: #2e6da4;
}
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="uploadModal" class="modal fade upload" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xs" style="transform: translateY(-50%);top: 50%;">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<div class="info-wrap" style="border: none; margin-left:0; height: auto;">
						<form class="needs-validation">
							<div class="form-group">
								<div class="row array" style="border-bottom: 1px solid #c9c9c9; padding-bottom: 15px;">
									<div class="col-xs-8" id="equiName" style="line-height: 30px;">
									다중 기기 등록
									</div>
									<div class="col-xs-4">
										<a class="search_btn col-xs-6" href="javascript:downloadFile();" type="button" style="float:right; margin-left: 10px; background: white; color: #666; border: 1px solid #c9c9c9;">양식 다운</a>
										<a class="search_btn col-xs-4" href="javascript:uploadFile();" type="button" style="float:right; background: white; color: #666; border: 1px solid #c9c9c9;">추가</a>
									</div>
								</div>
								<div class="row">
									
									<form id="upload">
										<div class="filebox bs3-primary">
											<input class="upload-name" value="파일선택" disabled="disabled">
				
											<label for="ex_filename">파일선택</label> 
										  <input type="file" name="filename" id="ex_filename" class="upload-hidden"> 
										</div>
									</form>
								</div>
							</div>
						</form>
					</div>
				</div><!-- modal-body -->
			</div><!-- modal-content -->
		</div>
    </div>
    <script>

	$(document).ready(function(){
	var fileTarget = $('.filebox .upload-hidden');

		fileTarget.on('change', function(){
			if(window.FileReader){
				var filename = $(this)[0].files[0].name;
			} else {
				var filename = $(this).val().split('/').pop().split('\\').pop();
			}

			$(this).siblings('.upload-name').val(filename);
		});
	}); 
	function uploadFile() {
		if($('input[name=filename]')[0].files[0] == undefined) {
			alertify.alert('에러', '선택된 파일이 없습니다.');
		} else {
			var form = $('#upload')[0];
			var formData = new FormData(form);
			formData.append("filename", $('input[name=filename]')[0].files[0]);

			$.ajax({
				url: '/api/admin/equiExcel',
				// url: '/ziptest',
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

	function downloadFile() {
		alertify.confirm("양식 다운로드", "다중 추가를 위한 양식파일입니다.<br> 양식은 꼭 맞춰야하며, 양식에 있는 코드는 <b style='color:red'>환경설정-공통코드</b>에 있는 코드를<br>입력해주셔야 정상적으로 추가가 됩니다.", function() {
			var options = 'top=0, left=0, width=0, height=0, status=no, menubar=no, toolbar=no, resizable=no';
    		window.open('/file/excel/equiExcel', '다운로드', options);
			// location.href="/file/excel/equiExcel"
		}, function() {
			
		}).set('labels', {ok: '다운로드', cancel: '취소'})
	}
	</script>