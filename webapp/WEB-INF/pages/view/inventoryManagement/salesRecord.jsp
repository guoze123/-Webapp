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
    <link rel="shortcut icon" href="favicon.ico" />
    <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
        rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/inventoryManagement/salesRecord.css" />
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
                                <div style="margin-right: 15px;" class="recordType">
                                    <input type="radio" name="record" id="" checked value="0" style="width: 20px;" />
                                    店铺销售记录
                                    <input type="radio" name="record" id="" value="1" style="width: 20px;" /> 个人销售记录
                                </div>
                                <div>
                                    <input id="" class="laydate-icon form-control layer-date query_startTime"
                                        onclick="laydate({istime: false, format: 'YYYY-MM-DD'})"
                                        placeholder="开始时间" />
                                </div>
                                <div>
                                    <input id="" class="laydate-icon form-control layer-date query_stopTime"
                                        onclick="laydate({istime: false, format: 'YYYY-MM-DD'})"
                                        placeholder="结束时间" />
                                </div>

                                <div>
                                   店铺名称
                                    <input class="query_storeName form-control" placeholder="店铺名称" />
                                </div>
                            </div>
                            <span style="display: block;width: 100%; text-align: right;">
                                <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn"
                                    style="width:80px;">
                                    查询
                                </button>
                                <button type="button" id="eventAddBtn" class="btn btn-info exportBtn"
                                    style="width:80px;" aria-label="Export">
                                    导出
                                </button>
                            </span>
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
                        <span>录入ID</span>
                        <input class="form-control " type="text" placeholder="" />
                    </div>
                    <div>
                        <span>录入时间</span>
                        <input class="form-control" type="text" placeholder="录入时间" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>
                            销售员
                        </span>
                        <input type="text" class="form-control" placeholder="销售员" />
                    </div>
                    <div>
                        <span>店铺id </span>
                        <input type="text" class="form-control" placeholder="店铺id" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>本次应付金额</span>
                        <input type="text" class="form-control" placeholder="本次应付金额" />
                    </div>
                    <div>
                        <span>本次实付金额</span>
                        <input type="text" class="form-control" placeholder="本次应付金额" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>备注</span>
                        <input type="text" class="form-control" placeholder="备注" />
                    </div>
                    <div>
                        <span>客户类型</span>
                        <select name="" id="" class="form-control">
                            <option value="0">老客户</option>
                            <option value="1">新客户</option>
                        </select>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="return_borrowed" id="detail" style="display: none; margin-bottom: 15px;">
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
                        <span>录入时间</span>
                        <input class="form-control" type="text" placeholder="录入时间" />
                    </div>
                    <div>
                        <span>客户类型</span>
                        <select name="" id="" class="form-control">
                            <option value="0">老客户</option>
                            <option value="1">新客户</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>
                            销售员
                        </span>
                        <input type="text" class="form-control" placeholder="销售员" />
                    </div>
                    <div>
                        <span>店铺id </span>
                        <input type="text" class="form-control" placeholder="店铺id" />
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div class="return_borrowed" id="userDetail" style="display: none; margin-bottom: 15px;">
        <div class="return_top">
            <table id="userDetailTable" data-mobile-responsive="true"></table>

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
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/pages/js/inventoryManagement/salesRecord.js"></script>
</body>

</html>