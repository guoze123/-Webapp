(function(document, window, $) {
  "use strict";
  monthRange(".query_startTime", ".query_stopTime");
  function initFn() {
    $("#payment").bootstrapTable({
      method: "post",
      url: base + "/inventory/queryPayment", // 请求路径
      // url: "../../testJson/storeManagement.json", //请求路径
      striped: true, // 是否显示行间隔色
      pageNumber: 1, // 初始化加载第一页
      pagination: true, // 是否分页
      sidePagination: "client", // server:服务器端分页|client：前端分页
      pageSize: 20, // 单页记录数
      height: $(window).height() - 150,
      showRefresh: false, // 刷新按钮
      cache: true, // 禁止数据缓存
      contentType: "application/x-www-form-urlencoded",
      search: false, // 是否展示搜索
      sortable: true,
      sortOrder: "asc", //排序方式
      showLoading: true,
      queryParams: queryParams,
      columns: [
     
        {
          title: "收款方",
          field: "toStoreName",
          sortable: true
        },
        {
          title: "应付金额",
          field: "totalAmount",
          sortable: true
        },
        {
          title: "实际支付金额",
          field: "payedAmount",
          sortable: true
        },
        {
          title: "尾款",
          field: "balance",
          sortable: true
        },
        {
          title: "延期时间",
          field: "delayDays",
          sortable: true
        },
        {
          title: "欠款方",
          field: "fromStoreName",
          sortable: true
        },
        {
          title: "操作",
          field: "publicationTime",
          events: operateEvents,
          formatter: operation
        }
      ]
    });
  }

  function operation(vlaue, row) {
    let purviewList = getQueryString("purview").split(",");
    let html = "";
    if (purviewList.includes("3")) {
      html += `<button type="button" id="paymentBtn" class="btn btn-info btn-sm paymentBtn" style="margin-right: 10px;">继续支付</button>`;
    }
    if (purviewList.includes("4")) {
      html += `<button type="button" id="detailBtn" class="btn btn-info btn-sm detailBtn">支付详情</button>`;
    }
    return html;
  }
  var operateEvents = {
    "click #detailBtn": function(e, v, row) {
      let params = {
        stockId: row.stockId
      };
      ajax_data(
        "/inventory/queryPaymentDetail",
        {
          params: {
            stockId: row.stockId
          },
          contentType: "application/x-www-form-urlencoded;charset=utf-8"
        },
        function(res) {
          $("#paymentDetailTable").bootstrapTable("destroy");
          $("#paymentDetailTable").bootstrapTable({
            striped: true, // 是否显示行间隔色
            pagination: false, // 是否分页,
            data: res,
            height: $("body").height() < 500 ? $("body").height() - 120 : 330,
            columns: [
              {
                title: "店铺ID",
                field: "storeId"
              },
              {
                title: "店铺名称",
                field: "storeName"
              },
              {
                title: "总金额",
                field: "totalAmount"
              },
              {
                title: "支付金额",
                field: "payAmount"
              },
              {
                title: "支付时间",
                field: "paymentTime"
              }
            ]
          });
        }
      );
      open_html("支付详情", "#payDetail", function() {
        $("input[type='text']").val("");
      });
    },
    "click #paymentBtn": function(e, v, row) {
      $("#keepPaying .storckId").val(row.stockId);
      $("#keepPaying .storeName").val(row.storeName);
      $("#keepPaying .totalAmount").val(row.totalAmount);
      $("#keepPaying .storeId").val(row.storeId);
      open_html(
        "继续支付",
        "#keepPaying",
        function() {
          $("input[type='text']").val("");
        },
        function() {
          confirmFn();
        },
        function() {
          closeFn();
        }
      );
    }
  };

  function queryParams() {
    return {
      
    };
  }
  initFn();
  // 点击查询按钮
  $("#eventqueryBtn").click(function() {
    $("#payment").bootstrapTable("selectPage", 1);
    $("#payment").bootstrapTable("refresh");
  });
  function closeFn() {
    layer.closeAll("page");
  }
  // 添加或修改
  function confirmFn() {
    let required = true;
    $(".required")
      .parent()
      .next()
      .each(function() {
        if (
          !$(this)
            .val()
            .trim()
        ) {
          required = false;
        }
      });
    if (!required) {
      tips(requiredText, 5);
      return;
    }
    let params = {
      stockId: $("#keepPaying .storckId")
        .val()
        .trim(),
      storeId: Number(
        $("#keepPaying .storeId")
          .val()
          .trim()
      ),
      paymentTime: $("#keepPaying .payTime")
        .val()
        .trim(),
      totalAmount: $("#keepPaying .totalAmount")
        .val()
        .trim(),
      payAmount: $("#keepPaying .amount")
        .val()
        .trim(),
      payType: Number(
        $("#keepPaying .payType input[type='radio']:checked")
          .val()
          .trim()
      ),
      custPhone: $("#keepPaying .custPhone")
        .val()
        .trim(),
      batchno: ""
    };
    ajax_data(
      "/inventory/appendPayment",
      {
        params: {
          jsonStr: JSON.stringify(params)
        },
        contentType: "application/x-www-form-urlencoded;charset=utf-8"
      },
      function(res) {
        if (res.resultCode > -1) {
          layer.closeAll("page");
          $("#payment").bootstrapTable("selectPage", 1);
          $("#payment").bootstrapTable("refresh");
        } else {
          tips("支付失败", 5);
        }
      }
    );
  }

  // 导出
  $(".exportBtn").click(function() {
    let menuName= $('.J_menuTab.active', parent.document).text().trim();
    let titleName=$(this).parents(".ibox").find(".ibox-title h5 ").text().trim();
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportPayment",
      method: "post"
    });
    $("<input>")
      .attr("name", "fileName")
      .val(menuName + "-" + titleName+".csv")
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });
})(document, window, jQuery);
