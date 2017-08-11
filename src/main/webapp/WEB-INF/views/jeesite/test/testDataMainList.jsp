<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>主子表管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/test/testDataMain/">主子表列表</a></li>
		<shiro:hasPermission name="test:testDataMain:edit"><li><a href="${ctx}/test/testDataMain/form">主子表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testDataMain" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testDataMain.user.id}" labelName="user.name" labelValue="${testDataMain.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="sex" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/test/testDataMain/data">
		<thead>
			<tr>
				<th data-field="user.name" data-formatter="nameFormatter">归属用户</th>
				<th data-field="name">名称</th>
				<th data-field="updateDate">更新时间</th>
				<th data-field="remarks">备注信息</th>
				<shiro:hasPermission name="test:testDataMain:edit">
				<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
	</table>
	<script>
	function nameFormatter(value, row, index){
        return '<a href="${ctx}/test/testDataMain/form?id='+row.id+'">'+value+'</a>';
    }
    function operateFormatter(value, row, index) {
        return [
            '<a class="form" href="javascript:void(0)">修改</a>  ',
            '<a class="delete" href="javascript:void(0)">删除</a>'
        ].join('');
    }
    window.operateEvents = {
        'click .form': function (e, value, row, index) {
            location = '${ctx}/test/testDataMain/form?id='+row.id;
        },
        'click .delete': function (e, value, row, index) {
            return confirmxx('确认要删除该主子表吗？', '${ctx}/test/testDataMain/delete?id='+row.id);
        }
    };
	</script>
</body>
</html>