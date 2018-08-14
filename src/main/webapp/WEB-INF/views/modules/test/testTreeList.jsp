<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>树结构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var laytpl = layui.laytpl;
			var data = ${fns:toJson(list)};
			laytpl(treeTableTpl.innerHTML).render(data, function(html){
				$("#treeTableList").html(html);
			});
			$("#treeTable").treeTable({expandLevel : 5});
		});
	</script>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/test/testTree/">树结构列表</a></li>
			<shiro:hasPermission name="test:testTree:edit"><li><a href="${ctx}/test/testTree/form">树结构添加</a></li></shiro:hasPermission>
		</ul>
	</div>
	<sys:message content="${message}"/>
	<div style="margin:15px">
	<table id="treeTable" class="layui-table" lay-even>
		<thead>
			<tr>
				<th>名称</th>
				<th>排序</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="test:testTree:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	</div>
	<script type="text/html" id="treeTableTpl">
	{{#  layui.each(d, function(index, item){ }}
		<tr id="{{item.id}}" pId="{{item.parentId}}">
			<td class="layui-text"><a href="${ctx}/test/testTree/form?id={{item.id}}">
				{{item.name}}
			</a></td>
			<td>
				{{item.sort}}
			</td>
			<td>
				{{item.updateDate}}
			</td>
			<td>
				{{item.remarks}}
			</td>
			<shiro:hasPermission name="test:testTree:edit"><td>
   				<a class="layui-btn layui-btn-sm" href="${ctx}/test/testTree/form?id={{item.id}}"><i class="layui-icon layui-icon-edit"></i>修改</a>
				<a class="layui-btn layui-btn-danger layui-btn-sm" onclick="confirmx('确认要删除该树结构及所有子树结构吗？', '${ctx}/test/testTree/delete?id={{item.id}}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
				<a class="layui-btn layui-btn-normal layui-btn-sm" href="${ctx}/test/testTree/form?parent.id={{item.id}}"><i class="layui-icon layui-icon-add-circle-fine"></i>添加下级树结构</a>
			</td></shiro:hasPermission>
		</tr>
	{{#  }); }}
	</script>
</body>
</html>