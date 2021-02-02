/***********************************************************
 * gms.util.js
 * 
 * CREATE BY   2016-12-21   
 * Rsm WEB UTIL 기본 스크립트
 * 
 ***********************************************************/
/**
 * rsmCurrentDateToStr 오늘날짜를 스트링으로 린턴
 * @param  N/A
 * @returns
 */
/*
window.onerror = function(e) {
    saAlert("Error caught");
};
*/



$(document).ready(function() {
    
    // /form submit event bubbling
	$('form[enctype!=multipart\\/form-data]').submit(function() {
        //엔터에 의한 form submit 방지
        return false;
    });
});

//오래된 브라우저를 지원하기 위한 로그더미함수
var console = console || {
    log:function(){},
    warn:function(){},
    error:function(){}
};
/** 
* String String::formatUseYn()
* @return {String}         사용/미사용 format
*/

function formatUseYn(value){
var rltValue = value ;
    
    if (value=="1"){
    	rltValue = rsmGetLocalize('COM.use');
    }else{
    	rltValue = rsmGetLocalize('COM.unused');    		
    }

    return rltValue;
}

/** 
* String String::formatPossibleYn()
* @return {String}         가능/불가능 format
*/

function formatPossibleYn(value){
var rltValue = value ;
    
    if (value=="1"){
    	rltValue = rsmGetLocalize('COM.possible');
    }else{
    	rltValue = rsmGetLocalize('COM.impossible');    		
    }

    return rltValue;
}

/** 
* String String::formatPhoneNum()
* @return {String}        휴대폰/전화 번호 마스킹 처리 (shinhs)
*/
function formatPhoneNum(value){

	var rltValue = '';
	
	if (typeof value != "undefined"){
	
		rltValue = value;
	    var formatNum = '';
	    
	    if(value.length == 11){
	       	rltValue = value.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
	    }
	    else if(value.length == 10){
	       	if(value.indexOf('02') == 0) {
	           	rltValue = value.replace(/(\d{2})(\d{4})(\d{4})/, '$1-****-$3');
	        }
	       	else {
	           	rltValue = value.replace(/(\d{3})(\d{3})(\d{4})/, '$1-***-$3');
	        }
	    }
	    else if(value.length == 8) {
	    	rltValue = value.replace(/(\d{4})(\d{4})/, '$1-$2');
	    }
	
	}
	
	return rltValue;
}

/** 
* String String::autoPhoneNum()
* @return {String}        휴대폰/전화 번호 하이픈(-) 자동 입력 (shinhs)
*/

function autoPhoneNum(value){

	var num = $('#' + value.id).val().replace(/[^0-9*]/g, '');	
	var tmp = "";

	if(num.length < 7){
		tmp += num.substr(0, 3);
		tmp += '-';
		tmp += num.substr(3);
		num = tmp;
	}
	else if(num.length < 11){
		
		if(num.indexOf('02') == 0) {
			if(num.length < 10){
				tmp += num.substr(0, 2);
				tmp += '-';
				tmp += num.substr(2, 3);
				tmp += '-';
				tmp += num.substr(5);
			}
			else {
				tmp += num.substr(0, 2);
				tmp += '-';
				tmp += num.substr(2, 4);
				tmp += '-';
				tmp += num.substr(6);
			}
		}
		else {
			tmp += num.substr(0, 3);
			tmp += '-';
			tmp += num.substr(3, 3);
			tmp += '-';
			tmp += num.substr(6);
		}
		num = tmp;
	}
	else{				
		tmp += num.substr(0, 3);
		tmp += '-';
		tmp += num.substr(3, 4);
		tmp += '-';
		tmp += num.substr(7);
		num = tmp;
	}

	$('#' + value.id).val(num);
	
}

/***********************************************
 * * 다국어 키로 조회하여 결과값을 리턴
 * @param String _key
 * @param Array  oOptions
 * return String
 */

