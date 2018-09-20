<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">字典列表</div>
      <div class="layui-card-body">
        <div id="searchForm" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">类型：</label>
              <div class="layui-input-inline">
                <select name="type">
                  <option value=""></option>
                  <c:forEach items="${typeList}" var="e">
                  <option value="${e}">${e}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">描述：</label>
              <div class="layui-input-inline">
                <input name="description" type="text" maxlength="50" class="layui-input"/>
              </div>
            </div>
            <div class="layui-inline">
              <input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
              <shiro:hasPermission name="sys:dict:edit"><input id="btnAdd" class="layui-btn" type="button" value="添加" onclick="openDialog('字典添加', '${ctx}/sys/dict/form?sort=10')"/></shiro:hasPermission>
            </div>
          </div>
        </div>
        <div class="layui-btn-group">
          <button class="layui-btn layui-btn-danger layui-btn-disabled" id="btnDelete" disabled><i class="layui-icon layui-icon-delete"></i>批量删除</button>
        </div>
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-sm" onclick="openDialog('字典修改', '${ctx}/sys/dict/form?id={{d.id}}')"><i class="layui-icon layui-icon-edit"></i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" onclick="confirmx('确认要删除该字典吗？', '${ctx}/sys/dict/delete?id={{d.id}}')"><i class="layui-icon layui-icon-delete"></i>删除</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-normal layui-btn-sm" onclick="openDialog('字典添加', '${ctx}/sys/dict/form?description={{d.description}}&type={{d.type}}&sort={{d.sort+10}}')"><i class="layui-icon layui-icon-add-circle-fine"></i>添加键值</a>
	</script>
	<script type="text/javascript">
	function typeFilter(type) {
		$('#type').val(type);
		form.render();
		reloadTable();
	}
	$(document).ready(function() {
		//执行渲染
		table.render({
		    url: '${ctx}/sys/dict/data' //数据接口
		    ,cols: [[ //表头
		       {type: 'checkbox', fixed:'left'}
		      ,{field: 'value',title: '键值'}
		      ,{title: '标签', templet: function(d) {
                  var url = '${ctx}/sys/dict/form?id='+d.id;
                  return '<a href="javascript:void(0)" class="layui-table-link" onclick="openDialog(\'字典修改\', \''+url+'\')">'+d.label+'</a>'
		       }}
		      ,{title: '类型', templet: function(d) {
		          return '<a href="javascript:void(0)" class="layui-table-link" onclick="typeFilter(\''+d.type+'\')">'+d.type+'</a>'
		       }}
		      ,{field: 'description', title: '描述'}
		      ,{field: 'sort', title: '排序'}
		      <shiro:hasPermission name="sys:dict:edit">
		      ,{fixed:'right', align:'center', width:300, title: '操作', toolbar:'#bar'}
		      </shiro:hasPermission>
		    ]]
		});
		//批量删除
		$('#btnDelete').on('click', function(){
			batchDelete('${ctx}/sys/dict/batchDelete');
		});
	});
	</script>
</body>
</html>