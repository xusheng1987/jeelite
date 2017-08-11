<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/table.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		});
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/list">用户列表</a></li>
		<shiro:hasPermission name="sys:user:edit"><li><a href="${ctx}/sys/user/form">用户添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="user" class="breadcrumb form-search ">
		<ul class="ul-form">
			<li><label>归属公司：</label><sys:treeselect id="company" name="company.id" value="" labelName="company.name" labelValue="" 
				title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/></li>
			<li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="clearfix"></li>
			<li><label>归属部门：</label><sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
				title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="table" data-url="${ctx}/sys/user/data">
		<thead>
		<tr>
			<th data-field="company.name">归属公司</th>
			<th data-field="office.name">归属部门</th>
			<th data-field="loginName" data-sortable="true" data-sort-name="login_name" data-formatter="loginNameFormatter">登录名</th>
			<th data-field="name" data-sortable="true">姓名</th>
			<th data-field="phone">电话</th>
			<th data-field="mobile">手机</th>
			<shiro:hasPermission name="sys:user:edit">
			<th data-events="operateEvents" data-formatter="operateFormatter">操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
	</table>
	<script>
	function loginNameFormatter(value, row, index){
        return '<a href="${ctx}/sys/user/form?id='+row.id+'">'+value+'</a>';
    }
    function operateFormatter(value, row, index) {
        return [
            '<a class="form" href="javascript:void(0)">修改</a>  ',
            '<a class="delete" href="javascript:void(0)">删除</a>'
        ].join('');
    }
    window.operateEvents = {
        'click .form': function (e, value, row, index) {
            location = '${ctx}/sys/user/form?id='+row.id;
        },
        'click .delete': function (e, value, row, index) {
            return confirmxx('确认要删除该用户吗？', '${ctx}/sys/user/delete?id='+row.id);
        }
    };
	</script>
</body>
</html>