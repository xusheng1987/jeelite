<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var layer = layui.layer;
			$("#btnExport").click(function(){
				layer.confirm("确认要导出用户数据吗？", {icon: 3, title:'系统提示'}, function(index){
					$("#searchForm").attr("action","${ctx}/sys/user/export");
					$("#searchForm").submit();
					layer.close(index);
				});
			});
			$("#btnImport").click(function(){
				layer.open({
					type: 1,
					title: "导入数据",
					content: $("#importBox").html(),
					btn: "关闭"
				});
			});
		});
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading();"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>
			<button type="submit" class="layui-btn" id="btnImportSubmit"><i class="layui-icon">&#xe67c;</i>导    入</button>
			<span class="layui-text"><a href="${ctx}/sys/user/import/template">下载模板</a></span>
		</form>
	</div>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/sys/user/list">用户列表</a></li>
			<shiro:hasPermission name="sys:user:edit"><li><a href="${ctx}/sys/user/form">用户添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<form:form id="searchForm" modelAttribute="user" class="layui-form">
		<div class="layui-form-item" style="margin:0px">
			<div class="layui-inline">
				<label class="layui-form-label">归属公司：</label>
				<sys:treeselect id="company" name="company.id" value="" labelName="company.name" labelValue="" 
					title="公司" url="/sys/office/treeData?type=1" allowClear="true"/>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">登录名：</label>
				<div class="layui-input-inline">
					<form:input path="loginName" htmlEscape="false" maxlength="50" class="layui-input input-medium"/>
				</div>
			</div>
		</div>
		<div class="layui-form-item" style="margin:0px">
			<div class="layui-inline">
				<label class="layui-form-label">归属部门：</label>
				<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
					title="部门" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true"/>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">姓&nbsp;&nbsp;&nbsp;名：</label>
				<div class="layui-input-inline">
					<form:input path="name" htmlEscape="false" maxlength="50" class="layui-input input-medium"/>
				</div>
			</div>
			<div class="layui-inline" style="margin-left:30px">
				<input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
				<input id="btnExport" class="layui-btn layui-btn-normal" type="button" value="导出"/>
				<input id="btnImport" class="layui-btn layui-btn-normal" type="button" value="导入"/>
			</div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<div style="margin:0px">
		<div class="layui-btn-group">
			<button class="layui-btn layui-btn-danger layui-btn-disabled" id="btnDelete" disabled><i class="layui-icon">&#xe640;</i>批量删除</button>
		</div>
		<table class="layui-table" lay-data="{id:'table', height:471, even:true, url:'${ctx}/sys/user/data', where:queryParams(), request: {pageName: 'pageNo'}, page:true, limit:10}">
		<thead>
		<tr>
			<th lay-data="{checkbox:true, fixed:true}"></th>
			<th lay-data="{width:150, templet:'#companyTpl'}">归属公司</th>
			<th lay-data="{width:120, templet:'#officeTpl'}">归属部门</th>
			<th lay-data="{width:150, sort: true, templet:'#loginNameTpl'}">登录名</th>
			<th lay-data="{field:'name', width:180, sort: true}">姓名</th>
			<th lay-data="{field:'phone', width:150}">电话</th>
			<shiro:hasPermission name="sys:user:edit">
				<th lay-data="{fixed:'right', width:180, align:'center', toolbar:'#bar'}">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
		</table>
	</div>
	<script type="text/html" id="companyTpl">
		{{d.company.name}}
	</script>
	<script type="text/html" id="officeTpl">
		{{d.office.name}}
	</script>
	<script type="text/html" id="loginNameTpl">
		<a href="${ctx}/sys/user/form?id={{d.id}}" class="layui-table-link">{{d.loginName}}</a>
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
              location = '${ctx}/sys/user/form?id='+data.id;
		  } else if(layEvent === 'del'){ //删除
			  confirmx('确认要删除该用户吗？', '${ctx}/sys/user/delete?id='+data.id)
		  }
		});
		//批量删除
		$('#btnDelete').on('click', function(){
			batchDelete('${ctx}/sys/user/batchDelete');
		});
	});
	</script>
</body>
</html>