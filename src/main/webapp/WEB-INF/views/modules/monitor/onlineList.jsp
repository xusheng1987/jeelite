<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>在线用户管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">在线用户列表</div>
      <div class="layui-card-body">
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
  <script type="text/html" id="bar">
    <a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" onclick="confirmx('确认要强制下线该用户吗？', '${ctx}/monitor/online/tickOut?sessionId={{d.id}}')"><i class="layui-icon layui-icon-delete"></i>强制下线</a>
  </script>
  <script type="text/javascript">
	$(document).ready(function() {
		//执行渲染
		table.render({
		    url: '${ctx}/monitor/online/data' //数据接口
		    ,cols: [[ //表头
		       {field: 'id',title: '会话编号'}
		      ,{field: 'startTimestamp', title: '创建时间'}
		      ,{field: 'lastAccessTime', title: '最后访问时间'}
		      ,{field: 'loginName', title: '登录名'}
		      ,{field: 'name', title: '姓名'}
		      ,{field: 'host', title: '主机'}
		      ,{field: 'ipAddress', title: 'IP地址'}
		      ,{field: 'browser', title: '浏览器'}
		      ,{field: 'os', title: '操作系统'}
	  	      <shiro:hasPermission name="monitor:online:edit">
	  	      ,{fixed:'right', align:'center', width:120, title: '操作', toolbar:'#bar'}
	  	      </shiro:hasPermission>
		    ]]
		});
	});
	</script>
</body>
</html>