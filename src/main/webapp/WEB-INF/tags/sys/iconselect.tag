<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<i id="${id}Icon" class="${value}" style="display:inline-block;width:20px;font-size:20px"></i>&nbsp;
<input id="${id}" name="${name}" type="text" class="layui-input" style="display:inline-block;width:192px" readonly="readonly" value="${value}"/>
<script type="text/javascript">
	$("#${id}").click(function(){
		var loadIndex = layer.load();
		$.get("${ctx}/tag/iconselect?value=${value}&id=${id}", function (result) {
			layer.open({
				type: 1,
				title: "选择图标",
				maxmin: true,
				area: ['80%', '80%'],//宽高
				content: result,
				btn: ['<i class="fa fa-close"></i> 关闭',
					 '<i class="fa fa-eraser"></i> 清除'],
				success: function(layero, index){
					layer.close(loadIndex);
					var info = '<font color="red" class="pull-left" style="margin-top:10px">提示：双击选择图标。</font>';
					layero.find('.layui-layer-btn').append(info);
				},
				btn1: function(index, layero){//关闭按钮的回调
					layer.close(index);
				},
				btn2: function(index, layero){//清除按钮的回调
					$("#${id}Icon").attr("class", "");
					$("#${id}").val("");
					layer.close(index);
				}
			}); 
		});
	});
</script>