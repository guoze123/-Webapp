(function (document, window, $) {
  "use strict";
  dateRange(".startTime", ".endTime");
  var sales_bar = echarts.init(document.getElementById("sales_bar"));
  var serving_bar = echarts.init(document.getElementById("serving_bar"));
  function initFn() {
    ajax_data(
      "/inventory/queryPersonalMarketing",
      {
        params: queryParams(),
        contentType: "application/x-www-form-urlencoded"
      },
      function (res) {
        let marketing = res.marketingData;
        let reportSale = res.reportSale;
        let reportService = res.reportService;
        query_sales_bar(res.reportSale);
        query_serving_bar(res.reportService);
        $("#personal").bootstrapTable({
          data: res.marketingData,
          striped: true, //是否显示行间隔色
          pageNumber: 1, //初始化加载第一页
          pagination: true, //是否分页
          sidePagination: "client", //server:服务器端分页|client：前端分页
          pageSize: 20, //单页记录数
          pageList: [10, 20, 30], //可选择单页记录数
          height: $(window).height() - 110,
          showRefresh: false, //刷新按钮
          cache: true, // 禁止数据缓存
          search: false, // 是否展示搜索
          showLoading: true,
          sortable: true,
          sortOrder: "asc", //排序方式
          columns: [
            {
              title: "开始时间",
              field: "startTime",
              sortable: true
            },
            {
              title: "结束时间",
              field: "endTime",
              sortable: true
            },
            {
              title: "店铺名称",
              field: "storeName",
              sortable: true
            },
            {
              title: "销售员",
              field: "sellers",
              sortable: true
            },
            {
              title: "销售额",
              field: "amount",
              sortable: true
            },
            {
              title: "服务次数",
              field: "serviceCnt",
              sortable: true
            }
          ]
        });
      }
    );
  }

  function queryParams() {
    return {
      jsonStr: JSON.stringify({
        ...userInformation(),
        startTime: $(".startTime")
          .val()
          .trim()
          ? $(".startTime")
            .val()
            .trim()
          : undefined,
        endTime: $(".endTime")
          .val()
          .trim()
          ? $(".endTime")
            .val()
            .trim()
          : undefined
      })
    };
  }
  function userInformation() {
    let userValue = $(".query_userinformation")
      .val()
      .trim();
    if (userValue) {
      let type = "";
      if (/^[0-9]{5}$/.test(userValue)) {
        type = "id";
      } else if (/^[0-9]{11}$/.test(userValue)) {
        type = "phoneNumber";
      } else {
        type = "name";
      }
      return {
        userType: type,
        userValue: userValue
      };
    } else {
      return {
        userType: undefined,
        userValue: undefined
      };
    }
  }

  function query_sales_bar(data) {
    if (Object.prototype.toString.call(data) == "[object Array]") {
      return;
    }
    let nameList = [];
    let valueList = [];
    for (let k in data) {
      nameList.push(k);
      valueList.push(data[k]);
    }
    let option = {
      noDataLoadingOption: {
        text: "无数据",
        effect: "bubble",
        effectOption: {
          effect: {
            n: 0
          }
        }
      },
      tooltip: {
        trigger: "axis",
        axisPointer: {
          // 坐标轴指示器，坐标轴触发有效
          type: "shadow" // 默认为直线，可选为：'line' | 'shadow'
        }
      },
      grid: {
        x: 45,
        y: 20,
        y2: 20,
        x2: 10
      },
      xAxis: [
        {
          type: "category",
          data: nameList
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
          type: "bar",
          data: valueList,
          barWidth:"30px",
          itemStyle: {
            normal: {
              color: "#1a7bb9"
            }
          }
        }
      ]
    };
    sales_bar.clear();
    sales_bar.setOption(option);
  }
  function query_serving_bar(data) {
    let nameList = [];
    let valueList = [];
    for (let k in data) {
      nameList.push(k);
      valueList.push(data[k]);
    }
    let option = {
      noDataLoadingOption: {
        text: "无数据",
        effect: "bubble",
        effectOption: {
          effect: {
            n: 0
          }
        }
      },
      tooltip: {
        trigger: "axis",
        axisPointer: {
          // 坐标轴指示器，坐标轴触发有效
          type: "shadow" // 默认为直线，可选为：'line' | 'shadow'
        }
      },
      grid: {
        x: 45,
        y: 20,
        y2: 20,
        x2: 10
      },
      xAxis: [
        {
          type: "category",
          data: nameList
        }
      ],
      yAxis: [
        {
          type: "value"
        }
      ],
      series: [
        {
          name: "服务次数",
          type: "bar",
          data: valueList,
          barWidth:"30px",
          itemStyle: {
            normal: {
              color: "#1a7bb9"
            }
          }
        }
      ]
    };
    serving_bar.clear();
    serving_bar.setOption(option, true);
  }

  initFn();
  // 点击查询按钮
  $("#eventqueryBtn").click(function () {
    $("#personal").bootstrapTable("destroy");
    initFn();
  });

  // 导出
  $(".exportBtn").click(function () {
    let menuName = $(".J_menuTab.active", parent.document)
      .text()
      .trim();
    let titleName = $(this)
      .parents(".ibox")
      .find(".ibox-title h5 ")
      .text()
      .trim();
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportPersonalMarketing",
      method: "post"
    });
    $("<input>")
      .attr("name", "jsonStr")
      .val(
        JSON.stringify({
          ...userInformation(),
          fileName: menuName + "-" + titleName + ".csv",
          startTime: $(".startTime")
            .val()
            .trim()
            ? $(".startTime")
              .val()
              .trim()
            : undefined,
          endTime: $(".endTime")
            .val()
            .trim()
            ? $(".endTime")
              .val()
              .trim()
            : undefined
        })
      )
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });
  $(window).resize(function () {
    sales_bar.resize();
    serving_bar.resize();
  });
})(document, window, jQuery);
