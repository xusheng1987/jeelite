<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务器监控</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<form:form id="inputForm" modelAttribute="sysInfo" action="" class="layui-form">
<div style="padding: 20px; background-color: #F2F2F2;">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md6">
      <div class="layui-card">
        <div class="layui-card-header"><b>CPU</b></div>
        <div class="layui-card-body">
          <div class="layui-row">
            <div class="layui-col-md6"><b>属性</b></div>
            <div class="layui-col-md6"><b>值</b></div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md6">核心数</div>
            <div class="layui-col-md6">${sysInfo.cpuCoreNum}</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md6">系统使用率</div>
            <div class="layui-col-md6">${sysInfo.cpuSysUsage}%</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md6">用户使用率</div>
            <div class="layui-col-md6">${sysInfo.cpuUserUsage}%</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md6">当前空闲率</div>
            <div class="layui-col-md6">${sysInfo.cpuFreeRate}%</div>
          </div>
          <hr>
        </div>
      </div>
    </div>
    <div class="layui-col-md6">
      <div class="layui-card">
        <div class="layui-card-header"><b>内存</b></div>
        <div class="layui-card-body">
          <div class="layui-row">
            <div class="layui-col-md4"><b>属性</b></div>
            <div class="layui-col-md4"><b>系统内存</b></div>
            <div class="layui-col-md4"><b>JVM内存</b></div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md4">内存总量</div>
            <div class="layui-col-md4">${sysInfo.memoryTotal}G</div>
            <div class="layui-col-md4">${sysInfo.jvmTotal}M</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md4">已用内存</div>
            <div class="layui-col-md4">${sysInfo.memoryUsed}G</div>
            <div class="layui-col-md4">${sysInfo.jvmUsed}M</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md4">剩余内存</div>
            <div class="layui-col-md4">${sysInfo.memoryFree}G</div>
            <div class="layui-col-md4">${sysInfo.jvmFree}M</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md4">内存使用率</div>
            <div class="layui-col-md4">${sysInfo.memoryUsage}%</div>
            <div class="layui-col-md4">${sysInfo.jvmUsage}%</div>
          </div>
          <hr>
        </div>
      </div>
    </div>
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header"><b>服务器信息</b></div>
        <div class="layui-card-body">
          <div class="layui-row">
            <div class="layui-col-md3">服务器名称</div>
            <div class="layui-col-md3">${sysInfo.serverName}</div>
            <div class="layui-col-md3">操作系统</div>
            <div class="layui-col-md3">${sysInfo.osName}</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md3">服务器IP</div>
            <div class="layui-col-md3">${sysInfo.serverIp}</div>
            <div class="layui-col-md3">系统架构</div>
            <div class="layui-col-md3">${sysInfo.osArch}</div>
          </div>
          <hr>
        </div>
      </div>
    </div>
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header"><b>JVM信息</b></div>
        <div class="layui-card-body">
          <div class="layui-row">
            <div class="layui-col-md3">JDK版本</div>
            <div class="layui-col-md3">${sysInfo.jdkVersion}</div>
            <div class="layui-col-md3">JDK路径</div>
            <div class="layui-col-md3">${sysInfo.jdkHome}</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md3">启动时间</div>
            <div class="layui-col-md3">${sysInfo.jvmStartTime}</div>
            <div class="layui-col-md3">运行时间</div>
            <div class="layui-col-md3">${sysInfo.jvmRunTime}</div>
          </div>
          <hr>
          <div class="layui-row">
            <div class="layui-col-md3">项目路径</div>
            <div class="layui-col-md3">${sysInfo.projectPath}</div>
          </div>
          <hr>
        </div>
      </div>
    </div>
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header"><b>磁盘状态</b></div>
        <div class="layui-card-body">
          <div class="layui-row">
            <div class="layui-col-md2"><b>盘符路径</b></div>
            <div class="layui-col-md2"><b>文件系统</b></div>
            <div class="layui-col-md2"><b>磁盘总大小</b></div>
            <div class="layui-col-md2"><b>磁盘剩余大小</b></div>
            <div class="layui-col-md2"><b>磁盘使用量</b></div>
            <div class="layui-col-md2"><b>磁盘使用率</b></div>
          </div>
          <hr>
        <c:forEach items="${sysInfo.diskInfos}" var="diskInfo">
          <div class="layui-row">
            <div class="layui-col-md2">${diskInfo.drivePath}</div>
            <div class="layui-col-md2">${diskInfo.fileSystem}</div>
            <div class="layui-col-md2">${diskInfo.diskTotal}</div>
            <div class="layui-col-md2">${diskInfo.diskFree}</div>
            <div class="layui-col-md2">${diskInfo.diskUsed}</div>
            <div class="layui-col-md2">${diskInfo.diskUsage}%</div>
          </div>
          <hr>
        </c:forEach>
        </div>
      </div>
    </div>
  </div>
</div>
</form:form>
</body>
</html>