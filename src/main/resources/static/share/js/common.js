//ajax 전역 설정
// $(document)
// 	.ajaxError(function(e, xhr) {
// 		if(xhr.status == 401) {
// 			alertify.alert("로그인","로그인 정보가 없습니다. 로그인해주세요.")
// 			location.href="/login"
// 		} else if(xhr.status == 403) {
// 			alertify.alert("실패","권한이 없습니다. 관리자에게 문의해주세요.")
// 		}
		
// 	})
$(document).ready(function() {
	chech_go_backpage();


	$(".mob_btn").click(function() {
  		$("#menu,.page_cover,html").addClass("open");	// 메뉴 버튼을 눌렀을때 메뉴, 커버, html에 open 클래스를 추가해서 효과를 준다.
  		window.location.hash = "#open";					// 페이지가 이동한것 처럼 URL 뒤에 #를 추가해 준다.
	});

	window.onhashchange = function() {
  		if (location.hash != "#open") {// URL에 #가 있을 경우 아래 명령을 실행한다.
    		$("#menu,.page_cover,html").removeClass("open");// open 클래스를 지워 원래대로 돌린다.
  		}
	};

	$(window).resize(function() {
		var browserHeight = $(window).height();
		var win_width = $(window).width() || window.innerWidth;
		if (win_width <= 991) {
			$('.navbar-collapse').css({
				'height' : browserHeight + 'px',
				'max-height' : browserHeight + 'px'
			});
		}
	});
	$('.navbar-toggle').on('click', function() {
		var browserHeight = $(window).height();
		var win_width = $(window).width() || window.innerWidth;
		$('#main-gnb').toggle();
		$('body').toggleClass('fixed');
		$('.navbar-blur').toggleClass('open');
		if (win_width <= 991) {
			$('.navbar-collapse').css({
				'height' : browserHeight + 'px',
				'max-height' : browserHeight + 'px'
			});
			$('.gnb_haeder .close_btn').on('click', function() {
				$('.navbar-toggle').trigger('click');
				$('.navbar-nav > li').removeClass('open')
			});
		};
	});
	$('.navbar-nav > li > a').on('click', function(e) {
		e.preventDefault();
		var browserHeight = $(window).height();
		if (window.innerWidth <= 991) {
			if (!$(this).parent().hasClass('open')) {
				$('.navbar-nav > li').removeClass('open');
				$(this).parent().addClass('open');
				return false;
			}
			$(this).parent().toggleClass('open');
		}
	});
	$(window).resize(function() {
		$('.navbar-nav > li').removeClass('open');
	});

	$('.info_agree > span').click(function() {
		$(this).parent().toggleClass('on')
	})
	$('.auto_login > span').click(function() {
		$(this).parent().toggleClass('on')
	})
	$('.style_bg').hide();
	$('.web_nav .navbar-nav').mouseenter(function() {
		$('.sub_menu').show();
		//$('.style_bg').stop().slideDown(200);
		$('.style_bg').show();
	});
	$('.web_nav .navbar-nav').mouseleave(function() {
		$('.sub_menu').hide();
		//$('.style_bg').stop().slideUp(200);
		$('.style_bg').hide();
	});

	if (window.innerWidth <= 991) {
		var $win = $(window);
		$('.list_con li').filter(function(index) {
			return (($(this).offset().top) > $win.height());
		}).hide();
		var notice_len = $('.list_con li').length;
		var notice_show = $('.list_con li:visible').length;
		var itemsPeradd = 5;
		$('.bottom_btn.more .current').text(notice_show);
		$('.bottom_btn.more .total').text(notice_len);
		$('.bottom_btn.more button').click(function() {
			var notice_hidden = $('.list_con li:hidden').length;
			$('.list_con li:hidden:lt(' + itemsPeradd + ')').slideDown(1000);
			if (itemsPeradd < notice_hidden) {
				$('.bottom_btn.more .current').text(notice_show += itemsPeradd);
			} else {
				$('.bottom_btn.more .current').text(notice_show += notice_hidden);
			};
		});
	}
	$('.meeting_tab a').click(function(e) {
		e.preventDefault();
		$('.tab_wrap .tab_con').hide();
		$('.meeting_tab a').removeClass('active');
		$(this).addClass('active');
		$($(this).attr('href')).show();
	});
	
	
	$("#btn_request_pay_bank").on("click", function(){
		$("#btn_request_pay_bank").fadeOut();
		setTimeout(function(){
			$("#pay_bank_info").show();
		}, 1000);
	});
});

