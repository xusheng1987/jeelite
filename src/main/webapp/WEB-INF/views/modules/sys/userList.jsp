<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				layer.confirm("确认要导出用户数据吗？", {icon: 3, title:'系统提示'}, function(index){
					$("#searchForm").attr("action","${ctx}/sys/user/export");
					$("#searchForm").submit();
					layer.close(index);
				});
			});
			$("#btnImport").click(function(){
				layer.open({
					type: 1,
					title: "导入数据",
					content: $("#importBox"),
					btn: "关闭",
					cancel: function(index, layero){
						$("#importBox").hide();
					},
					yes: function(index, layero){
						$("#importBox").hide();
						layer.close(index);
					}
				});
			});
			//批量删除
			$('#btnDelete').on('click', function(){
				batchDelete('${ctx}/sys/user/batchDelete');
			});
			//添加
			$('#btnAdd').on('click', function(){
				openDialog('用户添加', '${ctx}/sys/user/form');
			});
			var upload = layui.upload;
			//执行实例
			  var uploadInst = upload.render({
			    elem: '#btnImportSubmit' //绑定元素
			    ,url: '${ctx}/sys/user/import' //上传接口
				,accept: 'file'
			    ,exts: 'xlsx'
			    ,size: 10240 //限制文件大小10M，单位 KB
			    ,before: function(obj){//文件提交上传前的回调
			      layer.load(); //上传loading
			    }
			    ,done: function(result){
				  layer.closeAll('loading'); //关闭loading
			      //上传完毕回调
			      if (result.code == '200') {
					layer.msg(result.msg, {icon: 1});
				  } else {
					layer.alert(result.msg, {icon: 2});
				  }
			    }
			    ,error: function(){
			      //请求异常回调
			      layer.msg('上传失败');
			      layer.closeAll('loading'); //关闭loading
			    }
			  });
		});
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			style="text-align:center;width:300px;height:80px;"><br/>
			<button type="button" class="layui-btn" id="btnImportSubmit"><i class="layui-icon layui-icon-upload"></i>导    入</button>
			<span class="layui-text"><a href="${ctx}/sys/user/import/template">下载模板</a></span>
		</form>
	</div>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">用户列表</div>
      <div class="layui-card-body">
        <form id="searchForm" method="post" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">归属公司：</label>
              <sys:treeselect id="companySearch" name="company.id" value="" labelName="company.name" labelValue=""
                  title="公司" url="/sys/office/treeData?type=1" allowClear="true"/>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">登录名：</label>
              <div class="layui-input-inline">
                <input name="loginName" type="text" maxlength="50" class="layui-input input-medium"/>
              </div>
            </div>
          </div>
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">归属部门：</label>
              <sys:treeselect id="officeSearch" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
                  title="部门" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true"/>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">姓&nbsp;&nbsp;&nbsp;名：</label>
              <div class="layui-input-inline">
                <input name="name" type="text" maxlength="50" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline" style="margin-left:30px">
              <input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
              <input id="btnExport" class="layui-btn" style="background-color:#5FB878" type="button" value="导出"/>
              <shiro:hasPermission name="sys:user:edit">
			  <input id="btnImport" class="layui-btn layui-btn-warm" type="button" value="导入"/>
              <input id="btnAdd" class="layui-btn" type="button" value="添加"/>
			  </shiro:hasPermission>
            </div>
          </div>
        </form>
        <div class="layui-btn-group">
          <button class="layui-btn layui-btn-danger layui-btn-disabled" id="btnDelete" disabled><i class="layui-icon layui-icon-delete"></i>批量删除</button>
        </div>
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
  <script type="text/html" id="bar">
    <a href="javascript:void(0)" class="layui-btn layui-btn-sm" onclick="openDialog('用户修改', '${ctx}/sys/user/form?id={{d.id}}')"><i class="layui-icon layui-icon-edit"></i>修改</a>
  </script>
  <script type="text/javascript">
  $(document).ready(function() {
  	//执行渲染
  	table.render({
  	    url: '${ctx}/sys/user/data' //数据接口
  	    ,cols: [[ //表头
  	       {type: 'numbers', fixed:'left'}
  	      ,{type: 'checkbox', fixed:'left'}
  	      ,{title: '归属公司', templet: function(d) {
  	          return d.company.name
  	       }}
  	      ,{title: '归属部门', templet: function(d) {
  	          return d.office.name
  	       }}
  	      ,{field: 'loginName', title: '登录名', sort: true, templet: function(d) {
              var url = '${ctx}/sys/user/form?id='+d.id;
              return '<a href="javascript:void(0)" class="layui-table-link" onclick="openDialog(\'用户修改\', \''+url+'\')">'+d.loginName+'</a>'
  	       }}
  	      ,{field: 'name', title: '姓名'}
  	      ,{field: 'phone', title: '电话'}
  	      <shiro:hasPermission name="sys:user:edit">
  	      ,{fixed:'right', align:'center', width:120, title: '操作', toolbar:'#bar'}
  	      </shiro:hasPermission>
  	    ]]
  	});
  });
  </script>
</body>
</html>