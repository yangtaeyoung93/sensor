var d = new Date()
var year = d.getFullYear();
var month = d.getMonth()+1;
var day = d.getDate();
var date = '';
if (month<10){
    month = '0'+month
}

date = year+'-'+month+'-'+day;

var data = {
    rowrepairSet: function(data){
    var text = '';
    var _this = this;
console.log(data)
        $.each(data,function(a,b){
            var as_type_val = b.as_type.substr(0,2);
             text +="<div class ='q'>"+
                        "<ul class='row'>"+
                            "<li class='col-xs-1'>"+b.as_type+"</li>"+
                            "<li class='col-xs-2'>"+b.as_mgr_key+"</li>"+
                            "<li class='col-xs-1'>"+b.as_model+"</li>"+
                            "<li class='col-xs-1'>"+b.equi_info_key+"</li>"+
                            "<li class='col-xs-2'>"+b.as_date+"</li>"+
                            "<li class='col-xs-1'>"+b.as_text+"</li>"+
                            "<li class='col-xs-2'>"+b.as_reco_text+"</li>"+
                            "<li class='col-xs-1'>"+b.as_reco_comp+"</li>"+
                            "<li class='col-xs-1'>"+b.as_reco_man+"</li>"+


                        "</ul>"+
                    "</div>"+
                    "<div class='a'>"+
                          "<ul class='row'>"+
                            "<li class='col-xs-offset-1 col-xs-11'>"+
                                "<ul class='row'>"+
                                    "<li class='col-xs-6 '>"+
                                        "<span class='main_bg'>"+as_type_val+"</span>"+
                                    "</li>"+
                                    "<li class='col-xs-6 btn_wrap btn_r'>"+
                                        "<a class='writing' href='./repair_write'>수정</a>"+
                                        "<a class='writing' href='#'>삭제</a>"+
                                    "</li>"+
                                "</ul>"+
                                "<div class='con'>"+b.as_text+"</div>"+
                                "<div>"+b.as_date+"</div>"+
                            "</li>"+
                            "</ul>"+
                        "</div>";
                    })
    $('#repair_list').append(text)
    }

}