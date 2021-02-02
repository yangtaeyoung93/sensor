<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="../../share/js/jquery-1.12.4.min.js"></script>
        <!-- CSS & JS ADD -->
        <link rel="stylesheet" href="/share/css/common.css">
        <link rel="stylesheet" href="/share/css/login.css">
        
		<link rel="stylesheet" type="text/css" href="/share/alertifyjs/css/bootstrap.min.css"/>
		<style>
			@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
			body {
			    font-family: "Nanum Gothic", sans-serif;
			}
		</style>
    </head>
    <body>
    <form id="form">
    	<input type="file" accept="image/*" name="instAftBack" id="instAftBack">
    	<input type="file" accept="image/*" name="instAftFrt" id="instAftFrt">
    </form>
    <input class="save_btn col-xs-1" type="button" value="저장" style="background: white; color: #666; border: 1px solid #c9c9c9; display: block; float: right; overflow:auto; margin-right:30px; margin-bottom: 15px;"/>
        <div id="login" class="container">
            <div class="row">
                <img src="/img/common/seoul_login_logo1.png"/>
            </div>
            
            <div class="row">
                <h1 style="font-size:60px; color: red;">400!</h1>
                <h3>잘못된 요청입니다.</h3>
                <button href="/" type="submit" class="submit common-btn" style="margin-top:30px;" onclick="location.href='/'">홈으로 돌아가기</button>
            </div>
            
            <div class="row">
                <img src="/img/common/seoul_login_logo2.png"/>
            </div>
        </div>
        <script>
        $.fn.serializeObject = function() {
		    var obj = null;
		    try {
		        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
		            var arr = this.serializeArray();
		            if (arr) {
		                obj = {};
		                jQuery.each(arr, function() {
		                    obj[this.name] = this.value;
		                });
		            }//if ( arr ) {
		        }
		    } catch (e) {
		        alert(e.message);
		    } finally {
		    }
		 
		    return obj;
		};
	        $('.save_btn').click(function(e){
	    		e.preventDefault();
	    		var form = $('#form')[0];
	      		var formData = new FormData(form);
// 	      			formData.append("equiInfoKey",equiInfoKey)
	    		var data = $('#form').serializeObject();
	      		 $.ajax({
	      			 url: '/test',
	      			contentType : false,
	    	        processData: false,
	    	        enctype: "multipart/form-data",
	    	        type:'POST',
	      			 data: formData,
	      			beforeSend: function() {
	    				$('.loader').show();
	    				$('.dim').show();
	    			},
	      			 success: function(r) {
	      				 if(r.result == "success") {
	      					 alertify.alert('성공', '저장되었습니다.')
	      				 }
	      			 },
	      			complete: function() {
	    				$('.loader').hide();
	    				$('.dim').hide();
	    			}
	      		 
	      		 })
	    	})
        </script>
    </body>
</html>