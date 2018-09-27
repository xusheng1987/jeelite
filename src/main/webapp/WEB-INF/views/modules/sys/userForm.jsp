<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<script type="text/javascript">
		$(document).ready(function() {
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				}
			});
		});
</script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<div class="layui-form-item">
			<label class="layui-form-label">头像:</label>
			<sys:imageupload name="photo"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">归属公司:</label>
            <sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}"
				title="公司" url="/sys/office/treeData?type=1" cssClass="required"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">归属部门:</label>
            <sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
				title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">工号:</label>
			<div class="layui-input-inline">
				<form:input path="no" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">姓名:</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">登录名:</label>
			<div class="layui-input-inline">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密码:</label>
			<div class="layui-input-inline">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''} layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">
				<c:if test="${empty user.id}"><font color="red">*</font></c:if>
				<c:if test="${not empty user.id}">若不修改密码，请留空。</c:if>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码:</label>
			<div class="layui-input-inline">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword" class="layui-input"/>
			</div>
			<c:if test="${empty user.id}">
				<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
			</c:if>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">邮箱:</label>
			<div class="layui-input-inline">
				<form:input path="email" htmlEscape="false" maxlength="100" class="email layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">电话:</label>
			<div class="layui-input-inline">
				<form:input path="phone" htmlEscape="false" maxlength="100" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机:</label>
			<div class="layui-input-inline">
				<form:input path="mobile" htmlEscape="false" maxlength="100" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否允许登录:</label>
			<div class="layui-input-inline">
				<form:select path="loginFlag">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">用户角色:</label>
			<div class="layui-input-block">
				<c:forEach items="${allRoles}" var="role">
					<input type="checkbox" name="roleIdList" value="${role.id}" title="${role.name}" <c:if test="${fns:contains(user.roleIdList, role.id)}">checked</c:if>>
				</c:forEach>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="layui-textarea"/>
			</div>
		</div>
		<c:if test="${not empty user.id}">
			<div class="layui-form-item">
				<label class="layui-form-label">创建时间:</label>
				<div class="layui-input-block">
					<label class="layui-form-mid"><fmt:formatDate value="${user.createDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">最后登陆:</label>
				<div class="layui-input-block">
					<label class="layui-form-mid">IP: ${user.loginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.loginDate}" type="both" dateStyle="full"/></label>
				</div>
			</div>
		</c:if>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="sys:user:edit"><input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>