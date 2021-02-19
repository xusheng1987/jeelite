<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${productName}</title>
	<meta name="decorator" content="default"/><c:set var="tabmode" value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}"/>
	<script type="text/javascript">
		var element;
		$(document).ready(function() {
			element = layui.element;
			// 绑定菜单单击事件
			$("#menu a.menu").click(function(){
				// 一级菜单焦点
				$("#menu li.layui-nav-item").removeClass("layui-this");
				$(this).parent().addClass("layui-this");
				// 显示二级菜单
				var menuId = "#menu-" + $(this).attr("data-id");
				// 如果菜单已存在则直接显示
				if ($(menuId).length > 0){
					$("#left .layui-side").hide();
					$(menuId).show();
					// 默认选中左侧第一个三级菜单
					$(menuId + " .layui-nav-child a:first span").click();
				}else{
					// 获取二级菜单数据
					$.get($(this).attr("data-href"), function(data){
						// 未登录或登录超时的情况下，data是登录页面的内容
						if (data.indexOf("id=\"loginForm\"") != -1){
							alert('未登录或登录超时。请重新登录，谢谢！');
							top.location = "${ctx}";
							return false;
						}
						$("#left .layui-side").hide();
						$("#left").append(data);
						// 使导航的Hover效果生效
						element.render();
						// 展现三级菜单
						$(menuId + " .layui-nav-child a").click(function(){
							openMenu($(this));
						});
						// 默认选中左侧第一个三级菜单
						$(menuId + " .layui-nav-child a:first span").click();
					});
				}
				return false;
			});
			// 初始化点击第一个一级菜单
			$("#menu a.menu:first").click();
			// 右上角快捷菜单
			$("#userInfo a").mouseup(function(){
				openMenu($(this));
			});
		});
		function openMenu($this) {
			if ($this.attr("target") != "mainFrame") {
				$this.attr("href", $this.attr("data-href"));
				return;
			}
			// <c:if test="${tabmode eq '0'}"> 显示iframe
			$this.attr("href", $this.attr("data-href"));
			// iframe加载完毕以后执行的操作
			var loadIndex = layer.load();
			$("#mainFrame").load(function() {
				layer.close(loadIndex);
			}); // </c:if>
			// <c:if test="${tabmode eq '1'}"> 显示页签
			return addTab($this); // </c:if>
		}
		// <c:if test="${tabmode eq '1'}"> 添加一个页签
		function addTab($this){
			$(".layui-tab").show();
			var layId = $this.attr('data-id').substring(6);//取得tab的lay-id
			if (getlayId(layId) == -1) {//判断菜单是否已在tab打开
				var loadIndex = layer.load();
				element.tabAdd('tab', {
					title: '<i class="'+$this.children("i").attr("class")+'"></i><span>'+$this.text()+'</span>',
					content: '<iframe id="mainFrame_'+layId+'" name="mainFrame_'+layId+'" src="'+$this.attr('data-href')+'" scrolling="yes" frameborder="0"></iframe>',
					id: layId
				});
				$("#mainFrame_" + layId).load(function() {
					layer.close(loadIndex);
				});
			}
			element.tabChange('tab', layId);
		}
		function getlayId(layId){//查询要添加的tab是否已存在(-1:不存在，0:存在)
            var id = -1;
            $("ul.layui-tab-title").find("li").each(function(){//优先查询lay-id
                if(layId === $(this).attr("lay-id")){
                	id = 0;
                	return false;
                }
            });
            return id;
		}// </c:if>
	</script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin" id="main">
  <div id="header" class="layui-header">
    <div class="layui-logo">${productName}</div>
    <ul id="menu" class="layui-nav layui-layout-left">
    	<!-- 顶部导航菜单 -->
		<c:forEach items="${fns:getMenuList()}" var="menu">
			<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
				<li class="layui-nav-item">
    			<!-- 菜单下是功能模块 -->
				<c:if test="${empty menu.href}">
					<a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}">${menu.name}</a>
				</c:if>
    			<!-- 菜单直接对应单独的页面，一般很少用 -->
				<c:if test="${not empty menu.href}">
					<a class="menu" href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame">${menu.name}</a>
				</c:if>
				</li>
			</c:if>
		</c:forEach>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li id="userInfo" class="layui-nav-item">
        <a href="javascript:;">
          <c:if test="${not empty fns:getUser().photo}"><img src="${fns:getUser().photo}" class="layui-nav-img"></c:if>
          ${fns:getUser().name}
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:;" data-id="menu3-29" data-href="${ctx}/sys/user/info" target="mainFrame">个人信息</a></dd>
          <dd><a href="javascript:;" data-id="menu3-30" data-href="${ctx}/sys/user/modifyPwd" target="mainFrame">修改密码</a></dd>
          <dd><a href="javascript:cookie('tabmode','${tabmode eq '1' ? '0' : '1'}');location=location.href">${tabmode eq '1' ? '关闭' : '开启'}页签模式</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="${ctx}/logout">退出</a></li>
    </ul>
  </div>

  <div id="left"></div>
  <div id="right" class="layui-body">
  <c:if test="${tabmode eq '1'}">
	<div class="layui-tab layui-tab-card" lay-allowClose="true" lay-filter="tab" style="display:none">
		<ul class="layui-tab-title"></ul>
		<div class="layui-tab-content"></div>
	</div>
  </c:if>
  <c:if test="${tabmode eq '0'}">
	<div class="layui-tab-content">
		<iframe id="mainFrame" name="mainFrame" src="" scrolling="yes" frameborder="0"></iframe>
	</div>
  </c:if>
  </div>
</div>
</body>
</html>