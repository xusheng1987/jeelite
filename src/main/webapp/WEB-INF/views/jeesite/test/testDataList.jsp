<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/test/testData/">单表列表</a></li>
		<shiro:hasPermission name="test:testData:edit"><li><a href="${ctx}/test/testData/form">单表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testData" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>归属用户：</label>
				<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>归属部门：</label>
				<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>归属区域：</label>
				<sys:treeselect id="area" name="area.id" value="${testData.area.id}" labelName="area.name" labelValue="${testData.area.name}"
					title="区域" url="/sys/area/treeData" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>加入日期：</label>
				<input name="beginInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${testData.beginInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> -
				<input name="endInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${testData.endInDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/test/testData/data">
		<thead>
			<tr>
				<th data-field="user.name" data-formatter="nameFormatter">归属用户</th>
				<th data-field="office.name">归属部门</th>
				<th data-field="area.name">归属区域</th>
				<th data-field="name">名称</th>
				<th data-field="sex" data-formatter="sexFormatter">性别</th>
				<th data-field="updateDate">更新时间</th>
				<th data-field="remarks">备注信息</th>
				<shiro:hasPermission name="test:testData:edit">
				<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
	</table>
	<script>
	var sexData;
    $.get("${ctx}/sys/dict/query?type=sex", function(result){
    	sexData = result;
    });
	function nameFormatter(value, row, index){
        return '<a href="${ctx}/test/testData/form?id='+row.id+'">'+value+'</a>';
    }
	function sexFormatter(value, row, index){
		return getDictLabel(sexData, value, '--');
    }
    function operateFormatter(value, row, index) {
        return [
            '<a class="form" href="javascript:void(0)">修改</a>  ',
            '<a class="delete" href="javascript:void(0)">删除</a>'
        ].join('');
    }
    window.operateEvents = {
        'click .form': function (e, value, row, index) {
            location = '${ctx}/test/testData/form?id='+row.id;
        },
        'click .delete': function (e, value, row, index) {
            return confirmxx('确认要删除该单表吗？', '${ctx}/test/testData/delete?id='+row.id);
        }
    };
	</script>
</body>
</html>