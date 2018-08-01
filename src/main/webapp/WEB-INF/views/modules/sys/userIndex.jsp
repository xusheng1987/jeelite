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
	<sys:message content="${message}"/>
	<div id="content">
		<div class="layui-row">
			<div class="layui-col-xs2">
				<div style="height:auto;overflow:auto;padding:0 10px 0 10px">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;width:200px;">
					<legend>组织机构</legend>
				</fieldset>
				<div id="ztree" class="ztree"></div>
				</div>
			</div>
			<div class="layui-col-xs10" style="position:absolute;right:0;top:0;bottom:0;">
				<div style="height:100%;overflow:hidden;padding-left:10px">
				<iframe id="officeContent" src="${ctx}/sys/user/list" style="width:100%;height:100%" scrolling="yes" frameborder="0"></iframe>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var setting = {data:{simpleData:{enable:true,idKey:"id",pIdKey:"pId",rootPId:'0'}},
			callback:{onClick:function(event, treeId, treeNode){
					var id = treeNode.id == '0' ? '' :treeNode.id;
					$('#officeContent').attr("src","${ctx}/sys/user/list?office.id="+id+"&office.name="+treeNode.name);
				}
			}
		};
		
		function refreshTree(){
			$.getJSON("${ctx}/sys/office/treeData",function(data){
				$.fn.zTree.init($("#ztree"), setting, data).expandAll(true);
			});
		}
		refreshTree();
	</script>
</body>
</html>