<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8"%> <% String path = request.getContextPath(); String
basepath =
request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title></title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="renderer" content="webkit"/>
  <meta name="force-rendering" content="webkit"/>
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
  <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
    rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/datapicker/datepicker3.css" />
  <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/main.css" />
  <style>
    #laydate_table {
      display: none;
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
        <h5>公司年度计划</h5>
        <div class="ibox-tools"></div>
      </div>
      <div class="ibox-content">
        <div class="row row-lg">
          <div class="col-sm-12">
            <div class="example">
              <div class="searchList" style="float:right; width: 100%;">
                <div class="left">
                  <div style="display: inline;">
                    <label for="yearUploadFile" class="btn btn-success importBtn yearImport"
                      style="margin-bottom: 0; width:80px;">导入</label>
                    <input type="file" name="" id="yearUploadFile" style="width: 0; height: 0;" accept=".xlsx" />
                  </div>
                </div>
                <div class="right">
                  <input id="" class="laydate-icon form-control  startYear" placeholder="开始时间"
                    style="margin-right: 10px;" />
                  <input id="" class="laydate-icon form-control  endYear" placeholder="结束时间"
                    style="margin-right: 10px;" />
                  <span>
                    <button type="button" id="queryYearBtn" class="btn btn-success queryBtn" style="width:80px;">
                      查询
                    </button>
                    <button type="button" id="" class="btn btn-success exportBtn yearExport"
                      style="width:80px; margin-bottom: 0;">
                      导出模板
                    </button>
                  </span>
                </div>
              </div>
              <div class="plan">
                <table id="companyYearPlan" data-mobile-responsive="true"></table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="ibox float-e-margins">
      <div class="ibox-title">
        <h5>公司月度计划</h5>
        <div class="ibox-tools"></div>
      </div>
      <div class="ibox-content">
        <div class="row row-lg">
          <div class="col-sm-12">
            <div class="example">
              <div class="searchList" style="float:right;">
                <div class="left">
                  <div style="display: inline;">
                    <label for="monthUploadFile" class="btn btn-success importBtn monthImport"
                      style="margin-bottom: 0;width:80px;">导入</label>
                    <input type="file" name="" id="monthUploadFile" style="width: 0; height: 0;" accept=".xlsx" />
                  </div>
                </div>
                <div class="right">
                  <input id="" class="laydate-icon form-control startTime" placeholder="开始时间"
                    style="margin-right: 10px;" />
                  <input id="" class="laydate-icon form-control endTime" placeholder="结束时间"
                    style="margin-right: 10px;" />
                  <span>
                    <button type="button" id="queryMonthBtn" class="btn btn-success queryBtn" style="width:80px;">
                      查询
                    </button>
                    <button type="button" id="" class="btn btn-success exportBtn monthExport"
                      style="width:80px; margin-bottom: 0;">
                     导出模板
                    </button>
                  </span>
                </div>
              </div>
              <div class="plan">
                <table id="companyMonthPlan" data-mobile-responsive="true"></table>
              </div>
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
  <!-- 自定义js -->
  <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
  <script src="${pageContext.request.contextPath}/pages/js/main.js"></script>
</body>

</html>