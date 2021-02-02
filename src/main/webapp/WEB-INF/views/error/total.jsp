<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

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
        <div id="login" class="container">
            <div class="row">
                <img src="/img/common/seoul_login_logo1.png"/>
            </div>
            
            <div class="row">
                <h1 style="font-size:60px; color: red;">${code }!</h1>
                <h3>오류 내용 : ${msg}</h3>
                <button href="/" type="submit" class="submit common-btn" style="margin-top:30px;" onclick="location.href='/'">홈으로 돌아가기</button>
            </div>
            
            <div class="row">
                <img src="/img/common/seoul_login_logo2.png"/>
            </div>
        </div>
    </body>
</html>