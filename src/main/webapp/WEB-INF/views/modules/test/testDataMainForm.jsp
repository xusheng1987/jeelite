<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<script type="text/javascript">
	function addRow(list, idx, tpl, row){
		var laytpl = layui.laytpl;
		var data = {"idx":idx, "row":row};
		laytpl(tpl.innerHTML).render(data, function(html){
			$(list).append(html);
		});
		$(list+idx).find("select").each(function(){
			$(this).val($(this).attr("data-value"));
		});
		$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
			var ss = $(this).attr("data-value").split(',');
			for (var i=0; i<ss.length; i++){
				if($(this).val() == ss[i]){
					$(this).attr("checked","checked");
				}
			}
		});
	}
	function delRow(obj, prefix){
		var id = $(prefix+"_id");
		var delFlag = $(prefix+"_delFlag");
		if (id.val() == ""){
			$(obj).parent().parent().remove();
		}else if(delFlag.val() == "0"){
			delFlag.val("1");
			$(obj).html('<i class="layui-icon layui-icon-close-fill"></i>').attr("title", "撤销删除");
			$(obj).parent().parent().addClass("error");
		}else if(delFlag.val() == "1"){
			delFlag.val("0");
			$(obj).html('<i class="layui-icon layui-icon-delete"></i>').attr("title", "删除");
			$(obj).parent().parent().removeClass("error");
		}
	}
</script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="testDataMain" action="${ctx}/test/testDataMain/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<div class="layui-form-item">
			<label class="layui-form-label">归属用户：</label>
			<sys:treeselect id="user" name="user.id" value="${testDataMain.user.id}" labelName="user.name" labelValue="${testDataMain.user.name}"
				title="用户" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">归属部门：</label>
			<sys:treeselect id="office" name="office.id" value="${testDataMain.office.id}" labelName="office.name" labelValue="${testDataMain.office.name}"
				title="部门" url="/sys/office/treeData?type=2" allowClear="true" notAllowSelectParent="true"/>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">名称：</label>
			<div class="layui-input-inline">
				<form:input path="name" htmlEscape="false" maxlength="100" class="layui-input"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别：</label>
			<div class="layui-input-inline">
				<form:select path="sex">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">加入日期：</label>
			<div class="layui-input-inline">
				<input name="inDate" type="text" readonly="readonly" maxlength="20" class="layui-input Wdate"
					value="<fmt:formatDate value="${testDataMain.inDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注信息：</label>
			<div class="layui-input-inline">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="layui-textarea"/>
			</div>
		</div>
			<div class="layui-form-item">
				<label class="layui-form-label">业务数据子表：</label>
				<div class="layui-input-block">
					<table id="contentTable" class="layui-table">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>名称</th>
								<th>备注信息</th>
								<shiro:hasPermission name="test:testDataMain:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="testDataChildList">
						</tbody>
						<shiro:hasPermission name="test:testDataMain:edit"><tfoot>
							<tr><td colspan="4"><a href="javascript:" onclick="addRow('#testDataChildList', testDataChildRowIdx, testDataChildTpl);testDataChildRowIdx = testDataChildRowIdx + 1;" class="layui-btn layui-btn-primary">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/html" id="testDataChildTpl">
						<tr id="testDataChildList{{d.idx}}">
							<td class="hide">
								<input id="testDataChildList{{d.idx}}_id" name="testDataChildList[{{d.idx}}].id" type="hidden" value="{{# if(d.row){ }}{{d.row.id}}{{# } }}"/>
								<input id="testDataChildList{{d.idx}}_delFlag" name="testDataChildList[{{d.idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="testDataChildList{{d.idx}}_name" name="testDataChildList[{{d.idx}}].name" type="text" value="{{# if(d.row){ }}{{d.row.name}}{{# } }}" maxlength="100" class="layui-input"/>
							</td>
							<td>
								<input id="testDataChildList{{d.idx}}_remarks" name="testDataChildList[{{d.idx}}].remarks" type="text" value="{{# if(d.row){ }}{{d.row.remarks}}{{# } }}" maxlength="255" class="layui-input"/>
							</td>
							<shiro:hasPermission name="test:testDataMain:edit"><td width="10">
								<a href="javascript:void(0)" onclick="delRow(this, '#testDataChildList{{d.idx}}')"><i class="layui-icon layui-icon-delete"></i></a>
							</td></shiro:hasPermission>
						</tr>
					</script>
					<script type="text/javascript">
						var testDataChildRowIdx = 0;
						$(document).ready(function() {
							var data = ${fns:toJson(testDataMain.testDataChildList)};
							for (var i=0; i<data.length; i++){
								addRow('#testDataChildList', testDataChildRowIdx, testDataChildTpl, data[i]);
								testDataChildRowIdx = testDataChildRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="test:testDataMain:edit"><input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>