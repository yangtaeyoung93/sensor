/*
 * 통합 상태 정보 조회
 */
var chartBarOne;
var chartBarTwo;
var chartBarInnorDataOne;
var chartBarInnorDataTwo;

var totalAmChart = {
  areaWareChartBar: function (target, data) {
    // 2번 영역

    chartBarOne = am4core.create(target, am4charts.XYChart);
    chartBarInnorDataOne = data;

    chartBarOne.data = chartBarInnorDataOne;
    chartBarOne.scrollbarX = new am4core.Scrollbar();

    var categoryAxis = chartBarOne.xAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "equiType";
    categoryAxis.renderer.grid.template.location = 0;
    categoryAxis.renderer.minGridDistance = 30;

    var valueAxis = chartBarOne.yAxes.push(new am4charts.ValueAxis());
    valueAxis.title.text = "센서 수(량)";
    valueAxis.title.fontWeight = 800;

    var series = chartBarOne.series.push(new am4charts.ColumnSeries());
    series.dataFields.valueY = "normalEquiCnt";
    series.dataFields.categoryX = "equiType";
    series.clustered = false;
    series.tooltipText = "수신 기기: [bold]{valueY}[/]";

    var series2 = chartBarOne.series.push(new am4charts.ColumnSeries());
    series2.dataFields.valueY = "badEquiCnt";
    series2.dataFields.categoryX = "equiType";
    series2.clustered = false;
    series2.columns.template.width = am4core.percent(50);
    series2.tooltipText = "미수신 기기: [bold]{valueY}[/]";

    chartBarOne.cursor = new am4charts.XYCursor();
    chartBarOne.cursor.lineX.disabled = true;
    chartBarOne.cursor.lineY.disabled = true;
  },
  statusWareChartBar: function (target, data) {
    // 3번 영역
    chartBarTwo = am4core.create(target, am4charts.XYChart);
    chartBarInnorDataTwo = data;

    chartBarTwo.data = chartBarInnorDataTwo;
    chartBarTwo.scrollbarX = new am4core.Scrollbar();

    var categoryAxis = chartBarTwo.xAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "equiTypeHan";
    categoryAxis.renderer.grid.template.location = 0;
    categoryAxis.renderer.minGridDistance = 30;

    var valueAxis = chartBarTwo.yAxes.push(new am4charts.ValueAxis());
    valueAxis.title.text = "센서 수(량)";
    valueAxis.title.fontWeight = 800;

    var series = chartBarTwo.series.push(new am4charts.ColumnSeries());
    series.dataFields.valueY = "normalEquiCnt";
    series.dataFields.categoryX = "equiTypeHan";
    series.clustered = false;
    series.tooltipText = "정상 기기: [bold]{valueY}[/]";

    var series2 = chartBarTwo.series.push(new am4charts.ColumnSeries());
    series2.dataFields.valueY = "badEquicnt";
    series2.dataFields.categoryX = "equiTypeHan";
    series2.clustered = false;
    series2.columns.template.width = am4core.percent(50);
    series2.tooltipText = "비 정상 기기: [bold]{valueY}[/]";

    chartBarTwo.cursor = new am4charts.XYCursor();
    chartBarTwo.cursor.lineX.disabled = true;
    chartBarTwo.cursor.lineY.disabled = true;
  },
};

