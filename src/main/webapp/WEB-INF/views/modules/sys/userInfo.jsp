<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人信息</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
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
			<li class="layui-this"><a href="${ctx}/sys/user/info">个人信息</a></li>
			<li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
		</ul>
	</div><br/>
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post" class="layui-form">
		<sys:message content="${message}"/>
		<div class="layui-form-item">
			<label class="layui-form-label">头像:</label>
			<div class="layui-input-inline">
			<!--
				<div id="uploadImg" style="display:none">
					<img class="layui-upload-img" id="avatarPreview">
					<p id="errorText" style="margin-top:10px;margin-bottom:10px"></p>
				</div>
				<button type="button" class="layui-btn layui-btn-danger" id="avatar">
					<i class="layui-icon">&#xe67c;</i>上传图片
				</button>
			  -->
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255"/>
				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
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
				<form:input path="name" htmlEscape="false" maxlength="50" class="required layui-input" readonly="true"/>
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
				<input id="btnSubmit" class="layui-btn" type="submit" value="保 存"/>
			</div>
		</div>
	</form:form>
	<!--
	<script type="text/javascript">
			var upload = layui.upload
			,layer = layui.layer;
			//执行实例
			  var uploadInst = upload.render({
			    elem: '#avatar' //绑定元素
			    ,url: 'upload/' //上传接口
			    ,size: 10240 //限制文件大小10M，单位 KB
			    ,before: function(obj){
			      $("#uploadImg").show();
			      layer.load(); //上传loading
			      //图片预览，不支持ie8
			      obj.preview(function(index, file, result){
			        $('#avatarPreview').attr('src', result); //图片链接（base64）
			      });
			    }
			    ,done: function(res){
			      //上传完毕回调
			      console.log(res);
			      layer.closeAll('loading'); //关闭loading
			    }
			    ,error: function(){
			      //请求异常回调
			      layer.msg('上传失败');
			      layer.closeAll('loading'); //关闭loading
			      //失败状态，并实现重传
			      var errorText = $('#errorText');
			      errorText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini reload">重试</a>');
			      errorText.find('.reload').on('click', function(){
			        uploadInst.upload();
			      });
			    }
			  });
	</script>
	  -->
</body>
</html>