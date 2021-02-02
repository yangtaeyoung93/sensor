function infoSelect(target, data, parse) {
  var text = "";
  var relCd = "";
  var equiCode = "";
  $.each(data, function (a, b) {
    if (b != null) {
      equiCode = b.code;
      relCd = b.relCd1;

      if (equiCode == 5) {
        relCd = "풍향 / 풍속";
      }

      if (equiCode != 6) {
        if (b != null) {
          if (b.sortCd == parse) {
            if (b.relCd1 == "null") {
              text +=
                "<option value='" + b.code + "'>" + b.codeNm + "</option>";
            } else {
				if (equiCode != 5) {
					text += "<option value='" + b.code + "'>" + relCd + "</option>";
				}
            }
          }
        }
      }
    }
  });

  $("#" + target).append(text);
}

function dateDiff(_date1, _date2) {
  var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
  var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);

  diffDate_1 = new Date(
    diffDate_1.getFullYear(),
    diffDate_1.getMonth() + 1,
    diffDate_1.getDate()
  );
  diffDate_2 = new Date(
    diffDate_2.getFullYear(),
    diffDate_2.getMonth() + 1,
    diffDate_2.getDate()
  );

  var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
  diff = Math.ceil(diff / (1000 * 3600 * 24));

  return diff;
}

function ieTime(data) {
  if (typeof data == "object") {
    return data;
  }

  return new Date(data.substr(0, 4), data.substr(4, 2) - 1, data.substr(6, 2))
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
      return series;
    }
    var count = 0;
    $.each(field, function (a, b) {
      // console.log(a, b);
      var series = createSeries(a, b, count);
      count++;
    });


    chart.cursor = new am4charts.XYCursor();
  }); // end am4core.ready()
}

$(document).ready(function () {
  $.ajax({
    url: "/api/sensor/equiCommon",
    type: "GET",
    success: function (r) {
      infoSelect("sel-1", r.data, "측정요소");
    },
  });

  var count = 2;
  $(".search_btn").click(function (e) {
    e.preventDefault();
    var to = $("#to").val();
    var toDate = to.substr(0, 4) + to.substr(5, 2) + to.substr(8, 2);
    var from = $("#from").val();
    var fromDate = from.substr(0, 4) + from.substr(5, 2) + from.substr(8, 2);
    var stx = $("#sel-1").val();

    var windFlag = false;

    // stx 5일 경우 풍향, stx 6일 경우 풍속
    if (stx == 5 || stx == 6) {
      windFlag = true;
    }
    if (stx == 5) {
      toDate = to;
      fromDate = dateDiff(to, from);
    }
    count = 2;
    $(".list").html("");
    if (to != "" && from != "" && stx != "측정요소 선택") {
      var pageNum = "${param.page}";
      if (pageNum == "") pageNum = "1";

      $.ajax({
        url: "/api/sensor/guDataAvg",
        type: "POST",
        data: {
          toDate: toDate,
          fromDate: fromDate,
          stx: stx,
          "${_csrf.parameterName}": "${_csrf.token}",
          pageStart: 1,
        },
        beforeSend: function () {
          $(".loader").show();
          $(".dim_search").show();
        },
        success: function (r) {
          if (r.data.length == 0) {
            alert("조건에 만족하는 데이터가 없습니다.");
          }
          var _toDate = toDate;
          var _fromDate = fromDate;
          var _stx = stx;

          am4core.ready(function () {
            // Themes begin
            am4core.useTheme(am4themes_animated);
            // Themes end

            // Create chart instance
            var chart = am4core.create("chartdiv", am4charts.XYChart);

            // Add data
            chart.data = [
              { type: "gn", data: r.data[0]["gn"], title: "강남구" },
              { type: "gd", data: r.data[0]["gd"], title: "강동구" },
              { type: "gb", data: r.data[0]["gb"], title: "강북구" },
              { type: "gs", data: r.data[0]["gs"], title: "강서구" },
              { type: "ga", data: r.data[0]["ga"], title: "관악구" },
              { type: "gi", data: r.data[0]["gi"], title: "광진구" },
              { type: "gr", data: r.data[0]["gr"], title: "구로구" },
              { type: "gc", data: r.data[0]["gc"], title: "금천구" },
              { type: "no", data: r.data[0]["no"], title: "노원구" },
              { type: "db", data: r.data[0]["db"], title: "도봉구" },
              { type: "ddm", data: r.data[0]["ddm"], title: "동대문구" },
              { type: "dj", data: r.data[0]["dj"], title: "동작구" },
              { type: "mp", data: r.data[0]["mp"], title: "마포구" },
              { type: "sdm", data: r.data[0]["sdm"], title: "서대문구" },
              { type: "sc", data: r.data[0]["sc"], title: "서초구" },
              { type: "sd", data: r.data[0]["sd"], title: "성동구" },
              { type: "sb", data: r.data[0]["sb"], title: "성북구" },
              { type: "sp", data: r.data[0]["sp"], title: "송파구" },
              { type: "yc", data: r.data[0]["yc"], title: "양천구" },
              { type: "ydp", data: r.data[0]["ydp"], title: "영등포구" },
              { type: "ys", data: r.data[0]["ys"], title: "용산구" },
              { type: "ep", data: r.data[0]["ep"], title: "은평구" },
              { type: "jr", data: r.data[0]["jr"], title: "중랑구" },
              { type: "jg", data: r.data[0]["jg"], title: "중구" },
              { type: "jn", data: r.data[0]["jn"], title: "종로구" },
            ];

            // Create axes

            var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
            categoryAxis.dataFields.category = "title";
            categoryAxis.renderer.grid.template.location = 0;
            categoryAxis.renderer.minGridDistance = 30;

            categoryAxis.renderer.labels.template.adapter.add(
              "dy",
              function (dy, target) {
                if (target.dataItem && target.dataItem.index & (2 == 2)) {
                  return dy + 25;
                }
                return dy;
              }
            );

            var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

            // Create series
            var series = chart.series.push(new am4charts.ColumnSeries());
            series.dataFields.valueY = "data";
            series.dataFields.categoryX = "title";
            series.name = "구별 평균 데이터";
            series.columns.template.tooltipText =
              "{categoryX}: [bold]{valueY}[/]";
            series.columns.template.fillOpacity = 0.8;

            series.columns.template.events.on(
              "hit",
              function (ev) {
                console.log("clicked on ", ev.target._dataItem._dataContext);
                //비동기
                $.ajax({
                  url: "/api/sensor/guData",
                  type: "POST",
                  data: {
                    toDate: _toDate,
                    fromDate: _fromDate,
                    stx: _stx,
                    "${_csrf.parameterName}": "${_csrf.token}",
                    pageStart: 1,
                  },
                  beforeSend: function () {
                    $(".loader").show();
                    $(".dim_search").show();
                  },
                  success: function (r) {
                    if (r.data.length == 0) {
                      alert("조건에 만족하는 데이터가 없습니다.");
                    }
                    console.log(r);
                    var target = {};
                    target[ev.target._dataItem._dataContext.type] =
                      ev.target._dataItem._dataContext.title;

                    am4Generate(r.data, target, "amChart");
                  },
                  complete: function () {
                    $(".loader").hide();
                    $(".dim_search").hide();
                  },
                });
              },
              this
            );

            var columnTemplate = series.columns.template;
            columnTemplate.strokeWidth = 2;
            columnTemplate.strokeOpacity = 1;
          }); // end am4core.ready()
        },
        complete: function () {
          $(".loader").hide();
          $(".dim_search").hide();
        },
      });
    } else {
      alert("비어있는 값이 있습니다.");
    }
  });
});
