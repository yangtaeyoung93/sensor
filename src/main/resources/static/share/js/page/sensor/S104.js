$(document).ready(function () {
  var count = 2;
  $(".equi_search_btn").click(function (e) {
    e.preventDefault();
    var to = $("#to").val();
    var toDate = to.substr(0, 4) + to.substr(5, 2) + to.substr(8, 2);
    var from = $("#from").val();
    var fromDate = from.substr(0, 4) + from.substr(5, 2) + from.substr(8, 2);
    var guTp = $("#gu").val();
    var equi = $("#equi").val();

    count = 2;
    $(".list").html("");
    if (to != "" && from != "" && guTp != "구 선택" && equi != "기기 선택") {
      var pageNum = "${param.page}";
      if (pageNum == "") pageNum = "1";

      $.ajax({
        url: "/api/sensor/statList",
        type: "POST",
        data: {
          toDate: toDate,
          fromDate: fromDate,
          guTp: guTp,
          equiInfoKey: equi,
          "${_csrf.parameterName}": "${_csrf.token}",
          pageStart: 1,
        },
        beforeSend: function () {
          $(".loader").show();
        },
        success: function (r) {
          $("#example").DataTable().clear().draw();
          $("#example").DataTable().rows.add(r.data).draw();

          var dataLength = r.data.length;

          if (dataLength == 0) {
            $.ajax({
              url: "/api/sensor/statLastUpdate",
              type: "POST",
              data: {
                wareName: equi,
              },
              success: function (lastUpdateData) {
                $("#messageDiv").css("display", "block");

                if (lastUpdateData.data[0]) {
                  $("#lastUpdateDate").text(
                    "기기 마지막 송신 시각 : (" +
                      lastUpdateData.data[0].regDate +
                      ")"
                  );
                } else {
                  $("#lastUpdateDate").text("송신 이력 없음");
                }
              },
            });
          } else {
            $("#messageDiv").css("display", "none");
          }

          $(".loader").hide();
        },
      });
    } else {
      alert("비어있는 값이 있습니다.");
    }
  });

  $("#gu").change(function () {
    var value = $(this).val();
    var filterFlag = false;
    var filterValue = "";

    if (value == 26) {
      filterFlag = true;
    } else {
      filterFlag = false;
    }

    $.ajax({
      url: "/api/sensor/list/" + value,
      type: "GET",
      success: function (r) {
        var text = "<option>기기 선택</option>";

        if (r.length != 0) {
          if (!filterFlag) {
            $.each(r, function (a, b) {
              text +=
                '<option value="' +
                b.equiInfoKey +
                '">' +
                b.equiInfoKeyHan +
                "</option>";
            });
          } else {
            $.each(r, function (a, b) {
              filterValue = excelNameClassfication(b.equiInfoKey);

              text +=
                '<option value="' +
                b.equiInfoKey +
                '">' +
                b.equiInfoKeyHan +
                filterValue +
                "</option>";
            });
          }
        }

        $("#equi").html(text);
      },
    });
  });
});

function excelNameClassfication(equiInfoKey) {
  var filterValue = "";

  switch (equiInfoKey) {
    case "V02Q1940751":
      filterValue = "-001";
      break;

    case "V02Q1940798":
      filterValue = "-002";
      break;

    case "V02Q1940779":
      filterValue = "-003";
      break;

    case "V02Q1940850":
      filterValue = "-004";
      break;

    case "V02Q1940856":
      filterValue = "-005";
      break;

    case "V02Q1940884":
      filterValue = "-006";
      break;

    case "V02Q1940789":
      filterValue = "-007";
      break;

    case "V02Q1940755":
      filterValue = "-008";
      break;

    case "V02Q1940780":
      filterValue = "-009";
      break;

    case "V02Q1940882":
      filterValue = "-010";
      break;

    case "V02Q1940834":
      filterValue = "-011";
      break;

    case "V02Q1940854":
      filterValue = "-012";
      break;

    case "V02Q1940855":
      filterValue = "-013";
      break;

    case "V02Q1940872":
      filterValue = "-014";
      break;

    case "V02Q1940712":
      filterValue = "-015";
      break;

    case "V02Q1940782":
      filterValue = "-016";
      break;

    case "V02Q1940752":
      filterValue = "-017";
      break;

    case "V02Q1940955":
      filterValue = "-018";
      break;

    case "V02Q1940786":
      filterValue = "-019";
      break;

    case "V02Q1940880":
      filterValue = "-020";
      break;

    case "V02Q1940785":
      filterValue = "-021";
      break;

    case "V02Q1940852":
      filterValue = "-022";
      break;

    case "V02Q1940879":
      filterValue = "-023";
      break;

    case "V02Q1940887":
      filterValue = "-024";
      break;

    default:
      filterValue = "";
      break;
  }

  return filterValue;
}
