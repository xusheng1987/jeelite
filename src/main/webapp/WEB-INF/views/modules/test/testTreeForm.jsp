<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>树结构管理</title>
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
			<li><a href="${ctx}/test/testTree/">树结构列表</a></li>
			<li class="layui-this"><a href="${ctx}/test/testTree/form?id=${testTree.id}&parent.id=${testTreeparent.id}">树结构<shiro:hasPermission name="test:testTree:edit">${not empty testTree.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="test:testTree:edit">查看</shiro:lacksPermission></a></li>
		</ul>
	</div><br/>
	<form:form id="inputForm" modelAttribute="testTree" action="${ctx}/test/testTree/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
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
				<shiro:hasPermission name="test:testTree:edit"><input id="btnSubmit" class="layui-btn" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="layui-btn layui-btn-normal" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</div>
	</form:form>
</body>
</html>