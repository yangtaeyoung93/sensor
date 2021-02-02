function checkPassword(id, pw){

	var mbrId = $("#"+id).val();   // id 값 입력

	var mbrPwd = $("#"+pw).val();  // pw 입력

	var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9]).{9,}$/.test(mbrPwd);   //영문,숫자

	var check2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{9,}$/.test(mbrPwd);  //영문,특수문자

	var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{9,}$/.test(mbrPwd);  //특수문자, 숫자

	if(mbrPwd.length >= 10) {
		if(!(check1||check2||check3)){

			$('.pwd-errors span').text("사용할 수 없는 조합입니다. 10자리 이상 영문, 숫자, 특수문자중 한가지 이상 사용해주세요.")

			return false;

		}

		if(/(\w)\1\1/.test(mbrPwd)){

			$('.pwd-errors span').text("같은 문자를 3번 이상 사용하실 수 없습니다. ");

			return false;

		}

	} else {
		$('.pwd-errors span').text("비밀번호는 10자리이상 영문,숫자,특수문자가 들어가야합니다.");
		
		return false;
		
	}
	$('.pwd-errors span').text("");
	return true;

}


