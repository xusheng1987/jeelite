<%
response.setStatus(403);

//获取异常类
Throwable ex = Exceptions.getThrowable(request);

// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	if (ex!=null && StringUtils.startsWith(ex.getMessage(), "msg:")){
		out.print(StringUtils.replace(ex.getMessage(), "msg:", ""));
	}else{
		out.print("操作权限不足.");
	}
}

//输出异常信息页面
else {
%>
<%@page import="com.thinkgem.jeesite.common.web.Servlets"%>
<%@page import="com.thinkgem.jeesite.common.utils.Exceptions"%>
<%@page import="com.thinkgem.jeesite.common.utils.StringUtils"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>403 - 操作权限不足</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div style="margin:15px">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>操作权限不足.</legend>
		</fieldset>
		<%
			if (ex!=null && StringUtils.startsWith(ex.getMessage(), "msg:")){
				out.print("<div><blockquote class='layui-elem-quote'>"+StringUtils.replace(ex.getMessage(), "msg:", "")+"</blockquote><br/><br/></div>");
			}
		%>
		<a href="javascript:" onclick="history.go(-1);" class="layui-btn">返回上一页</a>
	</div>
</body>
</html>
<%
} out = pageContext.pushBody();
%>