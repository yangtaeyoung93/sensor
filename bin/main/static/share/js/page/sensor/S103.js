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
              text += "<option value='" + b.code + "'>" + relCd + "</option>";
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
        url: "/api/sensor/guData",
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

          $(".loader").hide();
          $(".dim_search").hide();
          // datatables
          if (windFlag) {
            $("#example_wrapper").hide();
            $("#board").show();
            var text = "";
            $.each(r.data, function (a, b) {
              if (b.length == 0) {
                alertify.alert(
                  "없음",
                  "해당 검색조건에 해당하는 데이터가 없습니다."
                );
                return false;
              }
              if (windFlag) {
                // console.log(a, b.baramNm);

                text += "<p style='font-weight:bold'>" + a + "</p>";
                $.each(b, function (c, d) {
                  if (d.baramNm != null) {
                    text +=
                      '<table class="list wind-list" style="margin-right: 30px; margin-bottom: 30px; display: table; width: calc(100% / 4 - 30px); border: 1px solid #c9c9c9; float: left;">' +
                      "<tr>" +
                      "    <th>센터명</th>" +
                      "    <th>풍향</th>" +
                      "    <th>풍속 (㎧)</th>" +
                      "</tr>";
                    text +=
                      "<tr>" +
                      "<td>" +
                      d.baramNm +
                      "</td>" +
                      '<td class="co_step02">' +
                      item.calcDire(
                        item.parseNumber(Number(d.windDire), stx),
                        "han"
                      ) +
                      "</td>" +
                      '<td class="co_step01">' +
                      item.parseNumber(Number(d.windSpeed), stx) +
                      "</td>" +
                      "</tr></table>";
                  }
                });
                $("#board").html(text);
              }
            });
          } else {
            $("#example_wrapper").show();
            $("#board").hide();
            function getFormatDate(date) {
              var year = date.getFullYear(); //yyyy
              var month = 1 + date.getMonth(); //M
              month = month >= 10 ? month : "0" + month; //month 두자리로 저장
              var day = date.getDate(); //d
              day = day >= 10 ? day : "0" + day; //day 두자리로 저장
              var hour =
                new Date().getHours() >= 10
                  ? new Date().getHours()
                  : "0" + new Date().getHours();
              var minutes =
                new Date().getMinutes() >= 10
                  ? new Date().getMinutes()
                  : "0" + new Date().getMinutes();
              return year + "" + month + "" + day + "" + hour + "" + minutes; //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
            }

            function getTitle() {
              var result = "";
              $("#sel-1 option").each(function () {
                if ($("#sel-1").val() == $(this).val()) {
                  result = $(this).text();
                }
              });
              return result + "_";
            }

            if ($.fn.dataTable.isDataTable("#example")) {
              $("#example").DataTable().destroy();
            }
            var columnRender = [];
            if (stx == 0) {
              columnRender.push({
                targets: "_all",
                render: function (data, type, row) {
                  if (data >= 76) {
                    color = "01";
                  } else if (data >= 36) {
                    color = "02";
                  } else if (data >= 16) {
                    color = "04";
                  } else if (data > 0) {
                    color = "05";
                  } else {
                    color = "00";
                  }
                  if (row.tm8 == data) {
                    return data;
                  } else {
                    return (
                      "<span class='co_step" + color + "'>" + data + "</span>"
                    );
                  }
                },
              });
            } else if (stx == 1) {
              columnRender.push({
                targets: "_all",
                render: function (data, type, row) {
                  if (data >= 151) {
                    color = "01";
                  } else if (data >= 81) {
                    color = "02";
                  } else if (data >= 31) {
                    color = "04";
                  } else if (data > 0) {
                    color = "05";
                  } else {
                    color = "00";
                  }
                  if (row.tm8 == data) {
                    return data;
                  } else {
                    return (
                      "<span class='co_step" + color + "'>" + data + "</span>"
                    );
                  }
                },
              });
            }

            $("#example").DataTable({
              paging: false,
              searching: false,
              sorting: false,
              scrollY: 500,
              scrollCollapse: true,
              dom: "Bfrtip",
              language: {
                info: "데이터 총 _TOTAL_개",
                emptyTable: "현재 검색된 데이터가 없습니다.",
                infoEmpty: "",
              },
              buttons: [
                {
                  extend: "excel",
                  title:
                    "항목별 측정자료 조회_" +
                    getTitle() +
                    getFormatDate(new Date()),
                  text: "데이터 EXPORT",
                  className: "exBtn",
                },
              ],
              columns: [
                { data: "tm8", title: "데이터시각" },
                { data: "gn", title: "강남구" },
                { data: "gd", title: "강동구" },
                { data: "gb", title: "강북구" },
                { data: "gs", title: "강서구" },
                { data: "ga", title: "관악구" },
                { data: "gi", title: "광진구" },
                { data: "gr", title: "구로구" },
                { data: "gc", title: "금천구" },
                { data: "no", title: "노원구" },
                { data: "db", title: "도봉구" },
                { data: "ddm", title: "동대문구" },
                { data: "dj", title: "동작구" },
                { data: "mp", title: "마포구" },
                { data: "sdm", title: "서대문구" },
                { data: "sc", title: "서초구" },
                { data: "sd", title: "성동구" },
                { data: "sb", title: "성북구" },
                { data: "sp", title: "송파구" },
                { data: "yc", title: "양천구" },
                { data: "ydp", title: "영등포구" },
                { data: "ys", title: "용산구" },
                { data: "ep", title: "은평구" },
                { data: "jr", title: "중랑구" },
                { data: "jg", title: "중구" },
                { data: "jn", title: "종로구" },
              ],
              columnDefs: columnRender,
            });
            Object.entries = function (obj) {
              var ownProps = Object.keys(obj),
                i = ownProps.length,
                resArray = new Array(i); // preallocate the Array
              while (i--) resArray[i] = [ownProps[i], obj[ownProps[i]]];

              return resArray;
            };
            r.data = r.data.filter(function (list, index) {
              // console.log(list, index);
              var count = 0;
              Object.entries(list).map(function (key, value) {
                if (!key[1]) {
                  count++;
                }
              });
              // console.log(count);
              if (count < 24) {
                return list;
              }
            });
            $("#example").DataTable().clear().draw();
            $("#example").DataTable().rows.add(r.data).draw();
          }
          // datatables
          //   item.rowSetGu(r.data, stx, windFlag);
        },
      });
    } else {
      alert("비어있는 값이 있습니다.");
    }
  });
});
