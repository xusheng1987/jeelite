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
		<table class="layui-table"></table>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		var table = layui.table;
		//执行渲染
		table.render({
		    url: '${ctx}/sys/log/data' //数据接口
		    ,cols: [[ //表头
		       {field: 'title',title: '操作菜单'}
		      ,{title: '操作用户', templet: function(d) {
		          return d.createBy.name
		       }}
		      ,{title: '所在公司', templet: function(d) {
		          return d.createBy.company.name
		       }} 
		      ,{title: '所在部门', templet: function(d) {
		          return d.createBy.office.name
		       }} 
		      ,{field: 'requestUri', title: 'URI'}
		      ,{field: 'method', title: '提交方式'}
		      ,{field: 'remoteAddr', title: '操作者IP'}
		      ,{field: 'createDate', title: '操作时间'}
		      ,{field: 'exception', title: '异常'}
		    ]]
		});
	});
	</script>
</body>
</html>