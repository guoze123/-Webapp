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
    <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
        rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/chosen/chosen.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/datapicker/datepicker3.css">
    <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/zoom/zoom.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/inventoryManagement/allocate.css" />
    <style>
        .fixed-table-border {
            height: 0 !important;
        }

        .fixed-table-container {
            border-bottom: 0px !important;
        }
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
                <h5>调拨管理</h5>
                <div class="ibox-tools"></div>
            </div>
            <div class="ibox-content">
                <div class="row row-lg">
                    <div class="col-sm-12">
                        <div class="example">
                            <div class="searchList">
                                <div class="left">
                                    <button type="button" id="" class="btn btn-success addBtn" style="width:80px;">
                                        添加
                                    </button>
                                </div>
                                <div class="right">
                                    <input id="" class="laydate-icon form-control layer-date query_startTime"
                                        placeholder="时间" />
                                    <span>
                                        <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn"
                                            style="width:80px;">
                                            查询
                                        </button>
                                        <button type="button" id="eventAddBtn" class="btn btn-success exportBtn"
                                            style="width:80px;" aria-label="Export">
                                            导出
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <table id="importInventory" data-mobile-responsive="true"></table>
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
                        <span><i class="required">*</i>订单日期</span>
                        <input id="" class="laydate-icon form-control layer-date startTime" type="text"
                            onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss',start:new Date().toLocaleString('chinese',{hour12:false})})"
                            placeholder="订单日期" />
                    </div>
                    <div>
                        <span><i class="required">*</i>应付金额</span>
                        <input type="text" class="form-control handleAmount" placeholder="应付金额" />
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span><i class="required">*</i>实付金额</span>
                        <input type="text" class="form-control actualAmount" placeholder="实付金额" />
                    </div>
                    <div>
                        <span><i class="required">*</i>发货方</span>
                        <select name="" id="" class="form-control m-b shipper">
                            <option value="">选择发货方</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div>
                        <span>备注</span>
                        <input type="text" class="form-control remark" placeholder="备注" />
                    </div>
                    <div>
                        <span><i class="required">*</i>收货方</span>
                        <select name="" id="" class="form-control m-b consignee">
                            <option value="">选择收货方</option>
                        </select>
                    </div>
                </div>
                <div class="list_row">
                    <div style="width: 100%; height: 45px;" class="payType">
                        <span>支付类型</span>
                        <div><input type="radio" name="payType" value="0" checked id="" style="width: 20px;">现金</div>
                        <div> <input type="radio" name="payType" value="1" id="" style="width: 20px;">微信</div>
                        <div><input type="radio" name="payType" value="2" id="" style="width: 20px;">支付宝</div>
                        <div><input type="radio" name="payType" value="3" id="" style="width: 20px;">刷卡</div>
                        <div><input type="radio" name="payType" value="4" id="" style="width: 20px;">购物卡</div>
                        <div><input type="radio" name="payType" value="5" id="" style="width: 20px;">其他</div>
                    </div>
                </div>
                <div class="list_row commodity firstGroup">
                    <div style="width: 100%;">
                        <span><i class="required">*</i>商品名称</span>
                        <select class="form-control name">
                            <option value=''>选择商品</option>
                        </select>
                        <span style="margin-left: 10px;"><i class="required">*</i>商品数量</span>
                        <input type="text" placeholder="商品数量" class="form-control number" />
                        <button style=" margin-left: 10px;" onclick="addCommodity(this)">
                            添加商品
                        </button>
                    </div>
                </div>
                <div class="list_row imgdesc">
                    <div style="width: 100%;">
                        <span>上传图片</span>
                        <div style=" display: flex;align-items: center; height: 110px;">
                            <label class="btn btn-success" for="upload" style="display: inline-block;">
                                <i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">上传图片</span>
                            </label>
                            <input type="file" name="" id="upload" accept="image/*" class="uploadimg"
                                style="visibility: hidden; width: 20px; height: 0;" />
                            <img src="" alt="" class="picList" data-action="zoom" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="return_borrowed" id="entryDetail" style="display: none; margin-bottom: 15px;">
        <div class="return_top">
            <table id="detailTable" data-mobile-responsive="true"></table>

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
    <script src="${pageContext.request.contextPath}/pages/js/plugins/chosen/chosen.jquery.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/laydate/laydate.js"></script>
    <script src="${pageContext.request.contextPath}/pages/js/plugins/zoom/zoom.js"></script>
    <!-- 自定义js -->
    <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
    <script src="${pageContext.request.contextPath}/pages/js/inventoryManagement/allocate.js"></script>
</body>

</html>