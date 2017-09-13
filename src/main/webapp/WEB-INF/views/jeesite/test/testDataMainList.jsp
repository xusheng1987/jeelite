<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>主子表管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/test/testDataMain/">主子表列表</a></li>
			<shiro:hasPermission name="test:testDataMain:edit"><li><a href="${ctx}/test/testDataMain/form">主子表添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<form:form id="searchForm" modelAttribute="testDataMain" class="layui-form">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testDataMain.user.id}" labelName="user.name" labelValue="${testDataMain.user.name}"
					title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">名称：</label>
				<div class="layui-input-inline">
					<form:input path="name" htmlEscape="false" maxlength="100" class="layui-input input-medium"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">性别：</label>
				<div class="layui-input-inline">
					<form:select path="sex">
						<form:option value="" label=""/>
						<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</div>
			</div>
			<div class="layui-inline">
				<input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
			</div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<div style="margin:15px">
		<table class="layui-table" lay-data="{id:'table', height:471, even:true, url:'${ctx}/test/testDataMain/data', where:queryParams(), request: {pageName: 'pageNo'}, page:true, limit:10}">
		<thead>
		<tr>
			<th lay-data="{width:120, templet:'#userTpl'}">归属用户</th>
			<th lay-data="{field:'name', width:120}">名称</th>
			<th lay-data="{field:'updateDate', width:180}">更新时间</th>
			<th lay-data="{field:'remarks', width:150}">备注信息</th>
			<shiro:hasPermission name="test:testDataMain:edit">
				<th lay-data="{fixed:'right', width:180, align:'center', toolbar:'#bar'}">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
		</table>
	</div>
	<script type="text/html" id="userTpl">
		<a href="${ctx}/test/testDataMain/form?id={{d.id}}" class="layui-table-link">{{d.user.name}}</a>
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
              location = '${ctx}/test/testDataMain/form?id='+data.id;
		  } else if(layEvent === 'del'){ //删除
			  confirmx('确认要删除该主子表吗？', '${ctx}/test/testDataMain/delete?id='+data.id)
		  }
		});
	});
	</script>
</body>
</html>