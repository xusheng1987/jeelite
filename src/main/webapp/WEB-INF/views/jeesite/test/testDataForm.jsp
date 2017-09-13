<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("input[name='sex'][value='"+$("#sex").val()+"']").attr("checked",true);
			layui.form.render('radio');
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
			<li><a href="${ctx}/test/testData/">单表列表</a></li>
			<li class="layui-this"><a href="${ctx}/test/testData/form?id=${testData.id}">单表<shiro:hasPermission name="test:testData:edit">${not empty testData.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="test:testData:edit">查看</shiro:lacksPermission></a></li>
		</ul>
	</div><br/>
	<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="layui-form-item">
			<label class="layui-form-label">归属用户：</label>
			<sys:treeselect id="user" name="user.id" value="${testData.user.id}" labelName="user.name" labelValue="${testData.user.name}"
				title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">归属部门：</label>
			<sys:treeselect id="office" name="office.id" value="${testData.office.id}" labelName="office.name" labelValue="${testData.office.name}"
				title="部门" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">归属区域：</label>
			<sys:treeselect id="area" name="area.id" value="${testData.area.id}" labelName="area.name" labelValue="${testData.area.name}"
				title="区域" url="/sys/area/treeData" allowClear="true" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">名称：</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="100" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别：</label>
			<div class="layui-input-inline">
				<input id="sex" type="hidden" value="${testData.sex}"/>
				<c:forEach items="${fns:getDictList('sex')}" var="dict">
					<input type="radio" name="sex" value="${dict.value}" title="${dict.label}">
				</c:forEach>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">加入日期：</label>
			<div class="layui-input-inline">
				<input name="inDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate "
					value="<fmt:formatDate value="${testData.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注信息：</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="layui-textarea"/>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="test:testData:edit"><input id="btnSubmit" class="layui-btn" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnCancel" class="layui-btn layui-btn-normal" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
		</div>
	</form:form>
</body>
</html>