<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="testData" action="${ctx}/test/testData/save" method="post" class="layui-form">
		<form:hidden path="id"/>
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
			<label class="layui-form-label">名称：</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="100" class="required layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别：</label>
			<div class="layui-input-inline">
				<c:forEach items="${fns:getDictList('sex')}" var="dict">
					<input type="radio" name="sex" value="${dict.value}" title="${dict.label}" ${dict.value eq testData.sex ? 'checked' : ''}>
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
				<shiro:hasPermission name="test:testData:edit"><input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>