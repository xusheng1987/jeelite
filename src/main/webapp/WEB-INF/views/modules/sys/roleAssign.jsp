<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>分配角色</title>
</head>
<body>
<div class="layui-fluid">
	<blockquote class="layui-elem-quote">
		<div class="layui-row">
			<div class="layui-col-md4">角色名称: <b>${role.name}</b></div>
			<div class="layui-col-md4">归属机构: ${role.office.name}</div>
		</div>
		<div class="layui-row">
			<c:set var="dictvalue" value="${role.dataScope}" scope="page" />
			<div class="layui-col-md4">数据范围: ${fns:getDictLabel(dictvalue, 'sys_data_scope', '')}</div>
		</div>
	</blockquote>
	<div style="margin:15px">
		<form id="assignRoleForm" action="${ctx}/sys/role/assignrole" method="post" class="hide">
			<input type="hidden" name="id" value="${role.id}"/>
			<input id="idsArr" type="hidden" name="idsArr" value=""/>
		</form>
		<div class="layui-btn-group">
			<button class="layui-btn layui-btn-normal" id="assignButton"><i class="layui-icon layui-icon-delete"></i>分配角色</button>
		</div>
		<script type="text/javascript">
			$("#assignButton").click(function(){
				$.get("${ctx}/sys/role/usertorole?id=${role.id}", function (result) {
					layer.open({
						type: 1,
						title: "分配角色",
						area: ['810px', '500px'],//宽高
						content: result,
						btn: ['确定分配','清除已选','关闭'],
						yes: function(index, layero){//确定按钮的回调
							// 删除''的元素
							if(ids[0]==''){
								ids.shift();
								pre_ids.shift();
							}
							if(pre_ids.sort().toString() == ids.sort().toString()){
								top.layer.msg("未给角色【${role.name}】分配新成员！", {icon: 0});
								return false;
							};
					    	// 执行保存
					    	var idsArr = "";
					    	for (var i = 0; i<ids.length; i++) {
					    		idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '':',');
					    	}
					    	$('#idsArr').val(idsArr);
							// 提交数据
							var loadIndex = layer.load();
							$.post($("#assignRoleForm").attr("action"), $("#assignRoleForm").serialize(), function (result) {
								if (result.code == '200') {
									layer.close(loadIndex);
									layer.close(index);
									reloadTable();
									layer.msg(result.msg, {icon: 1});
								} else {
									layer.close(loadIndex);
									layer.alert(result.msg, {icon: 2});
								}
							});
					    	return true;
						},
						btn2: function(index, layero){//清除按钮的回调
							clearAssign();
							return false;
						}
					});
				});
			});
		</script>
	<table class="layui-table"></table>
	</div>
</div>
  <script type="text/html" id="bar">
	<a class="layui-btn layui-btn-danger layui-btn-sm" href="javascript:void(0)"
		onclick="confirmx('确认要将用户<b>[{{d.name}}]</b>从<b>[${role.name}]</b>角色中移除吗？', '${ctx}/sys/role/outrole?userId={{d.id}}&roleId=${role.id}')"><i class="layui-icon layui-icon-delete"></i>移除</a>
  </script>
  <script type="text/javascript">
    $(document).ready(function() {
      //执行渲染
      table.render({
        url: '${ctx}/sys/role/assign/data?id=${role.id}' //数据接口
        ,cols: [[ //表头
           {title: '归属公司', templet: function(d) {
               return d.company.name
           }}
          ,{title: '归属部门', templet: function(d) {
              return d.office.name
           }}
          ,{field: 'loginName', title: '登录名'}
          ,{field: 'name', title: '姓名'}
          ,{field: 'phone', title: '电话'}
          ,{field: 'mobile', title: '手机'}
          <shiro:hasPermission name="sys:role:edit">
          ,{fixed:'right', align:'center', width:100, title: '操作', toolbar:'#bar'}
          </shiro:hasPermission>
          ]]
      });
    });
  </script>
</body>
</html>