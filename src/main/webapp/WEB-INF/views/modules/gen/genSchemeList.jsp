<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">生成方案列表</div>
      <div class="layui-card-body">
        <div id="searchForm" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">方案名称：</label>
                <div class="layui-input-inline">
                  <input name="name" type="text" maxlength="50" class="layui-input"/>
                </div>
            </div>
            <div class="layui-inline">
              <input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
              <shiro:hasPermission name="gen:genScheme:edit">
              <input id="btnAdd" class="layui-btn" type="button" value="添加" onclick="openDialog('生成方案添加', '${ctx}/gen/genScheme/form', '850px')"/>
              </shiro:hasPermission>
            </div>
          </div>
        </div>
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-sm" onclick="openDialog('生成方案修改', '${ctx}/gen/genScheme/form?id={{d.id}}', '850px')"><i class="layui-icon layui-icon-edit"></i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" onclick="confirmx('确认要删除该生成方案吗？', '${ctx}/gen/genScheme/delete?id={{d.id}}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		//执行渲染
		table.render({
		    url: '${ctx}/gen/genScheme/data' //数据接口
		    ,cols: [[ //表头
		       {field:'name', title: '方案名称', sort: true, templet: function(d) {
                  var url = '${ctx}/gen/genScheme/form?id='+d.id;
                  return '<a href="javascript:void(0)" class="layui-table-link" onclick="openDialog(\'生成方案修改\', \''+url+'\', \'850px\')">'+d.name+'</a>'
		       }}
		      ,{field: 'packageName', title: '生成模块'}
		      ,{field: 'moduleName', title: '模块名'}
		      ,{field: 'functionName', title: '功能名'}
		      ,{field: 'functionAuthor', title: '功能作者'}
		      <shiro:hasPermission name="gen:genScheme:edit">
		      ,{fixed:'right', align:'center', width:180, title: '操作', toolbar:'#bar'}
		      </shiro:hasPermission>
		    ]]
		});
	});
	</script>
</body>
</html>