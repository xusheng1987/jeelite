<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">日志列表</div>
      <div class="layui-card-body">
        <div id="searchForm" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">用户ID：</label>
              <div class="layui-input-inline">
                <input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="layui-input"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">URI：</label>
              <div class="layui-input-inline">
                <input id="requestUri" name="requestUri" type="text" maxlength="50" class="layui-input"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">日期范围：</label>
              <div class="layui-input-inline input-medium">
                <input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
                       value="<fmt:formatDate value="${beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
              </div>
              <div class="layui-form-mid">-</div>
              <div class="layui-input-inline input-medium">
                <input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
                       value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
              </div>
            </div>
            <div class="layui-inline">
              <input type="checkbox" lay-skin="primary" id="exception" name="exception" title="只查询异常信息">
            </div>
            <div class="layui-inline">
              <input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
            </div>
          </div>
        </div>
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
  <script type="text/javascript">
	$(document).ready(function() {
		//执行渲染
		table.render({
		    url: '${ctx}/sys/log/data' //数据接口
		    ,cols: [[ //表头
		       {field: 'title',title: '操作菜单'}
		      ,{title: '操作用户', templet: function(d) {
		          return d.createBy.name
		       }}
		      ,{title: '所在公司', templet: function(d) {
		          return d.createBy.company.name
		       }}
		      ,{title: '所在部门', templet: function(d) {
		          return d.createBy.office.name
		       }}
		      ,{field: 'requestUri', title: 'URI'}
		      ,{field: 'method', title: '提交方式'}
		      ,{field: 'remoteAddr', title: '操作者IP'}
		      ,{field: 'createDate', title: '操作时间'}
		      ,{field: 'exception', title: '异常'}
		    ]]
		});
		form.on('checkbox', function(data){
			  console.log(data.elem); //得到checkbox原始DOM对象
			  console.log(data.elem.checked); //是否被选中，true或者false
			  console.log(data.value); //复选框value值，也可以通过data.elem.value得到
			  console.log(data.othis); //得到美化后的DOM对象
			});        
	});
	</script>
</body>
</html>