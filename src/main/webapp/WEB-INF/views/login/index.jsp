<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <title></title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <!-- CSS & JS ADD -->
        <link rel="stylesheet" href="/share/css/common.css">
        <link rel="stylesheet" href="/share/css/login.css">
        <link rel="stylesheet" href="/share/css/login_citydata.css">
        <!-- bootstrap CSS -->
        <link rel="stylesheet" href="../share/css/bootstrap.min.css" />
        <!-- bootstrap JS -->
        <script src="../share/js/bootstrap.min.js"></script>
        <script src="../share/js/bfc93c2045.js" crossorigin="anonymous"></script>
        
        <!-- alertify -->	
	    <script src="/share/alertifyjs/alertify.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/share/alertifyjs/css/alertify.min.css"/>
		<link rel="stylesheet" type="text/css" href="/share/alertifyjs/css/bootstrap.min.css"/>
		<style>
			@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
			body {
			    font-family: "Nanum Gothic", sans-serif;
			}
		</style>
    </head>
    <body>
	<div class="lg_head">
		<div class="lg_cont">
			<h1 class="lg_logo"><a href="#"><img src="/img/common/logo_seoul.png" alt="서울특별시 로고"></a></h1>
			<h2 class="lg_logo2"><a href="#"><img src="/img/common/logo_seoul2.png" alt="I SEOUL U 로고"></a></h2>
		</div><!-- /.lg_cont -->
	</div><!-- /.lg_head -->

        <div id="login" class="container">

	

            <div class="row">
                <img src="/img/common/seoul_login_logo0507.png"/>
            </div>
            
            <div class="row">
                <form action="/login/member" method="post">
                    <div class="form-group form-custom">
                        <input type="email" name="username" class="custom-input" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="계정">
                        <span class="input-icon"><i class="fas fa-user"></i></span>
                    </div>
                    <div class="form-group form-custom">
                        <input type="password" name="pass" class="custom-input" id="exampleInputPassword1" placeholder="비밀번호">
                        <span class="input-icon"><i class="fas fa-lock"></i></span>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="iv" id="iv"/>
                    <input type="hidden" name="salt" id="salt"/>
                    <input type="hidden" name="keySize" id="keySize" value="128"/>
                    <input type="hidden" name="iterationCount" id="iterationCount" value="10000"/>
                    <input type="hidden" name="passPhrase" id="passPhrase" value="seoulsi"/>
                    <input type="hidden" name="encrypted" id="encrypted"/>
                    <button type="submit" class="submit common-btn">로그인</button>
                </form>
            </div>
            
            <div class="row">
                <img src="/img/common/seoul_login_logo2.png"/>
            </div>
            <div class="row" style="margin-top:60px">
            	<a href="/img/common/KDC-ST-R001-01-S-DoT 운영시스템 사용자메뉴얼(V1.5)-일반사용자용.pdf" target="_blank"  style="color:#636363;font-size:24px;font-weight:700">[ S-DoT 운영시스템 사용자 매뉴얼 다운로드 ]</a> 
            </div>
        </div>
    </body>
    <script    src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
	<script    src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/pbkdf2.js"></script>
	<script>
	 	
	 $(document).ready(function() {
		 $('button[type=submit]').click(function(e) {
			 e.preventDefault();
				var iv = CryptoJS.lib.WordArray.random(128/8).toString(CryptoJS.enc.Hex);
			    var salt = CryptoJS.lib.WordArray.random(128/8).toString(CryptoJS.enc.Hex);
			    var plainText = $('input[name=pass]').val();
			    var keySize = 128;
			    var iterationCount = 1024;
			    var passPhrase = "seoulsi";
			    
			    // PBKDF2 키 생성 
			    var key128Bits100Iterations = 
			            CryptoJS.PBKDF2(passPhrase, CryptoJS.enc.Hex.parse(salt),
			            { keySize: keySize/32, iterations: iterationCount });
			        
			    var encrypted = CryptoJS.AES.encrypt(
			            plainText,
			            key128Bits100Iterations,
			            { iv: CryptoJS.enc.Hex.parse(iv) });
			    
			    console.log(iv,salt,plainText,keySize,iterationCount, passPhrase, key128Bits100Iterations, encrypted.toString())
			    
			    $('#exampleInputPassword1').val(encrypted.toString()+" "+iv+" "+salt);
			    $('form').submit();
			    
		 })
	 })
	</script>
 	<script>
 	var para = document.location.href.split("?");
	if(para[1] == "error") {
		alertify.alert("로그인 실패", "아이디 혹은 비밀번호가 맞지않습니다.")
	}
	if(para[1] == "lock") {
		alertify.alert("로그인 실패", "비밀번호를 5회이상 틀려 계정이 일시정지되었습니다. 관리자에게 문의해주세요.");
	}
	if(para[1] == "empty") {
		alertify.alert("로그인 실패", "아이디 혹은 비밀번호를 입력해주세요.");
	}
	if(para[1] == "change") {
		alertify.alert("비밀번호 변경", "비밀번호를 변경한지 90일이 지났습니다.");
	}
 	</script>
</html>
