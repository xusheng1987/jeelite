<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<script type="text/javascript">
	function next() {
		$.post($("#inputForm").attr("action"), $("#inputForm").serialize(), function (result) {
			if (result.code == '200') {
				layer.closeAll();
				openDialog('业务表设置', '${ctx}/gen/genTable/next/form?name=' + $("#name").val(), '100%', '100%');
			} else {
				layer.alert(result.msg, {icon: 2});
			}
		});
	}
</script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/next" method="post" class="layui-form">
		<div class="layui-form-item">
			<label class="layui-form-label">表名:</label>
			<div class="layui-input-inline">
				<form:select path="name">
					<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<input class="layui-btn" type="button" value="下一步" onclick="next()"/>&nbsp;
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>