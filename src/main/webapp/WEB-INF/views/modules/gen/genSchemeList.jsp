<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/gen/genScheme/">生成方案列表</a></li>
			<shiro:hasPermission name="gen:genScheme:edit"><li><a href="${ctx}/gen/genScheme/form">生成方案添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<form:form id="searchForm" modelAttribute="genScheme" class="layui-form">
		<label class="layui-form-label">方案名称：</label>
		<div class="layui-input-inline">
			<form:input path="name" htmlEscape="false" maxlength="50" class="layui-input"/>
		</div>
		<input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<div style="margin:15px">
		<table class="layui-table"></table>
	</div>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-sm" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		var table = layui.table;
		//执行渲染
		table.render({
		    url: '${ctx}/gen/genScheme/data' //数据接口
		    ,cols: [[ //表头
		       {field:'name', title: '方案名称', sort: true, templet: function(d) {
		          return '<a href="${ctx}/gen/genScheme/form?id='+d.id+'" class="layui-table-link">'+d.name+'</a>'
		       }}
		      ,{field: 'packageName', title: '生成模块'}
		      ,{field: 'moduleName', title: '模块名'}
		      ,{field: 'functionName', title: '功能名'}
		      ,{field: 'functionAuthor', title: '功能作者'}
		      <shiro:hasPermission name="gen:genScheme:edit">
		      ,{fixed:'right', align:'center', width:180, title: '操作', toolbar:'#bar'}
		      </shiro:hasPermission>
		    ]]
		});
		//监听工具条
		table.on('tool', function(obj){
		  var data = obj.data; //获得当前行数据
		  var layEvent = obj.event; //获得 lay-event 对应的值
		  if(layEvent === 'edit'){ //修改
              location = '${ctx}/gen/genScheme/form?id='+data.id;
		  } else if(layEvent === 'del'){ //删除
			  confirmx('确认要删除该生成方案吗？', '${ctx}/gen/genScheme/delete?id='+data.id)
		  }
		});
	});
	</script>
</body>
</html>