/**
 * rsmSetDatePicker 날짜선택 입력 박스 에 달력버튼 설정처리
 * @param N/A
 * @returns
 */
function rsmSetDatePicker(){
	$( ".datepicker" ).datepicker({
		  showOn: "button",
		  buttonImage: gGlobal.ROOT_PATH+"/images/icon_calendar.gif",
		  buttonImageOnly: true,
		  buttonText: "Select date",
		  dateFormat: "yy-mm-dd",
		  dayNamesMin: [ "S", "M", "T", "W", "T", "F", "S" ],
		  monthNames: [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
		  monthNamesShort: [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
	/*
		  dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		  monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		  monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
		  */
		});
}

/***********************************************
 * * 다국어 키로 조회하여 결과값을 리턴
 * @param String _key
 * @param Array  oOptions
 * return String
 */

function rsmGetLocalize(_key,oOptions){
	var sReturn = "";
	
	try {
		sReturn = top.i18next.t(_key, oOptions);
    } catch (e) {
    	// dashboard preview 일 경우  window.open 으로 별도창에 오픈되므로 mainFrame을 top으로  못찾아감
    	sReturn = opener.top.i18next.t(_key, oOptions); 
    }
	return sReturn ;

}

function grantWriteCheck(o, menuid){
	
	
	if (typeof(o)!="undefined" || o == null){
		o = $("#btnSave");
	}
	if (typeof menuid =="undefined" || menuid == null || menuid ==''){
		var tmp = document.location.pathname.split('/');
    	
    	if (tmp.length > 0){
    		var tmpMenuId = tmp[tmp.length -1];
    		
    		menuid = tmpMenuId.toLowerCase().replace("rsm","").substring(0, 4);
    	}
	}
	
	$(o).hide();
	
	function checkView(data, textStatus, jqXHR){
		
		if (data.isOk()){
			var rows = data.getRows();
			if (rows.length > 0){
				if (rows[0].grantwrite +"" == "1"){
					$(o).show();
				}
			}
		}
	}
	
	var param = {};
	param.tenantid = CurrentUserInfo.tenantId;
	param.agentid = CurrentUserInfo.agentId;
	param.menuid = menuid;
	
	saJsonSearchList("SACOMMON", "RSM_Grand","__", param, checkView);
	
}

// 엑셀 권한 체크
function grantExcelCheck(o, menuid){
	
	
	if (typeof(o)!="undefined" || o == null){
		o = $("#btnExcel");
	}
	if (typeof menuid =="undefined" || menuid == null || menuid ==''){
		var tmp = document.location.pathname.split('/');
    	
    	if (tmp.length > 0){
    		var tmpMenuId = tmp[tmp.length -1];
    		
    		menuid = tmpMenuId.toLowerCase().replace("rsm","").substring(0, 4);
    	}
	}
	
	$(o).hide();
	
	function checkView(data, textStatus, jqXHR){
		
		if (data.isOk()){
			var rows = data.getRows();
			if (rows.length > 0){
				if (rows[0].grant3 +"" == "1"){
					$(o).show();
				}
			}
		}
	}
	
	var param = {};
	param.tenantid = CurrentUserInfo.tenantId;
	param.agentid = CurrentUserInfo.agentId;
	param.menuid = menuid;
	
	saJsonSearchList("SACOMMON", "RSM_Grand_Excel","__", param, checkView);
	
}

function bindSelectOption(o, service, method, param, val, text, basevalue){
	
	function bindOptions(data, textStatus, jqXHR){
		var rows = data.getRows();
		for (i=0; i<rows.length; i++){
				o.append("<option value='"+rows[i][val]+"'>"+rows[i][text]+"</option>");
		}
		if (typeof(basevalue)!="undefined" && basevalue!= null){
			o.val(basevalue);
		}
		
	}
	saJsonSearchList(service, method,"__", param, bindOptions);
}

function changeOnOffToggle(ele){
	ele.click(function(){
		if($(this).hasClass("on")	){
			$(this).removeClass("on");	 			
		}else{
			$(this).addClass("on");	 
			
		}
	});
}

function treeToggleEvent(){
	$(".tree_showHide").click(function () {
		if($(this).hasClass("on")	){
			$(this).removeClass("on"); 
			$(".sub_l.w290").removeClass("wd0"); 
			$(".sub_r.pl290").removeClass("pal0"); 			
		}else{
			$(this).addClass("on")	; 
			$(".sub_l.w290").addClass("wd0"); 
			$(".sub_r.pl290").addClass("pal0"); 
		}
		$(window).trigger("resize");
	});
}

function stateImage(value){
	var returnValue = "warn_state05.png";
	
	if (value+"" == "0") {
		returnValue = "warn_state05.png";
	} 
	else if (value+"" == "1") {
		returnValue = "warn_state01.png";
	}
	else if (value+"" == "2") {
		returnValue = "warn_state02.png";
	}
	return returnValue; 
}


function rsmCurrentDateToStr() {
    var date = new Date();
    var yyyy = date.getFullYear();
    var mm = date.getMonth() + 1;
    var dd = date.getDate();
    
    if (mm < 10) mm = "0" + mm;
    if (dd < 10) dd = "0" + dd;
    
    return yyyy +''+ mm +''+ dd; 
}

/**
 * rsmDateToStr : 날짜를 스트링으로 리턴
 * @param  date
 * @returns yyyymmdd
 */
function rsmDateToStr(date)
{
    var strYear = date.getFullYear().toString();
    var strMonth = (date.getMonth()+1).toString();
    var strDate = date.getDate().toString();
     
    if(strYear.length==2)
        strYear = '19'+strYear;
    else if(strYear.length==1)
        strYear = '190'+strYear;
      
    if(strMonth.length==1)
        strMonth = '0'+strMonth;
    if(strDate.length==1)
        strDate = '0'+strDate;
     
    return strYear+strMonth+strDate;
}

/* rsmAddMonth('20140428','-3');
 * 3달전(Date).
 */
function rsmAddMonth(strMonth, nOffSet)
{
    var date = new Date();
    date.setYear(parseInt(strMonth.substr(0, 4),0));
    date.setMonth(parseInt(strMonth.substr(4, 2),10)-1-(nOffSet*-1));
    date.setDate(parseInt(strMonth.substr(6, 2),10));
    
    if(strMonth==rsmDateToStr(date)){
        return rsmAddDate(strMonth, nOffSet*30);
    }
    
    return date;
}

/* rsmAddDate('20140331', -30)
 * -30일전(Date) : 밀리세컨드로 변경하여 비교하므로 한달전, 석달전이라기 보다 30일전, 90일전을 구할때 사용.
 */
function rsmAddDate(strDate, nOffSetDay)
{
    var date = new Date();
    strDate = ''+strDate;
    
    date.setYear(strDate.substr(0, 4));
    date.setMonth(strDate.substr(4, 2)-1);
    date.setDate(strDate.substr(6, 2));     
    
    if(nOffSetDay>0)
        return new Date(date.getTime() - 1000 * 3600 * 24 * nOffSetDay);
    else
        return new Date(date.getTime() + 1000 * 3600 * 24 * nOffSetDay);

}

/** rsmSetFormat
 * type에 해당하는 포멧으로 리턴
 * @param str           변경대상 (예 185650)
 * @param delim         삽입문자 (예 :)
 * @param type          원하는포멧 (예 4-2-2)
 * @returns {String}    리턴 (예 18:56:50)
 */
function rsmSetFormat(str, delim, type) {
    if(str == null || delim == null || type == null)        return '';
    var aType = type.split("-");
    var retStr = "";
    var firstLen = 0;
    var lastLen = 0;

    for(i3=0; i3<aType.length; i3++) {
        if(i3 == 0) {
            firstLen    = 0;
            lastLen     = parseInt(aType[0]);
        } else {
            firstLen    = lastLen;
            lastLen     = firstLen + parseInt(aType[i3]);
        }
        if(i3 == aType.length-1)
            retStr = retStr + str.substring(firstLen, lastLen);
        else
            retStr = retStr + str.substring(firstLen, lastLen) + delim;
    }
    return retStr;
}

/** rsmNumkeyCheck
 * 인풋박스에 숫자만 입력
 *  <input type="text" onKeyPress="return numkeyCheck(event)" id=""/>
 */
function rsmNumkeyCheck(e) {
	var keyValue = event.keyCode;
    if( ((keyValue >= 48) && (keyValue <= 57)) ) return true;
    else return false;
}

/** rsmYmdFormCheck
 * 텍스트 박스에 날짜 형식(yyyymmdd)으로 입력시 유효성 검사
 * @param param_dt   날짜 (예 20161225)
 * @returns boolean  
 */
function rsmYmdFormCheck(param_dt){
 	var bDateCheck = true;
 	if(param_dt.length != 8) {
 		bDateCheck = false;
 	}else{
 		var nYear = Number(param_dt.substring(0,4));
	    var nMonth = Number(param_dt.substring(4,6));
	    var nDay = Number(param_dt.substring(6,8));
	    //alert(nYear+'//'+nMonth+'//'+nDay);
	    if (nYear < 1900 || nYear > 3000) bDateCheck = false;
	    if (nMonth < 1 || nMonth > 12) bDateCheck = false;
	    var nMaxDay = new Date(new Date(nYear, nMonth, 1) - 86400000).getDate(); // 해당달의 마지막 일자 구하기
	    if (nDay < 1 || nDay > nMaxDay) bDateCheck = false;
 	}
 	return bDateCheck;
}

/** rsmTimeFormCheck
 * 텍스트 박스에 시간 형식(hhmm)으로 입력시 유효성 검사
 * @param param_tm   시간 (예 1315)
 * @returns boolean  
 */
function rsmTimeFormCheck(param_tm){
 	var bTimeCheck = true;
 	if(param_tm.length != 4) {
 		bTimeCheck = false;
 	}else {
 		var hh = Number(param_tm.substring(0,2));
	    var mm = Number(param_tm.substring(2,4));
	    if (hh > 23) bTimeCheck = false;
	    if (mm > 59) bTimeCheck = false;
 	}
 	return bTimeCheck;
}
//IE8에서 Amchart 외부라이브러리 사용중 오류발생 방지
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function(searchElement /* , fromIndex */) {
        'use strict';
        if (this == null) { throw new TypeError(); }
        var n, k, t = Object(this), len = t.length >>> 0;
        
        if (len === 0) { return -1; }
        n = 0;
        if (arguments.length > 1) {
            n = Number(arguments[1]);
            if (n != n) { // shortcut for verifying if it's NaN
                n = 0;
            } else if (n != 0 && n != Infinity && n != -Infinity) {
                n = (n > 0 || -1) * Math.floor(Math.abs(n));
            }
        }
        if (n >= len) { return -1; }
        for (k = n >= 0 ? n : Math.max(len - Math.abs(n), 0); k < len; k++) {
            if (k in t && t[k] === searchElement) { return k; }
        }
        return -1;
    };
}
//jSon 객체 배열
function getJsonObjectList(obj, key, val) {
    var objects = [];
    for (var i in obj) {
        if (!obj.hasOwnProperty(i)) continue;
        if (typeof obj[i] == 'object') {
            objects = objects.concat(getJsonObjectList(obj[i], key, val));
        } else if (i == key && obj[key] == val) {
            objects.push(obj);
        }
    }
    return objects;
}
/* inchar('20140102', '.')
 * return 2014.01.02
 */
function inchar(str, type){
    
    if(str.length==8){
        return str.substring(0,4)+type+str.substring(4,6)+type+str.substring(6,8);
    }
    
}


/** 
* String Number::nformat()
 * @return {String} 문자열타입의 숫자 format
*/
Number.prototype.nformat = function(){
    if(this==0) return 0;
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = (this + '');
    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
    return n;
};

function nformat(obj){
    if(typeof(obj) == "number" || typeof(obj) == "string") return obj.nformat();
    else return "";
}

/** 
* string String::cutByte(int len)
* 글자를 앞에서부터 원하는 바이트만큼 잘라 리턴합니다.
* 한글의 경우 2바이트로 계산하며, 글자 중간에서 잘리지 않습니다.
*/
String.prototype.cutByte = function(len) {
    var str = this;
    var count = 0;
     
    for(var i = 0; i < str.length; i++) {
        if(escape(str.charAt(i)).length >= 4)
            count += 2;
        else
            if(escape(str.charAt(i)) != "%0D")
                count++;


        if(count >  len) {
            if(escape(str.charAt(i)) == "%0A")
                i--;
            break;      
        }
    }
    return str.substring(0, i);
};
/** 
* bool String::byte(void)
* 해당스트링의 바이트단위 길이를 리턴합니다. (기존의 length 속성은 2바이트 문자를 한글자로 간주합니다)
*/
String.prototype.byte = function() {
    var str = this;
        var length = 0; 
    for(var i = 0; i < str.length; i++)
    {
        if(escape(str.charAt(i)).length >= 4)
            length += 2;
        else if(escape(str.charAt(i)) == "%A7")
            length += 2;
        else
            if(escape(str.charAt(i)) != "%0D")
                length++;
    }
        return length; 
};

/** 
* String String::replaceAll()
 * @return {String}     치환결과문자열
*/
String.prototype.replaceAll = function(oldStr, newStr) {
    if (this != null && this != "") {
        return this.split(oldStr).join(newStr);
    } else {
        return this;
    }
};
/** 
* String String::trim()
 * @return {String}     시작문자와 끝문자의 공백제거
*/
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
};