//측정 데이터 상태 Name 필터링
function dataNameFilter(apiData) {
  var filterName, dataName;
  // console.log(apiData);
  for (var i in apiData) {
    dataName = apiData[i].category;

    switch (dataName) {
      case "PM10":
        filterName = "미세먼지";
        break;
      case "PM25":
        filterName = "초미세먼지";
        break;
      case "TEMP":
        filterName = "기온";
        break;
      case "HUMI":
        filterName = "상대습도";
        break;
      case "WIND_DIRE":
        filterName = "풍향";
        break;
      case "WIND_SPEED":
        filterName = "풍속";
        break;
      case "INTE_ILLU":
        filterName = "조도";
        break;
      case "ULTRA_RAYS":
        filterName = "자외선";
        break;
      case "NOISE":
        filterName = "소음";
        break;
      case "CO":
        filterName = "일산화탄소";
        break;
      case "NO2":
        filterName = "이산화질소";
        break;
      case "SO2":
        filterName = "이산화황";
        break;
      case "NH3":
        filterName = "암모니아";
        break;
      case "H2S":
        filterName = "황화수소";
        break;
      case "O3":
        filterName = "오존";
        break;
      default:
      // console.log("없는 상태입니다. ", dataName);
    }
    apiData[i].filterCategory = filterName;
  }
  // console.log(apiData);
  return apiData;
}

// AmChart에서 이용할 Data 필터링
function dataFilter(apiData) {
  var r = [];
  var flag = apiData[0].wareTp;
  console.log(flag);
  var obj = {};
  apiData.map(function (list, index) {
    console.log(r, flag, index);

    if (flag != list.wareTp || index + 1 == apiData.length) {
      if (!obj["successCnt"]) {
        obj.successCnt = 0;
      }
      obj.category = flag;
      r.push(obj);
      flag = list.wareTp;
      obj = {};
    }

    if (list.dataCheck == "1") {
      obj.successCnt = list.wareCnt;
    } else if (list.dataCheck == "0") {
      obj.failCnt = list.wareCnt;
    }
  });

  // console.log("resultList", r);
  return r;
}

// 1번 영역, 수신 미수신 카운팅 함수 .
function receivedCount(totalData) {
  var receiveNum = 0;
  var unreceiveNum = 0;

  $.ajax({
    // Modal 영역  * 미수신 데이터 목록 . *
    url: "/api/sensor/unreceiveWareList",
    type: "GET",
    datType: "json",
    async: false,
    success: function (r) {
      unreceiveNum = r.data.length;
    },
  });

  $.ajax({
    // Modal 영역  * 수신 데이터 목록 . *
    url: "/api/sensor/receiveWareList",
    type: "GET",
    datType: "json",
    async: false,
    success: function (r) {
      receiveNum = r.data.length;
    },
  });

  return [receiveNum, unreceiveNum];
}

