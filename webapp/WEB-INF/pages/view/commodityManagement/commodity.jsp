<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "
http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <meta name="renderer" content="webkit"/>
    <meta name="force-rendering" content="webkit"/>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico">
    <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
        rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/commodityManagement/commodity.css">
</head>
<script>
    var base = "${pageContext.request.contextPath}"
</script>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>商品管理</h5>
                <div class="ibox-tools">
                </div>
            </div>
            <div class="ibox-content">
                <div class="row row-lg">
                    <div class="col-sm-12">
                        <div class="example">
                            <div class="searchList">
                                <div class="left">
                                    <button type="button" id="" class="btn btn-success addBtn"
                                        style="width:80px;">添加</button>
                                </div>
                                <div class="right">
                                    <input type="text" class="form-control query_wares_name" placeholder="商品名称">
                                    <select class="form-control m-b query_category_name" name="account">
                                        <option value="">选择商品分类</option>
                                    </select>
                                    <span>
                                        <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn"
                                            style="width:80px;">查询</button>
                                        <button type="button" id="" class="btn btn-success exportBtn"
                                            style="width:80px;">导出</button>
                                    </span>
                                </div>
                            </div>
                            <table id="waresManagement" data-mobile-responsive="true">
                            </table>
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
                        <span><i class="required">*</i>商品名称</span>
                        <input class="form-control wares_name" type="text" placeholder="商品名称" />
                    </div>
                    <div>
                        <span><i class="required">*</i>商品分类</span>
                        <select class="form-control m-b category_name">
                            <option value="">请选择商品</option>
                            <option value="1">dianzh</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>商品价格</span>
                        <input class="form-control wares_price" type="text" placeholder="商品价格" />
                    </div>
                    <div>
                        <span>商品描述</span>
                        <input class="form-control wares_desc" type="text" placeholder="商品描述" />
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
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/pages/js/commodityManagement/commodity.js"></script>
</body>

</html>