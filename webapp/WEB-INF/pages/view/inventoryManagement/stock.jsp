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
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
    <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
        rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/datapicker/datepicker3.css">
    <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/zoom/zoom.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/inventoryManagement/stock.css" />
    <style>
        .fixed-table-border {
            height: 0 !important;
        }

        .fixed-table-container {
            border-bottom: 0px !important;
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
                <h5>库存管理</h5>
                <div class="ibox-tools"></div>
            </div>
            <div class="ibox-content">
                <div class="row row-lg">
                    <div class="col-sm-12">
                        <div class="example">
                            <div class="searchList">
                                <div class="left">
                                </div>
                                <div class="right">
                                    <input type="radio" name="store" id="" checked value="0" style="width: 20px;" />
                                    公司
                                    <input type="radio" name="store" id="" value="1" style="width: 20px;" />店铺
                                    <input type="text" class="query_storeName form-control" placeholder="店铺名称" style="display: none;" />
                                    <span style="margin-left: 10px;"> 
                                        <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn"
                                            style="width:80px;">
                                            查询
                                        </button>
                                        <!-- <button type="button" id="eventAddBtn" class="btn btn-info exportBtn"
                                            style="width:80px;" aria-label="Export">
                                            导出
                                        </button> -->
                                    </span>
                                </div>
                            </div>
                            <table id="stockInformation" data-mobile-responsive="true"></table>
                        </div>
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
    <script src="${pageContext.request.contextPath}/pages/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/laydate/laydate.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/zoom/zoom.js"></script>
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/pages/js/inventoryManagement/stock.js"></script>
</body>

</html>