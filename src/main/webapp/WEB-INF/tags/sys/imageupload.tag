<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="隐藏域名称"%>
<div class="layui-input-inline">
	<div id="uploadImg" style="display:none">
		<img class="layui-upload-img" style="height:100px" id="avatarPreview">
		<p id="errorText" style="margin-top:10px;margin-bottom:10px"></p>
	</div>
	<button type="button" class="layui-btn layui-btn-danger" id="avatar">
		<i class="layui-icon">&#xe67c;</i>上传图片
	</button>
	<form:hidden path="${name}" htmlEscape="false"/>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		if($("#${name}").val()) {//显示头像
			$("#uploadImg").show();
			$('#avatarPreview').attr('src', $("#${name}").val());
		}
		var upload = layui.upload
		,layer = layui.layer;
		//执行实例
		  var uploadInst = upload.render({
		    elem: '#avatar' //绑定元素
		    ,url: 'upload/' //上传接口
		    ,size: 10240 //限制文件大小10M，单位 KB
		    ,before: function(obj){//文件提交上传前的回调
		      $("#uploadImg").show();
		      layer.load(); //上传loading
		      //图片预览，不支持ie8/9
		      obj.preview(function(index, file, result){
		        $('#avatarPreview').attr('src', result); //图片链接（base64）
		      });
		    }
		    ,done: function(res){
		      //上传完毕回调
		      if (res.src == '') {
			      layer.msg('上传失败');
		      } else {
			      $("#${name}").val(res.src);
		      }
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
	});
</script>