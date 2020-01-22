<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<script src="${pageContext.request.contextPath}/pages/js/jquery-3.4.1.min.js"></script>
<script>
	function commitFunc() {
	  var formData = {};
	  var url = "common/exportEntryStockData"
	  $.ajax({
	    url: "http://localhost:8080/sipimo/"+url,
	    dataType: "json",
	    type: "POST",
	    async: false,
	    data: {jsonStr:JSON.stringify(formData)},
	    //contentType: "application/json;charscontentet=utf-8",
	    contentType: "application/x-www-form-urlencoded;charset=utf-8",
	    success: function(data) {
	      console.log(data);
	    },
	    error: function(response) {
	      console.log(response);
	    }
	  });
	}
</script>
</head>
<body>
<button id="btnButton" onclick="commitFunc()">提交</button>
</body>
</html>
