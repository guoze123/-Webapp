$(function () {
  var barChart = echarts.init(document.getElementById("echarts-bar-chart"));
  monthRange(".startTime", ".endTime");
  var apiMap = {
    company: {
      // 公司
      sales: "/inventory/queryCompanyPolyline"
    },
    directStore: {
      // 直营店
      sales: "/inventory/queryDerectStorePolyline"
    },
    store: {
      sales: "/inventory/queryFranchiseStorePolyline"
    }
  };
  var urlSales = apiMap.company.sales;
  function init() {
    let params = {
      startTime: $(".startTime")
        .val()
        .trim(),
      endTime: $(".endTime")
        .val()
        .trim()
    };
    let sales = [],
      profit = [],
      batchno = [];
    ajax_data(urlSales, { params: JSON.stringify(params) }, function (res) {
      let baroption = {
        title: {
          text: "趋势图"
        },
        tooltip: {
          trigger: "axis"
        },
        legend: {
          data: ["销售额", "利润"]
        },
        calculable: true,
        xAxis: [
          {
            type: "category",
            data: batchno
          }
        ],
        yAxis: [
          {
            type: "value"
          }
        ],
        series: [
          {
            name: "销售额",
            type: "line",
            data: sales
          },
          {
            name: "利润",
            type: "line",
            data: profit
          }
        ]
      };
      profit = [];
      batchno = [];
      sales = [];
      res.profit.forEach(function (v, i) {
        profit.push(v.profit);
        batchno.push(v.batchno);
      });
      res.sales.forEach(function (v, i) {
        sales.push(v.sales);
      });
      baroption["series"][0]["data"] = sales;
      baroption["series"][1]["data"] = profit;
      baroption["xAxis"][0]["data"] = batchno;
      barChart.clear();
      barChart.setOption(baroption);
    });
  }

  init();
  $(".queryBtn").click(function () {
    init();
  });
  $(".salseType input[type='radio']").change(function () {
    // 公司：0  直营店：1 加盟店：2
    if (
      $(this)
        .val()
        .trim() == "0"
    ) {
      urlSales = apiMap.company.sales;
    } else if (
      $(this)
        .val()
        .trim() == "1"
    ) {
      urlSales = apiMap.directStore.sales;
    } else {
      urlSales = apiMap.store.sales;
    }
    init();
  });
  // 公司导出
  $(".exportBtn").click(function () {
    let menuName = $(".J_menuTab.active", parent.document).text().trim();
    let titleName = $(this)
      .parents(".ibox")
      .find(".ibox-title h5 ")
      .text().trim();
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportInventoryAnalysis",
      method: "post"
    });
    $("<input>")
      .attr("name", "jsonStr")
      .val(
        JSON.stringify({
          startTime: $(".startTime").val() ? $(".startTime").val() : undefined,
          endTime: $(".endTime").val() ? $(".endTime").val() : undefined,
          reportType: $("input[name='type']:checked").val(),
          fileName: menuName + "-"+ $(".salseType input[type='radio']:checked").attr("data-name")+ titleName+".csv"
        })
      )
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });

  $(window).resize(barChart.resize);
});
