(function(document, window, $) {
  "use strict";
  function initFn() {
    $("#departure").bootstrapTable({
      method: "post",
      url: base + "/personnel/queryLeaveEmployeeInfo", //请求路径
      striped: true, //是否显示行间隔色
      pageNumber: 1, //初始化加载第一页
      pagination: true, //是否分页
      sidePagination: "client", //server:服务器端分页|client：前端分页
      pageSize: 10, //单页记录数
      pageList: [10, 20, 30], //可选择单页记录数
      height: $(window).height() - 150,
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
          title: "员工工号",
          field: "employeeId",
          sortable: true
        },
        {
          title: "员工姓名",
          field: "employeeName",
          sortable: true
        },
        {
          title: "员工身份证号",
          field: "identityNumber",
          sortable: true
        },
        {
          title: "离职时间",
          field: "leaveTime",
          sortable: true
        },
        {
          title: "离职原因",
          field: "leaveReson"
        },
        {
          title: "离职凭证",
          formatter: function(value, row) {
            return `<img  class="viewImg" src="${base +
              "/uploadImgs/" +
              row.employeeId+"_"+row.leaveTime+
              ".jpg"+"?t="+new Date().valueOf()}"  style="width:50px;height:50px">`;
          },
          events: {
            "click .viewImg": function(e, v, row) {
              let url = base + "/uploadImgs/" + row.employeeId+"_"+row.leaveTime+ ".jpg?"+"t="+new Date().valueOf();
              let image = new Image();
              image.src = url;
              image.onload = function() {
                var width = image.width;
                var height = image.height;
                if (width > height) {
                  height = (800 / width) * height;
                  width = 800;
                } else {
                  width = (500 / height) * width;
                  height = 500;
                }
                layer.open({
                  type: 1,
                  title: false,
                  closeBtn: 1,
                  area: [width + "px", height + "px"],
                  skin: "layui-layer-nobg", //没有背景色
                  shadeClose: true,
                  content: `<img src="${url}" style="width:${width}px; height:${height}px "/>`
                });
              };
            }
          }
        },
        // {
        //   title: "操作",
        //   field: "publicationTime",
        //   events:operateEvents,
        //   formatter: operation //对资源进行操作,
        // }
      ]
    });
  }

  function operation(vlaue, row) {
    let purviewList = getQueryString("purview").split(",");
    let html = "";
    if (purviewList.includes("3")) {
      html += `<button type="button" id="edit" class="btn btn-info btn-sm editBtn">修改</button>`;
    }
    return html;
  }

  function queryParams() {
    return {
      employeeName: $(".query_employeeName")
        .val()
        .trim()
    };
  }
  initFn();

  document.getElementById("departure").addEventListener(
    "error",
    function(event) {
      var ev = event || window.event;
      var elem = ev.target;
      if (elem.tagName.toLowerCase() == "img") {
        elem.src = base + "/pages/img/noImg.png";
        $(elem).css({
          visibility:"hidden"
        })
      }
    },
    true
  );

  // 点击查询按钮
  $("#eventqueryBtn").click(function() {
    $("#departure").bootstrapTable("selectPage",1);
    $("#departure").bootstrapTable("refresh");
  });

  // 点击添加
  $(".addBtn").click(function() {
    open_html(
      "添加离职人员",
      "#editData",
      function() {
        $("input").val("");
      },
      function() {
        confirmFn();
      },
      function() {
        closeFn();
      }
    );
  });
  $(".uploadimg").change(function() {
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
      employeeId: $(".employeeId")
        .val()
        .trim(), //员工id
      leaveTime: $(".leaveTime")
        .val()
        .trim(),
      leaveReason: $(".leaveReason")
        .val()
        .trim()
    };
    let url;
    url = "/personnel/addLeaveEmployee";
    let formdata = new FormData();
    if ($(".uploadimg")[0].files[0]) {
      formdata.append("file", $(".uploadimg")[0].files[0]);
    }
    formdata.append("jsonStr", JSON.stringify(params));
    file_upload(url, formdata, function(res) {
      if (res.resultCode > -1) {
        layer.closeAll("page");
        $("#departure").bootstrapTable("selectPage",1);
        $("#departure").bootstrapTable("refresh");
      } else {
        tips("添加离职人员失败", 5);
      }
    });
  }
})(document, window, jQuery);
