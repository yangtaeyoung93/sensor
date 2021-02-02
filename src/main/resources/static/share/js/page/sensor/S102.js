var map = null;
var miniMap = null;

var mapInit = function () {
  map = L.map("map", {
    continuousWorld: true,
    worldCopyJump: false,
    zoomControl: true,
    zoomAnimation: true,
    markerZoomAnimation: true,
    fadeAnimation: true,
    inertia: false,
    closePopupOnClick: false,
    attributionControl: true,
  });

  map.setView([37.5302862, 126.9854131], 6); //지도 좌표 이동

  BaseMapChange(map, L.Dawul.BASEMAP_GEN); // 일반지도

  // 스케일바
  var scaleBar = new L.Control.Scale({ position: "bottomright" });
  map.addControl(scaleBar);

  return map;
};

$(document).ready(function () {
  function receivedCount(totalData) {
    var timeDiff;
    var receiveNum = 0;
    var unreceiveNum = 0;
    var recentDate = new Date();

    for (var i in totalData) {
      timeDiff = recentDate.getTime() - new Date(totalData[i].regDate);

      if (timeDiff / 1000 / 60 >= 10) {
        unreceiveNum++;
      }
    }

    receiveNum = totalData.length - unreceiveNum;

    return [receiveNum, unreceiveNum];
  }

  function loader(flag) {
    if (flag) {
      $(".loader").show();
      $(".dim").show();
    } else {
      $(".loader").hide();
      $(".dim").hide();
    }
  }
  var map = mapInit();
  var parseData = [];
  var recCount = [];
  $.ajax({
    url: "/api/equiGps",
    type: "GET",
    dataType: "json",
    beforeSend: function () {
      loader(true);
    },
    success: function (r) {
      // console.log(r.data);
      mapjs.data.data = r.data;
      mapjs.marker(r.data, "sensor");
      parseData = r.data;

      recCount = receivedCount(parseData);

      // count 표출 부분
      $("#receive_count span").html(recCount[0]);
      $("#unreceive_count span").html(recCount[1]);

      $(".marker-count span").html(parseData.length);
      map.setView([37.5302862, 126.9854131], 6);
      mapjs.marker(parseData, "sensor");
    },
    complete: function () {
      loader(false);
    },
  });
  $(".notice a").click(function () {
    $(".notice-box").toggle();
  });
  $("#sensorStatus").click(function () {
    loader(true);
    map.setView([37.5302862, 126.9854131], 6);
    map.closePopup();
    $(".pm25Table").hide();
    $(".pm10Table").hide();
    $(".notice").hide();
    $(".notice-box").hide();
    $(".leaflet-marker-icon").remove();

    recCount = receivedCount(parseData);
    $("#receive_count span").html(recCount[0]);
    $("#unreceive_count span").html(recCount[1]);

    $(".marker-count span").html(parseData.length);
    mapjs.marker(parseData, "sensor");
    // loader(false);
  });
  $("#pm10Status").click(function () {
    $(".notice").show();
    $(".notice-box").hide();
    $(".pm25Table").hide();
    $(".pm10Table").show();
    map.setView([37.5302862, 126.9854131], 6);
    map.closePopup();

    recCount = receivedCount(parseData);
    $("#receive_count span").html(recCount[0]);
    $("#unreceive_count span").html(recCount[1]);
    // console.log(parseData);
    $(".marker-count span").html(parseData.length);
    $(".leaflet-marker-icon").remove();
    var parseNum = mapjs.marker(parseData, "pm10");
    // console.log(parseNum);
    setTimeout(function () {
      listSet("good", parseNum);
      listSet("normal", parseNum);
      listSet("bad", parseNum);
      listSet("crit", parseNum);
    }, 3000);
    $(".pm10Table thead th:nth-child(1)").text(
      "좋음 (" + parseNum.good.num + ")"
    );
    $(".pm10Table thead th:nth-child(2)").text(
      "보통 (" + parseNum.normal.num + ")"
    );
    $(".pm10Table thead th:nth-child(3)").text(
      "나쁨 (" + parseNum.bad.num + ")"
    );
    $(".pm10Table thead th:nth-child(4)").text(
      "매우나쁨 (" + parseNum.crit.num + ")"
    );
  });

  function listSet(target, data) {
    $("#" + target + "ListTable").html("");
    var tableNo = 0;
    text =
      "<tr><th style='width: 60px;'><h5><strong>NO</strong></h5></th>" +
      "<th><h5><strong>기기 코드</strong></h5></th>" +
      "<th><h5><strong>기기 명</strong></h5></th>";
    $.each(data[target].data, function (a, b) {
      tableNo++;
      text +=
        "<tr><td><strong>" +
        tableNo +
        "</strong></td><td><strong>" +
        b.equiInfoKey +
        "</strong></td><td><strong>" +
        b.equiInfoKeyHan +
        "</strong></td></tr>";
      $("#" + target + "ListTable").html(text);
    });
  }

  $("#pm25Status").click(function () {
    $(".notice").show();
    $(".notice-box").hide();
    $(".pm25Table").show();
    $(".pm10Table").hide();
    map.setView([37.5302862, 126.9854131], 6);
    map.closePopup();

    recCount = receivedCount(parseData);
    $("#receive_count span").html(recCount[0]);
    $("#unreceive_count span").html(recCount[1]);

    $(".marker-count span").html(parseData.length);
    $(".leaflet-marker-icon").remove();
    var parseNum = mapjs.marker(parseData, "pm25");
    // console.log(parseNum);
    setTimeout(function () {
      listSet("good", parseNum);
      listSet("normal", parseNum);
      listSet("bad", parseNum);
      listSet("crit", parseNum);
    }, 3000);
    $(".pm25Table thead th:nth-child(1)").text(
      "좋음 (" + parseNum.good.num + ")"
    );
    $(".pm25Table thead th:nth-child(2)").text(
      "보통 (" + parseNum.normal.num + ")"
    );
    $(".pm25Table thead th:nth-child(3)").text(
      "나쁨 (" + parseNum.bad.num + ")"
    );
    $(".pm25Table thead th:nth-child(4)").text(
      "매우나쁨 (" + parseNum.crit.num + ")"
    );
  });

  $(".dropdown-menu.gu li").click(function () {
    map.setView([37.5302862, 126.9854131], 6);
    $(".notice").hide();
    $(".notice-box").hide();
    $(".pm25Table").hide();
    $(".pm10Table").hide();
    map.closePopup();
    $(".leaflet-marker-icon").remove();
    // console.log($(this).data("tp"));
    var tp = $(this).data("tp");
    if (tp == "all") {
      parseData = mapjs.data.data;
      recCount = receivedCount(parseData);
      $("#receive_count span").html(recCount[0]);
      $("#unreceive_count span").html(recCount[1]);

      $(".marker-count span").html(parseData.length);
      mapjs.marker(mapjs.data.data, "sensor");
    } else {
      parseData = [];
      // console.log(parseData);
      $.each(mapjs.data.data, function (a, b) {
        if (tp == "baramYn=Y") {
          if (b.baramYn == "Y") {
            parseData.push(mapjs.data.data[a]);
          }
        }
        if (tp == "airYn=Y") {
          if (b.airYn == "Y") {
            parseData.push(mapjs.data.data[a]);
          }
        }
        if (b.guTp == tp) {
          if (b.baramYn != "Y" && b.airYn != "Y") {
            parseData.push(mapjs.data.data[a]);
          }
          if (b.airYn == "Y") {
            parseData.push(mapjs.data.data[a]);
          }
        }
      });

      recCount = receivedCount(parseData);
      $("#receive_count span").html(recCount[0]);
      $("#unreceive_count span").html(recCount[1]);

      $(".marker-count span").html(parseData.length);
      mapjs.marker(parseData, "sensor");
    }
  });
});
