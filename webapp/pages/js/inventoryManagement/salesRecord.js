var userEditOption = {};
var storeEditOption = {};
var allwares = ""; //所有商品
var pay_type={
  "0":"现金",
  "1":"微信",
  "2":"支付宝",
  "3":"刷卡",
  "4":"购物卡",
  "5":"其他",
};
(function (document, window, $) {
  "use strict";
  queryStore();
  queryWaresInfo();
  monthRange(".query_startTime", ".query_stopTime");
  function initFn() {
    // down_list(".detailAddress", "url", "选择地址");
    queryUserRecord();
    $("#storeSalesRecord").bootstrapTable({
      method: "post",
      url: base + "/inventory/querySale", //请求路径
      striped: true, //是否显示行间隔色
      pageNumber: 1, //初始化加载第一页
      pagination: true, //是否分页
      sidePagination: "client", //server:服务器端分页|client：前端分页
      pageSize: 20, //单页记录数
      pageList: [10, 20, 30], //可选择单页记录数
      showRefresh: false, //刷新按钮
      cache: true, // 禁止数据缓存
      search: false, // 是否展示搜索
      sortable: true,
      sortOrder: "asc", //排序方式
      showLoading: true,
      height: $(window).height() - 190,
      queryParams: queryParams,
      contentType: "application/x-www-form-urlencoded",
      columns: [
        {
          title: "录入时间",
          field: "operationDate",
          sortable: true
        },
        {
          title: "销售员",
          field: "sellers",
          sortable: true
        },
        {
          title: "店铺名称",
          field: "storeName",
          sortable: true
        },
        {
          title: "应付金额",
          field: "totalAmount",
          sortable: true
        },
        {
          title: "实付金额",
          field: "payedAmount",
          sortable: true
        },
        {
	      title: "支付类型",
	      field: "payType",
	      sortable: true
	    },
        {
          title: "客户类型",
          field: "custType"
        },
        {
          title: "备注",
          field: "remark",
          sortable: true
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
    let purviewList = getQueryString("purview").split(",");
    let html = "";
    if (purviewList.includes("3")) {
      html += `<button type="button" id="edit" class="btn btn-info btn-sm editBtn">修改</button>`;
    }
    if (purviewList.includes("4")) {
      html += `<button type="button" id="detail" class="btn btn-primary btn-sm detailBtn">详情</button>`;
    }
    return html;
  }

  function userOperation(vlaue, row) {
    let purviewList = getQueryString("purview").split(",");
    let html = "";
    if (purviewList.includes("3")) {
      html += `<button type="button" id="editUserDataBtn" class="btn btn-info btn-sm editBtn">修改</button>`;
    }
    if (purviewList.includes("4")) {
      html += `<button type="button" id="userDetailBtn" class="btn btn-primary btn-sm detailBtn">详情</button>`;
    }
    return html;
  }

  var operateEvents = {
    "click #edit": function (e, v, row) {
      ajax_data(
        "/inventory/querySaleDetail",
        {
          params: {
            stockId: row.stockId,
            startTime: $(".searchList .query_startTime")
              .val()
              .trim()
              ? $(".searchList .query_startTime")
                .val()
                .trim()
              : undefined,
            endTime: $(".searchList .query_stopTime")
              .val()
              .trim()
              ? $(".searchList .query_stopTime")
                .val()
                .trim()
              : undefined
          },
          contentType: "application/x-www-form-urlencoded;charset=utf-8"
        },
        function (res) {
          $("#editData .commodity").remove();
          function allWares(selectId) {
            let option = "<option value='' data-id=''>选择商品名称</option>";
            if (allwares.length) {
              allwares.forEach(function (item, index) {
                option += `<option value="${item.waresName}" data-id="${
                  item.waresId
                  }" ${item.waresId == selectId ? "selected" : ""} >${
                  item.waresName
                  }</option>`;
              });
            }
            return option;
          }
          if (res.length > 0) {
            let str = "", str1 = "";
            for (let i = 0; i < res.length; i++) {
              if (res[i].isGift == "0") {
                str += `<div class="list_row commodity newShop">
                <div style="width: 100%;">
                <span><i class="required">*</i>商品名称</span>
                <select class="form-control name" isGift='${res[i].isGift}'>
                ${allWares(res[i].waresId)}
                </select>
                <span style="margin-left: 10px;"><i class="required">*</i>商品数量</span>
                <input type="text" placeholder="商品数量" class="form-control number" value="${
                  res[i].waresCount
                  }">
                <button style=" margin-left: 10px;" onclick="deleteCommodity(this)">删除商品</button>
                </div></div>
                        `;
              } else {
                str1 += `<div class="list_row commodity newShop">
                <div style="width: 100%;">
                <span><i class="required">*</i>商品名称</span>
                <select class="form-control name">
                ${allWares(res[i].waresId)}
                </select>
                <span style="margin-left: 10px;"><i class="required">*</i>商品数量</span>
                <input type="text" placeholder="商品数量" class="form-control number" value="${
                  res[i].waresCount
                  }">
                <button style=" margin-left: 10px;" onclick="deleteCommodity(this)">删除商品</button>
                </div></div>
                        `;
              }
            }
            $(".storeNotGift").after(str);
            $(".storeIsGift").after(str1);
          }
          // 支付方式列表
          if(row.paywayList.length > 0){
            let str="";
            for(let k=0; k < row.paywayList.length; k++){
              str+= `
                    <div class="actual_payment">
                    <span> <i class="required">*</i>选择支付方式：</span>
                    <select name="" id="" class="form-control" style="margin-right: 5px;">
                      ${all_pay_type(row.paywayList[k].paymentway)}
                    </select>
                    <span><i class="required">*</i>支付金额：</span>
                    <input type="text" name="" id="" class="form-control" style="width: 150px;" value="${row.paywayList[k].amount}">
                    ${
                      k == 0 ? '<button style="margin-left: 5px;" onclick="add_pay(this)">添加</button>':'<button style="margin-left: 5px;" onclick="del_pay(this)">删除</button>'
                    }
                </div>
                    `
            }

            $("#editData .actual_payment_content").html(str);

          }
          storeEditOption = {
            stockId: row.stockId,
            startTime: row.operationDate, //录入时间
            sellers: row.sellers, //销售员
            storeId: row.storeId, //店铺id
            totalAmount: row.totalAmount, //本次应付金额
            payedAmount: row.payedAmount, //本次实付金额
            custType: row.custType, //客户类型
            remark: row.remark,
            waresList: res,
            entryType: 1,
            paywayList:row.paywayList
          };
          $("#editData .stockId").val(row.stockId);
          $("#editData .operationDate").val(row.operationDate);
          $("#editData .sellers").val(row.sellers);
          $("#editData .totalAmount").val(row.totalAmount);
          $("#editData .payedAmount").val(row.payedAmount);
          $("#editData .remark").val(row.remark);
          $("#editData .custType").val(row.custType);
          $("#editData .storeId").val(row.storeId);
          $("#editData .storeId").trigger("chosen:updated");
          open_html(
            "修改信息",
            "#editData",
            function () {
              $("#editData input").val("");
              $("#editData select").val("");
              $("#editData .storeId").trigger("chosen:updated");
            },
            function () {
              confirmFn();
            },
            function () {
              closeFn();
            }
          );
          $("#editData .storeId").chosen({});
        });
    },
    "click #detail": function (e, v, row) {
      ajax_data(
        "/inventory/querySaleDetail",
        {
          params: {
            //jsonStr: JSON.stringify({
            stockId: row.stockId,
            startTime: $(".searchList .query_startTime")
              .val()
              .trim()
              ? $(".searchList .query_startTime")
                .val()
                .trim()
              : undefined,
            endTime: $(".searchList .query_stopTime")
              .val()
              .trim()
              ? $(".searchList .query_stopTime")
                .val()
                .trim()
              : undefined
            //})
          },
          contentType: "application/x-www-form-urlencoded;charset=utf-8"
        },
        function (res) {
          $("#detailTable").bootstrapTable("destroy");
          $("#detailTable").bootstrapTable({
            striped: true, //是否显示行间隔色
            pagination: false, //是否分页,
            data: res,
            height: $("body").height() < 500 ? $("body").height() - 120 : 330,
            columns: [
              {
                title: "商品编号",
                field: "waresId"
              },
              {
                title: "商品名称",
                field: "waresName"
              },
              {
                title: "商品数量",
                field: "waresCount"
              },
              {
                title: "是否赠品",
                field: "isGift"
              }
            ]
          });
          open_html("详情信息", "#storeDetail", function () {
            $("input[type='text']").val("");
          });
        }
      );
    }
  };

  var userOperateEvents = {
    "click #editUserDataBtn": function (e, v, row) {
      ajax_data(
        "/inventory/querySaleDetail",
        {
          params: {
            stockId: row.stockId,
            startTime: $(".searchList .query_startTime")
              .val()
              .trim()
              ? $(".searchList .query_startTime")
                .val()
                .trim()
              : undefined,
            endTime: $(".searchList .query_stopTime")
              .val()
              .trim()
              ? $(".searchList .query_stopTime")
                .val()
                .trim()
              : undefined
          },
          contentType: "application/x-www-form-urlencoded;charset=utf-8"
        },
        function (res) {
          $("#editUserData .commodity").remove();
          function allWares(selectId) {
            let option = "<option value='' data-id=''>选择商品名称</option>";
            if (allwares.length) {
              allwares.forEach(function (item, index) {
                option += `<option value="${item.waresName}" data-id="${
                  item.waresId
                  }" ${item.waresId == selectId ? "selected" : ""} >${
                  item.waresName
                  }</option>`;
              });
            }
            return option;
          }
          if (res.length > 0) {
            let str = "", str1 = "";
            for (let i = 0; i < res.length; i++) {
              if (res[i].isGift == "0") {
                str += `<div class="list_row commodity newShop">
                <div style="width: 100%;">
                <span><i class="required">*</i>商品名称</span>
                <select class="form-control name" isGift='${res[i].isGift}'>
                ${allWares(res[i].waresId)}
                </select>
                <span style="margin-left: 10px;"><i class="required">*</i>商品数量</span>
                <input type="text" placeholder="商品数量" class="form-control number" value="${
                  res[i].waresCount
                  }">
                <button style=" margin-left: 10px;" onclick="deleteCommodity(this)">删除商品</button>
                </div></div>
                        `;
              } else {
                str1 += `<div class="list_row commodity newShop">
                <div style="width: 100%;">
                <span><i class="required">*</i>商品名称</span>
                <select class="form-control name">
                ${allWares(res[i].waresId)}
                </select>
                <span style="margin-left: 10px;"><i class="required">*</i>商品数量</span>
                <input type="text" placeholder="商品数量" class="form-control number" value="${
                  res[i].waresCount
                  }">
                <button style=" margin-left: 10px;" onclick="deleteCommodity(this)">删除商品</button>
                </div></div>
                        `;
              }
            }
            $(".userNotGift").after(str);
            $(".userIsGift").after(str1);
          }

           // 支付方式列表
           if(row.paywayList.length > 0){
            let str="";
            for(let k=0; k < row.paywayList.length; k++){
              str+= `
                    <div class="actual_payment">
                    <span> <i class="required">*</i>选择支付方式：</span>
                    <select name="" id="" class="form-control" style="margin-right: 5px;">
                      ${all_pay_type(row.paywayList[k].paymentway)}
                    </select>
                    <span><i class="required">*</i>支付金额：</span>
                    <input type="text" name="" id="" class="form-control" style="width: 150px;" value="${row.paywayList[k].amount}">
                    ${
                      k == 0 ? '<button style="margin-left: 5px;" onclick="add_pay(this)">添加</button>':'<button style="margin-left: 5px;" onclick="del_pay(this)">删除</button>'
                    }
                </div>
                    `
            }
            $("#editUserData .actual_payment_content").html(str);

          }

          userEditOption = {
            stockId: row.stockId,
            startTime: row.operationDate, //录入时间
            sellers: row.sellers, //销售员
            storeId: row.storeId, //店铺id
            totalAmount: row.totalAmount, //本次应付金额
            payedAmount: row.payedAmount, //本次实付金额
            custType: row.custType, //客户类型
            remark: row.remark,
            waresList: res,
            entryType: 1,
            paywayList:row.paywayList
          };
          $("#editUserData .stockId").val(row.stockId);
          $("#editUserData .operationDate").val(row.operationDate);
          $("#editUserData .sellers").val(row.sellers);
          $("#editUserData .totalAmount").val(row.totalAmount);
          $("#editUserData .payedAmount").val(row.payedAmount);
          $("#editUserData .remark").val(row.remark);
          $("#editUserData .custType").val(row.custType);
          $("#editUserData .storeId").val(row.storeId);
          $("#editUserData .storeId").trigger("chosen:updated");
          open_html(
            "修改信息",
            "#editUserData",
            function () {
              $("#editUserData input").val("");
              $("#editUserData select").val("");
              $("#editUserData .storeId").trigger("chosen:updated");
            },
            function () {
              userConfirmFn();
            },
            function () {
              closeFn();
            }
          );
          $("#editUserData .storeId").chosen({});

        });
    },
    "click #userDetailBtn": function (e, v, row) {
      ajax_data(
        "/inventory/querySaleDetail",
        {
          params: {
            stockId: row.stockId,
            startTime: $(".searchList .query_startTime")
              .val()
              .trim()
              ? $(".searchList .query_startTime")
                .val()
                .trim()
              : undefined,
            endTime: $(".searchList .query_stopTime")
              .val()
              .trim()
              ? $(".searchList .query_stopTime")
                .val()
                .trim()
              : undefined
          },
          contentType: "application/x-www-form-urlencoded;charset=utf-8"
        },
        function (res) {
          $("#userDetailTable").bootstrapTable("destroy");
          $("#userDetailTable").bootstrapTable({
            striped: true, //是否显示行间隔色
            pagination: false, //是否分页,
            data: res,
            height: $("body").height() < 500 ? $("body").height() - 120 : 330,
            columns: [
              {
                title: "商品编号",
                field: "waresId"
              },
              {
                title: "商品名称",
                field: "waresName"
              },
              {
                title: "商品数量",
                field: "waresCount"
              },
              {
                title: "是否赠品",
                field: "isGift"
              }
            ]
          });
          open_html("详情信息", "#userDetail_content", function () { });
        }
      );
    }
  };

  function queryParams() {
    return {
      jsonStr: JSON.stringify({
        entryType: 1,
        startTime: $(".query_startTime")
          .val()
          .trim()
          ? $(".query_startTime")
            .val()
            .trim()
          : undefined,
        endTime: $(".query_stopTime")
          .val()
          .trim()
          ? $(".query_stopTime")
            .val()
            .trim()
          : undefined,
        storeName: $(".query_storeName")
          .val()
          .trim()
          ? $(".query_storeName")
            .val()
            .trim()
          : undefined
      })
    };
  }
  function queryParams1() {
    return {
      jsonStr: JSON.stringify({
        ...userInformation(),
        entryType: 1,
        startTime: $(".query_startTime")
          .val()
          .trim()
          ? $(".query_startTime")
            .val()
            .trim()
          : undefined,
        endTime: $(".query_stopTime")
          .val()
          .trim()
          ? $(".query_stopTime")
            .val()
            .trim()
          : undefined,
        storeName: $(".query_storeName")
          .val()
          .trim()
          ? $(".query_storeName")
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
        type = "name"
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
  function queryUserRecord() {
    $("#userSalesRecord").bootstrapTable({
      method: "post",
      url: base + "/inventory/queryPersonalSaleRecord", //请求路径
      striped: true, //是否显示行间隔色
      pageNumber: 1, //初始化加载第一页
      pagination: true, //是否分页
      sidePagination: "client", //server:服务器端分页|client：前端分页
      pageSize: 20, //单页记录数
      pageList: [10, 20, 30], //可选择单页记录数
      showRefresh: false, //刷新按钮
      cache: true, // 禁止数据缓存
      search: false, // 是否展示搜索
      sortable: true,
      sortOrder: "asc", //排序方式
      showLoading: true,
      height: $(window).height() - 190,
      contentType: "application/x-www-form-urlencoded",
      queryParams: queryParams1,
      columns: [
        {
          title: "录入时间",
          field: "operationDate",
          sortable: true
        },
        {
          title: "销售员",
          field: "sellers",
          sortable: true
        },
        {
          title: "店铺名称",
          field: "storeName",
          sortable: true
        },
        {
          title: "本次应付金额",
          field: "totalAmount",
          sortable: true
        },
        {
          title: "本次实付金额",
          field: "payedAmount",
          sortable: true
        },
        {
          title: "客户类型",
          field: "custType"
        },
        {
          title: "支付方式",
          field: "payType"
        },
        {
          title: "备注",
          field: "remark",
          sortable: true
        },
        {
          title: "操作",
          field: "publicationTime",
          events: userOperateEvents,
          formatter: userOperation //对资源进行操作,
        }
      ]
    });
  }

  initFn();
  // 点击查询按钮
  $("#eventqueryBtn").click(function () {
    // recordType 0 店铺 1 个人
    if (
      $(".recordType input:checked")
        .val()
        .trim() == "0"
    ) {
      $("#storeSalesRecord").bootstrapTable("selectPage", 1);
      $("#storeSalesRecord").bootstrapTable("refresh");
    } else {
      $("#userSalesRecord").bootstrapTable("selectPage", 1);
      $("#userSalesRecord").bootstrapTable("refresh");
    }
  });

  function closeFn() {
    layer.closeAll("page");
  }
  function confirmFn() {
    let required = true;
    $("#editData .required")
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

    let waresList = [];
    $("#editData .commodity").each(function() {
      let wares = {};
      wares["waresName"] = $(this)
        .find(".name")
        .val()
        .trim();
      wares["waresCount"] = $(this)
        .find(".number")
        .val()
        .trim();
      wares["waresId"] = $(this)
        .find(".name option:selected")
        .attr("data-id");
      wares["isGift"] = $(this).find(".name").attr("isGift");
      waresList.push(wares);
    });
    // 获取表单中 支付方式和支付金额
    let  paywayList =[];
    $("#editData .actual_payment").each(function() {
      let payway={};
      payway['paymentway']=$(this).find("option:selected").attr("value");
      payway['amount']=$(this).find('input').val();
      paywayList.push(payway)
    })
    let params = {
      stockId: $("#editData .stockId")
        .val()
        .trim(),
      startTime: $("#editData .operationDate")
        .val()
        .trim(), //录入时间
      sellers: $("#editData .sellers")
        .val()
        .trim(), //销售员
      storeId: $("#editData .storeId")
        .val()
        .trim(), //店铺id
      totalAmount: $("#editData .totalAmount")
        .val()
        .trim(), //本次应付金额
      payedAmount: $("#editData .payedAmount")
        .val()
        .trim(), //本次实付金额
      custType: $("#editData .custType")
        .val()
        .trim(), //客户类型
      remark: $("#editData .remark")
        .val()
        .trim(),
      entryType: 1,
      waresList: waresList,
      paywayList:paywayList
    };

    ajax_data("/inventory/modifyEntryStock", {
      params: {
        oldJsonStr: JSON.stringify(storeEditOption),
        newJsonStr: JSON.stringify(params)
      },
      contentType: "application/x-www-form-urlencoded;charset=utf-8"
    }, function (res) {
      if (res.resultCode > -1) {
        layer.closeAll("page");
        tips("修改信息成功", 6);
        $("#storeSalesRecord").bootstrapTable("selectPage", 1);
        $("#storeSalesRecord").bootstrapTable("refresh");
      } else {
        tips("修改信息失败", 5);
      }
    });

  }

  function userConfirmFn() {
    let required = true;
    $("#editUserData .required")
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
    let waresList = [];
    $("#editUserData .commodity").each(function() {
      let wares = {};
      wares["waresName"] = $(this)
        .find(".name")
        .val()
        .trim();
      wares["waresCount"] = $(this)
        .find(".number")
        .val()
        .trim();
      wares["waresId"] = $(this)
        .find(".name option:selected")
        .attr("data-id");
      wares["isGift"] =  $(this).find(".name").attr("isGift");
      waresList.push(wares);
    });

    // 获取表单中 支付方式和支付金额
    let  paywayList =[];
    $("#editUserData .actual_payment").each(function() {
      let payway={};
      payway['paymentway']=$(this).find('select').val();
      payway['amount']=$(this).find('input').val();
      paywayList.push(payway)
    })
    let params = {
      stockId: $("#editUserData .stockId")
        .val()
        .trim(),
      startTime: $("#editUserData .operationDate")
        .val()
        .trim(), //录入时间
      sellers: $("#editUserData .sellers")
        .val()
        .trim(), //销售员
      storeId: $("#editUserData .storeId")
        .val()
        .trim(), //店铺id
      totalAmount: $("#editUserData .totalAmount")
        .val()
        .trim(), //本次应付金额
      payedAmount: $("#editUserData .payedAmount")
        .val()
        .trim(), //本次实付金额
      custType: $("#editUserData .custType")
        .val()
        .trim(), //客户类型
      remark: $("#editUserData .remark")
        .val()
        .trim(),
      entryType: 1,
      waresList: waresList,
      paywayList:paywayList
    };

    ajax_data("/inventory/modifyEntryStock", {
      params: {
        oldJsonStr: JSON.stringify(userEditOption),
        newJsonStr: JSON.stringify(params)
      },
      contentType: "application/x-www-form-urlencoded;charset=utf-8"
    }, function (res) {
      if (res.resultCode > -1) {
        layer.closeAll("page");
        tips("修改信息成功", 6);
        $("#storeSalesRecord").bootstrapTable("selectPage", 1);
        $("#storeSalesRecord").bootstrapTable("refresh");
      } else {
        tips("修改信息失败", 5);
      }
    });
  }
  $(".recordType input[type='radio']").change(function () {
    $(".query_storeName").val("");
    $(".query_userinformation").val("");
    if (
      $(this)
        .val()
        .trim() == "0"
    ) {
      $(".storeSalesRecord").show();
      $(".userSalesRecord").hide();
      $(".query_storeName").show();
      $(".query_userinformation").hide();
    } else {
      $(".storeSalesRecord").hide();
      $(".userSalesRecord").show();
      $(".query_storeName").hide();
      $(".query_userinformation").show();
    }
  });

  // 导出
  $(".exportBtn").click(function () {
    let menuName = $('.J_menuTab.active', parent.document).text().trim();
    let titleName = $(this).parents(".ibox").find(".ibox-title h5 ").text().trim();
    let typeVal = "";
    if (
      $(".recordType input[type='radio']:checked")
        .val()
        .trim() == "0"
    ) {
      typeVal = 0;
    } else {
      typeVal = 1;
    }
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportSaleData",
      method: "post"
    });
    $("<input>")
      .attr("name", "jsonStr")
      .val(
        JSON.stringify({
          startTime: $(".query_startTime").val(),
          endTime: $(".query_stopTime").val(),
          type: typeVal,
          storeName: $(".query_storeName").val(),
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

// 查找门店
function queryStore() {
  ajax_data(
    "/competence/queryStoreInfo",
    { params: JSON.stringify({}) },
    function (res) {
      console.log(res);
      let option = "<option value=''>选择店铺</option>";
      res.forEach(function (element) {
        option += `<option value="${element.storeId}">${element.storeName}</option>`;
      });
      // allStroe = res;
      $("#editData .storeId").html(option);
      $("#editUserData .storeId").html(option);
      $("#editData .storeId").chosen();
      $("#editUserData .storeId").chosen();
    }
  );
}

function queryWaresInfo() {
  let url = "/configuration/queryWaresInfo";
  ajax_data(url, { params: JSON.stringify({}) }, function (res) {
    allwares = res;
  });
}

function addCommodity(that, param,isGift) {
  let option = "<option value=''>选择商品名称</option>";
  if (allwares.length) {
    allwares.forEach(function (item, index) {
      option += `<option value="${item.waresName}" data-id="${item.waresId}">${item.waresName}</option>`;
    });
  }
  let strHtml = `<div class="list_row commodity newShop">
            <div style="width: 100%;">
            <span><i class="required">*</i>商品名称</span>
            <select class="form-control name" isGift='${isGift}'>
            ${option}
            </select>
            <span style="margin-left: 10px;"><i class="required">*</i>商品数量</span>
            <input type="text" placeholder="商品数量" class="form-control number">
            <button style=" margin-left: 10px;" onclick="deleteCommodity(this)">删除商品</button>
            </div></div>
              `;
  if (param == "storeNotGift") {
    $(".storeIsGift").before(strHtml);
  } else if (param == "storeIsGift") {
    $(".storeIsGift").parent().append(strHtml);
  } else if (param == "userNotGift") {
    $(".userIsGift").before(strHtml);
  } else if (param == "userIsGift") {
    $(".userIsGift").parent().append(strHtml);
  }

}

function deleteCommodity(that) {
  $(that)
    .parent()
    .parent()
    .remove();
}

 // 添加支付方式
 function add_pay(that){
  let str=`
        <div class="actual_payment">
        <span> <i class="required">*</i>选择支付方式：</span>
        <select name="" id="" class="form-control" style="margin-right: 5px;">
            <option value="0">现金</option>
            <option value="1">微信</option>
            <option value="2">支付宝</option>
            <option value="3">刷卡</option>
            <option value="4">购物卡</option>
            <option value="5">其他</option>
        </select>
        <span><i class="required">*</i>
        支付金额：</span>
        <input type="text" name="" id="" class="form-control" style="width: 150px;">
        <button style="margin-left: 5px;" onclick="del_pay(this)">删除</button>
    </div>
  `
  $(that).parent().parent().append(str)

}

function all_pay_type(checkType) {
  let str="";
  for(let s in pay_type){
    str+=`<option value="${s}" ${ checkType == s ? "selected" : "" } >${pay_type[s]}</option> `
  }
  return str
}

// 删除支付方式
function del_pay(that) {
  $(that).parent().remove()
}
