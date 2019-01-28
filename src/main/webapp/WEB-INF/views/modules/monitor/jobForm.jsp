<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate({
			rules: {
				cronExpression: {remote: "${ctx}/monitor/job/checkCronExpression?oldCronExpression=${job.cronExpression}"}
			},
			messages: {
				cronExpression: {remote: "cron表达式无效"}
			}
		});
	});
</script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="job" action="${ctx}/monitor/job/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<div class="layui-form-item">
			<label class="layui-form-label">bean名称：</label>
			<div class="layui-input-inline">
				<form:input path="beanName" htmlEscape="false" maxlength="100" class="layui-input required"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">方法名：</label>
			<div class="layui-input-inline">
				<form:input path="methodName" htmlEscape="false" maxlength="100" class="layui-input required"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">参数：</label>
			<div class="layui-input-inline">
				<form:input path="params" htmlEscape="false" maxlength="100" class="layui-input "/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">cron表达式：</label>
			<div class="layui-input-inline">
				<form:input path="cronExpression" htmlEscape="false" maxlength="100" class="layui-input required"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注：</label>
			<div class="layui-input-inline">
				<form:textarea path="remark" htmlEscape="false" rows="3" maxlength="255" class="layui-textarea"/>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="monitor:job:edit"><input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>