(function(document, window, $) {
  "use strict";
  var Qdate = new Date();
  Qdate.setDate(1);
  Qdate.setMonth(Math.floor(Qdate.getMonth() / 3));
  $.fn.datepicker.dates["zh-CN-qtrs"] = {
    days: [
      "星期日",
      "星期一",
      "星期二",
      "星期三",
      "星期四",
      "星期五",
      "星期六",
      "星期日"
    ],
    daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
    months: ["Q1", "Q2", "Q3", "Q4", "", "", "", "", "", "", "", ""],
    monthsShort: [
      "一季度",
      "二季度",
      "三季度",
      "四季度",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ],
    clear: "清除",
    meridiem: ["上午", "下午"]
  };
  function quarterRange(start,end) { 
    $(start).datepicker({
      startDate:new Date( (new Date().getFullYear()-2)+"-01-01"),
      endDate: new Date(),
      clearBtn: true,
      startView: 1,
      maxViewMode: 1,
      minViewMode: 1,
      autoclose: true,
      format: "yyyy-MM",
      language: "zh-CN-qtrs",
      initialDate: Qdate
    }).on('changeDate',function(e){
        var startTime = e.date;
        $(end).datepicker('setStartDate',startTime);
    });
    //结束时间
    $(end).datepicker({
        startDate:new Date( (new Date().getFullYear()-2)+"-01-01"),
        endDate: new Date(),
        clearBtn: true,
        startView: 1,
        maxViewMode: 1,
        minViewMode: 1,
        autoclose: true,
        format: "yyyy-MM",
        language: "zh-CN-qtrs",
        initialDate: Qdate
    }).on('changeDate',function(e){
        var endTime = e.date;
        $(start).datepicker('setEndDate',endTime);
    });
  }

  quarterRange(".startTime",".endTime")
  function initFn() {
    $("#importInventory").bootstrapTable({
      method: "post",
      url: base + "/personnel/queryEmployeeAchievement", //请求路径
      striped: true, //是否显示行间隔色
      pageNumber: 1, //初始化加载第一页
      pagination: true, //是否分页
      sidePagination: "client", //server:服务器端分页|client：前端分页
      pageSize: 10, //单页记录数
      height: $(window).height() - 150,
      pageList: [10, 20, 30], //可选择单页记录数
      showRefresh: false, //刷新按钮
      cache: true, // 禁止数据缓存
      search: false, // 是否展示搜索
      sortable: true, //是否启用排序
      sortOrder: "asc",//排序方式
      showLoading: true,
      contentType: "application/x-www-form-urlencoded",
      queryParams: queryParams,
      columns: [
        {
          title: "员工id",
          field: "employeeId",
          sortable: true
        },
        {
          title: "员工名称",
          field: "employeeName",
          sortable: true
        },
        {
          title: "店铺名称",
          field: "ownerName",
          sortable: true
        },
        {
          title: "绩效时间",
          field: "batchno",
          sortable: true
        },
        {
          title: "绩效结果",
          field: "achievementResult",
          sortable: true
        },
        {
          title: "绩效原因",
          field: "reason"
        }
      ]
    });
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
        type="name"
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

  initFn();
  // 点击查询按钮
  $("#eventqueryBtn").click(function() {
    $("#importInventory").bootstrapTable("selectPage",1);
    $("#importInventory").bootstrapTable("refresh");
  });
  $("#uploadFile").change(function() {
    var fromdata = new FormData();
    fromdata.append("files", $(this)[0].files[0]);
    file_upload("/common/importAchievement", fromdata, function(res) {
      if (res.length > 0) {
        $("#importInventory").bootstrapTable("selectPage",1);
        $("#importInventory").bootstrapTable("refresh");
        tips("文件导入成功", 6);
      } else {
        tips("文件导入失败，请重新导入", 5);
      }
      $("#uploadFile").val("");
    });
  });

  // 导出
  $(".exportBtn").click(function() {
    let menuName= $('.J_menuTab.active', parent.document).text().trim();
    let titleName=$(this).parents(".ibox").find(".ibox-title h5 ").text().trim();
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportArchievementTemplate",
      method: "post"
    });
    $("<input>")
      .attr("name", "fileName")
      .val(menuName+"-"+titleName+".csv")
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });
})(document, window, jQuery);
