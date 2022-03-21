var mapjs = {
	data: {
		data:[]
	},
    divideValue: function(data)
    {
        // 
        // 
        // 
        // 
        // 
        // 
        // 미수신 	            #44c7f4
        // 0~19 	매우나쁨    #8dd638
        // 20~39 	나쁨        #ffc000
        // 40~59 	약간나쁨    #ff6700
        // 60~79 	보통        #ff0000
        // 80~100   좋음        #a1a1a1
        if(data >= 80) {
            return "#44c7f4";
        } 
        else if(data >= 60) {
            return "#8dd638";
        }
        else if(data >= 40) {
            return "#ffc000";
        }
        else if(data >= 20) {
            return "#ff6700";
        }
        else if(data >= 0) {
            return "#ff0000";
        }
        else {
            return "a1a1a1";
        }
    },
    infoTop10 : function(data, target) {
        var array = new Array();
        var text = color = '';
        var count = 1;
        data = data.sort(function(a, b) { // 내림차순
            return a.sta_name > b.sta_name ? -1 : a.sta_name < b.sta_name ? 1 : 0;
        });

        $.each(data, function(a,b) {
            array.push({'sta_name': b.staName, 'data': sensor.parseNumber(Number(b[target]))})
            if(b[target] >= 80) {
                color = '01';
            } else if(b[target] >=60){
                color = '02';
            } else if(b[target] >= 40) {
                color = '03';
            } else if(b[target] >= 20) {
                color = '04';
            } else if(b[target] >= 0) {
                color = '05';
            } else {
                color = '00';
            }
            text += '<tr>'+
            '	<td>'+count+'</td>'+
            '	<td>'+b.staName+'</td>'+
            '	<td class="co_step'+color+'">'+sensor.parseNumber(Number(b[target]))+'</td>'+
            '	<td><i class="bg_step'+color+'"></i></td>'+
            '</tr>';
            count++;
        })
        // console.log(text)
        $('.board .list.top10').append(text);
    },
    gradeInfo : function(data, target){
        var good = normal = littlebad = bad = hell = nope = 0;
        var good_guage = normal_guage = littlebad_guage = bad_guage = hell_guage = nope_guage = 0;
        

        $.each(data, function(a, b) {
            
            if(b[target] >= 80) {
                good++;
            } else if(b[target] >=60){
                normal++;
            } else if(b[target] >= 40) {
                littlebad++;
            } else if(b[target] >= 20) {
                bad++;
            } else if(b[target] >= 0) {
                hell++;
            } else {
                nope++;
            }
        })
        var guage = good + normal + littlebad + bad + hell + nope;

        nope_guage = Math.floor((nope/guage) * 100);
        good_guage = Math.floor((good/guage) * 100);
        normal_guage = Math.floor((normal/guage) * 100);
        littlebad_guage = Math.floor((littlebad/guage) * 100);
        bad_guage = Math.floor((bad/guage) * 100);
        hell_guage = Math.floor((hell/guage) * 100);

        
        var set = 
            '<td class="co_step00">'+
            '	<p>'+nope+'</p>'+
            '	<div><span class="bg_step00" style="height: '+nope_guage+'%;"></span></div>'+
            '</td>'+
            '<td class="co_step01">'+
            '	<p>'+good+'</p>'+
            '	<div><span class="bg_step01" style="height: '+good_guage+'%;"></span></div>'+
            '</td>'+
            '<td class="co_step02">'+
            '	<p>'+normal+'</p>'+
            '	<div><span class="bg_step02" style="height: '+normal_guage+'%;"></span></div>'+
            '</td>'+
            '<td class="co_step03">'+
            '	<p>'+littlebad+'</p>'+
            '	<div><span class="bg_step03" style="height: '+littlebad_guage+'%;"></span></div>'+
            '</td>'+
            '<td class="co_step04">'+
            '	<p>'+bad+'</p>'+
            '	<div><span class="bg_step04" style="height: '+bad_guage+'%;"></span></div>'+
            '</td>'+
            '<td class="co_step05">'+
            '	<p>'+hell+'</p>'+
            '	<div><span class="bg_step05" style="height: '+hell_guage+'%;"></span></div>'+
            '</td>'
        return set;		
    }, 
    marker : function(data, target, option) {
    	var _this = this;
    	var good = 0;
    	var goodData = [];
        var normal = 0;
        var normalData = [];
        var bad = 0;
        var badData = [];
        var crit = 0;
        var critData = [];
        var no = 0;
        var noData = [];
        $.each(data, function(a, b) {
            //마커이미지
            var img = '';
            var color = '';
            var color2 = '';

            if(target == "pm10"){
                if(b[target] == null){
                    img = 'area_06.png';
                }else if(b[target] >= 151) {
            		crit++;
            		img = 'area_05.png';
            	} else if(b[target] >=81){
            		bad++;
            		img = 'area_04.png';
            	} else if(b[target] >= 31) {
            		normal++;
            		img = 'area_02.png';
            	} else if(b[target] >= 0) {
            		good++;
            		img = 'area_01.png';
            	} else {
            		img = 'area_06.png';
            		no++;
            		noData.push(data[a])
            	}
            } else if(target == "pm25"){
                if(b[target] == null){
                    img = 'area_06.png';
                }else if(b[target] >= 76) {
            		crit++;
            		img = 'area_05.png';
            	} else if(b[target] >= 36){
            		bad++;
            		img = 'area_04.png';
            	} else if(b[target] >= 16) {
            		normal++;
            		img = 'area_02.png';
            	} else if(b[target] >= 0) {
            		good++;
            		img = 'area_01.png';
            	} else {
            		no++;
            		img = 'area_06.png';
            	}
            }
            else if(target == "sensor") {
            	if(b['baramYn'] == "Y") {
            		img = 'wind.png';
            	} else if(b['guTp'] == "26"){
            		img = 'common.png';
            	} else if(b['senseTp'] == "1"){
            		img = 'visitor.png'
            	}else {
            		img = 'common.png';
            		color = '00';
            	}
            }else if(target == "sensors"){
                img = 'common.png';
            }
            
            if(b['pm25'] == null){
                    color2 = '00';
                }else if(b['pm25'] >= 76) {
            		color2 = '01';
            	} else if(b['pm25'] >= 36){
            		color2 = '02';
            	} else if(b['pm25'] >= 16) {
            		color2 = '04';
            	} else if(b['pm25'] >= 0) {
            		color2 = '05';
            	} else {
            		color2 = '00';
                }
            if(b['pm10'] == null){
                    color = '00';
                }else if(b['pm10'] >= 151) {
            		color = '01';
            	} else if(b['pm10'] >=81){
            		color = '02';
            	} else if(b['pm10'] >= 31) {
            		color = '04';
            	} else if(b['pm10'] >= 0) {
            		color = '05';
            	} else {
            		color = '00';
            	}
            	
            if(b['temp'] == -100) {
              img = 'area_06.png';
            }
            
            if(b.pm10 == null){
                var pm10 = "-";
            }else{
                var pm10 = _this.parseNumber(Number(b.pm10));
            }

            if(b.pm25 == null){
                var pm25 = "-";
            }else{
                var pm25 = _this.parseNumber(Number(b.pm25));
            }
            
            
            var title = '	<h3>'+b.equiInfoKeyHan+'('+b.equiInfoKey+')</h3>';
            if(b['baramYn'] == "Y") {
            	title = '	<h3>바람길'+b.baramMngNum+'('+b.equiInfoKeyHan+')</h3>';
            }
            if(b['airYn'] == "Y") {
            	title = '	<h3>대기'+b.airMngNum+'('+b.equiInfoKeyHan+')</h3>';
            }
            var content =
                '<div class="info" style="top: -320px; left: -173px;">'+
                '	<div class="close" onclick="map.closePopup();"><i class="xi-close"></i></div>'+
                title+
                '	<p style="margin: 6px 0">주소 : '+b.instLoc +'</p>'+
                '	<table>'+
                '		<tr>'+
                '			<th>미세먼지(㎍/㎥)</th><td class="co_step'+color+'">'+pm10+'</td>'+
                '			<th>풍향/풍속(㎧)</th><td>'+_this.parseWind(_this.parseNumber(b.windDire))+'/'+_this.parseNumber(b.windSpeed)+'</td>'+
                '			<th>일산화탄소(ppm)</th><td>'+_this.parseNumber(b.co)+'</td>'+
                '		</tr>'+
                '		<tr>'+
                '			<th>초미세먼지(㎍/㎥)</th><td class="co_step'+color2+'">'+pm25+'</td>'+
                '			<th>조도(lx)</th><td>'+_this.parseNumber(b.inteIllu)+'</td>'+
                '			<th>이산화질소(ppb)</th><td>'+_this.parseNumber(b.no2)+'</td>'+
                '		</tr>'+
                '		<tr>'+
                '			<th>소음(dB)</th><td>'+_this.parseNumber(b.noise)+'</td>'+
                '			<th>자외선(UVI)</th><td>'+_this.parseNumber(b.ultraRays)+'</td>'+
                '			<th>이산화황(ppb)</th><td>'+_this.parseNumber(b.so2)+'</td>'+
                '		</tr>'+
                '		<tr>'+
                '			<th>온도(℃)</th><td>'+_this.parseNumber(b.temp, "temp")+'</td>'+
                '			<th>진동-X축(g)</th><td>'+_this.parseNumber(b.vibrX)+'</td>'+
                '			<th>암모니아(ppb)</th><td>'+_this.parseNumber(b.nh3)+'</td>'+
                '		</tr>'+
                '		<tr>'+
                '			<th>습도(%)</th><td>'+_this.parseNumber(b.humi)+'</td>'+
                '			<th>진동-Y축(g)</th><td>'+_this.parseNumber(b.vibrY)+'</td>'+
                '			<th>황화수소(ppb)</th><td>'+_this.parseNumber(b.h2s)+'</td>'+
                '		</tr>'+
                '		<tr>'+
                '			<th>진동-Z축(g)</th><td>'+_this.parseNumber(b.vibrZ)+'</td>'+
                '			<th>흑구(℃)</th><td>'+_this.parseNumber(b.effeTemp, 'temp')+'</td>'+
                '			<th>오존(ppb)</th><td>'+_this.parseNumber(b.o3)+'</td>'+
                '		</tr>'+
                '	</table>'+
                '</div>';
            if(b.gpsAbb != null || b.gpsLat != null) {
        		setPoint(map, "a"+i, b.gpsAbb, b.gpsLat, content, img);
            }
            
        })
        
        return {
        	crit: {
        		num: crit,
        		data: critData
        	},
        	bad: {
        		num: bad,
        		data: badData
        	},
        	normal: {
        		num: normal,
        		data: normalData
        	},
        	good: {
        		num: good,
        		data: goodData
        	},
        	no: {
        		num: no,
        		data: noData
        	}
        }
    },
    mapInit : function(map){
		map = L.map('map', {
			continuousWorld: true
			,worldCopyJump: false
			,zoomControl: true
			,zoomAnimation: true
			,markerZoomAnimation: true
			,fadeAnimation : true
			,inertia : false
			,closePopupOnClick : false
			,attributionControl : true
		});
		
		map.setView([37.5683206, 126.9905207], 10);  //지도 좌표 이동
		
		BaseMapChange(map, L.Dawul.BASEMAP_GEN);  // 일반지도
		
		// 스케일바
		var scaleBar = new L.Control.Scale({position:'bottomright'});
        map.addControl(scaleBar);
        
        return map;
    },
    parseWind: function(num) {
        var han = "-"
        if(!num) {
            return "-";
        }
        if(typeof(num) != "number") {
			return "-";
        }

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
        
        
        
        return han;
    },
    parseNumber: function(data, option) {
        if(data == 0) {
            return data;
        }

        data = Number(data);
        
        if(data == -999|| isNaN(data) || !data) {
            return "-";
        } else if(option == "temp"){
            if(data <= -100) {
                return '-'
            }
        	return (data/10 - 100).toFixed(1);
        } else {
            return data;
        }
    },
    infoCount : function(data, target) {
		var count = 0;
		$.each(data, function(a, b) {
			if(b[target] = -999) {
				count++;
			}	
		})
		return count;
	}
}