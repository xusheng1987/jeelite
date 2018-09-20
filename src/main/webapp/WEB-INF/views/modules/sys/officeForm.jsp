<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<div class="layui-form-item">
			<label class="layui-form-label">上级机构:</label>
            <sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
				title="机构" url="/sys/office/treeData" extId="${office.id}" allowClear="${office.currentUser.admin}"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">机构名称:</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">机构编码:</label>
			<div class="layui-input-inline">
				<form:input path="code" htmlEscape="false" maxlength="50" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">机构类型:</label>
			<div class="layui-input-inline">
				<form:select path="type">
					<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否可用:</label>
			<div class="layui-input-inline">
				<form:select path="useable">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">联系地址:</label>
			<div class="layui-input-inline">
				<form:input path="address" htmlEscape="false" maxlength="50" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">邮政编码:</label>
			<div class="layui-input-inline">
				<form:input path="zipCode" htmlEscape="false" maxlength="50" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">负责人:</label>
			<div class="layui-input-inline">
				<form:input path="master" htmlEscape="false" maxlength="50" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话:</label>
			<div class="layui-input-inline">
				<form:input path="phone" htmlEscape="false" maxlength="50" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">传真:</label>
			<div class="layui-input-inline">
				<form:input path="fax" htmlEscape="false" maxlength="50" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">邮箱:</label>
			<div class="layui-input-inline">
				<form:input path="email" htmlEscape="false" maxlength="50" class="layui-input"/>
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
				<shiro:hasPermission name="sys:office:edit"><input class="layui-btn" type="button" value="保 存" onclick="save()"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>