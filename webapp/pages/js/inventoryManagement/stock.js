
(function(document, window, $) {
  "use strict";

  $(".right input[type='radio']").on("change",function () {
    if($(this).val() == "1"){
      $(".query_storeName").show()
    }else{
      $(".query_storeName").hide()
    }
  })

  function initFn() {
    $("#stockInformation").bootstrapTable({
      method: "post",
      url: base + "/inventory/queryStoreStockValue", //请求路径query
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
      sortOrder: "asc",//排序方式
      showLoading: true,
      height: $(window).height() - 150,
      contentType: "application/x-www-form-urlencoded",
      queryParams: queryParams,
      columns: [
        {
          title: "店铺名称",
          field: "ownerName",
          sortable: true,
        },
        {
          title: "商品编号",
          field: "waresId",
          sortable: true,
        },
        {
          title: "商品名称",
          field: "waresName",
          sortable: true,
        },
        {
          title: "商品数量",
          field: "waresCount",
          sortable: true,
        }
      ]
    });
  }
  initFn();
  function queryParams() {
      // 0 公司 1 店铺
   if($("input[name='store']:checked").val() == "0"){
        return {
            storeType:"0",
            storeName:"0"
        };
   }else{
        return {
            storeType:"1",
            storeName:$(".query_storeName").val().trim()
        };
   }
  }
  // 点击查询按钮
  $("#eventqueryBtn").click(function() {
    if($("input[name='store']:checked").val() == "1"){
        if(!!!$(".query_storeName").val().trim()){
            tips("请输入店铺名称", 5);
           return;
        }
    }
    $("#stockInformation").bootstrapTable("destroy");
    initFn();
  });



  // 导出
  $(".exportBtn").click(function() {
    let menuName= $('.J_menuTab.active', parent.document).text().trim();
    let titleName=$(this).parents(".ibox").find(".ibox-title h5 ").text().trim();
    let exportType = "";
    let form = $('<form id="to_export" style="display:none"></form>').attr({
      action: base + "/common/exportEntryStockData",
      method: "post"
    });
    $("<input>")
      .attr("name", "jsonStr")
      .val(
        JSON.stringify({
          fileName:menuName+"-"+titleName+".csv",
          entryType:2,
          startTime: $(".query_startTime")
            .val()
            .trim()
        })
      )
      .appendTo(form);
    $("body").append(form);
    $("#to_export")
      .submit()
      .remove();
  });
})(document, window, jQuery);


