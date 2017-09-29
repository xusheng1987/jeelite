<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, rootId = "${not empty office.id ? office.id : '0'}";
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
							type: getDictLabel(${fns:toJson(fns:getDictList('sys_office_type'))}, row.type)
						}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/sys/office/list">机构列表</a></li>
			<shiro:hasPermission name="sys:office:edit"><li><a href="${ctx}/sys/office/form?parent.id=${office.id}">机构添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<sys:message content="${message}"/>
	<div style="margin:15px">
	<table id="treeTable" class="layui-table" lay-even>
		<thead><tr><th>机构名称</th><th>机构编码</th><th>机构类型</th><th>备注</th><shiro:hasPermission name="sys:office:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	</div>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td class="layui-text"><a href="${ctx}/sys/office/form?id={{row.id}}">{{row.name}}</a></td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<shiro:hasPermission name="sys:office:edit"><td>
				<a class="layui-btn layui-btn-small" href="${ctx}/sys/office/form?id={{row.id}}"><i class="layui-icon">&#xe642;</i>修改</a>
				<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:void(0)" onclick="confirmx('要删除该机构及所有子机构项吗？', '${ctx}/sys/office/delete?id={{row.id}}')"><i class="layui-icon">&#xe640;</i>删除</a>
				<a class="layui-btn layui-btn-normal layui-btn-small" href="${ctx}/sys/office/form?parent.id={{row.id}}"><i class="layui-icon">&#xe608;</i>添加下级机构</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>