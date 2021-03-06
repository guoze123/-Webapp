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
  <title>入职</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
  <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/chosen/chosen.css" />

  <link href="${pageContext.request.contextPath}/pages/css/plugins/bootstrap-table/bootstrap-table.min.css"
    rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/plugins/zoom/zoom.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/css/personnelManagement/onboarding.css" />
  <style>
    .chosen-container {
      width: 152px !important;
    }

    .ibox-content {
      padding-top: 0;
      padding-bottom: 0;
    }
  </style>
  <script>
    var base = "${pageContext.request.contextPath}";
  </script>
</head>

<body class="gray-bg">
  <div class="wrapper wrapper-content animated fadeInRight">
    <div class="row row-lg">
      <div class="col-sm-3" style="padding-left: 7px;padding-right: 7px;">
        <div class="ibox float-e-margins">
          <div class="ibox-title">
            <h5>人员比例</h5>
            <div class="ibox-tools"></div>
          </div>
          <div class="ibox-content">
            <div id="personnelRatio" style="width: 100%; height: 150px;">
            </div>
          </div>
        </div>
        <div class="ibox float-e-margins">
          <div class="ibox-title">
            <h5>人员流动</h5>
            <div class="ibox-tools"></div>
          </div>
          <div class="ibox-content">
            <div id="personnel" style="width: 100%; height: 250px;"></div>
          </div>
        </div>
      </div>
      <div class="col-sm-9" style="padding-left: 7px;padding-right: 7px;">
        <div class="ibox float-e-margins">
          <div class="ibox-title">
            <h5>人员管理</h5>
            <div class="ibox-tools"></div>
          </div>
          <div class="ibox-content">
            <div class="row row-lg">
              <div class="col-sm-12">
                <div class="example">
                  <div class="searchList" style="margin-top: 10px;">
                    <div class="left">
                      <button type="button" id="" class="btn btn-success addBtn" style="width:80px;">
                        添加
                      </button>
                    </div>
                    <div class="right">
                      <input type="text" class="form-control query_userinformation" placeholder="员工信息" />
                      <select class="form-control m-b query_ownerId">
                        <option value="">选择店铺</option>
                      </select>
                      <select class="form-control m-b query_activeStatus">
                        <option value="">选择在职状态</option>
                        <option value="0">在职</option>
                        <option value="-1">离职</option>
                      </select>
                      <span style="text-align: right;">
                        <button type="button" id="eventqueryBtn" class="btn btn-success queryBtn" style="width:80px;">
                          查询
                        </button>
                        <button type="button" id="" class="btn btn-success exportBtn" style="width:80px;">
                          导出
                        </button>
                      </span>
                    </div>
                  </div>
                  <table id="employeeInfo" data-mobile-responsive="true"></table>
                </div>
              </div>
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
            <span><i class="required">*</i>姓名</span>
            <input class="form-control employeeName" type="text" placeholder="姓名" />
          </div>
          <div>
            <span><i class="required">*</i>性别</span>
            <select class="form-control m-b employeeSex">
              <option value="">选择性别</option>
              <option value="男">男</option>
              <option value="女">女</option>
            </select>
          </div>
        </div>
        <div class="list_row">
          <div>
            <span><i class="required">*</i>身份证号</span>
            <input class="form-control identityNumber" type="text" placeholder="身份证号" />
          </div>
          <div>
            <span>出生日期</span>
            <input id="" class="laydate-icon form-control layer-date birthday"
              onclick="laydate({istime: false, format: 'YYYY-MM-DD'})" placeholder="出生日期" />
          </div>
        </div>
        <div class="list_row">
          <div>
            <span><i class="required">*</i>入职日期</span>
            <input id="" class="laydate-icon form-control layer-date entryTime"
              onclick="laydate({istime: false, format: 'YYYY-MM-DD'})" placeholder="入职日期" />
          </div>
          <div>
            <span><i class="required">*</i>电话</span>
            <input class="form-control telephone" type="text" placeholder="电话" />
          </div>
        </div>
        <div class="list_row">
          <div>
            <span><i class="required">*</i>归属门店</span>
            <select class="form-control m-b ownerId">
              <option value="">请选择门店</option>
            </select>
          </div>
          <div>
            <span><i class="required">*</i>角色</span>
            <select class="form-control m-b role">
              <option value="">请选择角色</option>
            </select>
          </div>
        </div>
        <div class="list_row">
          <div>
            <span>职务</span>
            <input class="form-control job" type="text" placeholder="职务" />
          </div>
          <div>
            <span>晋升职位</span>
            <input class="form-control promotion" type="text" placeholder="晋升职位" />
          </div>
        </div>
        <div class="list_row">
          <div>
            <span>学历</span>
            <input class="form-control education" type="text" placeholder="学历" />
          </div>
          <div>
            <span><i class="required">*</i>激活状态</span>
            <select class="form-control m-b activeStatus">
              <option value="">选择激活状态</option>
              <option value="0">在职</option>
              <option value="-1">离职</option>
            </select>
          </div>
        </div>
        <div class="list_row">
          <div>
            <span>住址</span>
            <input class="form-control address" type="text" placeholder="住址" />
          </div>
          <div>
            <span>工作经历</span>
            <input class="form-control workExperience" type="text" placeholder="工作经历" />
          </div>
        </div>
        <div class="list_row"></div>
        <div class="list_row">
          <div style="width:100%;">
            <span>简历图片</span>
            <div style=" display: flex;align-items: center; height: 110px;">
              <label class="btn btn-success" for="upload" style="display: inline-block;">
                <i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">简历图片</span>
              </label>
              <input type="file" name="" id="upload" accept=".jpg" class="uploadimg"
                style="visibility: hidden; width: 20px; height: 0;" />
              <img src="" alt="" class="resume" data-action="zoom" />
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
  <script src="${pageContext.request.contextPath}/pages/js/plugins/chosen/chosen.jquery.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/echarts/echarts-all.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/zoom/zoom.js"></script>
  <!-- 自定义js -->
  <script src="${pageContext.request.contextPath}/pages/js/content.js?v=1.0.0"></script>
  <script src="${pageContext.request.contextPath}/pages/js/personnelManagement/onboarding.js"></script>
</body>

</html>