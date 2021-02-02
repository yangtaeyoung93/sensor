 $(function(){

     $('#from').datepicker({

         calendarWeeks: false,

         todayHighlight: true,

         autoclose: true,

         format: "yyyy/mm/dd",

         language: "kr"

     });
     
     $('#to').datepicker({

         calendarWeeks: false,

         todayHighlight: true,

         autoclose: true,

         format: "yyyy/mm/dd",

         language: "kr"

     });
 });
 
$(document).ready(function() {
	$('#to').change(function() {
		if($('#from').val() != ""){
			var to = parse($('#to').val());
			var from = parse($('#from').val());
			var result = (from - to)/(24 * 3600 * 1000);
			
			if(result < 0) {
				$('#from').val('');
			}
			console.log($('#from').data('flag'))
			if(result > 5) {
				if( $('#from').data('flag') != false ) {
					$('#from').val('');
				}
			}
		}
	})
	
	$('#from').change(function() {
		if($('#to').val() != ""){
			var to = parse($('#to').val());
			var from = parse($('#from').val());
			var result = (from - to)/(24 * 3600 * 1000);
			
			if(result < 0) {
				$('#to').val('');
			}
			
			if(result > 5) {
				if($('#from').data('flag') != false) {
					alert("날짜 범위는 최대 5일입니다.");
					$('#from').val('');
				}
			}
		}
	})
	
	//menu
	var parent = $('.sub_menu .m_on').parent().parent().parent().parent().children('a').css('color', '#0c82e9').text();
	var child = $('.sub_menu .m_on').text()
	$.ajaxSetup({
		error: function(r){
			console.log(r);
			console.log(r.status);
			if(r.status == 500) {
				alertify.alert("에러","오류가 발생하였습니다.")
				$('.loader').hide();
			} else if(r.status == 401){
				alertify.alert('에러','로그인정보가 없습니다.', function(){location.href='/login'})
			}
		},
		complete: function(r) {
			console.log(r)
		}
		
	})
	// $.ajaxPrefilter(function( options, originalOptions, jqXHR ) {
	// 	$url = options.url;
	// 	  console.log($url)
	// 	  console.log(options)
	// 	  console.log(jqXHR)
	// 	  console.log(jqXHR['status'])
	// 	  console.log(jqXHR.statusCode().status)
	// 	  if(jqXHR.status == 403 && jqXHR.status == 401) {
	// 		  alertify.alert("에러", "로그인 정보가 없습니다.", function() {
	// 			location.href="/login"							  
	// 		  })
	// 	  }
	// 	});
	$('input').attr('autocomplete', 'off');
	$("input:text[numberOnly]").attr('title', '숫자만 입력 가능합니다.');
	$("input:text[numberOnly]").attr('data-toggle', 'tooltip');
    $('[data-toggle="tooltip"]').tooltip();
	
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
})

function parse(str) {
    var y = str.substr(0, 4);
    var m = str.substr(5, 2);
    var d = str.substr(8, 2);
    console.log(y,m,d)
    return new Date(y,m-1,d);
}

function includeJs(path) {
	var js = document.createElement("script")
	js.type = "text/javascript";
	js.src = path;
	
	document.head.appendChild(js);
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
