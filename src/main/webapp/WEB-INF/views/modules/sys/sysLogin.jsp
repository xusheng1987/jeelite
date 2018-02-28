<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/common/login.css" media="all">
	<script type="text/javascript">
		$(document).ready(function() {
			var form = layui.form,
			layer = layui.layer;
			form.on('submit', function(data){
				// 登录
				$.post("${ctx}/login", data.field, function (result) {
					if (result.message) {
						if(result.isValidateCodeLogin) {//显示验证码
							$("#validateCodeItem").show();
							$("#validateCode").attr("lay-verify","required");
						}
						layer.msg(result.message, {icon: 2});
					} else {
						location.href="${ctx}";
					}
				});
				return false;
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body class="layui-layout-body">
      <div class="layadmin-user-login">
        <div class="layadmin-user-login-main">
          <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>
              <strong>Jeesite快速开发平台</strong>
            </h2>
          </div>
          <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
          <form id="loginForm" method="post">
            <div class="layui-form-item"><!--<i class="layui-icon layadmin-user-login-icon">&#xe612;</i>-->
              <input type="text" name="username" id="username" lay-verify="required" placeholder="用户名" class="layui-input">
            </div>
            <div class="layui-form-item">
              <input type="password" name="password" id="password" lay-verify="required" placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item" id="validateCodeItem" style="display:none">
                <div class="layui-col-xs7">
                  <input type="text" name="validateCode" id="validateCode" placeholder="图形验证码" class="layui-input">
                </div>
                <div class="layui-col-xs4">
                  <div style="margin-left: 10px;">
                    <img src="${pageContext.request.contextPath}/servlet/validateCodeServlet" onclick="$(this).attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime());"
                       class="layadmin-user-login-codeimg"/>
                  </div>
                </div>
            </div>
            <div class="layui-form-item" style="margin-bottom: 20px;">
              <input type="checkbox" name="rememberMe" id="rememberMe" lay-skin="primary" title="记住密码（公共场所慎用）">
            </div>
            <div class="layui-form-item">
              <button class="layui-btn layui-btn-fluid" lay-submit>登 录</button>
            </div>
          </form>
          </div>
        </div>
        <div class="layadmin-user-login-footer">
          Copyright &copy; 2012-${fns:getConfig('copyrightYear')} <a href="https://github.com/xusheng1987/jeesite-lite">${fns:getConfig('productName')}</a> - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')} 
        </div>
      </div>
</body>
</html>