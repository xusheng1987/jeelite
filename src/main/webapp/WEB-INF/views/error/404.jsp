<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>404 - 页面不存在</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div style="margin:15px">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>页面不存在.</legend>
		</fieldset>
		<a href="javascript:" onclick="history.go(-1);" class="layui-btn">返回上一页</a>
	</div>
</body>
</html>
