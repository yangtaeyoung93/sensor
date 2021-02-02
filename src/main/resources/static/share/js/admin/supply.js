var data = {
    rowsupplySet:function(data){
        var text  = '';
        var _this =this;
        $.each(data,function(a,b){
            text += "<tr>"+
                    "<td>"+b.exp_name+"</td>"+
                    "<td>"+b.exp_mgr_key+"</td> "+
                    "<td>"+b.exp_model+"</td> "+
                    "<td>"+b.equi_info_key+"</td>"+
                    "<td>"+b.exp_date+"</td>"+
                    "<td>"+b.exp_type+"</td>"+
                    "<td>"+b.exp_reco_comp+"</td> "+
                    "<td>"+b.exp_reco_man+"</td>"+
                    "</tr>";
        })
        $('#supply_list').append(text)
    }
}