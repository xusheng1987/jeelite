<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
</head>
<body>
	<div id="searchForm" class="breadcrumb form-search">
		<div>
			<label>操作菜单：</label><input id="title" name="title" type="text" maxlength="50" class="input-mini"/>
			<label>用户ID：</label><input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="input-mini"/>
			<label>URI：</label><input id="requestUri" name="requestUri" type="text" maxlength="50" class="input-mini"/>
		</div><div style="margin-top:8px;">
			<label>日期范围：&nbsp;</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				value="<fmt:formatDate value="${beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			<label>&nbsp;--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
			&nbsp;<label for="exception"><input id="exception" name="exception" type="checkbox" value="1"/>只查询异常信息</label>
			&nbsp;&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
		</div>
	</div>
	<sys:message content="${message}"/>
	<table id="table" data-detail-view="true" data-detail-formatter="detailFormatter" data-url="${ctx}/sys/log/data">
		<thead>
		<tr>
			<th data-field="title">操作菜单</th>
			<th data-field="createBy.name">操作用户</th>
			<th data-field="createBy.company.name">所在公司</th>
			<th data-field="createBy.office.name">所在部门</th>
			<th data-field="requestUri">URI</th>
			<th data-field="method">提交方式</th>
			<th data-field="remoteAddr">操作者IP</th>
			<th data-field="createDate">操作时间</th>
		</tr>
		</thead>
	</table>
<script>
    function detailFormatter(index, row) {
        var html;
        if(row.exception != '') {
            html = '异常信息: <br/>' + row.exception;
        } else {
            html = '无异常信息';
        }
        return html;
    }
</script>
</body>
</html>