<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">角色列表</div>
      <div class="layui-card-body">
        <div class="layui-inline">
          <shiro:hasPermission name="sys:role:edit"><input class="layui-btn" type="button" value="添加" onclick="openDialog('角色添加', '${ctx}/sys/role/form')"/></shiro:hasPermission>
         </div>
         <table class="layui-table"></table>
      </div>
    </div>
  </div>
  <script type="text/html" id="bar">
    <a class="layui-btn layui-btn-normal layui-btn-sm" href="javascript:void(0)" onclick="openIframe('角色分配', '${ctx}/sys/role/assign?id={{d.id}}')"><i class="layui-icon layui-icon-add-circle-fine"></i>分配</a>
    <a class="layui-btn layui-btn-sm" href="javascript:void(0)" onclick="openDialog('角色修改', '${ctx}/sys/role/form?id={{d.id}}')"><i class="layui-icon layui-icon-edit"></i>修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)" onclick="confirmx('确认要删除该角色吗？', '${ctx}/sys/role/delete?id={{d.id}}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
  </script>
  <script type="text/javascript">
    var dataScopeData = ${fns:getDictListJson('sys_data_scope')};
    $(document).ready(function() {
      //执行渲染
      table.render({
        url: '${ctx}/sys/role/data' //数据接口
        ,cols: [[ //表头
           {title: '角色名称', templet: function(d) {
        	  return '<a href="javascript:void(0)" onclick="openDialog(\'角色修改\', \'${ctx}/sys/role/form?id='+d.id+'\')">'+d.name+'</a>';
           }}
          ,{title: '归属机构', templet: function(d) {
              return d.office.name
           }}
          ,{title: '数据范围', templet: function(d) {
        	  return getDictLabel(dataScopeData, d.dataScope);
          }}
          <shiro:hasPermission name="sys:role:edit">
          ,{fixed:'right', align:'center', width:250, title: '操作', toolbar:'#bar'}
          </shiro:hasPermission>
          ]]
      });
    });
  </script>
 </body>
</html>