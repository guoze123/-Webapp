(function (document, window, $) {
  ("use strict");
  var isadd = false;
  $(".costTime").datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    autoclose: true,
    format: "yyyy-mm-dd"
  });
  dateRange(
    ".query_startTime",
    ".query_endTime"
  );
  queryCostType();
  // queryDepartment();
  queryStore();
  function initFn() {
    $("#spending").bootstrapTable({
      method: "post",
      url: base + "/cost/queryCost", //请求路径
      striped: true, //是否显示行间隔色
      pageNumber: 1, //初始化加载第一页
      pagination: true, //是否分页
      sidePagination: "client", //server:服务器端分页|client：前端分页
      pageSize: 10, //单页记录数
      pageList: [10, 20, 30], //可选择单页记录数
      showRefresh: false, //刷新按钮
      cache: true, // 禁止数据缓存
      search: false, // 是否展示搜索
      height: $(window).height() - 150,
      showLoading: true,
      sortable: true,
      sortOrder: "asc", //排序方式
      queryParams: queryParams,
      contentType:
        "application/x-www-form-urlencoded",
      columns: [
        // {
        //   title: "开支id",
        //   field: "costId"
        // },
        {
          title: "开支时间",
          field: "costTime",
          sortable: true
        },
        {
          title: "核算单元",
          field: "ownerName",
          sortable: true
        },
        {
          title: "开支类型",
          field: "costTypeName",
          sortable: true
        },
        {
          title: "开支金额",
          field: "costAmount",
          sortable: true
        },
        {
          title: "备注信息",
          field: "remark"
        },
        {
          title: "发票",
          //   field: "receiptPic",
          formatter: function (value, row) {
            return `<img  class="viewImg" src="${base +
              "/uploadImgs/" +
              row.costId +
              ".jpg" +
              "?t=" +
              new Date().valueOf()}"  style="width:50px;height:50px">`;
          },
          events: {
            "click .viewImg": function (
              e,
              v,
              row
            ) {
              let url =
                base +
                "/uploadImgs/" +
                row.costId +
                ".jpg?" +
                "t=" +
                new Date().valueOf();
              let image = new Image();
              image.src = url;
              image.onload = function () {
                var width = image.width;
                var height = image.height;
                if (width > height) {
                  height =
                    (800 / width) * height;
                  width = 800;
                } else {
                  width =
                    (500 / height) * width;
                  height = 500;
                }
                layer.open({
                  type: 1,
                  title: false,
                  closeBtn: 1,
                  area: [
                    width + "px",
                    height + "px"
                  ],
                  skin: "layui-layer-nobg", //没有背景色
                  shadeClose: true,
                  content: `<img src="${url}" style="width:${width}px; height:${height}px "/>`
                });
              };
            }
          }
        },

        {
          title: "操作",
          field: "publicationTime",
          events: operateEvents,
          formatter: operation //对资源进行操作,
        }
      ]
    });
  }

  function operation(vlaue, row) {
    let purviewList = getQueryString(
      "purview"
    ).split(",");
    let html = "";
    if (purviewList.includes("3")) {
      html += ` <button type="button" id="edit" class="btn btn-info btn-sm editBtn">修改</button>`;
    }
    return html;
  }
  var operateEvents = {
    "click #edit": function (e, v, row) {
      $(".costTime").val(row.costTime);
      $(".ownerId").val(row.ownerId);
      $(".ownerId").trigger("chosen:updated");
      $(".costTypeId").val(row.costTypeId);
      $(".costTypeId").trigger(
        "chosen:updated"
      );
      $(".costAmount").val(row.costAmount);
      $(".receiptPic").val(row.receiptPic);
      $(".remark").val(row.remark);
      $(".remark").attr(
        "data_costId",
        row.costId
      );

      isadd = false;
      open_html(
        "修改信息",
        "#editData",
        function () {
          $("#editData input").val("");
          $("#editData select").val("");
          $(".ownerId").trigger(
            "chosen:updated"
          );
          $(".costTypeId").trigger(
            "chosen:updated"
          );
          $("#editData img").attr("src", "");
        },
        function () {
          confirmFn();
        },
        function () {
          closeFn();
        }
      );
      $(".ownerId").chosen();
    }
  };
  //查询条件
  function queryParams() {
    return {
      jsonStr: JSON.stringify({
        startTime: $(
          ".searchList .query_startTime"
        )
          .val()
          .trim()
          ? $(".searchList .query_startTime")
            .val()
            .trim()
          : undefined,
        endTime: $(".searchList .query_endTime")
          .val()
          .trim()
          ? $(".searchList .query_endTime")
            .val()
            .trim()
          : undefined,
        costTypeId: $(
          ".searchList .query_costTypeId"
        )
          .val()
          .trim()
          ? $(".searchList .query_costTypeId")
            .val()
            .trim()
          : undefined,
        ownerName: $(
          ".searchList .query_ownerName"
        )
          .val()
          .trim()
          ? $(".searchList .query_ownerName")
            .val()
            .trim()
          : undefined
      })
    };
  }

  initFn();
  document
    .getElementById("spending")
    .addEventListener(
      "error",
      function (event) {
        var ev = event || window.event;
        var elem = ev.target;
        if (
          elem.tagName.toLowerCase() == "img"
        ) {
          elem.src =
            base + "/pages/img/noImg.png";
          $(elem).css({
            visibility: "hidden"
          });
        }
      },
      true
    );
  // 点击查询按钮
  $("#eventqueryBtn").click(function () {
    $("#spending").bootstrapTable(
      "selectPage",
      1
    );
    $("#spending").bootstrapTable("refresh");
  });

  $(".addBtn").click(function () {
    isadd = true;
    open_html(
      "添加开支",
      "#editData",
      function () {
        $("#editData input").val("");
        $("#editData select").val("");
        $(".ownerId").trigger("chosen:updated");
        $(".costTypeId").trigger(
          "chosen:updated"
        );
        $("#editData img").attr("src", "");
      },
      function () {
        confirmFn();
      },
      function () {
        closeFn();
      }
    );
    $(".ownerId").chosen();
  });
  $(".uploadimg").change(function () {
    uploadFile($(this));
  });
  function closeFn() {
    layer.closeAll("page");
  }

  function confirmFn() {
    let required = true;
    $(".required")
      .parent()
      .next()
      .each(function () {
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
    let formdata = new FormData();
    let params = {
      costTime: $(".costTime")
        .val()
        .trim(),
      ownerId: $(".ownerId")
        .val()
        .trim(),
      costTypeId: $(".costTypeId")
        .val()
        .trim(),
      costAmount: $(".costAmount")
        .val()
        .trim(),
      remark: $(".remark")
        .val()
        .trim(),
      costId: $(".remark").attr("data_costId")
    };
    if ($(".uploadimg")[0].files[0]) {
      formdata.append(
        "file",
        $(".uploadimg")[0].files[0]
      );
    }
    formdata.append(
      "jsonStr",
      JSON.stringify(params)
    );
    let url;
    if (isadd) {
      url = "/cost/addCost";
    } else {
      url = "/cost/modifyCost";
    }
    file_upload(url, formdata, function (res) {
      console.log(res);
      if (res.resultCode > -1) {
        layer.closeAll("page");
        $("#spending").bootstrapTable(
          "selectPage",
          1
        );
        $("#spending").bootstrapTable(
          "destroy"
        );
        initFn();
        let tipsText;
        if (isadd) {
          tipsText = "添加开支信息成功";
        } else {
          tipsText = "修改开支信息成功";
        }
        tips(tipsText, 6);
      } else {
        let tipsText;
        if (isadd) {
          tipsText = "添加开支信息失败";
        } else {
          tipsText = "修改开支信息失败";
        }
        tips(tipsText, 5);
      }
    });
  }

  // 查询所有部门
  function queryDepartment() {
    ajax_data(
      "/competence/queryDepartment",
      { params: JSON.stringify({}) },
      function (res) {
        let option =
          "<option value=''>选择部门</option>";
        res.forEach(function (element) {
          option += `<option value="${element.departmentId}">${element.departmentName}</option>`;
        });
        $(".ownerId").html(option);
      }
    );
  }

  // 查找门店
  function queryStore() {
    ajax_data(
      "/competence/queryStoreInfo",
      { params: JSON.stringify({}) },
      function (storeData) {
        // console.log(res);
        let option =
        "<option value=''>选择店铺或部门</option>";
        storeData.forEach(function (element) {
          option += `<option value="${element.storeId}">${element.storeName}</option>`;
        });

        ajax_data(
          "/competence/queryDepartment",
          { params: JSON.stringify({}) },
          function (res) {
            res.forEach(function (element) {
              option += `<option value="${element.departmentId}">${element.departmentName}</option>`;
            });
            // allStroe = res;
            $(".ownerId").html(option);
            $(".ownerId").chosen();
          }
        );
      }
    );
  }

  // 开支分类
  function queryCostType() {
    let params = {
      categoryName: ""
    };
    ajax_data(
      "/cost/queryCostCategory",
      {
        params: JSON.stringify(params),
        async: false
      },
      function (res) {
        let option =
          "<option value=''>选择开支分类</option>";
        res.forEach(function (element) {
          option += `<option value="${element.categoryId}">${element.categoryName}</option>`;
        });
        $(".query_costTypeId").html(option);
        $(".query_costTypeId").chosen({});
        $(".costTypeId").html(option);
      }
    );
  }

  // 导出
  $(".exportBtn").click(function () {
    let menuName = $(
      ".J_menuTab.active",
      parent.document
    ).text().trim();
    let titleName = $(this)
      .parents(".ibox")
      .find(".ibox-title h5 ")
      .text().trim();
    let form = $(
      '<form id="to_export" style="display:none"></form>'
    ).attr({
      action:
        base + "/common/exportWaresOrCostData",
      method: "post"
    });
    $("<input>")
      .attr("name", "type")
      .val("1")
      .appendTo(form);
    $("<input>")
      .attr("name", "jsonStr")
      .val(
        JSON.stringify({
          startTime: $(
            ".searchList .query_startTime"
          )
            .val()
            .trim()
            ? $(".searchList .query_startTime")
              .val()
              .trim()
            : undefined,
          endTime: $(
            ".searchList .query_endTime"
          )
            .val()
            .trim()
            ? $(".searchList .query_endTime")
              .val()
              .trim()
            : undefined,
          costTypeId: $(
            ".searchList .query_costTypeId"
          )
            .val()
            .trim()
            ? $(".searchList .query_costTypeId")
              .val()
              .trim()
            : undefined,
          ownerName: $(
            ".searchList .query_ownerName"
          )
            .val()
            .trim()
            ? $(".searchList .query_ownerName")
              .val()
              .trim()
            : undefined,
          fileName: menuName + "-" + titleName+".csv"
        })
      )
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });
})(document, window, jQuery);
