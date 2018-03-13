<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改密码</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#oldPassword").focus();
			$("#inputForm").validate({
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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
			<li><a href="${ctx}/sys/user/info">个人信息</a></li>
			<li class="layui-this"><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
		</ul>
	</div><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" class="layui-form">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="layui-form-item">
			<label class="layui-form-label">旧密码:</label>
			<div class="layui-input-inline">
				<input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码:</label>
			<div class="layui-input-inline">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required layui-input"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认新密码:</label>
			<div class="layui-input-inline">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required layui-input" equalTo="#newPassword"/>
			</div>
			<div class="layui-form-mid layui-word-aux"><font color="red">*</font></div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<input id="btnSubmit" class="layui-btn" type="submit" value="保 存"/>
			</div>
		</div>
	</form:form>
</body>
</html>