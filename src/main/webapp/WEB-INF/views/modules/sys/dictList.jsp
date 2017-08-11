<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/dict/">字典列表</a></li>
		<shiro:hasPermission name="sys:dict:edit"><li><a href="${ctx}/sys/dict/form?sort=10">字典添加</a></li></shiro:hasPermission>
	</ul>
	<div id="searchForm" class="breadcrumb form-search">
		<label>类型：</label>
		<select id="type" name="type" class="input-medium">
			<option value=""></option>
			<c:forEach items="${typeList}" var="type">
				<option value="${type}">${type}</option>
			</c:forEach>
		</select>&nbsp;&nbsp;
		<label>描述 ：</label>
		<input type="text" name="description" id="description" maxlength="50" class="input-medium"/>&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</div>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/sys/dict/data">
		<thead>
		<tr>
			<th data-field="value">键值</th>
			<th data-field="label" data-formatter="labelFormatter">标签</th>
			<th data-field="type" data-events="typeEvents" data-formatter="typeFormatter">类型</th>
			<th data-field="description">描述</th>
			<th data-field="sort">排序</th>
			<shiro:hasPermission name="sys:dict:edit">
			<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
	</table>
	<script type="text/javascript">
		function labelFormatter(value, row, index){
	        return '<a href="${ctx}/sys/dict/form?id='+row.id+'">' + value + '</a>';
	    }
		function typeFormatter(value, row, index){
	        return '<a id="resultType" href="javascript:">'+value+'</a>';
	    }
	    function operateFormatter(value, row, index) {
	        return [
	            '<a class="form" href="javascript:void(0)">修改</a>  ',
	            '<a class="delete" href="javascript:void(0)">删除</a>  ',
	            '<a class="insert" href="javascript:void(0)">添加键值</a>'
	        ].join('');
	    }
	    window.typeEvents = {
	            'click #resultType': function (e, value, row, index) {
	            	$('#type').select2("val", value);
	            	$('#table').bootstrapTable('refresh', {query: {offset: '0'}});
	            }
	    };
	    window.operateEvents = {
	            'click .form': function (e, value, row, index) {
	                location = '${ctx}/sys/dict/form?id='+row.id;
	            },
	            'click .delete': function (e, value, row, index) {
	                return confirmxx('确认要删除该字典吗？', '${ctx}/sys/dict/delete?id='+row.id);
	            },
	            'click .insert': function (e, value, row, index) {
	                location = '${ctx}/sys/dict/form?description='+row.description+'&type='+row.type+'&sort='+(row.sort+10);
	            }
	    };
	</script>
</body>
</html>