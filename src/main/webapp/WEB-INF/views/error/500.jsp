<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html style="background-color:#fff">
<head>
	<title>500 - 系统内部错误</title>
	<script src="${ctxStatic}/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/layui/css/layui.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/common/jeelite.css" type="text/css" rel="stylesheet" />
</head>
<body>
<div style="margin:15px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>系统内部错误.</legend>
	</fieldset>
	<div class="errorMessage">
		<blockquote class="layui-elem-quote">
			错误信息：${errorMsg}
		</blockquote><br/>
		请点击“查看详细信息”按钮，将详细错误信息发送给系统管理员，谢谢！<br/> <br/>
		<a href="javascript:" onclick="history.go(-1);" class="layui-btn">返回上一页</a> &nbsp;
		<a href="javascript:" onclick="$('.errorMessage').toggle();" class="layui-btn layui-btn-normal">查看详细信息</a>
	</div>
	<div class="errorMessage hide">
		<blockquote class="layui-elem-quote">${detailMsg}<br/>
		</blockquote>
		<a href="javascript:" onclick="history.go(-1);" class="layui-btn">返回上一页</a> &nbsp;
		<a href="javascript:" onclick="$('.errorMessage').toggle();" class="layui-btn layui-btn-normal">隐藏详细信息</a>
	</div>
</div>
</body>
</html>