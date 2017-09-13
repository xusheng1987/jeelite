<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, rootId = "0";
			for (var i=0; i<data.length; i++) {
				$("#treeTableList").append(addRow(tpl, data[i], rootId, true));
			}
            var option = {
                    expandLevel : 1,
                    beforeExpand : function($treeTable, id) {
                        //判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作用
                        if ($('.' + id, $treeTable).length) { return; }
                        //动态加载下一级节点
                        $.get("${ctx}/sys/area/query?id="+id, function(result){
                			for (var i=0; i<result.length; i++) {
                				$treeTable.addChilds(addRow(tpl, result[i], id));
                			}
                        });
                    }
            };
			$("#treeTable").treeTable(option);
		});
		function addRow(tpl, row, pid, root){
				var rowContent;
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					rowContent = Mustache.render(tpl, {
						dict: {
							type: getDictLabel(${fns:toJson(fns:getDictList('sys_area_type'))}, row.type)
						}, pid: (root?0:pid), row: row, hasChild:(row.type!='2'?'hasChild="true"':'')
					});
				}
				return rowContent;
		}
	</script>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/sys/area/">区域列表</a></li>
			<shiro:hasPermission name="sys:area:edit"><li><a href="${ctx}/sys/area/form">区域添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<sys:message content="${message}"/>
	<div style="margin:15px">
	<table id="treeTable" class="layui-table" lay-even>
		<thead><tr><th>区域名称</th><th>区域编码</th><th>区域类型</th><th>备注</th><shiro:hasPermission name="sys:area:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList"></tbody>
	</table>
	</div>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}" {{hasChild}}>
			<td class="layui-text"><a href="${ctx}/sys/area/form?id={{row.id}}">{{row.name}}</a></td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<shiro:hasPermission name="sys:area:edit"><td>
				<a class="layui-btn layui-btn-small" href="${ctx}/sys/area/form?id={{row.id}}"><i class="layui-icon">&#xe642;</i>修改</a>
				<a class="layui-btn layui-btn-danger layui-btn-small" href="javascript:void(0)" onclick="confirmx('要删除该区域及所有子区域项吗？', '${ctx}/sys/area/delete?id={{row.id}}')"><i class="layui-icon">&#xe640;</i>删除</a>
				<a class="layui-btn layui-btn-normal layui-btn-small" href="${ctx}/sys/area/form?parent.id={{row.id}}"><i class="layui-icon">&#xe608;</i>添加下级区域</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>