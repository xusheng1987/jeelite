<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>403 - 操作权限不足</title>
	<link href="${ctxStatic}/layui/css/layui.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/common/jeelite.css" type="text/css" rel="stylesheet" />
</head>
<body>
	<div style="margin:15px">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>操作权限不足.</legend>
		</fieldset>
		<a href="javascript:" onclick="history.go(-1);" class="layui-btn">返回上一页</a>
	</div>
</body>
</html>