/** 
* String String::nformat()
 * @return {String} 문자열타입의 숫자 format
*/
String.prototype.nformat = function(){
    var num = parseFloat(this);
    if( isNaN(num) ) return "0";
    return num.nformat();
};

/** 
* String String::dformat(f)
* @param  {String} f       문자열포맷
* @return {String}         문자열타입 날짜 format
*/
String.prototype.dformat = function(f){
    var dateStr = this.replaceAll(".", "").replaceAll("-", "").replaceAll("/", "").replaceAll(":", "").replaceAll(" ", "");
    var date;
    var regExp;
    if(!f) {
        switch (this.length) {
            case 4 : f = "YYYY"; regExp = /^(\d{4})$/; date= new Date(dateStr.replace(regExp, '1/1/$1'));break;
            case 6 : f = "YYYY-MM"; regExp = /^(\d{4})(\d{2})$/; date= new Date(dateStr.replace(regExp, '$2/1/$1')); break;
            case 8 : f = "YYYY-MM-DD"; regExp = /^(\d{4})(\d{2})(\d{2})$/; date = new Date(dateStr.replace(regExp, '$2/$3/$1'));break;
            case 10: f = "YYYY-MM-DD HH24"; regExp = /^(\d{4})(\d{2})(\d{2})(\d{2})$/; date= new Date(dateStr.replace(regExp, '$4:00:00 $2/$3/$1')); break;
            case 12: f = "YYYY-MM-DD HH24:MI"; regExp = /^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})$/; date= new Date(dateStr.replace(regExp, '$4:$5:00 $2/$3/$1'));break;
            case 14: f = "YYYY-MM-DD HH24:MI:SS"; regExp = /^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})$/; date= new Date(dateStr.replace(regExp, '$4:$5:$6 $2/$3/$1'));break;
            default: return this;
        }
    }
    if( isNaN(date) ) return this;
    return date.format(f);
};

