<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3}).show();
		});
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
          <table id="treeTable" class="layui-table" lay-even>
            <thead><tr><th>名称</th><th>链接</th><th style="text-align:center;">排序</th><th>可见</th><th>权限标识</th><shiro:hasPermission name="sys:menu:edit"><th>操作</th></shiro:hasPermission></tr></thead>
            <tbody><c:forEach items="${list}" var="menu">
              <tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}">
                <td class="layui-text"><a href="${ctx}/sys/menu/form?id=${menu.id}">${menu.name}</a></td>
                <td title="${menu.href}">${fns:abbreviate(menu.href,30)}</td>
                <td style="text-align:center;">
                  <shiro:hasPermission name="sys:menu:edit">
                    <input type="hidden" name="ids" value="${menu.id}"/>
                    <input name="sorts" type="text" value="${menu.sort}" class="layui-input" style="width:50px;margin:0;padding:0;text-align:center;">
                  </shiro:hasPermission><shiro:lacksPermission name="sys:menu:edit">
                    ${menu.sort}
                  </shiro:lacksPermission>
                </td>
                <td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
                <td title="${menu.permission}">${fns:abbreviate(menu.permission,30)}</td>
                <shiro:hasPermission name="sys:menu:edit"><td nowrap>
                  <a class="layui-btn layui-btn-sm" onclick="openDialog('菜单修改', '${ctx}/sys/menu/form?id=${menu.id}', '75%')"><i class="layui-icon layui-icon-edit"></i>修改</a>
                  <a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)" onclick="deleteItem('要删除该菜单及所有子菜单项吗？', '${ctx}/sys/menu/delete?id=${menu.id}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
                  <a class="layui-btn layui-btn-normal layui-btn-sm" onclick="openDialog('添加下级菜单', '${ctx}/sys/menu/form?parent.id=${menu.id}', '75%')"><i class="layui-icon layui-icon-add-circle-fine"></i>添加下级菜单</a>
                </td></shiro:hasPermission>
              </tr>
            </c:forEach></tbody>
          </table>
          <shiro:hasPermission name="sys:menu:edit">
            <div class="layui-input-block">
              <input id="btnSubmit" class="layui-btn layui-btn-normal" type="button" value="保存排序" onclick="updateSort();"/>
            </div>
          </shiro:hasPermission>
         </form>
      </div>
    </div>
  </div>
</body>
</html>