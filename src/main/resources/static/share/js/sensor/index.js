var sensor = {
  rowSet: function (data) {
    var text = "";

    var _this = this;
    var parseDataArr = [];

    $.each(data, function (a, b) {
      var dateText = b.tm8 + b.tm6;

      parseDataArr.push({
        equiInfoKey: b.equiInfoKey,
        tm8: _this.parseDate2(dateText),
        pm10: _this.parseNumber(Number(b.pm10)),
        pm25: _this.parseNumber(Number(b.pm25)),
        noise: _this.parseNumber(Number(b.noise)),
        temp: _this.parseNumber(Number(b.temp)),
        humi: _this.parseNumber(Number(b.humi)),
        windDire: _this.calcDire(_this.parseNumber(Number(b.windDire)), "han"),
        windSpeed: _this.parseNumber(Number(b.windSpeed)),
        inteIllu: _this.parseNumber(Number(b.inteIllu)),
        ultraRays: parseFloat(_this.parseNumber(Number(b.ultraRays))),
        vibrX: _this.parseNumber(Number(b.vibrX)),
        vibrY: _this.parseNumber(Number(b.vibrY)),
        vibrZ: _this.parseNumber(Number(b.vibrZ)),
        effeTemp: _this.parseNumber(Number(b.effeTemp)),
        co: b.co,
        no2: b.no2,
        so2: b.so2,
        nh3: b.nh3,
        h2s: b.h2s,
        o3: b.o3,
        etc1: b.etc1,
        etc2: b.etc2,
        etc3: b.etc3,
      });
    });
    return parseDataArr;
  },
  rowSetType: function (data) {
    var text = "";

    var _this = this;
    $.each(data, function (a, b) {
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
      var dateText = b.tm8 + b.tm6;
      var color = "";
      var color2 = "";

      if (_this.parseNumber(Number(b.pm25)) >= 76) {
        color2 = "01";
      } else if (_this.parseNumber(Number(b.pm25)) >= 36) {
        color2 = "02";
      } else if (_this.parseNumber(Number(b.pm25)) >= 16) {
        color2 = "04";
      } else if (_this.parseNumber(Number(b.pm25)) > 0) {
        color2 = "05";
      } else {
        color2 = "00";
      }

      if (_this.parseNumber(Number(b.pm10)) >= 151) {
        color = "01";
      } else if (_this.parseNumber(Number(b.pm10)) >= 81) {
        color = "02";
      } else if (_this.parseNumber(Number(b.pm10)) >= 31) {
        color = "04";
      } else if (_this.parseNumber(Number(b.pm10)) > 0) {
        color = "05";
      } else {
        color = "00";
      }

      text +=
        "<div>" +
        "    <ul>" +
        "        <li><div>" +
        b.num +
        "</div></li>" +
        "        <li><div>" +
        b.equiInfoKey +
        "</div></li>" +
        "        <li><div>" +
        _this.parseDate2(dateText) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color +
        '">' +
        _this.parseNumber(Number(b.pm10)) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color2 +
        '">' +
        _this.parseNumber(Number(b.pm25)) +
        "</div></li>" +
        '        <li><div class="co_step">' +
        _this.parseNumber(Number(b.noise)) +
        "</div></li>" +
        '        <li><div class="co_step">' +
        _this.parseNumber(Number(b.temp)) +
        "</div></li>" +
        '        <li><div class="co_step">' +
        _this.parseNumber(Number(b.humi)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseWind(_this.parseNumber(Number(b.windDire))) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.windSpeed)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.inteIllu)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.ultraRays)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.vibrX)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.vibrY)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.vibrZ)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.effeTemp)) +
        "</div></li>" +
        "    </ul>" +
        "</div>";
    });

    return text;
  },
  rowSetCorrection: function (data) {
    var text = "";

    var _this = this;
    $.each(data, function (a, b) {
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
      var dateText = b.tm8 + b.tm6;
      var color = "";
      var color2 = "";
      var color3 = "";
      var color4 = "";

      if (_this.parseNumber(Number(b.pm25)) >= 76) {
        color2 = "01";
      } else if (_this.parseNumber(Number(b.pm25)) >= 36) {
        color2 = "02";
      } else if (_this.parseNumber(Number(b.pm25)) >= 16) {
        color2 = "04";
      } else if (_this.parseNumber(Number(b.pm25)) > 0) {
        color2 = "05";
      } else {
        color2 = "00";
      }

      if (_this.parseNumber(Number(b.pm10)) >= 151) {
        color = "01";
      } else if (_this.parseNumber(Number(b.pm10)) >= 81) {
        color = "02";
      } else if (_this.parseNumber(Number(b.pm10)) >= 31) {
        color = "04";
      } else if (_this.parseNumber(Number(b.pm10)) > 0) {
        color = "05";
      } else {
        color = "00";
      }

      if (_this.parseNumber(Number(b.pm25Std)) >= 76) {
        color3 = "01";
      } else if (_this.parseNumber(Number(b.pm25Std)) >= 36) {
        color3 = "02";
      } else if (_this.parseNumber(Number(b.pm25Std)) >= 16) {
        color3 = "04";
      } else if (_this.parseNumber(Number(b.pm25Std)) > 0) {
        color3 = "05";
      } else {
        color3 = "00";
      }

      if (_this.parseNumber(Number(b.pm10Std)) >= 151) {
        color4 = "01";
      } else if (_this.parseNumber(Number(b.pm10Std)) >= 81) {
        color4 = "02";
      } else if (_this.parseNumber(Number(b.pm10Std)) >= 31) {
        color4 = "04";
      } else if (_this.parseNumber(Number(b.pm10Std)) > 0) {
        color4 = "05";
      } else {
        color4 = "00";
      }

      text +=
        "<div>" +
        "    <ul>" +
        "        <li><div>" +
        b.num +
        "</div></li>" +
        "        <li><div>" +
        b.equiInfoKey +
        "</div></li>" +
        "        <li><div>" +
        _this.parseDate2(dateText) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color +
        '">' +
        _this.parseNumber(Number(b.pm10)) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color4 +
        '">' +
        _this.parseNumber(Number(b.pm10Std)) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color2 +
        '">' +
        _this.parseNumber(Number(b.pm25)) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color3 +
        '">' +
        _this.parseNumber(Number(b.pm25Std)) +
        "</div></li>" +
        "    </ul>" +
        "</div>";
    });

    $(".body").html(text);
  },
  rowSetList: function (data) {
    var text = "";

    var _this = this;
    $.each(data, function (a, b) {
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
      var dateText = b.tm8 + b.tm6;
      var color = "";
      var color2 = "";

      if (_this.parseNumber(Number(b.pm25)) >= 76) {
        color2 = "01";
      } else if (_this.parseNumber(Number(b.pm25)) >= 36) {
        color2 = "02";
      } else if (_this.parseNumber(Number(b.pm25)) >= 16) {
        color2 = "04";
      } else if (_this.parseNumber(Number(b.pm25)) > 0) {
        color2 = "05";
      } else {
        color2 = "00";
      }

      if (_this.parseNumber(Number(b.pm10)) >= 151) {
        color = "01";
      } else if (_this.parseNumber(Number(b.pm10)) >= 81) {
        color = "02";
      } else if (_this.parseNumber(Number(b.pm10)) >= 31) {
        color = "04";
      } else if (_this.parseNumber(Number(b.pm10)) > 0) {
        color = "05";
      } else {
        color = "00";
      }
      text +=
        "<div>" +
        "    <ul>" +
        "        <li><div>" +
        b.num +
        "</div></li>" +
        "        <li><div>" +
        b.equiInfoKey +
        "</div></li>" +
        "        <li><div>" +
        _this.parseDate2(dateText) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color +
        '">' +
        _this.parseNumber(Number(b.pm10)) +
        "</div></li>" +
        '        <li><div class="co_step' +
        color2 +
        '">' +
        _this.parseNumber(Number(b.pm25)) +
        "</div></li>" +
        '        <li><div class="co_step">' +
        _this.parseNumber(Number(b.noise)) +
        "</div></li>" +
        '        <li><div class="co_step">' +
        _this.parseNumber(Number(b.temp)) +
        "</div></li>" +
        '        <li><div class="co_step">' +
        _this.parseNumber(Number(b.humi)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseWind(_this.parseNumber(Number(b.windDire))) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.windDire)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.inteIllu)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.ultraRays)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.vibrX)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.vibrY)) +
        "</div></li>" +
        "        <li><div>" +
        _this.parseNumber(Number(b.vibrZ)) +
        "</div></li>" +
        "    </ul>" +
        "</div>";
    });

    $(".body").append(text);
  },
  rowSet2: function (data) {
    var text =
      "<tr>" +
      "    <th>데이터시각</th>" +
      "    <th>미세먼지<br/>(㎍/㎥)</th>" +
      "    <th>초미세먼지<br/>(㎍/㎥)</th>" +
      "    <th>소음<br/>(dB)</th>" +
      "    <th>온도<br/>(℃)</th>" +
      "    <th>습도<br/>(%)</th>" +
      "    <th>풍향<br/></th>" +
      "    <th>풍속<br/>(㎧)</th>" +
      "    <th>조도<br/>(lx)</th>" +
      "    <th>자외선<br/>(UVI)</th>" +
      "    <th>진동<br/>-X축(g)</th>" +
      "    <th>진동<br/>-Y축(g)</th>" +
      "    <th>진동<br/>-Z축(g)</th>" +
      "    <th>흑구</th>" +
      "</tr>;";
    var _this = this;
    var count = 0;
    var am = new Array();
    var pm10 = new Array();
    var pm25 = new Array();
    var c_date = new Array();
    $.each(data, function (a, b) {
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

      pm10.push(_this.parseNumber(Number(b.pm10)));
      pm25.push(_this.parseNumber(Number(b.pm25)));
      c_date.push(_this.parseDate(b.tm));
      var dateText = b.tm8 + b.tm6;
      text +=
        "<tr>" +
        "<td>" +
        _this.parseDate2(dateText) +
        "</td>" +
        '<td class="co_step01">' +
        _this.parseNumber(Number(b.pm10)) +
        "</td>" +
        '<td class="co_step02">' +
        _this.parseNumber(Number(b.pm25)) +
        "</td>" +
        '<td class="co_step04">' +
        _this.parseNumber(Number(b.noise)) +
        "</td>" +
        '<td class="co_step05">' +
        _this.parseNumber(Number(b.temp)) +
        "</td>" +
        '<td class="co_step01">' +
        _this.parseNumber(Number(b.humi)) +
        "</td>" +
        "<td>" +
        _this.parseWind(_this.parseNumber(Number(b.wind_dire))) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.wind_speed)) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.inte_illu)) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.ultra_rays)) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.vibr_x)) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.vibr_y)) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.vibr_z)) +
        "</td>" +
        "<td>" +
        _this.parseNumber(Number(b.effeTemp)) +
        "</td>" +
        "</tr>";
    });
    // _this.drawChart('graph', pm10, pm25, c_date)
    $(".list-detail").html(text);
  },
  parseDate2: function (date) {
    //20191108001122
    var year = date.substr(0, 4);
    var month = date.substr(4, 2);
    var day = date.substr(6, 2);
    var hour = date.substr(8, 2);
    var minute = date.substr(10, 2);
    var second = date.substr(12, 2);

    return year + "-" + month + "-" + day + " " + hour + ":" + minute;
  },
  parseDate: function (date) {
    var year = date.substr(0, 4);
    var month = date.substr(4, 2);
    var day = date.substr(6, 2);
    var hour = date.substr(8, 2);
    var minute = date.substr(10, 2);

    return year + "-" + month + "-" + day + " " + hour;
  },
  parseWind: function (data) {
    switch (data) {
      case 0:
        return "바람없음";
        break;
      case 1:
        return "북";
        break;
      case 2:
        return "북북동";
        break;
      case 3:
        return "북동";
        break;
      case 4:
        return "동북동";
        break;
      case 5:
        return "동";
        break;
      case 6:
        return "동남동";
        break;
      case 7:
        return "남동";
        break;
      case 8:
        return "남남동";
        break;
      case 9:
        return "남";
        break;
      case 10:
        return "남남서";
        break;
      case 11:
        return "남서";
        break;
      case 12:
        return "서남서";
        break;
      case 13:
        return "서";
        break;
      case 14:
        return "서북서";
        break;
      case 15:
        return "북서";
        break;
      case 16:
        return "북북서";
        break;
      default:
        return "-";
        break;
    }
  },
  calcDire: function (num, type) {
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
  },
  parseNumber: function (data) {
    if (data == -999 || isNaN(data)) {
      return "-";
    } else {
      return data;
    }
  },
  parseNumberZero: function (data) {
    if (data == -999 || isNaN(data)) {
      return 0;
    } else {
      return data;
    }
  },
  selectData: function (date) {
    var listJson = null;
    var am = new Array();
    var am2 = new Array();
    $.ajax({
      url: "/api/sensor/index",
      type: "POST",
      async: false,
      data: {
        date: date,
        // date: 20191021,
        serial: $("#m_serial").text(),
      },
      success: function (r) {
        listJson = JSON.parse(JSON.parse(r).list);
        var equiJson = JSON.parse(JSON.parse(r).equi);

        $.each(equiJson, function (a, b) {
          $("#m_station").text(b.sta_name);
          $("#m_reg_date").html(
            $.datepicker.formatDate("yy/mm/dd", new Date(b.inst_date))
          );
          // console.log(
          //   $.datepicker.formatDate("yy/mm/dd", new Date(b.inst_date))
          // );
        });

        $.each(listJson, function (a, b) {
          if (sensor.parseDate(b.tm).indexOf(":00") != -1) {
            am.push({
              pm10: sensor.parseNumber(Number(b.pm10)),
              pm10Date: sensor.parseDate(b.regDate),
            });
            am2.push({
              pm25: sensor.parseNumber(Number(b.pm25)),
              pm25Date: sensor.parseDate(b.regDate),
            });
          }
        });

        sensor.rowSet2(listJson);
      },
    });
    return listJson;
  },
  amChartStatPerson: function (target, data, chart) {
    var am = new Array();
    var dateDefault = "";
    var ampie = new Array();
    if (data == "default") {
      am.push({
        vistorCnt: 1,
        date: new Date(),
        dateTime: "0시",
      });
    } else {
      $(".piechartDiv").html("");
      $.each(data, function (a, b) {
        var year = b.vistorTm8.substring(0, 4);
        var month = b.vistorTm8.substring(4, 6);
        var day = b.vistorTm8.substring(6, 8);
        var hour = b.vistorTm4.substring(0, 2);
        var date = new Date(year, month - 1, day, hour);
        // }

        if (dateDefault == "") {
          dateDefault = b.vistorTm8;
        }

        if (dateDefault != "" && dateDefault != b.vistorTm8) {
          // console.log(dateDefault);
          $(".piechartDiv").append(
            "<div class='amPieChart" +
              dateDefault +
              "' style='border:1px solid #c9c9c9; margin-bottom:21px;height: 400px; position: relative;'><p>" +
              dateDefault +
              "</p></div>"
          );
          var chartPie = am4core.create(
            "amPieChart" + dateDefault,
            am4charts.PieChart3D
          );
          chartPie.hiddenState.properties.opacity = 0; // this creates initial fade-in
          chartPie.data = ampie;
          chartPie.legend = new am4charts.Legend();

          var pieSeries = chartPie.series.push(new am4charts.PieSeries3D());
          pieSeries.dataFields.value = "vistorCnt";
          pieSeries.dataFields.category = "dateTime";
          ampie = new Array();
          $(".amPieChart" + dateDefault).before("<p>" + dateDefault + "</p>");
          dateDefault = b.vistorTm8;
        }
        ampie.push({
          vistorCnt: b.vistorCnt,
          date: date,
          dateTime: hour + "시",
        });
      });
      $.each(chart, function (a, b) {
        var year = b.vistorTm8.substring(0, 4);
        var month = b.vistorTm8.substring(4, 6);
        var day = b.vistorTm8.substring(6, 8);
        var hour = b.vistorTm4.substring(0, 2);
        var min = b.vistorTm4.substring(2, 4);
        var date = new Date(year, month - 1, day, hour, min);
        am.push({
          vistorCnt: b.vistorCnt,
          date: date,
        });
      });
    }
    am4Generate(am, { vistorCnt: "체류인원" });
    // console.log(am);
    function am4Generate(data, field) {
      am4core.addLicense("CH205407412");
      am4core.ready(function () {
        // Create chart instance
        var chart = am4core.create("amChart", am4charts.XYChart);
        chart.language.locale = am4lang_ko_KR;
        //2019-11-08 00:01
        //        		chart.dateFormatter.inputDateFormat = "yyyy-mm-dd kk:mm"
        // Increase contrast by taking evey second color
        chart.colors.step = 0;

        // Add data
        chart.data = data;

        //Create axes
        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
        dateAxis.renderer.grid.template.location = 2;
        //         		dateAxis.renderer.minGridDistance = 50;
        chart.dateFormatter.dateFormat = "MMM dd일 HH시";
        dateAxis.dateFormats.setKey("hour", "MMM dd일 HH시");
        dateAxis.periodChangeDateFormats.setKey("hour", "MMM dd일 HH시");
        dateAxis.dateFormats.setKey("minute", "dd일 HH시 mm분");
        dateAxis.periodChangeDateFormats.setKey("minute", "dd일 HH시 mm분");
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
            "#5571c6",
            "#55c6c2",
            "#db9d61",
          ];
          var series = chart.series.push(new am4charts.LineSeries());
          series.dataFields.valueY = field;
          series.dataFields.dateX = "date";
          series.name = name;
          series.tooltipText = name + ": [b]{valueY}[/]";
          series.strokeWidth = 2;
          series.minBulletDistance = 50;
          series.fill = interfaceColors[count];
          series.stroke = interfaceColors[count];

          //         		  if(name != "미세먼지" || name != "초미세먼지") {
          if (count > 1) {
            series.hidden = true;
          }
          var bullet = series.bullets.push(new am4charts.CircleBullet());
          bullet.circle.stroke = interfaceColors[count];
          bullet.circle.strokeWidth = 2;

          return series;
        }
        var scrollbarX = new am4charts.XYChartScrollbar();
        var count = 0;
        $.each(field, function (a, b) {
          // console.log(a, b);
          var series = createSeries(a, b, count);
          count++;
          //         			scrollbarX.series.push(series);
        });
        chart.scrollbarX = scrollbarX;
        chart.legend = new am4charts.Legend();
        chart.cursor = new am4charts.XYCursor();
      }); // end am4core.ready()
    }

    //pieChart
    $(".piechartDiv").append(
      "<div class='amPieChart" +
        dateDefault +
        "' style='border:1px solid #c9c9c9; margin-bottom:21px;height: 400px; position: relative;'><p>" +
        dateDefault +
        "</p></div>"
    );
    $(".amPieChart" + dateDefault).before("<p>" + dateDefault + "</p>");
    var chartPie = am4core.create(
      "amPieChart" + dateDefault,
      am4charts.PieChart3D
    );
    chartPie.hiddenState.properties.opacity = 0; // this creates initial fade-in
    chartPie.data = ampie;
    chartPie.legend = new am4charts.Legend();

    var pieSeries = chartPie.series.push(new am4charts.PieSeries3D());
    pieSeries.dataFields.value = "vistorCnt";
    pieSeries.dataFields.category = "dateTime";
  },
  //    amChart: function(target, data, chart) {
  //        var am = new Array();
  //        var am2 = new Array();
  //        var am3 = new Array();
  //        $.each(data, function(a,b) {
  //            // if(sensor.parseDate(b.tm).indexOf(':00') != -1) {
  ////                am.push({pm10: sensor.parseNumberZero(Number(b.pm10)), pm10Date: sensor.dateObject(b.regDate)});
  ////                am2.push({pm25: sensor.parseNumberZero(Number(b.pm25)), pm25Date: sensor.dateObject(b.regDate)});
  // console.log(sensor.dateObject(b.tm))
  ////                am3.push({noise: sensor.parseNumberZero(Number(b.noise)), noiseDate: sensor.dateObject(b.regDate)});
  //                am.push({
  //                	pm10: sensor.parseNumberZero(Number(b.pm10)),
  //                	pm25: sensor.parseNumberZero(Number(b.pm25)),
  //                	noise: sensor.parseNumberZero(Number(b.noise)),
  //                	temp: sensor.parseNumberZero(Number(b.temp)),
  //                	humi: sensor.parseNumberZero(Number(b.humi)),
  //                	ultrarays: sensor.parseNumberZero(Number(b.ultraRays)),
  //                	inteillu: sensor.parseNumberZero(Number(b.inteIllu)),
  //                	date: sensor.dateObject(b.regDate)
  //                })
  //            // }
  //        })
  //        data = am.concat(am2).concat(am3);
  //        am4core.useTheme(am4themes_animated);
  //
  //        chart = am4core.create(target, am4charts.XYChart);
  //        chart.language.locale = am4lang_ko_KR;
  //        chart.data = am
  //        chart.autoMargins = false;
  //
  //        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
  //        valueAxis.renderer.minGridDistance = 20;
  //
  //        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
  //        dateAxis.renderer.grid.template.location = 0;
  //        dateAxis.renderer.labels.template.fill = am4core.color("#e59165");
  //
  //        var series = chart.series.push(new am4charts.LineSeries());
  //        series.name = "미세먼지";
  //        series.dataFields.dateX = "date";
  //        series.dataFields.valueY = "pm10";
  //        series.tooltipText = "미세먼지 : {valueY.value}";
  //        series.fill = am4core.color("#e59165");
  //        series.stroke = am4core.color("#e59165");
  //        //series.strokeWidth = 3;
  //
  //        var series2 = chart.series.push(new am4charts.LineSeries());
  //        series2.name = "초미세먼지";
  //        series2.dataFields.dateX = "date";
  //        series2.dataFields.valueY = "pm25";
  //        series2.tooltipText = "초미세먼지 : {valueY.value}";
  //        series2.fill = am4core.color("#dfcc64");
  //        series2.stroke = am4core.color("#dfcc64");
  //        //series2.strokeWidth = 3;
  //
  //        var series3 = chart.series.push(new am4charts.LineSeries());
  //        series3.name = "소음";
  //        series3.dataFields.dateX = "date";
  //        series3.dataFields.valueY = "noise";
  //        series3.tooltipText = "소음 : {valueY.value}";
  //        series3.fill = am4core.color("#0c82e9");
  //        series3.stroke = am4core.color("#0c82e9");
  //        //series2.strokeWidth = 3;
  //
  //
  //        var series4 = chart.series.push(new am4charts.LineSeries());
  //        series4.name = "온도";
  //        series4.dataFields.dateX = "date";
  //        series4.dataFields.valueY = "temp";
  //        series4.tooltipText = "온도 : {valueY.value}";
  //        series4.fill = am4core.color("#a8508a");
  //        series4.stroke = am4core.color("#a8508a");
  //
  //        var series5 = chart.series.push(new am4charts.LineSeries());
  //        series5.name = "습도";
  //        series5.dataFields.dateX = "date";
  //        series5.dataFields.valueY = "humi";
  //        series5.tooltipText = "습도 : {valueY.value}";
  //        series5.fill = am4core.color("#80a850");
  //        series5.stroke = am4core.color("#80a850");
  //
  //        var series6 = chart.series.push(new am4charts.LineSeries());
  //        series6.name = "자외선";
  //        series6.dataFields.dateX = "date";
  //        series6.dataFields.valueY = "ultrarays";
  //        series6.tooltipText = "자외선 : {valueY.value}";
  //        series6.fill = am4core.color("#6d47f4");
  //        series6.stroke = am4core.color("#6d47f4");
  //
  //        chart.cursor = new am4charts.XYCursor();
  //        chart.cursor.behavior = "none"
  ////        chart.cursor.behavior = "zoomX"
  //        chart.dateFormatter.dateFormat = "MMM dd일 HH시";
  //        dateAxis.baseInterval = {
  //        		  "timeUnit": "minute",
  //        		  "count": 1
  //        		}
  //        dateAxis.dateFormats.setKey("hour", "MMM dd일 HH시");
  //        dateAxis.periodChangeDateFormats.setKey("hour", "MMM dd일 HH시");
  //        dateAxis.dateFormats.setKey("minute", "dd일 HH시 mm분");
  //        dateAxis.periodChangeDateFormats.setKey("minute", "dd일 HH시 mm분");
  ////        var scrollbarX = new am4charts.XYChartScrollbar();
  ////        scrollbarX.series.push(series);
  ////        scrollbarX.series.push(series2);
  ////        scrollbarX.series.push(series3);
  ////        scrollbarX.series.push(series4);
  ////        scrollbarX.series.push(series5);
  ////        scrollbarX.series.push(series6);
  ////
  ////        chart.scrollbarX = scrollbarX;
  //
  //        chart.legend = new am4charts.Legend();
  //        chart.legend.parent = chart.plotContainer;
  //        chart.legend.zIndex = 100;
  //        chart.events.on("ready", function(ev) {
  //        	  valueAxis.min = valueAxis.minZoomed;
  //        	  valueAxis.max = valueAxis.maxZoomed;
  //        	});
  //        dateAxis.renderer.grid.template.strokeOpacity = 0.07;
  //        valueAxis.renderer.grid.template.strokeOpacity = 0.07;
  //    },
  dateObject: function (date) {
    var year = date.substr(0, 4);
    var month = date.substr(5, 2);
    var day = date.substr(8, 2);
    var hour = date.substr(11, 2);
    var minute = date.substr(14, 2);
    return new Date(year, month - 1, day, hour, minute);
  },
  drawChart: function (target, pm10, pm25, title) {
    var windDataTitle = [
      "07:20",
      "07:30",
      "07:40",
      "07:50",
      "08:00",
      "08:10",
      "08:20",
      "08:30",
      "08:40",
      "08:50",
      "09:00",
      "09:10",
      "09:20",
    ];
    // var windDataTitle = this.inputArray(time);
    var windData = [2, 2, 2, 2, 2, 1, 0, 1, 0, 2, 1, 1, 0];
    var windData2 = [3, 1, 2, 2, 2, 1, 0, 1, 0, 2, 1, 1, 0];
    // var windDataTitle = time, windData = ws;
    // console.log(pm10, pm25);
    var t_parent = $("#" + target).parent();
    $("#" + target).remove();
    $(t_parent).append('<canvas id="' + target + '"></canvas>');
    Chart.defaults.global.defaultFontFamily = "SeoulNamsan";
    if (pm10 && pm25) {
      new Chart(document.getElementById(target), {
        type: "line",
        data: {
          labels: title,
          datasets: [
            {
              label: "미세먼지",
              data: pm10,
              borderColor: "rgba(66, 115, 208, 1)",
              backgroundColor: "rgba(66, 115, 208, 0.5)",
              fill: false,
              lineTension: 0,
            },
            {
              label: "초미세먼지",
              data: pm25,
              borderColor: "rgba(255, 0, 0, 1)",
              backgroundColor: "rgba(255, 0, 0, 0.5)",
              fill: false,
              lineTension: 0,
            },
          ],
        },
        options: {
          responsive: true,
          title: {
            display: false,
          },
          tooltips: {
            mode: "index",
            intersect: true,
          },
          hover: {
            mode: "nearest",
            intersect: true,
          },
          scales: {
            yAxes: [
              {
                ticks: {
                  stepSize: 5,
                  min: 0,
                },
              },
            ],
          },
        },
      });
    }
  },
  statParse: function (stat) {
    if (stat == 1 || stat == "1") {
      return "<span style='color:#44c7f4;'>정상</span>";
    } else {
      return "<span style='color:#ff0000;'>비정상</span>";
    }
  },
};