function dformat(obj){
    if(obj) return obj.dformat();
    else return "";
}

/** 
* String String::tformat()
* @return {String}         시간format
*/
String.prototype.tformat = function(){
    var timeStr = this.replaceAll(":", "").replaceAll(" ", "");
    if(timeStr=="0") timeStr ="0000" ;
    
    var regExp;
    switch (timeStr.length) {
        case 4 : regExp = /^(\d{2})(\d{2})$/; timeStr = timeStr.replace(regExp, '$1:$2'); break;
        case 6 : regExp = /^(\d{2})(\d{2})(\d{2})$/; timeStr = timeStr.replace(regExp, '$1:$2:$3'); break;
        default: return this;
    }
    return timeStr;
};

function tformat(obj){
    if(obj) return obj.tformat();
    else return "";
}



/** 
* String String::nonformat()
* @return {String} {String} 포맷마스크제거
*/
String.prototype.nonformat = function(){
    if(this.length > 0)
        return this.replaceAll("-", "").replaceAll("/", "").replaceAll(":", "").replaceAll(",", "").replaceAll(" ", "");
    else
        return "";
};

//문자열 치환 String.format("{0}{0}문자열 조합해서 {1}{1} 만들어봐요! ", "{", "}")
String.format = function() {
    var s = arguments[0];
    for (var i = 0; i < arguments.length - 1; i++) {
        var reg = new RegExp("\\{" + i + "\\}", "gm");
        s = s.replace(reg, arguments[i + 1]);
    }
    return s;
};

