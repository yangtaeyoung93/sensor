var data = {
    init: function(){
        
    },
    rowliveSet: function(data){
       console.log(data)
        var text ='';
        var _this = this;

        $.each (data, function(a,b){   
            text += "<tr><td>"+b.user_grd_key+"</td>"+
                    "<td>"+b.sta_name+"</td>" +     
                    "<td>"+b.equi_info_key+"</td>"+
                    "<td>"+b.firm_ver+"</td>"+
                    "<td>"+b.inst_date+"</td>"+ 
                    "<td>"+b.mng_user+"</td>"+
                    "<td><a class='search_btn info_btn' href='#'>'일부 센서 장애'</a>"+
                    "<div class='info'>"+
                        "<div class='close info_btn'><i class='xi-close'></i></div>"+
                        "<h5>센서별 현황(서울시OAQ테스트02)</h5>"+
                        "<table>"+
                            "<tr>"+
                                "<th>초미세먼지</th><td class='co_step05'>o</td>"+
                                "<th>자외선</th><td class='co_step05'>o</td>"+
                            "</tr>"+
                            "<tr>"+
                                "<th>미세먼지</th><td class='co_step05'>o</td>"+
                                "<th>소음</th><td class='co_step05'>o</td>"+
                            "</tr>"+
                            "<tr>"+
                                "<th>기온</th><td class='co_step05'>o</td>"+
                                "<th>진동-X</th><td class='co_step05'>o</td>"+
                            "</tr>"+
                            "<tr>"+
                                "<th>습도</th><td class='co_step05'>o</td>"+
                                "<th>진동-Y</th><td class='co_step05'>o</td>"+
                            "</tr>"+
                            "<tr>"+
                                "<th>풍향</th><td class='co_step00'>none</td>"+
                                "<th>진동-Z</th><td class='co_step01'>x</td>"+
                            "</tr>"+     
                            "<tr>"+
                                "<th>풍속</th><td class='co_step00'>none</td>"+
                                "<th>최대진동-X</th><td class='co_step01'>x</td>"+
                            "</tr>"+ 
                            "<tr>"+
                                "<th>돌풍 풍향</th><td class='co_step00'>none</td>"+
                                "<th>최대진동-X</th><td class='co_step01'>x</td>"+
                            "</tr>"+                                    
                            "<tr>"+
                                "<th>돌풍 풍향</th><td class='co_step00'>none</td>"+
                                "<th>최대진동-Y</th><td class='co_step01'>x</td>"+
                            "</tr>"+                                    
                            "<tr>"+
                                "<th>돌풍 풍향</th><td class='co_step00'>none</td>"+
                                "<th>최대진동-Z</th><td class='co_step01'>x</td>"+
                            "</tr>"+        
                            "<tr>"+
                                "<th>조도</th><td class='co_step05'>o</td>"+
                                "<th>흑구온도-Z</th><td class='co_step00'>none</td>"+
                            "</tr>"+   
                        "</table>" +                                                                                                                                           
                    "</div>"+
                "</td>"+
                "</tr>";

                })
        $('#live').append(text);
    },
    rowequipmentSet: function(data){
        var _this = this;
        var text = '';

        $.each(data,function(a,b) {   
            text += "<tr><td>"+b.user_grd_key+"</td>"+
                "<td>"+b.sta_name+"</td>" +     
                "<td>"+b.equi_info_key+"</td>"+
                "<td>"+b.inst_date+"</td>"+
                "<td>100</td>"+
                "<td>99.9</td>"+
                "<td>99.2</td></tr>";
            })
        $('#equip').append(text);
    }


}
