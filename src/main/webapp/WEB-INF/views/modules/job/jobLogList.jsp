<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>定时任务日志管理</title>
  <meta name="decorator" content="default"/>
</head>
<body>
  <div class="layui-fluid">
    <div class="layui-card">
      <%--<div class="layui-card-header">定时任务日志列表</div> --%>
      <div class="layui-card-body">
        <div id="searchForm" class="layui-form">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">bean名称：</label>
              <div class="layui-input-inline">
                <input name="beanName" type="text" maxlength="200" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">方法名：</label>
              <div class="layui-input-inline">
                <input name="methodName" type="text" maxlength="100" class="layui-input input-medium"/>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">执行状态：</label>
              <div class="layui-input-inline">
                <select name="status">
                  <option value="">全部</option>
                  <option value="0">成功</option>
                  <option value="1">失败</option>
                </select>
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">创建时间：</label>
              <div class="layui-input-inline input-medium">
                <input name="beginCreateDate" id="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:'#F{$dp.$D(\'endCreateDate\')||\'%y-%M-%d\'}'});"/>
              </div>
              <div class="layui-form-mid">-</div>
              <div class="layui-input-inline input-medium">
                <input name="endCreateDate" id="endCreateDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,minDate:'#F{$dp.$D(\'beginCreateDate\')}',maxDate:'%y-%M-%d'});"/>
              </div>
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
        url: '${ctx}/job/log/data' //数据接口
        ,cols: [[ //表头
           {field: 'beanName', title: 'bean名称'}
          ,{field: 'methodName', title: '方法名'}
          ,{field: 'params', title: '参数'}
          ,{title: '执行状态', templet: function(d) {
        	  if(d.status == '0') {
        		  return '<span class="layui-badge layui-bg-green" style="height:30px;line-height:30px;">成功</span>';
        	  } else if(d.status == '1') {
        		  return '<span class="layui-badge layui-bg-red" style="height:30px;line-height:30px;">失败</span>';
        	  }
           }}
          ,{field: 'costTime', title: '耗时(毫秒)'}
          ,{field: 'createDate', title: '执行时间'}
        ]]
      });
    });
  </script>
</body>
</html>