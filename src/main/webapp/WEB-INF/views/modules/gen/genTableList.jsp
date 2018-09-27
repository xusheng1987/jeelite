<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务表管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">业务表列表</div>
      <div class="layui-card-body">
        <div id="searchForm" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">表名：</label>
              <div class="layui-input-inline">
                <input name="nameLike" type="text" maxlength="50" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">说明：</label>
              <div class="layui-input-inline">
                <input name="comments" type="text" maxlength="50" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">父表表名：</label>
              <div class="layui-input-inline">
                <input name="parentTable" type="text" maxlength="50" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline" style="margin-left:30px">
              <input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
              <shiro:hasPermission name="gen:genTable:edit">
              <input id="btnAdd" class="layui-btn" type="button" value="添加" onclick="openDialog('业务表添加', '${ctx}/gen/genTable/form', '100%', '100%')"/>
              </shiro:hasPermission>
            </div>
          </div>
        </div>
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-sm" onclick="openDialog('业务表修改', '${ctx}/gen/genTable/next/form?id={{d.id}}', '100%', '100%')"><i class="layui-icon layui-icon-edit"></i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" onclick="confirmx('确认要删除该业务表吗？', '${ctx}/gen/genTable/delete?id={{d.id}}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		//执行渲染
		table.render({
		    url: '${ctx}/gen/genTable/data' //数据接口
		    ,cols: [[ //表头
		       {type: 'checkbox', fixed:'left'}
		      ,{field:'name', title: '表名', sort: true, templet: function(d) {
                  var url = '${ctx}/gen/genTable/form?id='+d.id;
                  return '<a href="javascript:void(0)" class="layui-table-link" onclick="openDialog(\'业务表修改\', \''+url+'\')">'+d.name+'</a>'
		       }}
		      ,{field: 'comments', title: '说明'}
		      ,{field: 'className', sort: true, title: '类名'}
		      ,{field: 'parentTable', title: '父表'}
		      <shiro:hasPermission name="gen:genTable:edit">
		      ,{fixed:'right', align:'center', width:180, title: '操作', toolbar:'#bar'}
		      </shiro:hasPermission>
		    ]]
		});
	});
	</script>
</body>
</html>