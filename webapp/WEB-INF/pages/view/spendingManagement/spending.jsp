<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "
http://www.w3.org/TR/html4/loo">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico">
    <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
        rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/plugins/chosen/chosen.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/datapicker/datepicker3.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/zoom/zoom.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/spendingManagement/spending.css">
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
                <h5>开支</h5>
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
                                    <input id="" class="laydate-icon form-control query_startTime"
                                        placeholder="选择开始时间" />
                                    <input id="" class="laydate-icon form-control query_endTime" placeholder="选择结束时间" />
                                    <select class="form-control m-b query_costTypeId" name="account">
                                        <option value="">请选择开支分类</option>
                                    </select>
                                    <input type="text" class="form-control query_ownerName" placeholder="输入核算单元名称">
                                    <span>
                                        <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn"
                                            style="width:80px;">查询</button>
                                        <!-- <button type="button" id="" class="btn btn-success exportBtn"
                                            style="width:80px;">导出</button> -->
                                    </span>
                                </div>
                            </div>
                            <table id="spending" data-mobile-responsive="true">
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
                        <span><i class="required">*</i>时间</span>
                        <input id="" class="laydate-icon form-control layer-date costTime " placeholder="时间" />
                    </div>
                    <div>
                        <span><i class="required">*</i>部门</span>
                        <select class="form-control m-b ownerId" name="account">
                            <option value="">选择部门</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>金额</span>
                        <input id="" class=" form-control costAmount " placeholder="金额" />
                    </div>
                    <div>
                        <span><i class="required">*</i>开支分类</span>
                        <select class="form-control m-b costTypeId" name="account">
                            <option value="">选择开支分类</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div style="width: 100%;">
                        <span><i class="required">*</i>备注</span>
                        <input type="text" class="form-control remark" placeholder="备注" />
                    </div>
                </div>
                <div class="list_row">
                    <div style="width: 100%;">
                        <span>发票图片</span>
                        <div style=" display: flex;align-items: center; height: 110px;">
                            <label class="btn btn-success" for="upload" style="display: inline-block;">
                                <i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">发票图片</span>
                            </label>
                            <input type="file" name="" id="upload" accept="image/*" class="uploadimg"
                                style="visibility: hidden; width: 20px; height: 0;" />
                            <img src="" alt="" class="receiptPic" data-action="zoom" />
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
    <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/laydate/laydate.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/zoom/zoom.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/chosen/chosen.jquery.js"></script>
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/pages/js/spendingManagement/spending.js"></script>
</body>

</html>