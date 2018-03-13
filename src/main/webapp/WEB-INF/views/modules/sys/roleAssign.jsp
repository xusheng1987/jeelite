<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分配角色</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li><a href="${ctx}/sys/role/">角色列表</a></li>
			<li class="layui-this"><a href="${ctx}/sys/role/assign?id=${role.id}"><shiro:hasPermission name="sys:role:edit">角色分配</shiro:hasPermission><shiro:lacksPermission name="sys:role:edit">人员列表</shiro:lacksPermission></a></li>
		</ul>
	</div><br/>
	<blockquote class="layui-elem-quote">
		<div class="layui-row">
			<div class="layui-col-md3">角色名称: <b>${role.name}</b></div>
			<div class="layui-col-md3">归属机构: ${role.office.name}</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md3">角色类型: ${role.roleType}</div>
			<c:set var="dictvalue" value="${role.dataScope}" scope="page" />
			<div class="layui-col-md3">数据范围: ${fns:getDictLabel(dictvalue, 'sys_data_scope', '')}</div>
		</div>
	</blockquote>
	<sys:message content="${message}"/>
	<div style="margin:15px">
		<form id="assignRoleForm" action="${ctx}/sys/role/assignrole" method="post" class="hide">
			<input type="hidden" name="id" value="${role.id}"/>
			<input id="idsArr" type="hidden" name="idsArr" value=""/>
		</form>
		<div class="layui-btn-group">
			<button type="submit" class="layui-btn layui-btn-normal" id="assignButton"><i class="layui-icon">&#xe640;</i>分配角色</button>
		</div>
		<script type="text/javascript">
			$("#assignButton").click(function(){
				var layer = layui.layer;
				layer.open({
					type: 2,
					title: "分配角色",
					area: ['810px', '500px'],//宽高
					content: "${ctx}/sys/role/usertorole?id=${role.id}",
					btn: ['确定分配','清除已选','关闭'],
					yes: function(index, layero){//确定按钮的回调
						var pre_ids = layero.find("iframe")[0].contentWindow.pre_ids;
						var ids = layero.find("iframe")[0].contentWindow.ids;
						// 删除''的元素
						if(ids[0]==''){
							ids.shift();
							pre_ids.shift();
						}
						if(pre_ids.sort().toString() == ids.sort().toString()){
							layer.msg("未给角色【${role.name}】分配新成员！", {icon: 0});
							return false;
						};
				    	// 执行保存
				    	loading();
				    	var idsArr = "";
				    	for (var i = 0; i<ids.length; i++) {
				    		idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '':',');
				    	}
				    	$('#idsArr').val(idsArr);
						layer.close(index);
				    	$('#assignRoleForm').submit();
				    	return true;
					},
					btn2: function(index, layero){//清除按钮的回调
						layero.find("iframe")[0].contentWindow.clearAssign();
						return false;
					}
				});
			});
		</script>
	<table id="contentTable" class="layui-table" lay-even>
		<thead><tr><th>归属公司</th><th>归属部门</th><th>登录名</th><th>姓名</th><th>电话</th><th>手机</th><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${userList}" var="user">
			<tr>
				<td>${user.company.name}</td>
				<td>${user.office.name}</td>
				<td class="layui-text"><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
				<td>${user.name}</td>
				<td>${user.phone}</td>
				<td>${user.mobile}</td>
				<shiro:hasPermission name="sys:role:edit">
					<td>
						<a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)"
							onclick="confirmx('确认要将用户<b>[${user.name}]</b>从<b>[${role.name}]</b>角色中移除吗？', '${ctx}/sys/role/outrole?userId=${user.id}&roleId=${role.id}')"><i class="layui-icon">&#xe640;</i>移除</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
</body>
</html>