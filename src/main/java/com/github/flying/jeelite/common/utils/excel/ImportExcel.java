/**
 * Copyright &copy; 2017-2018 <a href="https://github.com/xusheng1987/jeelite">jeelite</a> All rights reserved.
 */
package com.github.flying.jeelite.common.utils.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.github.flying.jeelite.common.utils.NumberUtils;
import com.github.flying.jeelite.common.utils.Reflections;
import com.github.flying.jeelite.common.utils.excel.annotation.ExcelField;
import com.github.flying.jeelite.modules.sys.utils.DictUtils;

/**
 * 导入Excel文件（支持“XLS”和“XLSX”格式）
 *
 * @author flying
 * @version 2013-03-10
 */
public class ImportExcel {

	private static Logger log = LoggerFactory.getLogger(ImportExcel.class);

	/**
	 * 工作薄对象
	 */
	private Workbook wb;

	/**
	 * 工作表对象
	 */
	private Sheet sheet;

	/**
	 * 标题行号
	 */
	private int headerNum;
	
	/**
	 * 公式
	 */
	private FormulaEvaluator formulaEvaluator;
	
	/**
	 * 格式化单元格的值，防止精度丢失
	 */
	private DecimalFormat numberFormat;
	
	private double format(double cellValue) {
		if (numberFormat == null) {
			numberFormat = new DecimalFormat("#.000000");
		}
		return Double.parseDouble(numberFormat.format(cellValue));
	}

	/**
	 * 构造函数
	 *
	 * @param path 导入文件，读取第一个工作表
	 * @param headerNum 标题行号，数据行号=标题行号+1
	 * @throws IOException
	 */
	public ImportExcel(String fileName, int headerNum) throws IOException {
		this(new File(fileName), headerNum);
	}

	/**
	 * 构造函数
	 *
	 * @param path 导入文件对象，读取第一个工作表
	 * @param headerNum 标题行号，数据行号=标题行号+1
	 * @throws IOException
	 */
	public ImportExcel(File file, int headerNum) throws IOException {
		this(file, headerNum, 0);
	}

	/**
	 * 构造函数
	 *
	 * @param path 导入文件
	 * @param headerNum 标题行号，数据行号=标题行号+1
	 * @param sheetIndex 工作表编号
	 * @throws IOException
	 */
	public ImportExcel(String fileName, int headerNum, int sheetIndex) throws IOException {
		this(new File(fileName), headerNum, sheetIndex);
	}

	/**
	 * 构造函数
	 *
	 * @param path 导入文件对象
	 * @param headerNum 标题行号，数据行号=标题行号+1
	 * @param sheetIndex 工作表编号
	 * @throws IOException
	 */
	public ImportExcel(File file, int headerNum, int sheetIndex) throws IOException {
		this(file.getName(), new FileInputStream(file), headerNum, sheetIndex);
	}

	/**
	 * 构造函数
	 *
	 * @param file 导入文件对象
	 * @param headerNum 标题行号，数据行号=标题行号+1
	 * @param sheetIndex 工作表编号
	 * @throws IOException
	 */
	public ImportExcel(MultipartFile multipartFile, int headerNum, int sheetIndex) throws IOException {
		this(multipartFile.getOriginalFilename(), multipartFile.getInputStream(), headerNum, sheetIndex);
	}

	/**
	 * 构造函数
	 *
	 * @param path 导入文件对象
	 * @param headerNum 标题行号，数据行号=标题行号+1
	 * @param sheetIndex 工作表编号
	 * @throws IOException
	 */
	public ImportExcel(String fileName, InputStream is, int headerNum, int sheetIndex) throws IOException {
		if (StringUtils.isBlank(fileName)) {
			throw new RuntimeException("导入文档为空!");
		} else if (fileName.toLowerCase().endsWith("xls")) {
			this.wb = new HSSFWorkbook(is);
		} else if (fileName.toLowerCase().endsWith("xlsx")) {
			this.wb = new XSSFWorkbook(is);
		} else {
			throw new RuntimeException("文档格式不正确!");
		}
		if (this.wb.getNumberOfSheets() < sheetIndex) {
			throw new RuntimeException("文档中没有工作表!");
		}
		this.sheet = this.wb.getSheetAt(sheetIndex);
		this.formulaEvaluator = wb.getCreationHelper().createFormulaEvaluator();
		this.headerNum = headerNum;
	}

