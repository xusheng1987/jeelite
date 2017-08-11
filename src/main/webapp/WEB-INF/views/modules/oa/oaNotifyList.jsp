<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}">通知列表</a></li>
		<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><li><a href="${ctx}/oa/oaNotify/form">通知添加</a></li></shiro:hasPermission></c:if>
	</ul>
	<form:form id="searchForm" modelAttribute="oaNotify" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<c:if test="${!oaNotify.self}"><li><label>状态：</label>
				<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li></c:if>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/oa/oaNotify/data${oaNotify.self?'/self':''}">
		<thead>
			<tr>
				<th data-field="title" data-formatter="titleFormatter">标题</th>
				<th data-field="type" data-formatter="typeFormatter">类型</th>
				<th data-field="status" data-formatter="statusFormatter">状态</th>
				<th data-field="readFlag" data-formatter="readFormatter">查阅状态</th>
				<th data-field="updateDate">更新时间</th>
				<c:if test="${!oaNotify.self}">
				<shiro:hasPermission name="oa:oaNotify:edit">
				<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
				</shiro:hasPermission>
				</c:if>
			</tr>
		</thead>
	</table>
	<script>
	var typeData, statusData, readData;
    $.get("${ctx}/sys/dict/query?type=oa_notify_type", function(result){
    	typeData = result;
    });
    $.get("${ctx}/sys/dict/query?type=oa_notify_status", function(result){
    	statusData = result;
    });
    $.get("${ctx}/sys/dict/query?type=oa_notify_read", function(result){
    	readData = result;
    });
	function titleFormatter(value, row, index){
		var view = "${oaNotify.self?'view':'form'}";
        return '<a href="${ctx}/oa/oaNotify/'+view+'?id='+row.id+'">'+ abbr(value, 50) + '</a>';
    }
	function typeFormatter(value, row, index){
		return getDictLabel(typeData, value, '--');
    }
	function statusFormatter(value, row, index){
		return getDictLabel(statusData, value, '--');
    }
	function readFormatter(value, row, index){
		var self = "${oaNotify.self}";
		if(self=="true") {
			return getDictLabel(readData, value, '--');
		} else {
	        return parseInt(row.readNum) + '/' + parseInt(row.readNum + row.unReadNum);
		}
    }
    function operateFormatter(value, row, index) {
        return [
            '<a class="form" href="javascript:void(0)">修改</a>  ',
            '<a class="delete" href="javascript:void(0)">删除</a>'
        ].join('');
    }
    window.operateEvents = {
        'click .form': function (e, value, row, index) {
            location = '${ctx}/oa/oaNotify/form?id='+row.id;
        },
        'click .delete': function (e, value, row, index) {
            return confirmxx('确认要删除该通知吗？', '${ctx}/oa/oaNotify/delete?id='+row.id);
        }
    };
	</script>
</body>
</html>