// 3번 영역
function wareDataTable(dataList) {
  function parseData(data) {
    var parse = [];

    for (i in data) {
      if (parse[data[i].wareTp] == null) {
        parse[data[i].wareTp] = new Array();
      }
      // console.log(i);
      parse[data[i].wareTp][data[i].dataCheck] = data[i];
    }

    return parse;
  }

  function getWareCnt(data) {
    if (typeof data != "undefined") {
      return data.wareCnt;
    } else {
      return 0;
    }
  }
  var text;
  var tableNo = 0;

  var filterDataList = parseData(dataList);
  // console.log(filterDataList);
  text =
    "<tr><th style='text-align: center'><h5><strong>측정 데이터</strong></h5></th>" +
    "<th style='text-align: center'><h5><strong>설치현황</strong></h5></th>" +
    "<th style='text-align: center'><h5><strong>정상장비</strong></h5></th>" +
    "<th style='text-align: center'><h5><strong>이상장비</strong></h5></th></tr>";

  function generateData(list) {
    var sort = [];
    list.map(function (data) {
      switch (data.equiType) {
        case "pm10":
          data.equiTypeHan = "미세먼지";
          data.param = "pm10";
          sort[1] = data;
          break;
        case "pm25":
          data.equiTypeHan = "초미세먼지";
          data.param = "pm25";
          sort[2] = data;
          break;
        case "noise":
          data.equiTypeHan = "소음";
          data.param = "noise";
          sort[3] = data;
          break;
        case "temp":
          data.equiTypeHan = "온도";
          data.param = "temp";
          sort[4] = data;
          break;
        case "humi":
          data.equiTypeHan = "습도";
          data.param = "humi";
          sort[5] = data;
          break;
        case "wind_dire":
          data.equiTypeHan = "풍향";
          data.param = "windDire";
          sort[6] = data;
          break;
        case "wind_speed":
          data.equiTypeHan = "풍속";
          data.param = "windSpeed";
          sort[7] = data;
          break;
        case "inte_illu":
          data.equiTypeHan = "조도";
          data.param = "inteIllu";
          sort[8] = data;
          break;
        case "ultra_rays":
          data.equiTypeHan = "자외선";
          data.param = "ultraRays";
          sort[9] = data;
          break;
        case "vibr":
          data.equiTypeHan = "진동";
          data.param = "vibr";
          sort[10] = data;
          break;
        case "effe_temp":
          data.equiTypeHan = "흑구";
          data.param = "effeTemp";
          sort[11] = data;
          break;
        case "co":
          data.equiTypeHan = "일산화탄소";
          data.param = "co";
          sort[12] = data;
          break;
        case "no2":
          data.equiTypeHan = "이산화질소";
          data.param = "no2";
          sort[13] = data;
          break;
        case "so2":
          data.equiTypeHan = "이산화황";
          data.param = "so2";
          sort[14] = data;
          break;
        case "nh3":
          data.equiTypeHan = "암모니아";
          data.param = "nh3";
          sort[15] = data;
          break;
        case "h2s":
          data.equiTypeHan = "황화수소";
          data.param = "h2S";
          sort[16] = data;
          break;
        case "o3":
          data.equiTypeHan = "오존";
          data.param = "o3";
          sort[17] = data;
          break;
        default:
          data.equiTypeHan = "전체";
          data.param = "all";
          sort[0] = data;
      }
    });

    return sort;
  }
  function generateTrTd(data) {
    return (
      "<tr><td style='text-align: center;'>" +
      data.equiTypeHan +
      "</td><td style='text-align: center;'>" +
      data.equiCnt +
      "</td><td style='text-align: center;'><span style='color: #69A2ED'>" +
      data.normalEquiCnt +
      "</span></td><td class='badWareCat' data-type='" +
      data.param +
      "' style='color: #FA8072; text-align: center;'><span style='color: #FA8072'>" +
      data.badEquiCnt +
      "</span></td></tr>"
    );
  }
  var month =
    new Date().getMonth() + 1 < 10
      ? "0" + (new Date().getMonth() + 1)
      : new Date().getMonth() + 1;
  var day =
    new Date().getDate() < 10
      ? "0" + new Date().getDate()
      : new Date().getDate();
  var date = new Date().getFullYear().toString() + "" + month + "" + day;
  $.ajax({
    url: "/api/sensor/getDailyCntForEqui",
    method: "POST",
    data: {
      toDate: date,
      fromDate: date,
    },
    success: function (r) {
      console.log(r);
      // tr -> td
      var result = generateData(r.data);
      result.map(function (list) {
        if (list.equiType == "all") {
          list.equiType = "전체";
          //1번 영역 수정
          $("#totalCount span").html(list.equiCnt);
          $("#receiveCount span").html(list.normalEquiCnt);
          $("#unreceiveCount span").html(list.badEquiCnt);
        }
        text += generateTrTd(list);
      });

      totalAmChart.statusWareChartBar("statusWareChartBar", result);

      $("#wareDataTb").html(text);
    },
  });
}

