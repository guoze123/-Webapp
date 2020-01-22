layui.use(["table", "code"], function() {
  var table = layui.table;
  layui.code();

  //转换静态表格
  table.init("demo", {
    height: 315, //设置高度
    limit: 10 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
    //支持所有基础参数
  });
  function func7() {
    //页面层
    layer.open({
      type: 1,
      skin: "layui-layer-rim", //加上边框
      area: ["350px", "360px"], //宽高

      content: "@Url.Action('AddUser', 'UserInfo')" //调到新增页面
    });
  }
});
