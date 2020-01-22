var EditForm = function () {
            var self = this;
            self.initialJoinTime = function () {
                layui.use('laydate', function () {
                    var laydate = layui.laydate;
                    laydate.render({
                        elem: '#joinTime'
                    });
                });
            }

            self.initialTransferTime = function () {
                layui.use('laydate', function () {
                    var laydate = layui.laydate;
                    laydate.render({
                        elem: '#transferTime'
                    });
                });
            }

            self.initialFormSubmit = function (param, callBack) {
                layui.use(["form"], function () {
                    layui.form.on("submit(submitEdit)", function (data) {
                        $.ajax({
                            "contentType": "application/json",
                            "dataType": "json",
                            "type": "post",
                            "url": urlConfig().submitPeopleData,
                            "data": JSON.stringify(param),
                            "success": function (response) {
                                if (response.ResponseCode === "200") {
                                    layer.msg(response.Message);
                                    callBack();
                                } else {
                                    layer.alert(response.Message);
                                }
                            }
                        });
                        return false; 
                    });
                });
            }
        }

表单相关的JavaScript