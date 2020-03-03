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
	  var url = "inventory/queryPersonalMarketing"
	  //var url = "feedback/feedback.txt"
	  $.ajax({
	    url: "http://localhost:8080/sipimo/"+url,
	    //dataType: "json",
	    type: "POST",
	    async: false,
	    data: {jsonStr:JSON.stringify(formData)},
	    //data: formData,
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
	
	//function exportFun() {
		// 导出
		$(".exportBtn").click(function() {
		  //let menuName= $('.J_menuTab.active', parent.document).text();
		  //let titleName=$(this).parents(".ibox").find(".ibox-title h5 ").text();
		  let form = $('<form id="to_export" style="display:none"></form>').attr({
		    action: "/sipimo" + "/common/exportWaresData",
		    method: "post"
		  });
		  $("<input>")
	      .attr("name", "jsonStr")
	      .val(JSON.stringify({
	        fileName:"exportFileName.csv"
	      }))
	      .appendTo(form);
	    $("body").append(form);
	    $("#to_export")
	      .submit()
	      .remove();
	  });
	//}
</script>
</head>
<body>
<button id="btnButton" onclick="commitFunc()">提交</button>
<button class="exportBtn">导出</button>
</body>
</html>
