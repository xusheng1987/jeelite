<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@include file="/WEB-INF/views/include/treeview.jsp" %>
<div class="layui-container">
	<div id="assignRole" class="layui-row">
		<div class="layui-col-xs4" style="border-right: 1px solid #A8A8A8;">
			<p>所在部门：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="layui-col-xs4" style="padding-left:16px;">
			<p>待选人员：</p>
			<div id="userTree" class="ztree"></div>
		</div>
		<div class="layui-col-xs4" style="padding-left:16px;border-left: 1px solid #A8A8A8;">
			<p>已选人员：</p>
			<div id="selectedTree" class="ztree"></div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		var officeTree;
		var selectedTree;//zTree已选择对象

		var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false,dblClickExpand:false},
				data: {simpleData: {enable: true}},
				callback: {onClick: treeOnClick}};

		var officeNodes=[
	            <c:forEach items="${officeList}" var="office">
	            {id:"${office.id}",
	             pId:"${not empty office.parent?office.parent.id:0}",
	             name:"${office.name}"},
	            </c:forEach>];

		var pre_selectedNodes =[
   		        <c:forEach items="${userList}" var="user">
   		        {id:"${user.id}",
   		         pId:"0",
   		         name:"<font color='red' style='font-weight:bold;'>${user.name}</font>"},
   		        </c:forEach>];

		var selectedNodes =[
		        <c:forEach items="${userList}" var="user">
		        {id:"${user.id}",
		         pId:"0",
		         name:"<font color='red' style='font-weight:bold;'>${user.name}</font>"},
		        </c:forEach>];

		var pre_ids = "${selectIds}".split(",");
		var ids = "${selectIds}".split(",");

		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
			if("officeTree"==treeId){
				$.get("${ctx}/sys/role/users?officeId=" + treeNode.id, function(userNodes){
					$.fn.zTree.init($("#userTree"), setting, userNodes);
				});
			}
			if("userTree"==treeId){
				if($.inArray(String(treeNode.id), ids)<0){
					selectedTree.addNodes(null, treeNode);
					ids.push(String(treeNode.id));
				}
			};
			if("selectedTree"==treeId){
				if($.inArray(String(treeNode.id), pre_ids)<0){
					selectedTree.removeNode(treeNode);
					ids.splice($.inArray(String(treeNode.id), ids), 1);
				}else{
					layer.msg("角色原有成员不能清除！", {icon: 0});
				}
			}
		};
		function clearAssign(){
			top.layer.confirm("确定清除角色【${role.name}】下的已选人员？", {icon: 3, title:'清除确认'}, function(index){
				var tips="";
				if(pre_ids.sort().toString() == ids.sort().toString()){
					tips = "未给角色【${role.name}】分配新成员！";
				}else{
					tips = "已选人员清除成功！";
				}
				ids=pre_ids.slice(0);
				selectedNodes=pre_selectedNodes;
				$.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
				top.layer.msg(tips, {icon: 0});
			}, function(index){
		    	// 取消
				top.layer.msg("取消清除操作！", {icon: 0});
			});
		};

		// 初始化
		$(document).ready(function(){
			officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
			selectedTree = $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
		});
	</script>