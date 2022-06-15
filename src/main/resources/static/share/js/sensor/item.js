var item = {
    
    rowSetGu: function(data, type, windFlag) {
    	var text = "";

    	if (!windFlag) {
			text = 
				'<table class="list" style="margin-bottom: 60px;">'+
				'<tr style="position: sticky; top:0; left:0; z-index: 9;">'+
				'    <th>데이터시각</th>'+
				'    <th>강남구</th>'+
				'    <th>강동구</th>'+
				'    <th>강북구</th>'+
				'    <th>강서구</th>'+
				'    <th>관악구</th>'+
				'    <th>광진구</th>'+
				'    <th>구로구</th>'+
				'    <th>금천구</th>'+
				'    <th>노원구</th>'+
				'    <th>도봉구</th>'+
				'    <th>동대문구</th>'+
				'    <th>동작구</th>'+
				'    <th>마포구</th>'+
				'    <th>서대문구</th>'+
				'    <th>서초구</th>'+
				'    <th>성동구</th>'+
				'    <th>성북구</th>'+
				'    <th>송파구</th>'+
				'    <th>양천구</th>'+
				'    <th>영등포구</th>'+
				'    <th>용산구</th>'+
				'    <th>은평구</th>'+
				'    <th>중랑구</th>'+
				'    <th>중구</th>'+
				'    <th>종로구</th>'+
				'    <th>이동형</th>'+
				'</tr>';
    	}

		var _this = this;
		// console.log(data)
        $.each(data, function(a,b) {
        	if(b.length == 0){
        		alertify.alert('없음', '해당 검색조건에 해당하는 데이터가 없습니다.')
        		return false;
        	}
        	
                // 데이터시각	tm
                // 미세먼지		pm10
                // 초미세먼지	pm25
                // 소음		noise
                // 온도		temp
                // 습도		humi
                // 풍향		gust_dire
                // 풍속		gust_speed
                // 조도		inte_illu
                // 자외선		ultra_rays
                // 진동-X		vibr_x
                // 진동-Y		vibr_y
                // 진동-Z		vibr_z
        	
        	if (windFlag) {
        		// console.log(a,b.baramNm);
        		text += "<p style='font-weight:bold'>"+a+"</p>";
        		$.each(b, function(c,d) {
        			if(d.baramNm != null) {
        				text += 
        					'<table class="list wind-list" style="margin-right: 30px; margin-bottom: 30px; display: table; width: calc(100% / 4 - 30px); border: 1px solid #c9c9c9; float: left;">'+
        					'<tr>'+
        					'    <th>센터명</th>'+
        					'    <th>풍향</th>'+
        					'    <th>풍속 (㎧)</th>'+
        					'</tr>';
        				text +=
        					'<tr>'+ 
        					'<td>'+d.baramNm+'</td>'+
        					'<td class="co_step02">'+_this.calcDire(_this.parseNumber(Number(d.windDire), type), 'han')+'</td>'+                                                                               
        					'<td class="co_step01">'+_this.parseNumber(Number(d.windSpeed), type)+'</td>'+
        					'</tr></table>';
        			}
        		})
        		
        	} else {

        		text +=
                    '<tr>'+ 
                    '<td>'+_this.parseDate(b.tm8)+'</td>'+
                    _this.parseColor(_this.parseNumber(Number(b.gn), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.gd), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.gb), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.gs), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.ga), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.gi), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.gr), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.gc), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.no), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.db), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.ddm), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.dj), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.mp), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.sdm), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.sc), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.sd), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.sb), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.sp), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.yc), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.ydp), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.ys), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.ep), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.jr), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.jg), type), type)+
                    _this.parseColor(_this.parseNumber(Number(b.jn), type), type)+                                                                                 
                    _this.parseColor(_this.parseNumber(Number(b.mov), type), type)+
                    '</tr>';
        	}
        })

        if(!windFlag) {
        	text += "</table>"
        }

        $('#board').html(text);

        // $('.list').append(text);
    },
    rowSet2: function(data) {
        var text = 
        '<tr>'+
        '    <th>데이터시각</th>'+
        '    <th>미세먼지<br/>(㎍/㎥)</th>'+
        '    <th>초미세먼지<br/>(㎍/㎥)</th>'+
        '    <th>소음<br/>(dB)</th>'+
        '    <th>온도<br/>(℃)</th>'+
        '    <th>습도<br/>(%)</th>'+
        '    <th>풍향<br/></th>'+
        '    <th>풍속<br/>(㎧)</th>'+
        '    <th>조도<br/>(lx)</th>'+
        '    <th>자외선<br/>(UVI)</th>'+
        '    <th>진동<br/>-X축(g)</th>'+
        '    <th>진동<br/>-Y축(g)</th>'+
        '    <th>진동<br/>-Z축(g)</th>'+
        '</tr>;';
        var _this = this;
        var count = 0;
        var pm10 = new Array();
        var pm25 = new Array();
        var c_date = new Array();
        $.each(data, function(a,b) {
        	if(b == null){
        		alertify.alert('없음', '해당 검색조건에 해당하는 데이터가 없습니다.')
        		return false;
        	}
            // 데이터시각	tm
            // 미세먼지		pm10
            // 초미세먼지	pm25
            // 소음		noise
                // 온도		temp
                // 습도		humi
                // 풍향		gust_dire
                // 풍속		gust_speed
                // 조도		inte_illu
                // 자외선		ultra_rays
                // 진동-X		vibr_x
                // 진동-Y		vibr_y
                // 진동-Z		vibr_z
                pm10.push(_this.parseNumber(Number(b.pm10)))
                pm25.push(_this.parseNumber(Number(b.pm25)))
                c_date.push(_this.parseDate(b.tm));
                text +=
                    '<tr>'+ 
                    '<td>'+_this.parseDate(b.tm)+'</td>'+
                    '<td class="co_step01">'+_this.parseNumber(Number(b.pm10))+'</td>'+
                    '<td class="co_step02">'+_this.parseNumber(Number(b.pm25))+'</td>'+
                    '<td class="co_step04">'+_this.parseNumber(Number(b.noise))+'</td>'+
                    '<td class="co_step05">'+_this.parseNumber(Number(b.temp))+'</td>'+
                    '<td class="co_step01">'+_this.parseNumber(Number(b.humi))+'</td>'+
                    '<td>'+_this.parseWind(_this.parseNumber(Number(b.gust_dire)))+'</td>'+
                    '<td>'+_this.parseNumber(Number(b.gust_speed))+'</td>'+
                    '<td>'+_this.parseNumber(Number(b.inte_illu))+'</td>'+
                    '<td>'+_this.parseNumber(Number(b.ultra_rays))+'</td>'+
                    '<td>'+_this.parseNumber(Number(b.vibr_x))+'</td>'+
                    '<td>'+_this.parseNumber(Number(b.vibr_y))+'</td>'+
                    '<td>'+_this.parseNumber(Number(b.vibr_z))+'</td>'+
                    '</tr>';
        })
        _this.drawChart('graph', pm10, pm25, c_date)
        $('.list-detail').html(text);
    },
    parseDate: function(date) {
        var year = date.substr(0,4);
        var month = date.substr(4,2);
        var day = date.substr(6,2);
        var day = date.substr(6,2);
        var hour = date.substr(8,2);
        var minute = date.substr(10,2);

        return year+"-"+month+"-"+day;
    },
    parseWind: function(data) {
        // console.log(data);
        switch(data) {
            case 0:  return '바람없음'; break;
            case 1:  return '북'; break;
            case 2:  return '북북동'; break;
            case 3:  return '북동'; break;
            case 4:  return '동북동'; break;
            case 5:  return '동'; break;
            case 6:  return '동남동'; break;
            case 7:  return '남동'; break;
            case 8:  return '남남동'; break;
            case 9:  return '남'; break;
            case 10: return '남남서';  break;
            case 11: return '남서';  break;
            case 12: return '서남서';  break;
            case 13: return '서';  break;
            case 14: return '서북서';  break;
            case 15: return '북서';  break;
            case 16: return '북북서';  break;
            default: return '-'; break;
        }
    },
    parseNumber: function(data, type) {
        if(data == -999 || isNaN(data)) {
            return "-";
        } else {
        	return data;
        }
    },
    parseColor: function(data, type) {
      var color = '';
      var data = Number(data)
           if(type=='1') {
            if(data >= 76) {
            		color = '01';
            	} else if(data >= 36){
            		color = '02';
            	} else if(data >= 16) {
            		color = '04';
            	} else if(data > 0) {
            		color = '05';
            	} else {
            		color = '00';
            	} 
            }
            if(type=='0'){
              if(data >= 151) {
            		color = '01';
            	} else if(data >=81){
            		color = '02';
            	} else if(data >= 31) {
            		color = '04';
            	} else if(data > 0) {
            		color = '05';
            	} else {
            		color = '00';
            	}  
            }
            
        return '<td class="co_step'+color+'">'+this.parseNumber(data, type)+'</td>';
    },
    calcDire: function(num, type) {
    	// console.log(type);
		var result = 0;
		var han = "";
		if(num > 348.75 && num <= 11.25) {
		    result = 180;
		    han = "남"
		}
		if(num > 11.25 && num <= 33.75) {
		    result = 202.5
		    han = "남남서";
		}
		if(num > 33.75 && num <= 56.25) {
		    result = 225;
		    han = "남서";
		}
		if(num > 56.25 && num <= 78.75) {
			result =  247.5;
			han = "서남서";
		}
		if(num > 78.75 && num <= 101.25) {
			result =  270;
			han = "서";
		}
		if(num > 101.25 && num <= 123.75) {
			result =  292.5;
			han = "서북서";
		}
		if(num > 123.75 && num <= 146.25) {
			result = 315;
			han = "북서";
		}
		if(num > 146.25 && num <= 168.75) {
			result =  337.5
			han = "북북서";
		}
		if(num > 168.75 && num <= 191.25) {
		    result = 0;
		    han = "북";
		}
		if(num > 191.25 && num <= 213.75) {
			result = 22.5;
			han = "북북동";
		}
		if(num > 213.75 && num <= 236.25) {
			result = 45;
			han = "북동";
		}
		if(num > 236.25 && num <= 258.75) {
			result = 67.5;
			han = "동북동";
		}
		if(num > 258.75 && num <= 281.25) {
		    result = 90;
		    han = "동";
		}
		if(num > 281.25 && num <= 303.75) {
			result = 112.5;
			han = "동남동";
		}
		if(num > 303.75 && num <= 326.25) {
			result = 135;
			han = "남동";
		}
		if(num > 326.25 && num <= 348.75) {
			result = 157.5;
			han = "남남동";
		}
		if(typeof(num) != "number") {
			return "-";
		} else {
			if(type = "han") {
				return han + " ("+num+"°)";
			}
			return '<img src="/share/img/arrow_top.png" style="width:30px; height:30px; transform: rotate('+result+'deg)"/>' + num + "°";
		}
	}
    
}
