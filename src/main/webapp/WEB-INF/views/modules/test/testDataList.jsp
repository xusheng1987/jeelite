<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/test/testData/">单表列表</a></li>
			<shiro:hasPermission name="test:testData:edit"><li><a href="${ctx}/test/testData/form">单表添加</a></li></shiro:hasPermission>
		</ul>
	</div><br/>
	<form:form id="searchForm" modelAttribute="testData" class="layui-form">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}"
					title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">归属部门：</label>
				<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}"
					title="部门" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true"/>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">名称：</label>
				<div class="layui-input-inline">
					<form:input path="name" htmlEscape="false" maxlength="100" class="layui-input input-medium"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">性别：</label>
				<div class="layui-input-inline" style="width:auto">
					<c:forEach items="${fns:getDictList('sex')}" var="dict">
						<input type="radio" name="sex" value="${dict.value}" title="${dict.label}">
					</c:forEach>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">加入日期：</label>
				<div class="layui-input-inline input-medium">
					<input name="beginInDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
						value="<fmt:formatDate value="${testData.beginInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline input-medium">
					<input name="endInDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
						value="<fmt:formatDate value="${testData.endInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				</div>
			</div>
			<div class="layui-inline">
				<input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
			</div>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<div style="margin:15px">
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
		    url: '${ctx}/test/testData/data' //数据接口
		    ,cols: [[ //表头
		       {title: '归属用户', templet: function(d) {
		          return '<a href="${ctx}/test/testData/form?id='+d.id+'" class="layui-table-link">'+d.user.name+'</a>'
		       }}
		      ,{title: '归属部门', templet: function(d) {
		          return d.office.name
		       }}
		      ,{field: 'name', title: '名称'}
		      ,{field: 'updateDate', title: '更新时间'}
		      ,{field: 'remarks', title: '备注信息'}
		      <shiro:hasPermission name="test:testData:edit">
		      ,{fixed:'right', align:'center', width:180, title: '操作', toolbar:'#bar'}
		      </shiro:hasPermission>
		    ]]
		});
		//监听工具条
		table.on('tool', function(obj){
		  var data = obj.data; //获得当前行数据
		  var layEvent = obj.event; //获得 lay-event 对应的值
		  if(layEvent === 'edit'){ //修改
              location = '${ctx}/test/testData/form?id='+data.id;
		  } else if(layEvent === 'del'){ //删除
			  confirmx('确认要删除该单表吗？', '${ctx}/test/testData/delete?id='+data.id)
		  }
		});
	});
	</script>
</body>
</html>