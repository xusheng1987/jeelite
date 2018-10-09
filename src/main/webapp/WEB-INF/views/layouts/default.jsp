<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:write property='title'/> - Powered By Jeelite</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<sitemesh:write property='head'/>
</head>
<body>
	<sitemesh:write property='body'/>
	<script src="${ctxStatic}/layui/layui.all.js" type="text/javascript"></script>
</body>
</html>