//Ware List Modal 영역 (수신 기기&미수신 기기 목록)
function wareListDataTable(dataList, reciveFlag) {
  var text, noDataText, wareCatMsg, noticeMsg;
  var tableNo = 0;

  if (reciveFlag) {
    wareCatMsg = "수신 기기";
    noticeMsg = "수신중인 기기가 없습니다.";
  } else {
    wareCatMsg = "미수신 기기";
    noticeMsg = "미수신 기기가 없습니다.";
  }

  text =
    "<tr><th style='width: 60px;'><h5><strong>NO</strong></h5></th>" +
    "<th><h5><strong>설치 지역</strong></h5></th>" +
    "<th><h5><strong>기기 명</strong></h5></th>" +
    "<th><h5><strong>최종 수신 시각</strong></h5></th>";

  for (var i in dataList) {
    tableNo++;
    text +=
      "<tr><td><strong>" +
      tableNo +
      "</strong></td><td><strong>" +
      dataList[i].wareTp +
      "</strong></td><td><strong>" +
      dataList[i].wareName +
      "</strong></td><td><strong>" +
      dataList[i].lastDate +
      "</strong></td></tr>";
  }

  if (dataList.length == 0 || dataList == null) {
    noDataText = "<br/><br/><h4><strong>" + noticeMsg + "</strong></h4>";
    $("#noticeMsgDiv").html(noDataText);
  } else {
    $("#noticeMsgDiv").html("");
  }

  $("#wareCatMsg").html(wareCatMsg);
  $("#wareListTable").html(text);
}

//Ware List Modal 영역 (측정 데이터 상태에 따른 기기 목록)
function statusWareListDataTable(dataList) {
  var text, noDataText, noticeMsg;
  var tableNo = 0;

  noticeMsg = "이상 기기가 없습니다.";

  text =
    "<tr><th style='width: 60px;'><h5><strong>NO</strong></h5></th>" +
    "<th><h5><strong>설치 지역</strong></h5></th>" +
    "<th><h5><strong>기기 명</strong></h5></th>";

  for (var i in dataList.list) {
    var guName = dataList.code.filter(function (list) {
      return list.code == dataList.list[i].guTp;
    });
    console.log(guName);
    tableNo++;
    text +=
      "<tr><td><strong>" +
      tableNo +
      "</strong></td><td><strong>" +
      guName[0].relCd1 +
      "</strong></td><td><strong>" +
      dataList.list[i].equiInfoKey +
      "</strong></td></tr>";
  }

  if (dataList.list.length == 0 || dataList == null) {
    noDataText = "<br/><br/><h4><strong>" + noticeMsg + "</strong></h4>";
    $("#statusNoticeMsgDiv").html(noDataText);
  } else {
    $("#statusNoticeMsgDiv").html("");
  }

  $("#statusWareListTable").html(text);
}

/**
 * Ware List Modal 표출용 Click Event
 *  - Ware List의 경우 페이지 부하를 줄이기 위해 실시간 처리는 지양 .
 */
function wareListCliEve() {
  $("#receiveCount").click(function () {
    $("#wareCatMsg").html("");
    $("#wareListTable").html("");
    $("#noticeMsgDiv").html("리스트를 가져오는중입니다.");

    $.ajax({
      // Modal 영역  * 수신 데이터 목록 . *
      url: "/api/sensor/receiveWareList",
      type: "GET",
      datType: "json",
      success: function (r) {
        wareListDataTable(r.data, true);
      },
    });
  });

  $("#unreceiveCount").click(function () {
    $("#wareCatMsg").html("");
    $("#wareListTable").html("");
    $("#noticeMsgDiv").html("리스트를 가져오는중입니다.");

    $.ajax({
      // Modal 영역  * 미수신 데이터 목록 . *
      url: "/api/sensor/unreceiveWareList",
      type: "GET",
      datType: "json",
      success: function (r) {
        wareListDataTable(r.data, false);
      },
    });
  });
}

var loadCheck = true;

//10초 주기 갱신
function realTimeData() {
  var parseData = [];
  var recCount = [];
  var wareFilterDatas = [];

  $.ajax({
    url: "/api/sensor/getEquiCnt",
    success: function (r) {
      console.log(r.data);
      totalAmChart.areaWareChartBar("areaWareChartBar", r.data);
    },
  });
  wareDataTable(null);
}

$().ready(function () {
  wareListCliEve();
  realTimeData();
});
