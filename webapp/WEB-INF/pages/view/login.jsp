<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <title>登录</title>
  <meta name="renderer" content="webkit"/>
  <meta name="force-rendering" content="webkit"/>
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/pages/img/favicon.ico" />
  <link href="${pageContext.request.contextPath}/pages/css/bootstrap.min.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/font-awesome.css?v=4.4.0" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/animate.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/style.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/pages/css/login.css" rel="stylesheet" />
  <style>
    .has-error {
      color: #a94442;
    }
  </style>

  <script>
    var base = "${pageContext.request.contextPath}"
    if (window.top !== window.self) {
      window.top.location = window.location;
    }
  </script>
</head>

<body class="signin">
  <div class="signinpanel">
    <div class="login_content">
      <div class="login_header">
        天健康养后台管理系统
      </div>
      <div class="login_text">
        <input type="text" class="form-control uname" placeholder="手机号" autocomplete="off"
          oninput="validationPhone(this)" />
        <div class="phoneErr"></div>
        <input type="password" class="form-control pword" placeholder="密码" autocomplete="off"
          oninput="validationPassword(this)" />
        <div class="passwordErr"></div>
        <div style="display: flex;justify-content:space-between;">
          <a href="${pageContext.request.contextPath}/common/userRegister">点击注册</a>
          <a href="${pageContext.request.contextPath}/common/forgetPassword">忘记密码</a>
        </div>
        <button class="btn btn-success btn-block btn-login">
          登录
        </button>
      </div>
    </div>
  </div>
</body>
<script src="${pageContext.request.contextPath}/pages/js/jquery.min.js?v=2.1.4"></script>
<script src="${pageContext.request.contextPath}/pages/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${pageContext.request.contextPath}/pages/js/common.js"></script>
<script src="${pageContext.request.contextPath}/pages/js/plugins/layer/layer.min.js"></script>
<script src="${pageContext.request.contextPath}/pages/js/loading.js"></script>

<script>
  var phoneReg = /^1[0-9]{10}$/,
    passwordReg = /^[0-9a-zA-Z]{6,10}$/;
  function validationPhone(that) {
    let errStr =
      '<span id="phone-error" class="has-error  m-b-none"><i class="fa fa-times-circle"></i>请输入有效的手机号</span>';
    if ($(that).val()) {
      if (phoneReg.test($(that).val())) {
        $("#phone-error").remove();
      } else {
        if (!$("#phone-error").length) {
          $(".phoneErr").html(errStr);
        }
      }
    } else {
      $("#phone-error").remove();
    }
  }
  function validationPassword(that) {
    let errStr =
      '<span id="password-error" class="has-error  m-b-none"><i class="fa fa-times-circle"></i>6-10位数字字母组成的字符</span>';
    if ($(that).val()) {
      if (passwordReg.test($(that).val())) {
        $("#password-error").remove();
      } else {
        if (!$("#password-error").length) {
          $(".passwordErr").html(errStr);
        }
      }
    } else {
      $("#password-error").remove();
    }
  }

  $(".btn-login").click(function () {
    if ($(".has-error").length) {
      return;
    }
    if ($(".uname").val() == "" || $(".pword").val() == "") {
      tips("请填写手机号或密码", 5, 10);
      return;
    }
    var params = {
      phoneNumber: $(".uname").val(),
      passwd: $(".pword").val()
    };
    ajax_data("/common/login", { params: JSON.stringify(params) }, function (
      res
    ) {
      if (res.resultCode > -1) {
        setCookie("phoneNumber", res.personalInfo.phoneNumber);
        setCookie("employeeName", res.personalInfo.employeeName);
        setCookie("job", res.personalInfo.job);
        setCookie("ownerId", res.personalInfo.ownerId);
        setCookie("employeeId", res.personalInfo.employeeId);
        setCookie("role", res.personalInfo.role);
        window.location.href = "${pageContext.request.contextPath}/common/index";
      } else {
        tips("登录失败,请检查用户名或密码", 5);
      }
    });
  });
  $(document).keyup(function (event) {
    if (event.keyCode == 13 || event.keyCode == 108) {
      $(".btn-login").trigger("click");
    }
  });
 
</script>

</html>