
//마커 표현 및 툴팁 샘플
function setPoint(map, t,a, b, content, img) {
	if(a == null || b == null) {
		return ;
	}
	eval("var "+t+"= null");
	// mkClear(t);
	t = new L.Marker(new L.LatLng(a,b),{icon: new L.Icon({   // 마커 찍기
    	iconUrl: "/share/img/"+img,   //핀 이미지
		iconAnchor: [13,34],  // 오프셋 (핀의 끝이 좌표로 매칭하기 위해 적용)
		title: "title"
    })}).addTo(map);
	
	t.bindPopup(mkContent(content),{
		maxWidth:20,          //가로 최대 크기
		offset:[0,-30],          //오프셋
		keepInView:false,      //팝업이 열려 있는동안 지도 벗어나게 이동 막기
		autoPan:true,          //팝업창이 지도에서 안보일시 보이는 위치까지 자동 지도 이동
		closeButton:false      //팝업 닫기 버튼 유,무
		//'className':'dawul'    //팝업 테두리 없애기  (팝업 기본 테두리를 없애시려면 추가  중요:dw_popup.css 추가 시켜줘야 함.  테두리 제거 css가 들어있음)
	});

	// t는 Object이므로 커스텀 변수를 추가할 수 있다.
	t.addData = { 'lat':a, 'lng':b};

	t.on('click',(function(e) {
		console.log(e.target.addData.lat);
		map.setView([ a,b ], 10);
	}));
	
	
	/*var aaa = new Array();
	for(var i=0; i<13; i++) {
		aaa.push("aaaa"+i);
	}
	marker.bindPopup(popupContents(aaa),{
		maxWidth:20,          //가로 최대 크기
		offset:[35,-15],          //오프셋
		keepInView:false,      //팝업이 열려 있는동안 지도 벗어나게 이동 막기
		autoPan:true,          //팝업창이 지도에서 안보일시 보이는 위치까지 자동 지도 이동
		closeButton:false,     //팝업 닫기 버튼 유,무
		'className':'dawul'    //팝업 테두리 없애기  (팝업 기본 테두리를 없애시려면 추가  중요:dw_popup.css 추가 시켜줘야 함.  테두리 제거 css가 들어있음)
	});*/
	return t;
}
//마커 툴팁 내용 샘플
function mkContent(content){
	html_ = "<p>"+content+"</p>";
	return html_;
}

//마커 삭제
function mkClear(marker) {
	if(marker!=null) {
		map.removeLayer(marker);
		marker = null;
	}
}