/** 
* String Date::format(f)
* @param  {String} f        문자열포맷
* @return {String}         문자열타입 날짜 format
*/
//2011년 09월 11일 오후 03시 45분 42초
//console.log(new Date().format("yyyy년 MM월 dd일 a/p hh시 mm분 ss초"));
//2011-09-11
//console.log(new Date().format("yyyy-MM-dd"));
//'11 09.11
//console.log(new Date().format("'yy MM.dd"));
//2011-09-11 일요일
//console.log(new Date().format("yyyy-MM-dd E"));
//현재년도 : 2011
//console.log("현재년도 : " + new Date().format("yyyy"));
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;

    return f.replace(/(YYYY|YY|MM|DD|E|HH24|HH|MI|SS|a\/p)/gi, function($1) {
        switch ($1) {
            case "YYYY": return d.getFullYear();
            case "YY": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "DD": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH24": return d.getHours().zf(2);
            case "HH": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "MI": return d.getMinutes().zf(2);
            case "SS": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};


//String 함수 split 함수의 cross browsing 때문에 사용합니다. 장점이 많은 ie방식에 따랐습니다.
//@param sString : split할 구분 문자열
//@return split한 문자열 배열
String.prototype.iSplit = function(sString) {

var jaSplit, iNumber;

jaSplit = this.split(sString);

if (jaSplit.length != 0) {
   iNumber = jaSplit.length - 1;
   if (jaSplit[iNumber] == "") {
       delete jaSplit[iNumber];
       jaSplit.length = iNumber;
   }
}

return jaSplit;
};

/**
 * type에 해당하는 포멧으로 리턴
 * @param str           변경대상 (예 185650)
 * @param delim         삽입문자 (예 :)
 * @param type          원하는포멧 (예 4-2-2)
 * @returns {String}    리턴 (예 18:56:50)
 */
function getFormat(str, delim, type) {
    if(str == null || delim == null || type == null)        return '';
    var aType = type.split("-");
    var retStr = "";
    var firstLen = 0;
    var lastLen = 0;

    for(i3=0; i3<aType.length; i3++) {
        if(i3 == 0) {
            firstLen    = 0;
            lastLen     = parseInt(aType[0]);
        } else {
            firstLen    = lastLen;
            lastLen     = firstLen + parseInt(aType[i3]);
        }
        if(i3 == aType.length-1)
            retStr = retStr + str.substring(firstLen, lastLen);
        else
            retStr = retStr + str.substring(firstLen, lastLen) + delim;
    }
    return retStr;
}



function openWindow(sUrl,sName,nWidth,nHeight)
{
    var nLeft;
    var nTop;
    var nScreenHeight = screen.availHeight;
    var nScreenWidth = screen.availWidth;

    if (window.innerWidth == 'undefined' || window.innerWidth == null)
    {
        if (document.body.clientWidth == window.screen.width)
        {
            nLeft = (nScreenWidth - (nWidth + 40)) / 2;
            nTop = (nScreenHeight - (nHeight + 80)) / 2;
        }
        else
        {
            if (window.screenLeft < 0)
            {
                //alert((window.screenLeft - (document.body.clientWidth - window.screen.width)));
                nLeft = (document.body.clientWidth - (document.body.clientWidth - window.screen.width)) + ((document.body.clientWidth - (nWidth + 40)) / 2);
                nTop = (nScreenHeight - (nHeight + 80)) / 2;
            }
            else
            {
                nLeft = window.screenLeft + ((document.body.clientWidth - (nWidth + 40)) / 2);
                nTop = (nScreenHeight - (nHeight + 80)) / 2;
            }
        }

        var sFeatures = 'height=' + nHeight + ',width=' + nWidth + ',left=' + nLeft + ',top=' + nTop + ',status=no,toolbar=no,menubar=no,location=no,scroll=yes';
        win = window.open(sUrl, sName, sFeatures);
        win.focus();
        
    }
    else
    {
        if (window.innerWidth == window.screen.width)
        {
            nLeft = (nScreenWidth - (nWidth + 40)) / 2;
            nTop = (nScreenHeight - (nHeight + 80)) / 2;
        }
        else
        {
            if (window.screenLeft < 0)
            {
                //alert((window.screenLeft - (window.innerWidth - window.screen.width)));
                nLeft = (window.innerWidth - (window.innerWidth - window.screen.width)) + ((window.innerWidth - (nWidth + 40)) / 2);
                nTop = (nScreenHeight - (nHeight + 80)) / 2;
            }
            else
            {
                nLeft = window.screenLeft + ((window.innerWidth - (nWidth + 40)) / 2);
                nTop = (nScreenHeight - (nHeight + 80)) / 2;
            }
        }

        
        var sFeatures = 'height=' + nHeight + ',width=' + nWidth + ',left=' + nLeft + ',top=' + nTop + ',status=no,toolbar=no,menubar=no,location=no,scroll=yes';
        win = window.open(sUrl, sName, sFeatures);
        win.focus();
    }
}

/**
 * 페이지영역의 width와 height 확인
 * @returns {Object}    width와 height를 가지 구조체
 */
function getPageArea() {
    if (document.compatMode == 'BackCompat') {
        return {
            width: Math.max(document.body.scrollWidth, document.body.clientWidth),
            height: Math.max(document.body.scrollHeight, document.body.clientHeight)
        };
    } else {
        return {
            width: Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth),
            height: Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight)
        };
    }
}

