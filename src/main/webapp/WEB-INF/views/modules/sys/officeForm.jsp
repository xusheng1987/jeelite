<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
			<li><a href="${ctx}/sys/office/list">机构列表</a></li>
			<li class="layui-this"><a href="${ctx}/sys/office/form?id=${office.id}&parent.id=${office.parent.id}">机构<shiro:hasPermission name="sys:office:edit">${not empty office.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:office:edit">查看</shiro:lacksPermission></a></li>
		</ul>
	</div><br/>
	<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
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
			<label class="layui-form-label">机构级别:</label>
			<div class="layui-input-inline">
				<form:select path="grade">
					<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			<label class="layui-form-label">主负责人:</label>
			<sys:treeselect id="primaryPerson" name="primaryPerson.id" value="${office.primaryPerson.id}" labelName="office.primaryPerson.name" labelValue="${office.primaryPerson.name}"
				title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">副负责人:</label>
			<sys:treeselect id="deputyPerson" name="deputyPerson.id" value="${office.deputyPerson.id}" labelName="office.deputyPerson.name" labelValue="${office.deputyPerson.name}"
				title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
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
		<c:if test="${empty office.id}">
			<div class="layui-form-item">
				<label class="layui-form-label">快速添加下级部门:</label>
				<div class="layui-input-block">
					<c:forEach items="${fns:getDictList('sys_office_common')}" var="dict">
						<input type="checkbox" name="childDeptList" value="${dict.value}" title="${dict.label}">
					</c:forEach>
				</div>
			</div>
		</c:if>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="sys:office:edit"><input id="btnSubmit" class="layui-btn" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="layui-btn layui-btn-normal" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</div>
	</form:form>
</body>
</html>