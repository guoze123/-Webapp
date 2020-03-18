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
    <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/chosen/chosen.css" />
    <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
        rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/datapicker/datepicker3.css">
    <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/inventoryManagement/salesRecord.css" />
    <style>
        .chosen-container {
            width: 240px !important;
        }

        .fixed-table-border {
            height: 0px !important;
        }

        .fixed-table-container {
            padding-bottom: 37px !important;
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
                <h5>销售记录</h5>
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
                                    <div style="margin-right: 15px;" class="recordType">
                                        <input type="radio" name="record" id="" checked value="0"
                                            style="width: 20px; vertical-align: middle;" />
                                        店铺
                                        <input type="radio" name="record" id="" value="1" style="width: 20px; vertical-align: middle;" /> 个人
                                    </div>
                                    <div>
                                        <input id="" class="laydate-icon form-control layer-date query_startTime"
                                            placeholder="开始时间" />
                                    </div>
                                    <div>
                                        <input id="" class="laydate-icon form-control layer-date query_stopTime"
                                            placeholder="结束时间" />
                                    </div>
                                    <div>
                                        <input class="query_storeName form-control" placeholder="店铺名称" />
                                    </div>
                                    <div>
                                        <input class="query_userinformation form-control" style="display: none;" placeholder="个人信息" />
                                    </div>
                                    
                                    <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn"
                                        style="width:80px;">
                                        查询
                                    </button>
                                    <button type="button" id="eventAddBtn" class="btn btn-success exportBtn"
                                        style="width:80px; margin-left: 5px;" aria-label="Export">
                                        导出
                                    </button>
                                </div>
                            </div>
                            <div class="storeSalesRecord">
                                <table id="storeSalesRecord" data-mobile-responsive="true"></table>
                            </div>
                            <div class="userSalesRecord" style="display: none;">
                                <table id="userSalesRecord" data-mobile-responsive="true"></table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 修改/添加模板 店铺的添加修改 -->
    <div class="return_borrowed" id="editData" style="display: none; margin-bottom: 15px;">
        <div class="return_top">
            <div class="textContent">
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>录入ID</span>
                        <input class="form-control stockId " type="text" placeholder="" readonly />
                    </div>
                    <div>
                        <span><i class="required">*</i>录入时间</span>
                        <input class="form-control operationDate laydate-icon layer-date"
                            onclick="laydate({istime: true, format: 'YYYY-MM-DD HH:MM:SS'})" type="text"
                            placeholder="录入时间" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>
                            <i class="required">*</i> 销售员
                        </span>
                        <input type="text" class="form-control sellers" placeholder="销售员" />
                    </div>
                    <div>
                        <span><i class="required">*</i>店铺</span>
                        <select class="form-control m-b storeId">
                            <option value="">请选择店铺</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>本次应付金额</span>
                        <input type="text" class="form-control totalAmount" placeholder="本次应付金额" />
                    </div>
                    <div>
                        <span><i class="required">*</i>本次实付金额</span>
                        <input type="text" class="form-control payedAmount" placeholder="本次应付金额" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>备注</span>
                        <input type="text" class="form-control remark" placeholder="备注" />
                    </div>
                    <div>
                        <span>客户类型</span>
                        <select name="" id="" class="form-control custType">
                            <option value="">选择客户类型</option>
                            <option value="0">老客户</option>
                            <option value="1">新客户</option>
                        </select>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="return_borrowed" id="storeDetail" style="display: none; margin-bottom: 15px;">
        <div class="return_top">
            <table id="detailTable" data-mobile-responsive="true"></table>
        </div>
    </div>
    <!-- 修改/添加模板 个人的添加修改 -->
    <div class="return_borrowed" id="editUserData" style="display: none; margin-bottom: 15px;">
        <div class="return_top">
            <div class="textContent">
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>录入ID</span>
                        <input class="form-control stockId " type="text" placeholder="" readonly />
                    </div>
                    <div>
                        <span><i class="required">*</i>录入时间</span>
                        <input class="form-control operationDate laydate-icon layer-date"
                            onclick="laydate({istime: true, format: 'YYYY-MM-DD HH:MM:SS',start:new Date().toLocaleString()})"
                            type="text" placeholder="录入时间" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>
                            <i class="required">*</i> 销售员
                        </span>
                        <input type="text" class="form-control sellers" placeholder="销售员" />
                    </div>
                    <div>
                        <span><i class="required">*</i>店铺</span>
                        <select class="form-control m-b storeId">
                            <option value="">请选择店铺</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>本次应付金额</span>
                        <input type="text" class="form-control totalAmount" placeholder="本次应付金额" />
                    </div>
                    <div>
                        <span><i class="required">*</i>本次实付金额</span>
                        <input type="text" class="form-control payedAmount" placeholder="本次应付金额" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>备注</span>
                        <input type="text" class="form-control remark" placeholder="备注" />
                    </div>
                    <div>
                        <span>客户类型</span>
                        <select name="" id="" class="form-control custType">
                            <option value="0">老客户</option>
                            <option value="1">新客户</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="return_borrowed" id="userDetail_content" style="display: none; margin-bottom: 15px;">
        <div class="return_top">
            <table id="userDetailTable" data-mobile-responsive="true"></table>

        </div>
    </div>
    <!-- 全局js -->
    <script src="${pageContext.request.contextPath}/pages/js/jquery.min.js?v=2.1.4"></script>
    <script src="${pageContext.request.contextPath}/pages/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="${pageContext.request.contextPath}/pages/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/layer.min.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/loading.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <script
        src="${pageContext.request.contextPath}/pages/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/laydate/laydate.js"></script>
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/pages/js/inventoryManagement/salesRecord.js"></script>
</body>

</html>