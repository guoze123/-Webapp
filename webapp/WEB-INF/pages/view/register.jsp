<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basepath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "
http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
  <title>注册</title>
  <meta name="keywords" content="" />
  <meta name="description" content="" />
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
      <div class="register_content">
        <div class="register_header">
          诗碧曼后台管理系统
        </div>
        <div class="register_text">
         
          <input
            type="text"
            class="form-control  employeeId uname"
            autocomplete="off"
            placeholder="员工编号"
            oninput="validationId(this)"
          />
          <div class="errHeight idErr"></div>
          <input
            type="text"
            class="form-control uname phoneNumber"
            autocomplete="off"
            placeholder="手机号"
            oninput="validationPhone(this)"
          />
          <div class="errHeight phoneErr"></div>
          <input
            type="password"
            class="form-control pword"
            autocomplete="off"
            placeholder="密码"
            oninput="validationPassword(this)"
          />
          <div class="errHeight passwordErr"></div>
          <input
            type="password"
            class="form-control confirmPasswd"
            autocomplete="off"
            placeholder="确认密码"
          />
          <div class="errHeight "></div>
          <a href="${pageContext.request.contextPath}/common/userLogin">已有账号，返回登录</a>
          <button class="btn btn-success btn-block btn-register">注册</button>
        </div>
      </div>
    </div>
  </body>
<script src="${pageContext.request.contextPath}/pages/js/jquery.min.js?v=2.1.4"></script>
<script src="${pageContext.request.contextPath}/pages/js/bootstrap.min.js?v=3.3.6"></script>
<script src="${pageContext.request.contextPath}/pages/js/common.js"></script>
<script src="${pageContext.request.contextPath}/pages/js/plugins/layer/layer.min.js"></script>
<script src="${pageContext.request.contextPath}/pages//js/loading.js"></script>
<script>
    var phoneReg = /^1[0-9]{10}$/,
      passwordReg = /^[0-9a-zA-Z]{6,10}$/,
      idReg=/^[0-9]{5}$/;
  function validationPhone(that) {
    let errStr =
      '<span id="phone-error" class="has-error help-block m-b-none"><i class="fa fa-times-circle"></i>请输入有效的手机号</span>';
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
      '<span id="password-error" class="has-error help-block m-b-none"><i class="fa fa-times-circle"></i>6-10位数字字母组成的字符</span>';
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
    function validationId(that) {
      let errStr =
        '<span id="id-error" class="has-error help-block m-b-none"><i class="fa fa-times-circle"></i>输入正确的员工编号</span>';
      if ($(that).val()) {
        if (idReg.test($(that).val())) {
          $("#id-error").remove();
        } else {
          if (!$("#id-error").length) {
            $(".idErr").html(errStr);
          }
        }
      } else {
        $("#id-error").remove();
      }
    }

    $(".btn-register").click(function() {
      if (
        $(".pword").val().trim() &&
        $(".confirmPasswd").val().trim() &&
        $(".phoneNumber").val().trim() &&
        $(".employeeId").val().trim()
      ) {
        if ($(".pword").val().trim() !== $(".confirmPasswd").val().trim()) {
          tips("密码填写不一致", 5);
          return;
        }
      } else {
        tips("将注册信息填写完整", 5);
        return;
      }

    var params = {
      phoneNumber: $(".phoneNumber").val(),
      passwd: $(".pword").val(),
      employeeId: $(".employeeId").val()
    };
    ajax_data(
      "/common/register",
      { params: JSON.stringify(params) },
      function (res) {
        if (res.resultCode > -1) {
          setCookie("phoneNumber", res.personalInfo.phoneNumber);
          setCookie("employeeName", res.personalInfo.employeeName);
          setCookie("job", res.personalInfo.job);
          setCookie("ownerId", res.personalInfo.ownerId);
          setCookie("employeeId", res.personalInfo.employeeId);
          setCookie("role", res.personalInfo.role);
          window.location.href = "${pageContext.request.contextPath}/common/index";
        } else if (res.resultCode == -2) {
          tips("用户已存在", 5);
        } else {
           tips("注册失败，请检查注册信息", 5);
        }
      }
    );
  });
  $(document).keyup(function (event) {
    if (event.keyCode == 13 || event.keyCode == 108) {
      $(".btn-register").trigger("click");
    }
  });
</script>
</html>