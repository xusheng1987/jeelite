<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
  <div class="layui-side layui-bg-black" id="menu-${param.parentId}">
	<c:set var="menuList" value="${fns:getMenuList()}"/><c:set var="firstMenu" value="true"/>
    <div class="layui-side-scroll">
      <ul class="layui-nav layui-nav-tree">
	<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
	<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">${menu.name}</a>
          <dl class="layui-nav-child">
			<c:forEach items="${menuList}" var="menu2">
			<c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
            <dd><a data-href=".menu3-${menu2.id}" href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" target="${not empty menu2.target ? menu2.target : 'mainFrame'}" ><span>${menu2.name}</span></a></dd>
            </c:if></c:forEach>
          </dl>
        </li>
        </c:if></c:forEach>
      </ul>
    </div>
  </div>