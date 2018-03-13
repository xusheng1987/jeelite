<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务表管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/gen/genTable/">业务表列表</a></li>
			<shiro:hasPermission name="gen:genTable:edit"><li><a href="${ctx}/gen/genTable/form">业务表添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<form:form id="searchForm" modelAttribute="genTable" class="layui-form">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">表名：</label>
				<div class="layui-input-inline">
					<form:input path="nameLike" htmlEscape="false" maxlength="50" class="layui-input input-medium"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">说明：</label>
				<div class="layui-input-inline">
					<form:input path="comments" htmlEscape="false" maxlength="50" class="layui-input input-medium"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">父表表名：</label>
				<div class="layui-input-inline">
					<form:input path="parentTable" htmlEscape="false" maxlength="50" class="layui-input input-medium"/>
				</div>
			</div>
			<div class="layui-inline" style="margin-left:30px">
				<input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
			</div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<div style="margin:15px">
		<div class="layui-btn-group">
			<button class="layui-btn layui-btn-danger layui-btn-disabled" id="btnDelete" disabled><i class="layui-icon">&#xe640;</i>批量删除</button>
		</div>
		<table class="layui-table"></table>
	</div>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-sm" lay-event="edit"><i class="layui-icon">&#xe642;</i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		var table = layui.table;
		//执行渲染
		table.render({
		    url: '${ctx}/gen/genTable/data' //数据接口
		    ,cols: [[ //表头
		       {type: 'checkbox', fixed:'left'}
		      ,{field:'name', title: '表名', sort: true, templet: function(d) {
		          return '<a href="${ctx}/gen/genTable/form?id='+d.id+'" class="layui-table-link">'+d.name+'</a>'
		       }}
		      ,{field: 'comments', title: '说明'}
		      ,{field: 'className', sort: true, title: '类名'}
		      ,{field: 'parentTable', title: '父表'}
		      <shiro:hasPermission name="gen:genTable:edit">
		      ,{fixed:'right', align:'center', width:180, title: '操作', toolbar:'#bar'}
		      </shiro:hasPermission>
		    ]]
		});
		//监听工具条
		table.on('tool', function(obj){
		  var data = obj.data; //获得当前行数据
		  var layEvent = obj.event; //获得 lay-event 对应的值
		  if(layEvent === 'edit'){ //修改
              location = '${ctx}/gen/genTable/form?id='+data.id;
		  } else if(layEvent === 'del'){ //删除
			  confirmx('确认要删除该业务表吗？', '${ctx}/gen/genTable/delete?id='+data.id)
		  }
		});
		//批量删除
		$('#btnDelete').on('click', function(){
			batchDelete('${ctx}/gen/genTable/batchDelete');
		});
	});
	</script>
</body>
</html>