<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.layui-form-item .layui-inline {margin-right: -10px;}
	</style>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"><a href="${ctx}/sys/log/">日志列表</a></li>
		</ul>
	</div><br/>
	<div id="searchForm" class="layui-form">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">操作菜单：</label>
				<div class="layui-input-inline">
					<input id="title" name="title" type="text" maxlength="50" class="layui-input"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="width:60px">用户ID：</label>
				<div class="layui-input-inline">
					<input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="layui-input"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="width:30px">URI：</label>
				<div class="layui-input-inline">
					<input id="requestUri" name="requestUri" type="text" maxlength="50" class="layui-input"/>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">日期范围：&nbsp;</label>
				<div class="layui-input-inline">
					<input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
						value="<fmt:formatDate value="${beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</div>
				<div class="layui-form-mid">-</div>
				<div class="layui-input-inline">
					<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
						value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>&nbsp;&nbsp;
				</div>
			</div>
			<div class="layui-inline" style="margin:0 0 30px 10px">
				<input type="checkbox" lay-skin="primary" id="exception" name="exception" value="1" title="只查询异常信息">
			</div>
			<div class="layui-inline" style="margin-bottom:23px">
				<input id="btnSearch" class="layui-btn layui-btn-normal" type="submit" value="查询"/>
			</div>
		</div>
	</div>
	<sys:message content="${message}"/>
	<div style="margin:15px">
		<table class="layui-table" lay-data="{id:'table', height:488, even:true, url:'${ctx}/sys/log/data', where:queryParams(), request: {pageName: 'pageNo'}, page:true, limit:10}">
		<thead>
		<tr>
			<th lay-data="{field:'title', width:300}">操作菜单</th>
			<th lay-data="{width:150, templet:'#createByNameTpl'}">操作用户</th>
			<th lay-data="{width:150, templet:'#companyNameTpl'}">所在公司</th>
			<th lay-data="{width:150, templet:'#officeNameTpl'}">所在部门</th>
			<th lay-data="{field:'requestUri', width:300}">URI</th>
			<th lay-data="{field:'method', width:100}">提交方式</th>
			<th lay-data="{field:'remoteAddr', width:150}">操作者IP</th>
			<th lay-data="{field:'createDate', width:180}">操作时间</th>
			<th lay-data="{field:'exception', width:180}">异常</th>
		</tr>
		</thead>
		</table>
	</div>
	<script type="text/html" id="createByNameTpl">
		{{d.createBy.name}}
	</script>
	<script type="text/html" id="companyNameTpl">
		{{d.createBy.company.name}}
	</script>
	<script type="text/html" id="officeNameTpl">
		{{d.createBy.office.name}}
	</script>
</body>
</html>