//---- 모바일 화면 좌측 메뉴 오픈
function open_menu(obj) {
	var is_menu_open = $(obj).hasClass('open');

	//---- 메뉴 항목이 열려 있는 경우
	if(is_menu_open) {
		$(obj).children(".nav_left_sub_menu").slideUp('fast', function() {
			$(obj).removeClass('open');
		});

	//---- 메뉴 항목이 닫혀 있는 경우
	} else {
		$(obj).children(".nav_left_sub_menu").slideDown('fast', function() {
			$(obj).addClass('open');
		});
	}
}

//---- 상단메뉴 GO_TOP
function go_top() {
	var animate_speed = 500;
	$('html, body').stop().animate({ scrollTop: 0 }, animate_speed, 'easeOutCubic');
}

//---- 모바일 지역 메뉴 활성화
function btn_mob_location() {
	var is_search_location = $("#search_location").hasClass('on');

	if(is_search_location) {
		$("#search_location").removeClass('on');
	} else {
		$("#search_location").addClass('on');
	}
}

function GetLocation() {
	// GPS를 지원하는 경우
	if ( navigator.geolocation ) {
		navigator.geolocation.getCurrentPosition( function(position) {
			var lat = position.coords.latitude;
			var lng = position.coords.longitude;
			SetLocationdata(lat, lng);
		}, function(error) {
			alert('현재 위치를 확인할 수 없습니다. 지역을 선택해 주세요.');
			//console.error(error);
		}, {
			enableHighAccuracy: true,
			maximumAge: 2000,
			timeout: Infinity
		});
	} else {
		alert('GPS를 지원하지 않습니다.');
	}
}

function SetLocationdata( lat, lng ) {
	var lat = lat;
	var lng = lng;

	var datas = "lat=" + lat;
	datas += "&lng=" + lng;

	$.ajax({
		url : '/web/html/ajax_get_location.php'
		, type: 'POST'
		, dataType: 'html'
		, data : datas
		, cache : false
		, success : function(ret_json) {
			//Success 처리
			if ( parseInt(ret_json) == 0 ) {
				var str_html = '<option value="" selected>상세 지역 선택</option>';

				$("#s_location_number option").remove();
				$("#s_location_number").append(str_html);

				alert('현재위치를 찾지 못했습니다.');

				return false;
			} else {
				//---- 목록 구성
				var str_html						= '<option value="">상세 지역 선택</option>';
				var tmp_data 						= JSON.parse(ret_json);
				
				var s_location_code					= tmp_data['s_location_code'];
				var s_location_number				= tmp_data['s_location_number'];
				var s_location_number1				= tmp_data['s_location_number1'];
				var s_location_number2				= tmp_data['s_location_number2'];
				var s_use_location					= tmp_data['s_use_location'];

				var sub_location_data				= tmp_data['sub_location_data'];		// 배열

				for(var i=0; i < sub_location_data.length; i++){
					var json_data 					= sub_location_data[i];

					var location_code 				= json_data['location_code'];
					var location_name 				= json_data['location_name'];
					var location_number 			= json_data['location_number'];
					var location_number1 			= json_data['location_number1'];
					var location_number2 			= json_data['location_number2'];
					var use_location 				= json_data['use_location'];

					var row_html = '';

					row_html += '<option value="' + location_number + '">' + location_name + '</option>';

					str_html += row_html;
				}

				$("#s_location_code").val(s_location_code);
				$("#s_location_number option").remove();
				$("#s_location_number").append(str_html);
				$("#s_location_number").val(s_location_number);

				$("#s_location_code_pc").val(s_location_code);
				$("#s_location_number_pc option").remove();
				$("#s_location_number_pc").append(str_html);
				$("#s_location_number_pc").val(s_location_number);

			}
		}
		, error: function(xhr,xmlStatus) {
			alert('처리중에 오류가 발생하였습니다.\n\n'+ xhr.xmlStatus);
			return;
		}
	});
}



