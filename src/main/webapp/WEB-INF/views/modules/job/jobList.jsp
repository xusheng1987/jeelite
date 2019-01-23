<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>定时任务管理</title>
  <meta name="decorator" content="default"/>
  <script type="text/javascript">
    //暂停任务
    function pauseJob() {
		var ids = getSelectedIds();
		if (ids.length == 0) {
			layer.msg('请先选择任务', {icon: 2});
			return;
		}
		$.ajax({
			type: "POST",
			url: "${ctx}/job/pause",
			contentType: "application/json",
			data: JSON.stringify(ids),
			success: function(result) {
				if (result.code == '200') {
					reloadTable();
					layer.msg(result.msg, {icon: 1});
				} else {
					layer.alert(result.msg, {icon: 2});
				}
			}
		});
    }
    //恢复任务
    function resumeJob() {
		var ids = getSelectedIds();
		if (ids.length == 0) {
			layer.msg('请先选择任务', {icon: 2});
			return;
		}
		$.ajax({
			type: "POST",
			url: "${ctx}/job/resume",
			contentType: "application/json",
			data: JSON.stringify(ids),
			success: function(result) {
				if (result.code == '200') {
					reloadTable();
					layer.msg(result.msg, {icon: 1});
				} else {
					layer.alert(result.msg, {icon: 2});
				}
			}
		});
    }
    //立即执行任务
    function runJob(id) {
    	confirmx('确认要执行该任务吗？', function() {
			$.post("${ctx}/job/run", {"id":id}, function(result) {
				if (result.code == '200') {
					layer.msg(result.msg, {icon: 1});
				} else {
					layer.alert(result.msg, {icon: 2});
				}
			});
    	});
    }
  </script>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <div class="layui-card-header">定时任务列表</div>
      <div class="layui-card-body">
        <div id="searchForm" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">bean名称：</label>
              <div class="layui-input-inline">
                <input name="beanName" type="text" maxlength="100" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">方法名：</label>
              <div class="layui-input-inline">
                <input name="methodName" type="text" maxlength="100" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">任务状态</label>
              <div class="layui-input-inline">
                <select name="status">
                  <option value=""></option>
                  <c:forEach items="${fns:getDictList('job_status')}" var="dict">
                  <option value="${dict.value}">${dict.label}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="layui-inline">
              <input id="btnSearch" class="layui-btn layui-btn-normal" type="button" value="查询"/>
              <shiro:hasPermission name="job:edit">
              <input class="layui-btn" type="button" value="添加" onclick="openDialog('定时任务添加', '${ctx}/job/form')"/>
              <input class="layui-btn layui-btn-danger" type="button" value="删除" onclick="batchDelete('${ctx}/job/delete')"/>
              <input class="layui-btn layui-btn-warm" type="button" value="暂停" onclick="confirmx('确认要暂停选中的任务吗？', pauseJob)"/>
              <input class="layui-btn" style="background-color:#5FB878" type="button" value="恢复" onclick="confirmx('确认要恢复选中的任务吗？', resumeJob)"/>
              </shiro:hasPermission>
            </div>
            <div class="layui-inline" style="position:absolute;right:20px">
              <input class="layui-btn layui-btn-normal" type="button" onclick="openIframe('定时任务日志列表', '${ctx}/job/log', '100%', '100%')" value="日志列表"/>
            </div>
          </div>
        </div>
        <table class="layui-table"></table>
      </div>
    </div>
  </div>
  <script type="text/html" id="bar">
    <a href="javascript:void(0)" class="layui-btn layui-btn-normal layui-btn-sm" onclick="runJob('{{d.id}}')"><i class="layui-icon layui-icon-triangle-r"></i>执行</a>
    <a href="javascript:void(0)" class="layui-btn layui-btn-sm" onclick="openDialog('定时任务修改', '${ctx}/job/form?id={{d.id}}')"><i class="layui-icon layui-icon-edit"></i>修改</a>
  </script>
  <script type="text/javascript">
    $(document).ready(function() {
      //执行渲染
      table.render({
        url: '${ctx}/job/data' //数据接口
        ,cols: [[ //表头
          {type: 'numbers', fixed:'left'}
          ,{type: 'checkbox', fixed:'left'}
          ,{field: 'beanName', sort: true, title: 'bean名称'}
          ,{field: 'methodName', title: '方法名'}
          ,{field: 'params', title: '参数'}
          ,{field: 'cronExpression', title: 'cron表达式'}
          ,{title: '任务状态', templet: function(d) {
        	  if(d.status == '0') {
        		  return '<span class="layui-badge layui-bg-green" style="height:30px;line-height:30px;">正常</span>';
        	  } else if(d.status == '1') {
        		  return '<span class="layui-badge layui-bg-orange" style="height:30px;line-height:30px;">暂停</span>';
        	  }
           }}
          ,{field: 'nextExecutionDate', title: '下次执行时间'}
          ,{field: 'remark', title: '备注'}
          ,{field: 'updateDate', sort: true, title: '更新时间'}
          <shiro:hasPermission name="job:edit">
          ,{fixed:'right', align:'center', width:180, title: '操作', toolbar:'#bar'}
          </shiro:hasPermission>
        ]]
      });
    });
  </script>
</body>
</html>