	/**
	 * 获取行对象
	 */
	public Row getRow(int rownum) {
		return this.sheet.getRow(rownum);
	}

	/**
	 * 获取数据行号
	 */
	public int getDataRowNum() {
		return headerNum + 1;
	}

	/**
	 * 获取最后一个数据行号
	 */
	public int getLastDataRowNum() {
		return this.sheet.getLastRowNum() + headerNum;
	}

	/**
	 * 获取最后一个列号
	 */
	public int getLastCellNum() {
		return this.getRow(headerNum).getLastCellNum();
	}

	/**
	 * 获取单元格值
	 *
	 * @param row 获取的行
	 * @param column 获取单元格列号
	 * @return 单元格值
	 */
	public Object getCellValue(Row row, int column) {
		Cell cell = row.getCell(column);
		Object val = getCellValue(cell);
		return val;
	}
	
	public Object getCellValue(Cell cell) {
		Object val = "";
		try {
			if (cell != null) {
				if (cell.getCellTypeEnum() == CellType.NUMERIC) {
//					if (DateUtil.isCellDateFormatted(cell)) {// 单元格为日期
//						SimpleDateFormat sdf = null;
//						short format = cell.getCellStyle().getDataFormat();
//						if (format == 14 || format == 31 || format == 57 || format == 58
//								|| (176 <= format && format <= 178) || (182 <= format && format <= 196)
//								|| (210 <= format && format <= 213) || format == 208) { // 日期
//							sdf = new SimpleDateFormat("yyyy-MM-dd");
//						} else if (format == 20 || format == 32 || format == 183 || (200 <= format && format <= 209)) { // 时间
//							sdf = new SimpleDateFormat("HH:mm");
//						} else if (format == 22 || format == 179 || format == 180) { // 日期 + 时间
//							sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//						}
//						val = sdf.format(cell.getDateCellValue());
//					} else
					if (String.valueOf(cell.getNumericCellValue()).indexOf("E") > 0) {// 单元格为电话号码
						val = new DecimalFormat("#").format(cell.getNumericCellValue());
					} else {
						val = cell.getNumericCellValue();
					}
				} else if (cell.getCellTypeEnum() == CellType.STRING) {
					val = cell.getStringCellValue();
				} else if (cell.getCellTypeEnum() == CellType.FORMULA) {
					val = getCellValue(formulaEvaluator.evaluateInCell(cell));
					if (NumberUtils.isCreatable(val.toString())) {
						val = format(Double.parseDouble(val.toString()));
					}
				} else if (cell.getCellTypeEnum() == CellType.BOOLEAN) {
					val = cell.getBooleanCellValue();
				} else if (cell.getCellTypeEnum() == CellType.ERROR) {
					val = cell.getErrorCellValue();
				}
			}
		} catch (Exception e) {
			return val;
		}
		return val;
	}

