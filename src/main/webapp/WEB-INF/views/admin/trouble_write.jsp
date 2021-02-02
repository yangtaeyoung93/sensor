<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../common/header.jsp"></jsp:include>
<div id="sensor" class="body_wrap">

			<div class="container">
				
				<div class="sub_title">
					<h1 class="main_co">장비 고장 이력</h1>
				</div>

				<div id="board" class="pb_b5">
					<form>
						<table class="write">
							<colgroup>
								<col style="width:20%;">
								<col style="width:30%;">
								<col style="width:20%;">
								<col style="width:30%;">
							</colgroup>
							<tr>
								<th>장애내역</th>
								<td><input type="text" id='obst_text' name=""></td>
								<th>관리번호</th>
								<td><input type="text" id='obst_mgr_key' name=""></td>
							</tr>
							<tr>
								<th>장애일시</th>
								<td><input type="text" id='obst_date' name=""></td>
								<th>모델명</th>
								<td><input type="text" id='obst_model' name=""></td>
							</tr>
							<tr>
								<th>복구일시</th>
								<td><input type="text" id='obst_reco_date' name=""></td>
								<th>시리얼번호</th>
								<td><input type="text" id='equi_info_key' name=""></td>
							</tr>
							<tr>
								<th>조치내용</th>
								<td colspan="3"><textarea rows="10" id='obst_reco_text'></textarea></td>
							</tr>
							<tr>
								<th>조치업체</th>
								<td colspan="3"><input type="text" id='obst_reco_comp' name=""></td>
							</tr>
							<tr>
								<th>조치자</th>
								<td colspan="3"><input type="text" id='obst_reco_man' name=""></td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3">
									<div class="filebox bs3-primary">
										<input class="upload-name" id='obst_file_root' value="선택된 파일 없음" disabled="disabled">

										<label for="ex_filename">파일 첨부하기</label> 
										<input type="file" id="ex_filename" class="upload-hidden"> 
									</div>
								</td>
							</tr>
						</table>
						<div class="btn_wrap pb_t2 btn_r">
							<a class="cancel" href="./trouble">취소</a>
							<input class="writing" type="submit" id="insert" value="등록">
						</div>
					</form>
				</div><!-- board -->
			</div><!-- container -->

        </div><!-- sensor -->
<script type="text/javascript">
	$("#insert").on('click',function(e){
		e.preventDefault();

		var obst_text= $('#obst_text').val();	
		var	obst_mgr_key= $('#obst_mgr_key').val();
		var	obst_date= $('#obst_date').val();
		var	obst_reco_date= $('#obst_reco_date').val();
		var	obst_model= $('#obst_model').val();
		var	equi_info_key= $('#equi_info_key').val();
		var	obst_reco_text= $('#obst_reco_text').val();
		var	obst_reco_comp= $('#obst_reco_comp').val();
		var	obst_reco_man= $('#obst_reco_man').val();
		var	obst_file_root= $('#obst_file_root').val();

		$.ajax({
			url:"/api/admin/troubleCreate",
			type:"POST",
			data:{
				obst_text,
				obst_mgr_key,
				obst_date,
				obst_reco_date,
				obst_model,
				equi_info_key,
				obst_reco_text,
				obst_reco_comp,
				obst_reco_man,
				obst_file_root
			},
			success: function(r){
				console.log(r)
			if(r==1){
					alert("추가하였습니다.");
					location.replace("./trouble");
				}else{
					alert("실패하였습니다.");
				}
			},
			error: function(e){
				console.log(e)
			}
			})
	})



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
    
</script>
<jsp:include page="../common/footer.jsp"></jsp:include>