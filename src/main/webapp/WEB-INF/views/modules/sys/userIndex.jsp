<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.ztree {display: inline-block; width: 180px; padding: 10px; border: 1px solid #ddd; overflow: auto;}
	</style>
</head>
<body>
	<div id="content">
		<div class="layui-row">
			<div class="layui-col-xs2" style="background-color:#fff;margin-top: 15px;margin-left: 10px;padding-bottom:76px">
				<div style="height:auto;overflow:auto;padding:0 10px 0 10px">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;width:200px;">
					<legend>组织机构</legend>
				</fieldset>
				<div id="ztree" class="ztree"></div>
				</div>
			</div>
			<div class="layui-col-xs10" style="position:absolute;right:0;top:0;bottom:0;">
				<div style="height:100%;overflow:hidden;padding-left:10px" id="officeContent">
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
					var id = treeNode.id == '0' ? '' :treeNode.id;
					loadUserListPage(id, treeNode.name);
				}
			}
		};
		
		function refreshTree(){
			$.getJSON("${ctx}/sys/office/treeData",function(data){
				$.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
			});
		}
		// 刷新组织机构
		refreshTree();
		
		function loadUserListPage(officeId, officeName) {
			var param = "";
			if (officeId) {
				param = "?office.id="+officeId+"&office.name="+officeName;
			}
			// 显示用户列表页面
			var loadIndex = layer.load();
			$.get("${ctx}/sys/user/list" + param, function(data){
				layer.close(loadIndex);
				$("#officeContent").html(data);
				form.render();
			});
		}
		$(document).ready(function() {
			// 加载用户列表页面
			loadUserListPage();
		});
	</script>
</body>
</html>