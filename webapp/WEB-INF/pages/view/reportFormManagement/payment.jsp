<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "
http://www.w3.org/TR/html4/loo">
<html>

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>支付记录</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
  <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
    rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/datapicker/datepicker3.css">
  <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/reportFormManagement/payment.css" />
  <script>
    var base = "${pageContext.request.contextPath}";
  </script>
</head>

<body class="gray-bg">
  <div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5>应收账款</h5>
        <div class="ibox-tools"></div>
      </div>
      <div class="ibox-content">
        <div class="row row-lg">
          <div class="col-sm-12">
            <div class="example">
              <div class="searchList">
                <div class="left"></div>
                <div class="right">
                  <input id="" class="laydate-icon form-control layer-date query_startTime" placeholder="开始时间">
                  <input id="" class="laydate-icon form-control layer-date query_endTime" placeholder="结束时间"> 
                  <input type="text" class="form-control query_toStoreName" placeholder="付款方名称" />
                  <span>
                    <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn" style="width:80px;">
                      查询
                    </button>
                    <button type="button" id="" class="btn btn-success exportBtn" style="width:80px;">
                      导出
                    </button>
                  </span>
                </div>

              </div>
              <table id="payment" data-mobile-responsive="true"></table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- 修改/添加模板 -->
  <div class="return_borrowed" id="payDetail" style="display: none; margin-bottom: 15px;">
    <div class="return_top">
      <table id="paymentDetailTable" data-mobile-responsive="true"></table>

    </div>
  </div>

  <div id="keepPaying" style="display: none; margin-bottom: 15px;">
    <div class="return_top">
      <div class="textContent">
        <div class="list_row">
          <div>
            <span>店铺Id</span>
            <input class="form-control storeId" type="text" placeholder="" readonly />
          </div>
          <div>
            <span>店铺名称</span>
            <input class="form-control storeName" type="text" placeholder="" readonly />
          </div>
        </div>
        <div class="list_row">
          <div>
            <span><i class="required">*</i>支付时间</span>
            <input id="" class="laydate-icon form-control layer-date payTime" type="text"
              onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss',start:new Date().toLocaleString('chinese',{hour12:false})})"
              placeholder="支付时间" />
          </div>
          <div>
            <span><i class="required">*</i>支付金额</span>
            <input type="text" class="form-control amount" placeholder="支付金额">
          </div>
        </div>
        <div class="list_row">
          <div style="width:100%">
            <span>手机号</span>
            <input type="text" class="form-control custPhone" placeholder="手机号">
          </div>
        </div>
        <div class="list_row" style="display: none;">
          <div>
            <span>storckId</span>
            <input class="form-control storckId" type="text" placeholder="" readonly />
          </div>
          <div>
            <span>总金额</span>
            <input class="form-control totalAmount" type="text" placeholder="" readonly />
          </div>
        </div>
        <div class="list_row">
          <div style="width: 100%;" class="payType">
            <span>支付类型</span>
            <div><input type="radio" name="payType" value="0" checked id="" style="width: 20px;">现金</div>
            <div> <input type="radio" name="payType" value="1" id="" style="width: 20px;">微信</div>
            <div><input type="radio" name="payType" value="2" id="" style="width: 20px;">支付宝</div>
            <div><input type="radio" name="payType" value="3" id="" style="width: 20px;">刷卡</div>
            <div><input type="radio" name="payType" value="4" id="" style="width: 20px;">购物卡</div>
            <div><input type="radio" name="payType" value="5" id="" style="width: 20px;">其他</div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- 全局js -->
  <script src="${pageContext.request.contextPath}/pages/js/jquery.min.js?v=2.1.4"></script>
  <script src="${pageContext.request.contextPath}/pages/js/bootstrap.min.js?v=3.3.6"></script>
  <script src="${pageContext.request.contextPath}/pages/js/common.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/layer.min.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/loading.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
  <script
    src="${pageContext.request.contextPath}/pages/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/laydate/laydate.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/datapicker/bootstrap-datepicker.js"></script>
  <!-- 自定义js -->
  <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
  <script src="${pageContext.request.contextPath}/pages/js/reportFormManagement/payment.js"></script>
</body>

</html>