<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
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
			<li class="layui-this"><a href="${ctx}/sys/office/list">机构列表</a></li>
			<shiro:hasPermission name="sys:office:edit"><li><a href="${ctx}/sys/office/form?parent.id=${office.id}">机构添加</a></li></shiro:hasPermission>
		</ul>
	</div>
	<sys:message content="${message}"/>
	<div style="margin:15px">
	<table id="treeTable" class="layui-table" lay-even>
		<thead><tr><th>机构名称</th><th>机构编码</th><th>机构类型</th><th>备注</th><shiro:hasPermission name="sys:office:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	</div>
	<script type="text/html" id="treeTableTpl">
	{{#  var typeData = ${fns:getDictListJson('sys_office_type')}; }}
	{{#  layui.each(d, function(index, item){ }}
		<tr id="{{item.id}}" pId="{{item.parentId}}">
			<td class="layui-text"><a href="${ctx}/sys/office/form?id={{item.id}}">{{item.name}}</a></td>
			<td>{{item.code}}</td>
			<td>{{getDictLabel(typeData, item.type)}}</td>
			<td>{{item.remarks}}</td>
			<shiro:hasPermission name="sys:office:edit"><td>
				<a class="layui-btn layui-btn-sm" href="${ctx}/sys/office/form?id={{item.id}}"><i class="layui-icon layui-icon-edit"></i>修改</a>
				<a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)" onclick="confirmx('要删除该机构及所有子机构项吗？', '${ctx}/sys/office/delete?id={{item.id}}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
				<a class="layui-btn layui-btn-normal layui-btn-sm" href="${ctx}/sys/office/form?parent.id={{item.id}}"><i class="layui-icon layui-icon-add-circle-fine"></i>添加下级机构</a>
			</td></shiro:hasPermission>
		</tr>
	{{#  }); }}
	</script>
</body>
</html>