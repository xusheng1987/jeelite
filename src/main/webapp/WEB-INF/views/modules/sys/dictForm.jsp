<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="dict" action="${ctx}/sys/dict/save" method="post" class="layui-form">
		<form:hidden path="id"/>
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
				<shiro:hasPermission name="sys:dict:edit"><input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>