/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.modules.gen.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.google.common.collect.Lists;
import com.github.flying.jeelite.common.persistence.DataEntity;
import com.github.flying.jeelite.common.utils.StringUtils;

/**
 * 业务表Entity
 * @author flying
 * @version 2013-10-15
 */
@TableName("gen_table")
public class GenTable extends DataEntity<GenTable> {

	private static final long serialVersionUID = 1L;
	private String name; 	// 名称
	private String comments;		// 描述
	private String className;		// 实体类名称
	private String parentTable;		// 关联父表
	private String parentTableFk;		// 关联父表外键

	@TableField(exist=false)
	private List<GenTableColumn> columnList = Lists.newArrayList();	// 表列

	@TableField(exist=false)
	private String nameLike; 	// 按名称模糊查询

	@TableField(exist=false)
	private List<String> pkList; // 当前表主键列表

	@TableField(exist=false)
	private GenTable parent;	// 父表对象
	@TableField(exist=false)
	private List<GenTable> childList = Lists.newArrayList();	// 子表列表

	public GenTable() {
		super();
	}

	public GenTable(String id){
		super(id);
	}

	@Length(min=1, max=200)
	public String getName() {
		return StringUtils.lowerCase(name);
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getParentTable() {
		return StringUtils.lowerCase(parentTable);
	}

	public void setParentTable(String parentTable) {
		this.parentTable = parentTable;
	}

	public String getParentTableFk() {
		return StringUtils.lowerCase(parentTableFk);
	}

	public void setParentTableFk(String parentTableFk) {
		this.parentTableFk = parentTableFk;
	}

	public List<String> getPkList() {
		return pkList;
	}

	public void setPkList(List<String> pkList) {
		this.pkList = pkList;
	}

	public String getNameLike() {
		return nameLike;
	}

	public void setNameLike(String nameLike) {
		this.nameLike = nameLike;
	}

	public GenTable getParent() {
		return parent;
	}

	public void setParent(GenTable parent) {
		this.parent = parent;
	}

	public List<GenTableColumn> getColumnList() {
		return columnList;
	}

	public void setColumnList(List<GenTableColumn> columnList) {
		this.columnList = columnList;
	}

	public List<GenTable> getChildList() {
		return childList;
	}

	public void setChildList(List<GenTable> childList) {
		this.childList = childList;
	}

	/**
	 * 获取列名和说明
	 */
	public String getNameAndComments() {
		return getName() + (comments == null ? "" : "  :  " + comments);
	}

	/**
	 * 获取导入依赖包字符串
	 */
	public List<String> getImportList(){
		List<String> importList = Lists.newArrayList(); // 引用列表
		for (GenTableColumn column : getColumnList()){
			if (column.getIsNotBaseField() || ("1".equals(column.getIsQuery()) && "between".equals(column.getQueryType())
							&& ("createDate".equals(column.getSimpleJavaField()) || "updateDate".equals(column.getSimpleJavaField())))){
				// 导入类型依赖包， 如果类型中包含“.”，则需要导入引用。
				if (StringUtils.indexOf(column.getJavaType(), ".") != -1 && !importList.contains(column.getJavaType())){
					importList.add(column.getJavaType());
				}
			}
			if (column.getIsNotBaseField()){
				// 导入JSR303、Json等依赖包
				for (String ann : column.getAnnotationList()){
					if (!importList.contains(StringUtils.substringBefore(ann, "("))){
						importList.add(StringUtils.substringBefore(ann, "("));
					}
				}
			}
		}
		// 如果有子表，则需要导入List相关引用
		if (getChildList() != null && getChildList().size() > 0){
			if (!importList.contains("java.util.List")){
				importList.add("java.util.List");
			}
			if (!importList.contains("com.google.common.collect.Lists")){
				importList.add("com.google.common.collect.Lists");
			}
		}
		// 导入mybatis-plus的依赖包
		importList.add("com.baomidou.mybatisplus.annotations.TableField");
		importList.add("com.baomidou.mybatisplus.annotations.TableName");
		return importList;
	}

	/**
	 * 是否存在父类
	 */
	public Boolean getParentExists(){
		return parent != null && StringUtils.isNotBlank(parentTable) && StringUtils.isNotBlank(parentTableFk);
	}

	/**
	 * 是否存在create_date列
	 */
	public Boolean getCreateDateExists(){
		for (GenTableColumn c : columnList){
			if ("create_date".equals(c.getName())){
				return true;
			}
		}
		return false;
	}

	/**
	 * 是否存在update_date列
	 */
	public Boolean getUpdateDateExists(){
		for (GenTableColumn c : columnList){
			if ("update_date".equals(c.getName())){
				return true;
			}
		}
		return false;
	}

	/**
	 * 是否存在del_flag列
	 */
	public Boolean getDelFlagExists(){
		for (GenTableColumn c : columnList){
			if ("del_flag".equals(c.getName())){
				return true;
			}
		}
		return false;
	}
}