<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<script type="text/javascript">
	// 保存方案
	function save() {
		$('#flag').val('0');
		postData();
	}
	// 保存并生成代码
	function saveAndGenerate() {
		$('#flag').val('1');
		postData();
	}
	// 提交数据
	function postData() {
		var loadIndex = layer.load();
		$.post($("#inputForm").attr("action"), $("#inputForm").serialize(), function (result) {
			if (result.code == '200') {
				layer.closeAll();
				layer.msg(result.msg, {icon: 1});
			} else {
				layer.close(loadIndex);
				layer.alert(result.msg, {icon: 2});
			}
		});
	}
</script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="genScheme" action="${ctx}/gen/genScheme/save" method="post" class="layui-form">
		<form:hidden path="id"/><form:hidden path="flag"/>
		<div class="layui-form-item">
			<label class="layui-form-label">方案名称:</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="200" class="required layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">模板分类:</label>
			<div class="layui-input-inline">
				<form:select path="category" class="required">
					<form:options items="${config.categoryList}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="layui-form-mid layui-word-aux">生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{java类}</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生成包路径:</label>
			<div class="layui-input-inline">
				<form:input path="packageName" htmlEscape="false" maxlength="500" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">建议模块包：com.github.flying.jeelite.modules</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生成模块名:</label>
			<div class="layui-input-inline">
				<form:input path="moduleName" htmlEscape="false" maxlength="500" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">可理解为子系统名，例如 sys</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生成功能描述:</label>
			<div class="layui-input-inline">
				<form:input path="functionName" htmlEscape="false" maxlength="500" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">将设置到类描述</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生成功能名:</label>
			<div class="layui-input-inline">
				<form:input path="functionNameSimple" htmlEscape="false" maxlength="500" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">用作功能提示，如：保存“某某”成功</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生成功能作者:</label>
			<div class="layui-input-inline">
				<form:input path="functionAuthor" htmlEscape="false" maxlength="500" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux">功能开发者</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">业务表名:</label>
			<div class="layui-input-inline">
				<form:select path="genTable.id" class="required">
					<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="id" htmlEscape="false"/>
				</form:select>
			</div>
			<div class="layui-form-mid layui-word-aux">生成的数据表，一对多情况下请选择主表。</div>
		</div>
		<div class="layui-form-item hide">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="layui-textarea"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">生成选项:</label>
			<div class="layui-input-block">
				<input type="checkbox" name="replaceFile" value="true" title="是否替换现有文件">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="gen:genScheme:edit">
					<input class="layui-btn" type="button" value="保存方案" onclick="save();"/>&nbsp;
					<input class="layui-btn layui-btn-danger" type="button" value="保存并生成代码" onclick="saveAndGenerate();"/>&nbsp;
				</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>