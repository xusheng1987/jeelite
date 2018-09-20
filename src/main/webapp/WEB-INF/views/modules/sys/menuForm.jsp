<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<div class="layui-form-item">
			<label class="layui-form-label">上级菜单:</label>
            <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
				title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">名称:</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">链接:</label>
			<div class="layui-input-inline">
				<form:input path="href" htmlEscape="false" maxlength="2000" class="layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">点击菜单跳转的页面</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">目标:</label>
			<div class="layui-input-inline">
				<form:input path="target" htmlEscape="false" maxlength="10" class="layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">链接地址打开的目标窗口，默认：mainFrame</div>
		</div>
		<!-- <div class="layui-form-item">
			<label class="layui-form-label">图标:</label>
			<div class="layui-input-inline">
				<sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
			</div>
		</div> -->
		<div class="layui-form-item">
			<label class="layui-form-label">排序:</label>
			<div class="layui-input-inline">
				<form:input path="sort" htmlEscape="false" maxlength="50" class="required digits layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">排列顺序，升序。</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">可见:</label>
			<div class="layui-input-inline">
				<c:forEach items="${fns:getDictList('show_hide')}" var="dict">
					<input type="radio" name="isShow" value="${dict.value}" title="${dict.label}" ${dict.value eq menu.isShow ? 'checked' : ''}>
				</c:forEach>
			</div>
			<div class="layui-form-mid layui-word-aux">该菜单或操作是否显示到系统菜单中</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">权限标识:</label>
			<div class="layui-input-inline" style="width:400px">
				<form:input path="permission" htmlEscape="false" maxlength="100" class="layui-input" style="width:400px"/>
			</div>
			<div class="layui-form-mid layui-word-aux">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="layui-textarea"/>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="sys:menu:edit"><input class="layui-btn" type="button" value="保 存" onclick="save()"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>