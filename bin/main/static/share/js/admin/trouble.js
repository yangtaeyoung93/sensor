var trouble = {
    rowTroubleSet: function(data){
        var text = 
        	'<tr style="position: sticky; top:0; left:0; z-index: 9;">'+
        	'    <th>장애 내역</th>'+
        	'    <th>관리번호</th>'+
        	'    <th>모델명</th>'+
        	'    <th>시리얼번호</th>'+
        	'    <th>장애일시</th>'+
        	'    <th>복구일시</th>'+
        	'    <th>조치 내용</th>'+
        	'    <th>조치업체</th>'+
        	'    <th>조치자</th>'+
        	'</tr>';
        var _this = this;
        console.log(data)
        $.each(data,function(a,b){
            text += "<tr>"+
            "<td>"+b.obstText+"</td>"+
            "<td>"+b.obstMgrKey+"</td>"+
            "<td>"+b.obstModel+"</td>"+
            "<td>"+b.equiInfoKey+"</td>"+
            "<td>"+b.obstDate+"</td>"+            
            "<td>"+b.obstRecoDate+"</td>"+            
            "<td>"+b.obstRecoText+"</td>"+            
            "<td>"+b.obstRecoComp+"</td>"+            
            "<td>"+b.obstRecoMan+"</td>"+                       
            "</tr>";
        })
        console.log(text)
        $('.list').html(text)
    },
    rowTroubleList: function(data){
        var text = '';
        var _this = this;
        console.log(data)
        $.each(data,function(a,b){
            text += "<tr>"+
            "<td>"+b.obstText+"</td>"+
            "<td>"+b.obstMgrKey+"</td>"+
            "<td>"+b.obstModel+"</td>"+
            "<td>"+b.equiInfoKey+"</td>"+
            "<td>"+b.obstDate+"</td>"+            
            "<td>"+b.obstRecoDate+"</td>"+            
            "<td>"+b.obstRecoText+"</td>"+            
            "<td>"+b.obstRecoComp+"</td>"+            
            "<td>"+b.obstRecoMan+"</td>"+                       
            "</tr>";
        })
        console.log(text)
        $('.list').append(text)
    }
}
