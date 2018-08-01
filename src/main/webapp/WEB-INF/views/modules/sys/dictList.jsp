<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/sys/dict/">字典列表</a></li>
			<shiro:hasPermission name="sys:dict:edit"><li><a href="${ctx}/sys/dict/form?sort=10">字典添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<form:form id="searchForm" modelAttribute="dict" class="layui-form">
	<div class="layui-form-item">
		<label class="layui-form-label">类型：</label>
		<div class="layui-input-inline" style="width:160px">
			<form:select id="type" path="type">
				<form:option value="" label=""/>
				<form:options items="${typeList}" htmlEscape="false"/>
			</form:select>
		</div>
		<label class="layui-form-label">描述 ：</label>
		<div class="layui-input-inline">
			<form:input path="description" htmlEscape="false" maxlength="50" class="layui-input input-medium"/>
		</div>
		<input id="btnSearch" class="layui-btn layui-btn-normal" style="margin-left:50px" type="button" value="查询"/>
	</div>
	</form:form>
	<sys:message content="${message}"/>
	<div style="margin:15px">
		<div class="layui-btn-group">
			<button class="layui-btn layui-btn-danger layui-btn-disabled" id="btnDelete" disabled><i class="layui-icon layui-icon-delete"></i>批量删除</button>
		</div>
		<table class="layui-table"></table>
	</div>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-sm" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-normal layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加键值</a>
	</script>
	<script type="text/javascript">
	function typeFilter(type) {
		$('#type').val(type);
		layui.form.render();
		reloadTable();
	}
	$(document).ready(function() {
		var table = layui.table;
		//执行渲染
		table.render({
		    url: '${ctx}/sys/dict/data' //数据接口
		    ,cols: [[ //表头
		       {type: 'checkbox', fixed:'left'}
		      ,{field: 'value',title: '键值'}
		      ,{title: '标签', templet: function(d) {
		          return '<a href="${ctx}/sys/dict/form?id='+d.id+'" class="layui-table-link">'+d.label+'</a>'
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
		//监听工具条
		table.on('tool', function(obj){
		  var data = obj.data; //获得当前行数据
		  var layEvent = obj.event; //获得 lay-event 对应的值
		  if(layEvent === 'edit'){ //修改
              location = '${ctx}/sys/dict/form?id='+data.id;
		  } else if(layEvent === 'del'){ //删除
			  confirmx('确认要删除该字典吗？', '${ctx}/sys/dict/delete?id='+data.id)
		  } else if(layEvent === 'add'){ //添加键值
              location = '${ctx}/sys/dict/form?description='+data.description+'&type='+data.type+'&sort='+(data.sort+10);
		  }
		});
		//批量删除
		$('#btnDelete').on('click', function(){
			batchDelete('${ctx}/sys/dict/batchDelete');
		});
	});
	</script>
</body>
</html>