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
		<table class="layui-table" lay-data="{id:'table', height:471, even:true, url:'${ctx}/gen/genScheme/data', where:queryParams(), request: {pageName: 'pageNo'}, page:true, limit:10}">
		<thead>
		<tr>
			<th lay-data="{field:'name', width:150, templet:'#nameTpl'}">方案名称</th>
			<th lay-data="{field:'packageName', width:300}">生成模块</th>
			<th lay-data="{field:'moduleName', width:100}">模块名</th>
			<th lay-data="{field:'functionName', width:120}">功能名</th>
			<th lay-data="{field:'functionAuthor', width:120}">功能作者</th>
			<shiro:hasPermission name="gen:genScheme:edit">
				<th lay-data="{fixed:'right', width:180, align:'center', toolbar:'#bar'}">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
		</table>
	</div>
	<script type="text/html" id="nameTpl">
		<a href="${ctx}/gen/genScheme/form?id={{d.id}}" class="layui-table-link">{{d.name}}</a>
	</script>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-small" lay-event="edit"><i class="layui-icon">&#xe642;</i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-small" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		var table = layui.table;
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