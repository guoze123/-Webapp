<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% 
	String path = request.getContextPath(); 
	String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" " http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="renderer" content="webkit" />
  <title>天健康养</title>
  <meta name="renderer" content="webkit"/>
  <meta name="force-rendering" content="webkit"/>
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
  <meta name="keywords" content="H+" />
  <meta name="description" content="H+" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
  <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css?v=3.3.6" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/font-awesome.min.css?v=4.4.0" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/style.css?v=4.1.0" rel="stylesheet" />
  <style>
    body {
      min-width: 1000px !important;
    }

    .has-error {
      color: #a94442;
    }

    #updata_password_content {
      padding: 20px 40px;
    }

    #updata_password_content {
      padding: 20px 40px;
    }

    .errHeight {
      height: 20px;
      line-height: 20px;
    }
  </style>
  <script>
    var base = "${pageContext.request.contextPath}";
  </script>
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
  <div id="wrapper">
    <!--左侧导航开始-->
    <div class="navbar-default navbar-static-side" role="navigation">
      <div class="nav-close"><i class="fa fa-times-circle"></i></div>
      <div class="sidebar-collapse">
        <ul class="nav" id="side-menu">
          <li class="nav-header">
            <div class="dropdown profile-element" style="display: flex;align-items: flex-end">
              <div>
                <img alt="image" class="img-circle" src="${pageContext.request.contextPath}/pages/img/avatar.jpg" />
              </div>
              <div class="clear" style="margin-left: 10px;">
                <span class="block " style="color: #a7b1c2;"> 工号：<strong class="font-bold employeeId">10099</strong></span>
                <span class="block " style="color: #a7b1c2;"> 姓名：<strong class="font-bold userName">Beaut-zihan</strong></span>
                <span class="text-muted text-xs block" style="color: #a7b1c2;"> 职位：<span class="userJob">超级管理员</span>
                </span>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
      <div class="row content-tabs">
        <button class="roll-nav roll-left J_tabLeft">
          <i class="fa fa-backward"></i>
        </button>
        <nav class="page-tabs J_menuTabs">
          <div class="page-tabs-content">
            <a href="javascript:;" class="active J_menuTab" data-id="0_0">首页</a>
          </div>
        </nav>
        <button class="roll-nav roll-right J_tabRight" style="right: 200px;">
          <i class="fa fa-forward"></i>
        </button>
        <div class="btn-group roll-nav roll-right" style="right: 120px;">
          <button class="dropdown J_tabClose" data-toggle="dropdown">
            关闭操作<span class="caret"></span>
          </button>
          <ul role="menu" class="dropdown-menu dropdown-menu-right">
            <li class="J_tabShowActive"><a>定位当前选项卡</a></li>
            <li class="divider"></li>
            <li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
            <li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
          </ul>
        </div>
        <div class="btn-group roll-nav roll-right" id="updata_password"
          style="right: 60px; width: 60px; background: #fff;">
          修改密码
        </div>
        <div class="roll-nav roll-right J_tabExit" onclick="logout()">
          <i class="fa fa fa-sign-out"></i> 退出
        </div>
      </div>
      <div class="row J_mainContent" id="content-main">
        <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="" frameborder="0" data-id="0_0"
          seamless></iframe>
      </div>
    </div>
    <!--右侧部分结束-->
    <!--右侧边栏开始-->
    <div id="right-sidebar">
      <div class="sidebar-container">
        <ul class="nav nav-tabs navs-3">
          <li class="active">
            <a data-toggle="tab" href="#tab-1">
              <i class="fa fa-gear"></i> 主题
            </a>
          </li>
          <li class="">
            <a data-toggle="tab" href="#tab-2">
              通知
            </a>
          </li>
          <li>
            <a data-toggle="tab" href="#tab-3">
              项目进度
            </a>
          </li>
        </ul>

        <div class="tab-content">
          <div id="tab-1" class="tab-pane active">
            <div class="sidebar-title">
              <h3><i class="fa fa-comments-o"></i> 主题设置</h3>
              <small><i class="fa fa-tim"></i> </small>
            </div>
            <div class="skin-setttings">
              <div class="title">主题设置</div>
              <div class="setings-item">
                <span>收起左侧菜单</span>
                <div class="switch">
                  <div class="onoffswitch">
                    <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="collapsemenu" />
                    <label class="onoffswitch-label" for="collapsemenu">
                      <span class="onoffswitch-inner"></span>
                      <span class="onoffswitch-switch"></span>
                    </label>
                  </div>
                </div>
              </div>
              <div class="setings-item">
                <span>固定顶部</span>
                <div class="switch">
                  <div class="onoffswitch">
                    <input type="checkbox" name="fixednavbar" class="onoffswitch-checkbox" id="fixednavbar" />
                    <label class="onoffswitch-label" for="fixednavbar">
                      <span class="onoffswitch-inner"></span>
                      <span class="onoffswitch-switch"></span>
                    </label>
                  </div>
                </div>
              </div>
              <div class="setings-item">
                <span>
                  固定宽度
                </span>
                <div class="switch">
                  <div class="onoffswitch">
                    <input type="checkbox" name="boxedlayout" class="onoffswitch-checkbox" id="boxedlayout" />
                    <label class="onoffswitch-label" for="boxedlayout">
                      <span class="onoffswitch-inner"></span>
                      <span class="onoffswitch-switch"></span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--右侧边栏结束-->
  </div>
  <div class="footer" style="text-align: center;">
    <div>
                         陕ICP备20001778号-1
    </div>
  </div>
  <div id="updata_password_content" style="display: none; margin-bottom: 15px;">
    <div class="return_top">
      <div class="textContent">
        <div>
          <span style="font-size: 14px; display: block;margin-bottom: 5px;"><i class="required">*</i>原始密码：</span>
          <input type="password" class="form-control passwd" oninput="validationPassword(this)" placeholder="输入原始密码">
        </div>
        <div class="errHeight passwordErr"></div>
        <div>
          <span style="font-size: 14px; display: block;margin-bottom: 5px;"><i class="required">*</i>新密码：</span>
          <input type="password" class="form-control newPasswd" oninput="validationPassword(this)" placeholder="输入新密码">
        </div>
        <div class="errHeight passwordErr"></div>
      </div>
    </div>
  </div>
  <!-- 全局js -->
  <script src="${pageContext.request.contextPath}/pages/js/jquery.min.js?v=2.1.4"></script>
  <script src="${pageContext.request.contextPath}/pages/js/bootstrap.min.js?v=3.3.6"></script>
  <script src="${pageContext.request.contextPath}/pages/js/common.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/metisMenu/jquery.metisMenu.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/plugins/layer/layer.min.js"></script>
  <script src="${pageContext.request.contextPath}/pages//js/loading.js"></script>
  <!-- 自定义js -->
  <script src="${pageContext.request.contextPath}/pages/js/hplus.js?v=4.1.0"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/pages/js/contabs.js"></script>
  <!-- 第三方插件 -->
  <script src="${pageContext.request.contextPath}/pages/js/plugins/pace/pace.min.js"></script>
  <script src="${pageContext.request.contextPath}/pages/js/index.js"></script>
</body>

</html>