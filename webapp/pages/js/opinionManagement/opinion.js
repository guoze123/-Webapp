"use strict";
(function (document, window, $) {
  monthRange(".startTime", ".endTime");
  function initFn() {
    $("#opinion").bootstrapTable({
      method: "post",
      url: base + "/competence/queryFeedBack",
      striped: true,
      pageNumber: 1,
      pagination: true,
      sidePagination: "client",
      pageSize: 20,
      pageList: [10, 20, 30, 40],
      height: $(window).height() - 150,
      showRefresh: false,
      cache: true,
      search: false,
      showLoading: true,
      sortable: true,
      sortOrder: "asc", //排序方式
      contentType: "application/x-www-form-urlencoded",
      queryParams: queryParams,
      columns: [
        {
          title: "时间",
          field: "operaterDate",
          width: "200px",
          sortable: true
        },
        {
          title: "手机号",
          field: "telephone",
          width: "150px",
          sortable: true
        },
        {
          title: "意见内容",
          field: "content",
          sortable: true
        }
      ]
    });
  }
  function queryParams() {
    return {
      jsonStr: JSON.stringify({
        startTime: $(".startTime").val().trim() ? $(".startTime").val().trim() : undefined,
        endTime: $(".endTime").val().trim() ? $(".endTime").val().trim() : undefined,
      })
    }
  }
  initFn();

  $("#eventqueryBtn").click(function () {
    $("#opinion").bootstrapTable("refresh");
  });
  // 导出
  $(".exportBtn").click(function () {
    let menuName = $(".J_menuTab.active", parent.document)
      .text()
      .trim();
    let titleName = $(this)
      .parents(".ibox")
      .find(".ibox-title h5")
      .text()
      .trim();
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportFeedBack",
      method: "post"
    });
    $("<input>")
      .attr("name", "jsonStr")
      .val(
        JSON.stringify({
          ...queryParams(),
          fileName: menuName + "-" + titleName + ".csv"
        })
      )
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });
})(document, window, jQuery);
