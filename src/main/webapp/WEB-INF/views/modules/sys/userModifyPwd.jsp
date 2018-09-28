<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>修改密码</title>
  <script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#oldPassword").focus();
			$("#inputForm").validate({
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				}
			});
		});
	</script>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">修改密码</div>
      <div class="layui-card-body">
        <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd/save" method="post" class="layui-form">
          <form:hidden path="id"/>
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
              <input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>
            </div>
          </div>
        </form:form>
      </div>
    </div>
  </div>
</body>
</html>