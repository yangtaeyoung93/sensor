var data={
    rowsensorSet:function(data){
        var text ='';
        var _this = this;

        $.each(data,function(a,b){
            text+=  '<tr>'+
                    '<td>test</td>'+
                    '<td>test</td>'+
                    '<td>test</td>'+
                    '<td>'+b.equi_info_key+'</td>'+
                    '<td class="co_step01">'+b.pm10+'</td>'+
                    '<td class="co_step02">'+b.pm25+'</td>'+
                    '<td class="co_step04">'+b.noise+'</td>'+
                    '<td class="co_step05">'+b.temp+'</td>'+
                    '<td class="co_step01">'+b.humi+'</td>'+
                    '<td>'+b.wind_dire+'</td>'+
                    '<td>'+b.wind_speed+'</td>'+
                    '<td>10'+b.inte_illu+'</td>'+
                    '</tr>';
        })
        $('#sensorlist').append(text)
    }
}