function onlyNumber(){
    var keyCode = event.keyCode ? event.keyCode : 
    event.which ? event.which : event.charCode;
    if (keyCode!=13) {
        if((keyCode>47 && keyCode<58)) {
            event.returnValue = true;
        } else {
            event.returnValue = false;
        }
    }   
}

function hasOnlyNumDN() {
    var code = event.keyCode ? event.keyCode : 
              event.which ? event.which : event.charCode;
    if (code!=13) {
        event.returnValue =
            ( code >= 48 && code <= 57)     // Number
            || code == 8                    // Backspace
            || code == 9                    // Tab
            || code == 46                   // Delete
            || ( code >= 37 && code <= 40)  // Cursor Key
            || ( code >= 96 && code <= 105); // Key Pad
    }
}

function keyCheck_num1(obj) {   
    if(obj.value == "") return true;    
    var s       = new String("0123456789");
    var re_data = String(obj.value);
    var len     = re_data.length;
    var numYn   = false;
    
    for(var i = 0 ; i < len; i++){      
          numYn   = false;              
          for(var k = 0 ; k < 10; k++){ 
              if(re_data.charAt(i) == s.charAt(k)){
                numYn = true;               
              }             
          }     
          if(!numYn) {
              return false;
          }
    }   
    return true;
} 


