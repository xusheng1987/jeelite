<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/form.js" type="text/javascript"></script>
<script type="text/javascript">
	function submitHandler() {
		$("input[type=checkbox]").each(function(){
			$(this).after("<input type=\"hidden\" name=\""+$(this).attr("dataName")+"\" value=\""
					+($(this).is(":checked")?"1":"0")+"\"/>");
		});
	}
</script>
<div class="layui-fluid">
	<form:form id="inputForm" modelAttribute="genTable" action="${ctx}/gen/genTable/save" method="post" class="layui-form">
		<form:hidden path="id"/>
		<fieldset class="layui-elem-field layui-field-title">
			<legend>基本信息</legend>
		</fieldset>
			<div class="layui-form-item">
				<label class="layui-form-label">表名:</label>
				<div class="layui-input-inline">
					<form:input path="name" htmlEscape="false" maxlength="200" class="required layui-input" readonly="true"/>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">说明:</label>
				<div class="layui-input-inline">
					<form:input path="comments" htmlEscape="false" maxlength="200" class="required layui-input"/>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">类名:</label>
				<div class="layui-input-inline">
					<form:input path="className" htmlEscape="false" maxlength="200" class="required layui-input"/>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">父表表名:</label>
					<div class="layui-input-inline">
						<form:select path="parentTable">
							<form:option value="">无</form:option>
							<form:options items="${tableList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">当前表外键:</label>
					<div class="layui-input-inline">
						<form:select path="parentTableFk">
							<form:option value="">无</form:option>
							<form:options items="${genTable.columnList}" itemLabel="nameAndComments" itemValue="name" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div class="layui-inline">
					<div class="layui-form-mid layui-word-aux">如果有父表，请指定父表表名和外键</div>
				</div>
			</div>
			<div class="layui-form-item hide">
				<label class="layui-form-label">备注:</label>
				<div class="layui-input-inline">
					<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="layui-textarea"/>
				</div>
			</div>
		<fieldset class="layui-elem-field layui-field-title">
			<legend>字段列表</legend>
		</fieldset>
			<div style="margin:15px">
				<table id="contentTable" class="layui-table" lay-even>
					<thead><tr><th title="数据库字段名">列名</th><th title="默认读取数据库字段备注">说明</th><th title="数据库中设置的字段类型及长度">物理类型</th><th title="实体对象的属性字段类型">Java类型</th>
						<th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">Java属性名称 <i class="icon-question-sign"></i></th>
						<th title="是否是数据库主键">主键</th><th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
						<th title="选中后该字段被加入到update语句里">编辑</th><th title="选中后该字段被加入到查询列表里">列表</th>
						<th title="选中后该字段被加入到查询条件里">查询</th><th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
						<th title="字段在表单中显示的类型">显示表单类型</th><th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th><th>排序</th></tr></thead>
					<tbody>
					<c:forEach items="${genTable.columnList}" var="column" varStatus="vs">
						<tr${column.delFlag eq '1'?' class="error" title="已删除的列，保存之后消失！"':''}>
							<td nowrap>
								<input type="hidden" name="columnList[${vs.index}].id" value="${column.id}"/>
								<input type="hidden" name="columnList[${vs.index}].delFlag" value="${column.delFlag}"/>
								<input type="hidden" name="columnList[${vs.index}].genTable.id" value="${column.genTable.id}"/>
								<input type="hidden" name="columnList[${vs.index}].name" value="${column.name}"/>${column.name}
							</td>
							<td>
								<input type="text" name="columnList[${vs.index}].comments" value="${column.comments}" maxlength="200" class="required layui-input" style="width:150px;"/>
							</td>
							<td nowrap>
								<input type="hidden" name="columnList[${vs.index}].jdbcType" value="${column.jdbcType}"/>${column.jdbcType}
							</td>
							<td>
							<div style="width:100px;">
								<select name="columnList[${vs.index}].javaType" class="required">
									<c:forEach items="${config.javaTypeList}" var="dict">
										<option value="${dict.value}" ${dict.value==column.javaType?'selected':''} title="${dict.description}">${dict.label}</option>
									</c:forEach>
								</select>
							</div>
							</td>
							<td>
								<input type="text" name="columnList[${vs.index}].javaField" value="${column.javaField}" maxlength="200" class="required layui-input" style="width:120px;"/>
							</td>
							<td>
								<input type="checkbox" lay-skin="primary" dataName="columnList[${vs.index}].isPk" value="1" ${column.isPk eq '1' ? 'checked' : ''}/>
							</td>
							<td>
								<input type="checkbox" lay-skin="primary" dataName="columnList[${vs.index}].isNull" value="1" ${column.isNull eq '1' ? 'checked' : ''}/>
							</td>
							<td>
								<input type="checkbox" lay-skin="primary" dataName="columnList[${vs.index}].isEdit" value="1" ${column.isEdit eq '1' ? 'checked' : ''}/>
							</td>
							<td>
								<input type="checkbox" lay-skin="primary" dataName="columnList[${vs.index}].isList" value="1" ${column.isList eq '1' ? 'checked' : ''}/>
							</td>
							<td>
								<input type="checkbox" lay-skin="primary" dataName="columnList[${vs.index}].isQuery" value="1" ${column.isQuery eq '1' ? 'checked' : ''}/>
							</td>
							<td>
							<div style="width:100px;">
								<select name="columnList[${vs.index}].queryType" class="required input-mini">
									<c:forEach items="${config.queryTypeList}" var="dict">
										<option value="${fns:escapeHtml(dict.value)}" ${fns:escapeHtml(dict.value)==column.queryType?'selected':''} title="${dict.description}">${fns:escapeHtml(dict.label)}</option>
									</c:forEach>
								</select>
							</div>
							</td>
							<td>
							<div style="width:100px;">
								<select name="columnList[${vs.index}].showType" class="required" style="width:100px;">
									<c:forEach items="${config.showTypeList}" var="dict">
										<option value="${dict.value}" ${dict.value==column.showType?'selected':''} title="${dict.description}">${dict.label}</option>
									</c:forEach>
								</select>
							</div>
							</td>
							<td>
								<input type="text" name="columnList[${vs.index}].dictType" value="${column.dictType}" maxlength="200" class="layui-input" style="width:100px;"/>
							</td>
							<td>
								<input type="text" name="columnList[${vs.index}].sort" value="${column.sort}" maxlength="200" class="required layui-input digits" style="width:40px;"/>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<shiro:hasPermission name="gen:genTable:edit"><input id="btnSubmit" class="layui-btn" type="button" value="保 存"/>&nbsp;</shiro:hasPermission>
				<input id="btnClose" class="layui-btn layui-btn-normal" type="button" value="关 闭"/>
			</div>
		</div>
	</form:form>
</div>