function open_html1(title, ht_id, fn, yesFn, closeFn) {
  var h_w = "800px";
  var h_h = ($("body").height() < 500 ? $("body").height() - 40 : "500") + "px";
  layer.open({
    type: 1,
    title: title,
    maxmin: true,
    content: $(ht_id), //这里content
    area: [h_w, h_h],
    end: function () {
      // 销毁弹出时 执行
      if (!!fn) {
        fn();
      }
    },
    btn: ["确定", "取消"],
    yes: function (index, layero) {
      yesFn();
    },
    btn2: function (index, layero) {
      closeFn();
    }
  });
}
var employeeId = "";

(function (document, window, $) {
  "use strict";
  var isadd = false;
  var allStroe = [];
  var allRole = [];
  var personnelRatio = echarts.init(document.getElementById("personnelRatio"));
  var personnel = echarts.init(document.getElementById("personnel"));
  queryCompetence();
  queryStore();
  function initFn() {
    ajax_data(
      "/personnel/queryEmployeeInfo",
      { params: JSON.stringify(queryParams()) },
      function (res) {
        queryRatio(res.activeCnt);
        queryPersonnel(res.flowCnt)
        $("#employeeInfo").bootstrapTable({
          // method: "post",
          // url: base + "/personnel/queryEmployeeInfo", //请求路径
          data: res.tblData,
          striped: true, //是否显示行间隔色
          pageNumber: 1, //初始化加载第一页
          pagination: true, //是否分页
          sidePagination: "client", //server:服务器端分页|client：前端分页
          pageSize: 20, //单页记录数
          pageList: [10, 20, 30], //可选择单页记录数
          showRefresh: false, //刷新按钮
          cache: true, // 禁止数据缓存
          search: false, // 是否展示搜索
          sortable: true, //是否启用排序
          sortOrder: "asc",//排序方式
          height: $(window).height() - 110,
          showLoading: true,
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
              title: "性别",
              field: "employeeSex",
              sortable: true
            },
            {
              title: "归属部门",
              field: "ownerName",
              sortable: true
            },
            {
              title: "身份证号",
              field: "identityNumber",
              sortable: true
            },
            {
              title: "入职时间",
              field: "entryTime",
              sortable: true
            },
            {
              title: "电话",
              field: "telephone",
              sortable: true
            },
            {
              title: "职务名称",
              field: "job",
              sortable: true
            },
            {
              title: "简历",
              formatter: function (value, row) {
                return `<img  class="viewImg" src="${base +
                  "/uploadImgs/" +
                  row.telephone +
                  ".jpg" + "?t=" + new Date().valueOf()}"  style="width:50px;height:50px">`;
              },
              events: {
                "click .viewImg": function (e, v, row) {
                  let url = base + "/uploadImgs/" + row.telephone + ".jpg?" + "t=" + new Date().valueOf();
                  let image = new Image();
                  image.src = url;
                  image.onload = function () {
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
            {
              title: "操作",
              field: "publicationTime",
              events: operateEvents,
              formatter: operation //对资源进行操作,
            }
          ]
        });
      }
    );
  }
  function operation(vlaue, row) {
    let purviewList = getQueryString("purview").split(",");
    let html = "";
    if (purviewList.includes("3")) {
      html += `<button type="button" id="edit" class="btn btn-info btn-sm editBtn">修改</button>`;
    }
    return html;
  }
  var operateEvents = {
    "click #edit": function (e, v, row) {
      isadd = false;
      employeeId = row.employeeId;
      $(".employeeName").val(row.employeeName); //姓名
      $(".employeeSex").val(row.employeeSex); //性别
      $(".identityNumber").val(row.identityNumber); //身份证
      $(".entryTime").val(row.entryTime); //入职时间
      $(".telephone").val(row.telephone); //电话
      $(".job").val(row.job); //职务
      $(".role").val(row.role); //角色
      $(".address").val(row.address); //地址
      $(".activeStatus").val(row.activeStatus); //状态 在离
      $(".education").val(row.education); // 学历8
      $(".ownerId").val(`${row.ownerId}`); //店铺id
      $(".ownerId").trigger("chosen:updated");
      $(".birthday").val(row.birthday);
      $(".promotion").val(row.promotion);
      $(".workExperience").val(row.workExperience);
      open_html1(
        "修改信息",
        "#editData",
        function () {
          $("#editData input").val("");
          $("#editData select").val("");
          $(".ownerId").trigger("chosen:updated");
          $("#editData img").attr("src", "");
        },
        function () {
          confirmBtn();
        },
        function () {
          layer.closeAll("page");
        }
      );
      $(".ownerId").chosen();
    }
  };
  function queryParams() {
    return {
      ...userInformation(),
      ownerId: $(".query_ownerId")
        .val()
        .trim()
        ? $(".query_ownerId")
          .val()
          .trim()
        : undefined,
      activeStatus: $(".query_activeStatus")
        .val()
        .trim()
        ? $(".query_activeStatus")
          .val()
          .trim()
        : undefined
    };
  }
  function userInformation() {
    let userValue = $(".query_userinformation")
      .val()
      .trim();
    if (userValue) {
      if (/^[0-9]{5}$/.test(userValue)) {
        return {
          employeeId: userValue
        };
      } else if (/^[0-9]{11}$/.test(userValue)) {
        return {
          telephone: userValue
        };
      } else {
        return {
          employeeName: userValue
        };
      }
    } else {
      return {};
    }
  }

  initFn();

  // 查询人员比例
  function queryRatio(param) {
    let option = {
      color: ['#1a7bb9', "#c3cad0"],
      tooltip: {
        formatter: "{b}:{c}({d}%)"
      },
      legend: {
        x: "left",
        orient: "vertical",
        data: ["在职", "离职"]
      },
      labelLine: {
        normal: {
          show: false // show设置线是否显示，默认为true，可选值：true ¦ false
        }
      },
      series: [
        {

          type: "pie",
          radius: "70%",
          itemStyle: {
            normal: {
              label: {
                show: false
              },
              labelLine: {
                show: false
              }
            }
          },
          data: [
            { value: param[0]["activedCount"], name: "在职" },
            { value: param[0]["inActiveCount"], name: "离职" }
          ]
        }
      ]
    };
    personnelRatio.clear();
    personnelRatio.setOption(option);
  }
  // 查询 每个月的 入职离职人数
  function queryPersonnel(data) {
    let time = [], activeNum = [], inactived = [];
    data.forEach(function (ele) {
      time.push(ele.batchno)
      activeNum.push(ele.entryUser)
      inactived.push(ele.leaveUser)
    })
    let option = {
      tooltip: {
        trigger: "axis",
        axisPointer: {
          // 坐标轴指示器，坐标轴触发有效
          type: "shadow" // 默认为直线，可选为：'line' | 'shadow'
        }
      },
      legend: {
        data: ["入职", "离职"]
      },
      grid: {
        x: 30,
        x2: 10
      },
      xAxis: [
        {
          type: "category",
          data: time
        }
      ],
      yAxis: [
        {
          type: "value"
        }
      ],
      series: [
        {
          name: "入职",
          type: "bar",
          barWidth: "30px",
          data: activeNum,
          itemStyle: {
            normal: {
              color: "#1a7bb9"
            }
          }
        },
        {
          name: "离职",
          type: "bar",
          barWidth: "30px",
          data: inactived,
          itemStyle: {
            normal: {
              color: "#c3cad0"
            }
          }
        }
      ]
    };
    personnel.clear();
    personnel.setOption(option);
  }

  $(window).resize(function () {
    personnelRatio.resize();
    personnel.resize();
  });
  document.getElementById("employeeInfo").addEventListener(
    "error",
    function (event) {
      var ev = event || window.event;
      var elem = ev.target;
      if (elem.tagName.toLowerCase() == "img") {
        elem.src = base + "/pages/img/noImg.png";
        $(elem).css({
          visibility: "hidden"
        })
      }
    },
    true
  );
  // 点击查询按钮
  $("#eventqueryBtn").click(function () {
    $("#employeeInfo").bootstrapTable("destroy");
    initFn();
  });

  $(".uploadimg").change(function () {
    uploadFile($(this));
  });
  // 添加人员
  $(".addBtn").click(function () {
    isadd = true;
    open_html1(
      "添加人员",
      "#editData",
      function (params) {
        $("#editData input").val("");
        $("#editData select").val("");
        $(".ownerId").trigger("chosen:updated");
        //$(".chosen-single span").html("")
        $("#editData img").attr("src", "");
      },
      function () {
        confirmBtn();
      },
      function () {
        layer.closeAll("page");
      }
    );
    $(".ownerId").chosen();
  });
  function confirmBtn() {
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
    let params = {
      employeeId: isadd ? undefined : employeeId,
      employeeName: $(".employeeName")
        .val()
        .trim(), //姓名
      employeeSex: $(".employeeSex")
        .val()
        .trim(), //性别
      identityNumber: $(".identityNumber")
        .val()
        .trim(), //身份证
      entryTime: $(".entryTime")
        .val()
        .trim(), //入职时间
      telephone: $(".telephone")
        .val()
        .trim(), //电话
      job: $(".job")
        .val()
        .trim(), //职务
      role: $(".role")
        .val()
        .trim(), //角色
      ownerId: $(".ownerId")
        .val()
        .trim(), //店铺id
      address: $(".address")
        .val()
        .trim(), //地址
      activeStatus: $(".activeStatus")
        .val()
        .trim(), //状态 在离
      education: $(".education")
        .val()
        .trim(), // 学历
      birthday: $(".birthday").val().trim(),
      promotion: $(".promotion").val().trim(),
      workExperience: $(".workExperience").val().trim()

    };
    let formdata = new FormData();
    if ($(".uploadimg")[0].files[0]) {
      formdata.append("file", $(".uploadimg")[0].files[0]);
    }
    formdata.append("jsonStr", JSON.stringify(params));
    let url;
    if (isadd) {
      url = "/personnel/addEmployeeInfo";
    } else {
      url = "/personnel/modifyEmployeeInfo";
    }

    file_upload(url, formdata, function (res) {
      console.log(res);
      if (res.resultCode > -1) {
        layer.closeAll("page");
        $("#employeeInfo").bootstrapTable("destroy");
        initFn();
        let tipsText;
        if (isadd) {
          tipsText = "添加人员信息成功";
        } else {
          tipsText = "修改人员信息成功";
        }
        tips(tipsText, 6);
      } else {
        let tipsText;
        if (isadd) {
          tipsText = "添加人员信息失败";
        } else {
          tipsText = "修改人员信息失败";
        }
        tips(tipsText, 5);
      }
    });
  }
  // 人员导出
  $(".exportBtn").click(function () {
    let menuName = $('.J_menuTab.active', parent.document).text().trim();
    let titleName = $(this).parents(".ibox").find(".ibox-title h5 ").text().trim();
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportEmployee",
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

  // 查找角色
  function queryCompetence() {
    ajax_data(
      "/common/getCompetence",
      { params: {}, contentType: "application/x-www-form-urlencoded" },
      function (res) {
        console.log(res);
        let option = "<option value=''>选择角色</option>";
        res.obj.forEach(function (element) {
          option += `<option value="${element.id}">${element.name}</option>`;
        });

        allRole = res.obj;
        $(".role").html(option);
        $(".query_role").html(option);
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
            $(".query_ownerId").html(option);
            $(".ownerId").chosen();
            $(".query_ownerId").chosen();
          }
        );
      }
    );
  }
})(document, window, jQuery);