/**
 * JSON data를 key값으로 sort한 JSON을 리턴
 * @param data	{JSON}		소트할 JSON
 * @param key	{string}	소트시킬 key
 * @param way	{string}	ASC, DESC 구분
 * @returns 	{JSON}
 */
function sortJSON(data, key, way) {
    return data.sort(function(a, b) {
        var x = a[key]; var y = b[key];
        if (way.toUpperCase() == 'ASC' ) { return ((x < y) ? -1 : ((x > y) ? 1 : 0)); }
        if (way.toUpperCase() == 'DESC') { return ((x > y) ? -1 : ((x < y) ? 1 : 0)); }
    });
}

/**
 * 전화번호 중간에 하이픈을 삽입하여 리턴
 * @param str	{string}	전화번호
 * @returns
 */
function phoneNumDash( str ){ 
    var RegNotNum  = /[^0-9]/g; 
    var RegPhonNum = ""; 
    var DataForm   = ""; 
    
    if( str == "" || str == null ) return ""; 
    
    str = str.replace(RegNotNum,''); 
       
    if( str.length < 4 ) return str; 
    
    if( str.length > 3 && str.length < 7 ) { 
        DataForm = "$1-$2"; 
        RegPhonNum = /([0-9]{3})([0-9]+)/; 
    } else if(str.length == 7 ) {
        DataForm = "$1-$2"; 
        RegPhonNum = /([0-9]{3})([0-9]{4})/; 
    } else if(str.length == 9 ) {
        DataForm = "$1-$2-$3"; 
        RegPhonNum = /([0-9]{2})([0-9]{3})([0-9]+)/; 
    } else if(str.length == 10){ 
        if(str.substring(0,2)=="02"){
            DataForm = "$1-$2-$3"; 
            RegPhonNum = /([0-9]{2})([0-9]{4})([0-9]+)/; 
        }else{
            DataForm = "$1-$2-$3"; 
            RegPhonNum = /([0-9]{3})([0-9]{3})([0-9]+)/;
        }
    } else if(str.length > 10){ 
        DataForm = "$1-$2-$3"; 
        RegPhonNum = /([0-9]{3})([0-9]{4})([0-9]+)/; 
    } 
    
    try{
        while( RegPhonNum.test(str) ) {  
            str = str.replace(RegPhonNum, DataForm);  
        }     	
    }catch(e){
    }

    return str; 
} 

/**
 * Client의 브라우저를 리턴.
 * @returns {String}
 */
function getBrowserType(){
    
    var _ua = navigator.userAgent;
    var rv = -1;
     
    //IE 11,10,9,8
    var trident = _ua.match(/Trident\/(\d.\d)/i);
    if( trident != null )
    {
        if( trident[1] == "7.0" ) return rv = "IE" + 11;
        if( trident[1] == "6.0" ) return rv = "IE" + 10;
        if( trident[1] == "5.0" ) return rv = "IE" + 9;
        if( trident[1] == "4.0" ) return rv = "IE" + 8;
    }
     
    //IE 7...
    if( navigator.appName == 'Microsoft Internet Explorer' ) return rv = "IE" + 7;
     
    /*
    var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if(re.exec(_ua) != null) rv = parseFloat(RegExp.$1);
    if( rv == 7 ) return rv = "IE" + 7; 
    */
     
    //other
    var agt = _ua.toLowerCase();
    if (agt == "mozilla/5.0 (windows nt 10.0)" ) return 'IE'+'EDGE'; //??
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}
