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
		<table class="layui-table" lay-data="{id:'table', height:471, even:true, url:'${ctx}/gen/genTable/data', where:queryParams(), request: {pageName: 'pageNo'}, page:true, limit:10}">
		<thead>
		<tr>
			<th lay-data="{checkbox:true, fixed:true}"></th>
			<th lay-data="{field:'name', width:150, sort: true, templet:'#nameTpl'}">表名</th>
			<th lay-data="{field:'comments', width:120}">说明</th>
			<th lay-data="{field:'className', width:150}">类名</th>
			<th lay-data="{field:'parentTable', width:150}">父表</th>
			<shiro:hasPermission name="gen:genTable:edit">
				<th lay-data="{fixed:'right', width:180, align:'center', toolbar:'#bar'}">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
		</table>
	</div>
	<script type="text/html" id="nameTpl">
		<a href="${ctx}/gen/genTable/form?id={{d.id}}" class="layui-table-link">{{d.name}}</a>
	</script>
	<script type="text/html" id="bar">
		<a href="javascript:void(0)" class="layui-btn layui-btn-small" lay-event="edit"><i class="layui-icon">&#xe642;</i>修改</a>
		<a href="javascript:void(0)" class="layui-btn layui-btn-danger layui-btn-small" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		var table = layui.table;
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