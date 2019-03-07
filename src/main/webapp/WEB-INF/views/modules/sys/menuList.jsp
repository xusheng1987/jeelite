<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			reloadTree();
		});
		function reloadTree() {
			var laytpl = layui.laytpl;
			$.get("${ctx}/sys/menu/data", function(data){
				laytpl(treeTableTpl.innerHTML).render(data, function(html){
					$("#treeTableList").html(html);
				});
				$("#treeTable").treeTable({expandLevel : 3});
			});
		}
		function updateSort() {
			var loadIndex = layer.load();
			$.post("${ctx}/sys/menu/updateSort", $("#listForm").serialize(), function (result) {
				layer.close(loadIndex);
				if (result.code == '200') {
					layer.msg(result.msg, {icon: 1});
				} else {
					layer.alert(result.msg, {icon: 2});
				}
			});
    	}
	</script>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">菜单列表</div>
      <div class="layui-card-body">
        <div class="layui-inline">
          <shiro:hasPermission name="sys:menu:edit">
          <input class="layui-btn" type="button" value="添加" onclick="openDialog('菜单添加', '${ctx}/sys/menu/form', '75%')"/>
          </shiro:hasPermission>
         </div>
         <form id="listForm" style="margin-top:15px">
         <table id="treeTable" class="layui-table" style="margin-top:15px" lay-even>
           <thead><tr><th>名称</th><th>链接</th><th>排序</th><th>可见</th><th>权限标识</th><shiro:hasPermission name="sys:menu:edit"><th>操作</th></shiro:hasPermission></tr></thead>
           <tbody id="treeTableList"></tbody>
         </table>
         </form>
         <shiro:hasPermission name="sys:menu:edit">
           <div class="layui-input-block">
             <input id="btnSubmit" class="layui-btn layui-btn-normal" type="button" value="保存排序" onclick="updateSort();"/>
           </div>
         </shiro:hasPermission>
      </div>
    </div>
  </div>
	<script type="text/html" id="treeTableTpl">
	{{#  layui.each(d, function(index, item){ }}
		<tr id="{{item.id}}" pId="{{item.parentId != '1' ? item.parentId : '0'}}">
			<td class="layui-text"><a href="javascript:void(0)" onclick="openDialog('菜单修改', '${ctx}/sys/menu/form?id={{item.id}}')">{{item.name}}</a></td>
			<td>{{item.href}}</td>
			<td>
				<shiro:hasPermission name="sys:menu:edit">
					<input type="hidden" name="ids" value="{{item.id}}"/>
					<input name="sorts" type="text" value="{{item.sort}}" class="layui-input" style="width:50px;margin:0;padding:0;text-align:center;">
				</shiro:hasPermission>
				<shiro:lacksPermission name="sys:menu:edit">{{item.sort}}</shiro:lacksPermission>
			</td>
			<td>{{item.isShow == '1'?'显示':'隐藏'}}</td>
			<td title="{{item.permission}}">{{ abbr(item.permission, 40) }}</td>
			<shiro:hasPermission name="sys:menu:edit"><td>
				<a class="layui-btn layui-btn-sm" href="javascript:void(0)" onclick="openDialog('菜单修改', '${ctx}/sys/menu/form?id={{item.id}}', '75%')"><i class="layui-icon layui-icon-edit"></i>修改</a>
				<a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)" onclick="confirmx('要删除该菜单及所有子菜单项吗？', '${ctx}/sys/menu/delete?id={{item.id}}', true)"><i class="layui-icon layui-icon-delete"></i>删除</a>
				<a class="layui-btn layui-btn-normal layui-btn-sm" href="javascript:void(0)" onclick="openDialog('添加下级菜单', '${ctx}/sys/menu/form?parent.id={{item.id}}', '75%')"><i class="layui-icon layui-icon-add-circle-fine"></i>添加下级菜单</a>
			</td></shiro:hasPermission>
		</tr>
	{{#  }); }}
	</script>
</body>
</html>