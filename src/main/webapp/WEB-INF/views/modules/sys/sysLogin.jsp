<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		* {
			box-sizing: border-box
		}
		body {
			font-size: 13px;
			overflow-x: hidden;
			line-height: 1.5;
			font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
			height: auto;
			background: url(${ctxStatic}/images/login-background.jpg) no-repeat center fixed;
			background-size: cover;
			color: rgba(255, 255, 255, .95);
		}
		label.error {
			background: none;
			width: 270px;
			font-weight: normal;
			color: inherit;
			margin: 0;
			display: block;
		}
		.signinpanel {
			width: 750px;
			margin: 10% auto 0
		}
		.signup-footer {
			border-top: solid 1px rgba(255, 255, 255, .3);
			margin: 20px 0;
			padding-top: 15px
		}
		.signinpanel form {
			background: rgba(255, 255, 255, .2);
			border: 1px solid rgba(255, 255, 255, .3);
			border-radius: 3px;
			padding: 30px
		}
		.signinpanel .uname {
			background: #fff url(${ctxStatic}/images/user.png) no-repeat 95% center;
			color: #333;
		}
		.signinpanel .pword {
			background: #fff url(${ctxStatic}/images/locked.png) no-repeat 95% center;
			color: #333
		}
		.signinpanel .form-control {
			display: block;
			margin-top: 15px;
			border: 1px solid #e5e6e7;
			width: 100%;
			padding: 6px 12px;
			font-size: 14px;
			height: 34px;
			margin-bottom: 20px
		}
		.m-b {
			margin-bottom: 15px
		}
		.m-t-md {
			margin-top: 20px
		}
		a {
			color: #337ab7;
			text-decoration: none;
		}
		.signinpanel .btn {
			margin-top: 15px
		}
		.layui-btn {
			background-color: #1c84c6;
			border-color: #1c84c6;
			color: #FFF;
			width: 100%;
			margin-bottom: 15px;
		}
		.alert {
			width: 300px;
			margin: 0 auto;
			padding: 8px 35px 8px 14px;
			border-radius: 4px
		}
		.alert-error {
			color: #bd4247;
			background-color: #f2bdb1;
			border-color: #f0a5a4;
			position: absolute
		}
		#messageBox {
			margin-top: -100px;
			margin-left: 15%
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
	<div class="signinpanel">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}">
			<label id="loginError" class="error">${message}</label>
		</div>
        <div class="layui-row">
            <div class="layui-col-sm7">
                    <div class="logopanel m-b">
                        <h1 style="font-size:36px">Jeesite</h1>
                    </div>
                    <div class="m-b"></div>
                    <h2>欢迎使用 <strong>Jeesite快速开发平台</strong></h2>
                    <ul style="margin-top:30px">
                        <li><i class="layui-icon">&#xe602;</i>JeeSite是基于多个优秀的开源项目，高度整合封装而成的高效，高性能，强安全性的开源Java EE快速开发平台</li>
                        <li><i class="layui-icon">&#xe602;</i>使用 Apache License 2.0 协议，源代码完全开源，无商业限制</li>
                        <li><i class="layui-icon">&#xe602;</i>使用目前主流的Java EE开发框架，简单易学，学习成本低</li>
                        <li><i class="layui-icon">&#xe602;</i>模块化设计，层次结构清晰。内置一系列企业信息管理的基础功能</li>
                        <li><i class="layui-icon">&#xe602;</i>提供在线功能代码生成工具，提高开发效率及质量</li>
                    </ul>
            </div>
            <div class="layui-col-sm5">
                <form id="loginForm" action="${ctx}/login" method="post">
                    <h4>登录：</h4>
                    <input type="text" id="username" name="username" class="form-control uname required" value="${username}" placeholder="用户名" />
                    <input type="password" id="password" name="password" class="form-control pword m-b required" placeholder="密码" />
                    <c:if test="${isValidateCodeLogin}">
                    <div class="validateCode">
						<sys:validateCode name="validateCode" inputCssStyle="display:inline;margin-top:0px;margin-bottom:15px;"/>
					</div>
					</c:if>
                    <input class="layui-btn" type="submit" value="登 录"/>
                    <input type="checkbox" title="记住我（公共场所慎用）" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}/> 记住我（公共场所慎用）
                </form>
            </div>
        </div>
        <div class="signup-footer">
            <div>
				Copyright &copy; 2012-${fns:getConfig('copyrightYear')} <a href="https://github.com/xusheng1987/jeesite-lite">${fns:getConfig('productName')}</a> - Powered By <a href="http://jeesite.com" target="_blank">JeeSite</a> ${fns:getConfig('version')} 
            </div>
        </div>
    </div>
</body>
</html>