<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>字典管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading();
					form.submit();
				}
			});
		});
	</script>
</head>
<body>
	<div class="layui-tab">
		<ul class="layui-tab-title">
			<li><a href="${ctx}/sys/dict/">字典列表</a></li>
			<li class="layui-this"><a href="${ctx}/sys/dict/form?id=${dict.id}">字典<shiro:hasPermission name="sys:dict:edit">${not empty dict.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:dict:edit">查看</shiro:lacksPermission></a></li>
		</ul>
	</div><br/>
	<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="layui-form-item">
			<label class="layui-form-label">键值:</label>
			<div class="layui-input-inline">
				<form:input path="value" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">标签:</label>
			<div class="layui-input-inline">
				<form:input path="label" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">类型:</label>
			<div class="layui-input-inline">
				<form:input path="type" htmlEscape="false" maxlength="50" class="required abc layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">描述:</label>
			<div class="layui-input-inline">
				<form:input path="description" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">排序:</label>
			<div class="layui-input-inline">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="layui-textarea"/>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="sys:dict:edit"><input id="btnSubmit" class="layui-btn" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="layui-btn layui-btn-normal" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</div>
	</form:form>
</body>
</html>