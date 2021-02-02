function ieTime(data) {
  if (typeof data == "object") {
    return data;
  }

  var a = data.split(" ");
  var ymd = a[0].split("-");
  var hm = a[1].split(":");

  return new Date(ymd[0], Number(ymd[1]) - 1, ymd[2], hm[0], hm[1]);
}
function calcDire(num, type) {
  // console.log(type);
  var result = 0;
  var han = "";
  if (num > 348.75 && num <= 11.25) {
    result = 180;
    han = "남";
  }
  if (num > 11.25 && num <= 33.75) {
    result = 202.5;
    han = "남남서";
  }
  if (num > 33.75 && num <= 56.25) {
    result = 225;
    han = "남서";
  }
  if (num > 56.25 && num <= 78.75) {
    result = 247.5;
    han = "서남서";
  }
  if (num > 78.75 && num <= 101.25) {
    result = 270;
    han = "서";
  }
  if (num > 101.25 && num <= 123.75) {
    result = 292.5;
    han = "서북서";
  }
  if (num > 123.75 && num <= 146.25) {
    result = 315;
    han = "북서";
  }
  if (num > 146.25 && num <= 168.75) {
    result = 337.5;
    han = "북북서";
  }
  if (num > 168.75 && num <= 191.25) {
    result = 0;
    han = "북";
  }
  if (num > 191.25 && num <= 213.75) {
    result = 22.5;
    han = "북북동";
  }
  if (num > 213.75 && num <= 236.25) {
    result = 45;
    han = "북동";
  }
  if (num > 236.25 && num <= 258.75) {
    result = 67.5;
    han = "동북동";
  }
  if (num > 258.75 && num <= 281.25) {
    result = 90;
    han = "동";
  }
  if (num > 281.25 && num <= 303.75) {
    result = 112.5;
    han = "동남동";
  }
  if (num > 303.75 && num <= 326.25) {
    result = 135;
    han = "남동";
  }
  if (num > 326.25 && num <= 348.75) {
    result = 157.5;
    han = "남남동";
  }
  if (typeof num != "number") {
    return "-";
  } else {
    if ((type = "han")) {
      return han + " (" + num + "°)";
    }
    return (
      '<img src="/share/img/arrow_top.png" style="width:30px; height:30px; transform: rotate(' +
      result +
      'deg)"/>' +
      num +
      "°"
    );
  }
}
function am4Generate(data, field, target) {
  am4core.ready(function () {
    var chart = am4core.create(target, am4charts.XYChart);
    chart.language.locale = am4lang_ko_KR;
    chart.colors.step = 0;
    $.each(data, function (a, b) {
      data[a]["tm8"] = ieTime(data[a]["tm8"]);
    });

    chart.data = data;

    var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
    dateAxis.renderer.grid.template.location = 2;

    chart.dateFormatter.dateFormat = "MMM dd일 HH시";
    dateAxis.dateFormats.setKey("hour", "MMM dd일 HH시");
    dateAxis.periodChangeDateFormats.setKey("hour", "MMM dd일 HH시");
    dateAxis.dateFormats.setKey("minute", "dd일 HH시 mm분");
    dateAxis.periodChangeDateFormats.setKey("minute", "dd일 HH시 mm분");

    // console.log(dateAxis);
    var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

    // Create series
    function createSeries(field, name, count) {
      var interfaceColors = [
        "#5571c6",
        "#55c6c2",
        "#db9d61",
        "#0D8ECF",
        "#2A0CD0",
        "#CD0D74",
        "#CC0000",
        "#00CC00",
        "#0000CC",
        "#DDDDDD",
        "#999999",
        "#333333",
        "#990000",
        "#96C5F7",
        "#A9D3FF",
        "#00BFFF",
      ];
      var series = chart.series.push(new am4charts.LineSeries());
      series.dataFields.valueY = field;
      series.dataFields.dateX = "tm8";
      series.name = name;
      series.tooltipText = name + ": [b]{valueY}[/]";
      series.strokeWidth = 2;
      series.minBulletDistance = 100;
      series.fill = interfaceColors[count];
      series.stroke = interfaceColors[count];

      if (count > 1) {
        series.hidden = true;
      }
      var bullet = series.bullets.push(new am4charts.CircleBullet());
      bullet.circle.stroke = interfaceColors[count];
      bullet.circle.strokeWidth = 2;
      series.events.on("hit", toggleAxes);
      series.events.on("ready", toggleAxes2);
      return series;
    }
    var scrollbarX = new am4charts.XYChartScrollbar();
    var count = 0;
    $.each(field, function (a, b) {
      // console.log(a, b);
      var series = createSeries(a, b, count);
      count++;
    });
    chart.scrollbarX = scrollbarX;

    function toggleAxes(ev) {
      // console.log(ev);
    }
    function toggleAxes2(ev) {
      // console.log("ready", ev.maxValue, valueAxis.max);
    }
    chart.legend = new am4charts.Legend();
    chart.cursor = new am4charts.XYCursor();
  }); // end am4core.ready()
}

$(document).ready(function () {
  var count = 2;
  $(".equi_search_btn").click(function (e) {
    e.preventDefault();
    var to = $("#to").val();
    var toDate = to.substr(0, 4) + to.substr(5, 2) + to.substr(8, 2);
    var from = $("#from").val();
    var fromDate = from.substr(0, 4) + from.substr(5, 2) + from.substr(8, 2);
    var gu = $("#gu").val();
    var equi = $("#equi").val();

    count = 2;
    $(".list").html("");
    if (to != "" && from != "" && gu != "구 선택" && equi != "기기 선택") {
      var pageNum = "${param.page}";
      if (pageNum == "") pageNum = "1";

      $.ajax({
        url: "/api/sensor/equiSearchList",
        type: "POST",
        data: {
          toDate: toDate,
          fromDate: fromDate,
          gu: gu,
          equiInfoKey: equi,
          "${_csrf.parameterName}": "${_csrf.token}",
          pageStart: 1,
        },
        beforeSend: function () {
          $(".loader").show();
          $(".dim_search").show();
        },
        success: function (r) {
          // console.log(r.allData);
          $(".loader").hide();
          $(".dim_search").hide();
          var adata = sensor.rowSet(r.data);
          // console.log(adata);
          var rows = r.allData;
          am4Generate(
            r.allData,
            {
              pm10: "미세먼지",
              pm25: "초미세먼지",
              temp: "온도",
              noise: "소음",
              humi: "습도",
              ultraRays: "자외선",
              vibrX: "X축",
              vibrY: "Y축",
              vibrZ: "Z축",
              effeTemp: "흑구",
              co: "일산화탄소",
              no2: "이산화질소",
              so2: "이산화황",
              nh3: "암모니아",
              h2s: "황화수소",
              o3: "오존",
            },
            "amChart"
          );
          $("#example").DataTable().clear().draw();
          $("#example").DataTable().rows.add(adata).draw();
          am4Generate(r.allData, { inteIllu: "조도" }, "amChart2");

          if (r.data.length == 0) {
            alert("조건에 만족하는 데이터가 없습니다.");
          }
        },
      });
    } else {
      alert("비어있는 값이 있습니다.");
    }
  });
});
