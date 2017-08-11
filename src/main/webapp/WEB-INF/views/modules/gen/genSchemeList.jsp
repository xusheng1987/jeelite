<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>生成方案管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/gen/genScheme/">生成方案列表</a></li>
		<shiro:hasPermission name="gen:genScheme:edit"><li><a href="${ctx}/gen/genScheme/form">生成方案添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="genScheme" class="breadcrumb form-search">
		<label>方案名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/gen/genScheme/data">
		<thead>
		<tr>
			<th data-field="name" data-formatter="nameFormatter">方案名称</th>
			<th data-field="packageName">生成模块</th>
			<th data-field="moduleName">模块名</th>
			<th data-field="functionName">功能名</th>
			<th data-field="functionAuthor">功能作者</th>
			<shiro:hasPermission name="gen:genScheme:edit">
			<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
	</table>
	<script>
	function nameFormatter(value, row, index){
        return '<a href="${ctx}/gen/genScheme/form?id='+row.id+'">'+value+'</a>';
    }
    function operateFormatter(value, row, index) {
        return [
            '<a class="form" href="javascript:void(0)">修改</a>  ',
            '<a class="delete" href="javascript:void(0)">删除</a>'
        ].join('');
    }
    window.operateEvents = {
        'click .form': function (e, value, row, index) {
            location = '${ctx}/gen/genScheme/form?id='+row.id;
        },
        'click .delete': function (e, value, row, index) {
            return confirmxx('确认要删除该生成方案吗？', '${ctx}/gen/genScheme/delete?id='+row.id);
        }
    };
	</script>
</body>
</html>