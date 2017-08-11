<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务表管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/gen/genTable/">业务表列表</a></li>
		<shiro:hasPermission name="gen:genTable:edit"><li><a href="${ctx}/gen/genTable/form">业务表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="genTable" class="breadcrumb form-search">
		<label>表名：</label><form:input path="nameLike" htmlEscape="false" maxlength="50" class="input-medium"/>
		<label>说明：</label><form:input path="comments" htmlEscape="false" maxlength="50" class="input-medium"/>
		<label>父表表名：</label><form:input path="parentTable" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/gen/genTable/data">
		<thead>
		<tr>
			<th data-field="name" data-sortable="true" data-formatter="nameFormatter">表名</th>
			<th data-field="comments">说明</th>
			<th data-field="className" data-sortable="true" data-sort-name="class_name">类名</th>
			<th data-field="parentTable" data-sortable="true" data-sort-name="parent_table">父表</th>
			<shiro:hasPermission name="gen:genTable:edit">
			<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
	</table>
	<script>
	function nameFormatter(value, row, index){
        return '<a href="${ctx}/gen/genTable/form?id='+row.id+'">'+value+'</a>';
    }
    function operateFormatter(value, row, index) {
        return [
            '<a class="form" href="javascript:void(0)">修改</a>  ',
            '<a class="delete" href="javascript:void(0)">删除</a>'
        ].join('');
    }
    window.operateEvents = {
        'click .form': function (e, value, row, index) {
            location = '${ctx}/gen/genTable/form?id='+row.id;
        },
        'click .delete': function (e, value, row, index) {
            return confirmxx('确认要删除该业务表吗？', '${ctx}/gen/genTable/delete?id='+row.id);
        }
    };
	</script>
</body>
</html>
