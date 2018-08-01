<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/sys/role/">角色列表</a></li>
		<shiro:hasPermission name="sys:role:edit"><li><a href="${ctx}/sys/role/form">角色添加</a></li></shiro:hasPermission>
		</ul>
	</div>
	<sys:message content="${message}"/>
	<div style="margin:15px">
	<table id="contentTable" class="layui-table" lay-even>
		<tr><th>角色名称</th><th>归属机构</th><th>数据范围</th><shiro:hasPermission name="sys:role:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${list}" var="role">
			<tr>
				<td><a href="form?id=${role.id}">${role.name}</a></td>
				<td>${role.office.name}</td>
				<td>${fns:getDictLabel(role.dataScope, 'sys_data_scope', '无')}</td>
				<shiro:hasPermission name="sys:role:edit"><td>
					<a class="layui-btn layui-btn-normal layui-btn-sm" href="${ctx}/sys/role/assign?id=${role.id}"><i class="layui-icon layui-icon-add-circle-fine"></i>分配</a>
					<a class="layui-btn layui-btn-sm" href="${ctx}/sys/role/form?id=${role.id}"><i class="layui-icon layui-icon-edit"></i>修改</a>
					<a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)" onclick="confirmx('确认要删除该角色吗？', '${ctx}/sys/role/delete?id=${role.id}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	</div>
</body>
</html>