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
  <title></title>
  <meta name="renderer" content="webkit"/>
  <meta name="force-rendering" content="webkit"/>
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
  <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
    rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/plugins/chosen/chosen.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/pages/css/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/storeManagement/storeManagement.css" />
  <style>
    .chosen-container {
      width: 152px !important;
    }
  </style>
  <script>
    var base = "${pageContext.request.contextPath}";
  </script>
</head>

<body class="gray-bg">
  <div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5>店铺管理</h5>
        <div class="ibox-tools"></div>
      </div>
      <div class="ibox-content">
        <div class="row row-lg">
          <div class="col-sm-12">
            <div class="example">
              <div class="searchList">
                <div class="left">
                  <button type="button" id="addBtn" class="btn btn-success addBtn" style="width:80px;">
                    添加
                  </button>
                </div>
                <div class="right">
                  <div class="areaSearch">
                    <select class="form-control m-b query_province">
                      <option value="">选择省份</option>

                    </select>
                    <select class="form-control m-b query_city">
                      <option value="">选择城市</option>

                    </select>
                    <select class="form-control m-b query_county">
                      <option value="">选择区县</option>
                    </select>
                    <div>
                      <input type="text" class="form-control query_StoreName" placeholder="输入店铺名称">
                    </div>
                  </div>
                  <span>
                    <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn" style="width:80px;">
                      查询
                    </button>
                  </span>
                </div>
              </div>
              <table id="exampleTableFromData" data-mobile-responsive="true"></table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- 修改/添加模板 -->
  <div class="return_borrowed" id="editData" style="display: none; margin-bottom: 15px;">
    <div class="return_top">
      <div class="textContent">
        <div class="list_row">
          <div>
            <span><i class="required">*</i>店铺名称</span>
            <input class="form-control store_name" type="text" placeholder="店铺名称" />
          </div>
          <div>
            <span>店长名称</span>
            <div class="queryStoreManager manager">
            </div>
          </div>
        </div>
        <div class="list_row">
          <div>
            <span>开店时间</span>
            <input id="" class="laydate-icon form-control layer-date open_time" placeholder="开店时间"
              onclick="laydate({istime: false, format: 'YYYY-MM-DD'})" />
          </div>
          <div>
            <span><i class="required">*</i>店铺状态</span>
            <select class="form-control m-b open_status">
              <option value="">选择店铺状态</option>
              <option value="0">待定</option>
              <option value="1">营业</option>
              <option value="-1">停业</option>
            </select>
          </div>
        </div>
        <div class="list_row">
          <div style="width: 100%;">
            <span><i class="arae_list" style="color: red;">*</i>区域选择</span>
            <select class="form-control m-b params_province">
              <option value="">请选择省份</option>
            </select>
            <select class="form-control m-b params_city">
              <option value="">请选择城市</option>
            </select>
            <select class="form-control m-b params_area">
              <option value="">请选择区县</option>
            </select>
          </div>
        </div>
        <div class="list_row">
          <div>
            <span>
              <i class="required">*</i>详细地信息
            </span>
            <input type="text" class="form-control detailAddress" placeholder="详细地信息">
          </div>
          <div>
            <span><i class="required">*</i>店铺类型</span>
            <select class="form-control m-b store_type" name="account">
              <option value="">选择店铺类型</option>
              <option value="1">直营店</option>
              <option value="2">加盟店</option>
            </select>
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
  <script src="${pageContext.request.contextPath}/pages/js/plugins/chosen/chosen.jquery.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/loading.js"></script>
  <!-- 自定义js -->
  <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
  <script
    src="${pageContext.request.contextPath}/pages/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

  <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/laydate/laydate.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/storeManagement/storeManagement.js"></script>
  <script>

  </script>
</body>

</html>