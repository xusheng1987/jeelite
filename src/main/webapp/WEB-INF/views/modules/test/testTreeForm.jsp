<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="testTree" action="${ctx}/test/testTree/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<div class="layui-form-item">
			<label class="layui-form-label">上级编号:</label>
			<sys:treeselect id="parent" name="parent.id" value="${testTree.parent.id}" labelName="parent.name" labelValue="${testTree.parent.name}"
				title="父级编号" url="/test/testTree/treeData" extId="${testTree.id}" allowClear="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">名称：</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="100" class="layui-input required"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">排序：</label>
			<div class="layui-input-inline">
				<form:input path="sort" htmlEscape="false" maxlength="10" class="layui-input required digits"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注信息：</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="layui-textarea"/>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="test:testTree:edit"><input class="layui-btn" type="button" value="保 存" onclick="save()"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>