function change_location_code(data) {
	var location_code = data;

	var datas = "location_code=" + location_code;

	$.ajax({
		url : './ajax_search_location_number_data.php'
		, type: 'POST'
		, dataType: 'html'
		, data : datas
		, cache : false
		, success : function(ret_json) {
			//Success 처리
			if ( parseInt(ret_json) == 0 ) {
				var str_html = '<option value="" selected>상세 지역 선택</option>';

				$("#s_location_number option").remove();
				$("#s_location_number").append(str_html);

				return false;
			} else {
				//---- 목록 구성
				var str_html						= '<option value="" selected>상세 지역 선택</option>';
				var tmp_data 						= JSON.parse(ret_json);

				for(var i=0; i < tmp_data.length; i++){
					var json_data 					= tmp_data[i];

					var use_location				= json_data['use_location'];
					var location_code				= json_data['location_code'];
					var location_name				= json_data['location_name'];
					var location_number				= json_data['location_number'];
					var location_number1			= json_data['location_number1'];
					var location_number2			= json_data['location_number2'];

					var row_html = '';

					row_html += '<option value="' + location_number + '">' + location_name + '</option>';

					str_html += row_html;
				}

				$("#s_location_number option").remove();
				$("#s_location_number").append(str_html);

			}
		}
		, error: function(xhr,xmlStatus) {
			alert('처리중에 오류가 발생하였습니다.\n\n'+ xhr.xmlStatus);
			return;
		}
	});
}


function change_location_code_pc(data) {
	var location_code = data;

	var datas = "location_code=" + location_code;

	$.ajax({
		url : './ajax_search_location_number_data.php'
		, type: 'POST'
		, dataType: 'html'
		, data : datas
		, cache : false
		, success : function(ret_json) {
			//Success 처리
			if ( parseInt(ret_json) == 0 ) {
				var str_html = '<option value="" selected>상세 지역 선택</option>';

				$("#s_location_number_pc option").remove();
				$("#s_location_number_pc").append(str_html);

				return false;
			} else {
				//---- 목록 구성
				var str_html						= '<option value="" selected>상세 지역 선택</option>';
				var tmp_data 						= JSON.parse(ret_json);

				for(var i=0; i < tmp_data.length; i++){
					var json_data 					= tmp_data[i];

					var use_location				= json_data['use_location'];
					var location_code				= json_data['location_code'];
					var location_name				= json_data['location_name'];
					var location_number				= json_data['location_number'];
					var location_number1			= json_data['location_number1'];
					var location_number2			= json_data['location_number2'];

					var row_html = '';

					row_html += '<option value="' + location_number + '">' + location_name + '</option>';

					str_html += row_html;
				}

				$("#s_location_number_pc option").remove();
				$("#s_location_number_pc").append(str_html);

			}
		}
		, error: function(xhr,xmlStatus) {
			alert('처리중에 오류가 발생하였습니다.\n\n'+ xhr.xmlStatus);
			return;
		}
	});
}

function go_backpage() {
	if(document.referrer) {
		history.go(-1);
		return false;
	} else {

	}
}

function chech_go_backpage() {
	if(document.referrer) {
		$("#mob_back").css('display', '');
	} else {
		$("#mob_back").css('display', 'none');
	}
}

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