	/**
	 * 获取导入数据列表
	 *
	 * @param cls 导入对象类型
	 * @param groups 导入分组
	 */
	public <E> List<E> getDataList(Class<E> cls, int... groups) throws InstantiationException, IllegalAccessException {
		List<Object[]> annotationList = Lists.newArrayList();
		// Get annotation field
		Field[] fs = cls.getDeclaredFields();
		for (Field f : fs) {
			ExcelField ef = f.getAnnotation(ExcelField.class);
			if (ef != null && (ef.type() == 0 || ef.type() == 2)) {
				if (groups != null && groups.length > 0) {
					boolean inGroup = false;
					for (int g : groups) {
						if (inGroup) {
							break;
						}
						for (int efg : ef.groups()) {
							if (g == efg) {
								inGroup = true;
								annotationList.add(new Object[] { ef, f });
								break;
							}
						}
					}
				} else {
					annotationList.add(new Object[] { ef, f });
				}
			}
		}
		// Get annotation method
		Method[] ms = cls.getDeclaredMethods();
		for (Method m : ms) {
			ExcelField ef = m.getAnnotation(ExcelField.class);
			if (ef != null && (ef.type() == 0 || ef.type() == 2)) {
				if (groups != null && groups.length > 0) {
					boolean inGroup = false;
					for (int g : groups) {
						if (inGroup) {
							break;
						}
						for (int efg : ef.groups()) {
							if (g == efg) {
								inGroup = true;
								annotationList.add(new Object[] { ef, m });
								break;
							}
						}
					}
				} else {
					annotationList.add(new Object[] { ef, m });
				}
			}
		}
		// Field sorting
		Collections.sort(annotationList, new Comparator<Object[]>() {
			@Override
			public int compare(Object[] o1, Object[] o2) {
				return new Integer(((ExcelField) o1[0]).sort()).compareTo(new Integer(((ExcelField) o2[0]).sort()));
			}
		});
		// Get excel data
		List<E> dataList = Lists.newArrayList();
		for (int i = this.getDataRowNum(); i < this.getLastDataRowNum(); i++) {
			E e = cls.newInstance();
			int column = 0;
			Row row = this.getRow(i);
			StringBuilder sb = new StringBuilder();
			for (Object[] os : annotationList) {
				Object val = this.getCellValue(row, column++);
				if (val != null) {
					ExcelField ef = (ExcelField) os[0];
					// If is dict type, get dict value
					if (StringUtils.isNotBlank(ef.dictType())) {
						val = DictUtils.getDictValue(val.toString(), ef.dictType(), "");
					}
					// Get param type and type cast
					Class<?> valType = Class.class;
					if (os[1] instanceof Field) {
						valType = ((Field) os[1]).getType();
					} else if (os[1] instanceof Method) {
						Method method = ((Method) os[1]);
						if ("get".equals(method.getName().substring(0, 3))) {
							valType = method.getReturnType();
						} else if ("set".equals(method.getName().substring(0, 3))) {
							valType = ((Method) os[1]).getParameterTypes()[0];
						}
					}
					try {
						if (valType == String.class) {
							String s = String.valueOf(val.toString());
							if (StringUtils.endsWith(s, ".0")) {
								val = StringUtils.substringBefore(s, ".0");
							} else {
								val = String.valueOf(val.toString());
							}
						} else if (valType == Integer.class) {
							val = Double.valueOf(val.toString()).intValue();
						} else if (valType == Long.class) {
							val = Double.valueOf(val.toString()).longValue();
						} else if (valType == Double.class) {
							val = Double.valueOf(val.toString());
						} else if (valType == Float.class) {
							val = Float.valueOf(val.toString());
						} else if (valType == Date.class) {
							val = DateUtil.getJavaDate((Double) val);
						} else {
							if (ef.fieldType() != Class.class) {
								val = ef.fieldType().getMethod("getValue", String.class).invoke(null, val.toString());
							} else {
								val = Class.forName(this.getClass().getName().replaceAll(this.getClass().getSimpleName(),
										"fieldtype." + valType.getSimpleName() + "Type"))
										.getMethod("getValue", String.class).invoke(null, val.toString());
							}
						}
					} catch (Exception ex) {
						log.warn("Get cell value [" + i + "," + column + "] error: " + ex.toString());
						val = null;
					}
					// set entity value
					if (os[1] instanceof Field) {
						Reflections.invokeSetter(e, ((Field) os[1]).getName(), val);
					} else if (os[1] instanceof Method) {
						String methodName = ((Method) os[1]).getName();
						if ("get".equals(methodName.substring(0, 3))) {
							methodName = "set" + StringUtils.substringAfter(methodName, "get");
						}
						Reflections.invokeMethod(e, methodName, new Class[] { valType }, new Object[] { val });
					}
				}
				sb.append(val + ", ");
			}
			dataList.add(e);
		}
		return dataList;
	}

}