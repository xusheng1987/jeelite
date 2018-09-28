<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>个人信息</title>
  <script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">个人信息</div>
      <div class="layui-card-body">
        <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info/save" method="post" class="layui-form">
          <div class="layui-form-item">
            <label class="layui-form-label">头像:</label>
            <sys:imageupload name="photo"/>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">归属公司:</label>
            <div class="layui-input-inline">
              <label class="layui-form-mid">${user.company.name}</label>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">归属部门:</label>
            <div class="layui-input-inline">
              <label class="layui-form-mid">${user.office.name}</label>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">姓名:</label>
            <div class="layui-input-inline">
              <form:input path="name" htmlEscape="false" maxlength="50" class="required layui-input"/>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">邮箱:</label>
            <div class="layui-input-inline">
              <form:input path="email" htmlEscape="false" maxlength="50" class="email layui-input"/>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">电话:</label>
            <div class="layui-input-inline">
              <form:input path="phone" htmlEscape="false" maxlength="50" class="layui-input"/>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">手机:</label>
            <div class="layui-input-inline">
              <form:input path="mobile" htmlEscape="false" maxlength="50" class="layui-input"/>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
              <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="layui-textarea"/>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">用户角色:</label>
            <div class="layui-input-block">
              <label class="layui-form-mid">${user.roleNames}</label>
            </div>
          </div>
          <div class="layui-form-item">
            <label class="layui-form-label">上次登录:</label>
            <div class="layui-input-block">
              <label class="layui-form-mid">IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></label>
            </div>
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