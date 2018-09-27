package com.github.flying.jeelite.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletResponse;

import org.jxls.common.Context;
import org.jxls.expression.JexlExpressionEvaluator;
import org.jxls.transform.Transformer;
import org.jxls.transform.poi.PoiTransformer;
import org.jxls.util.JxlsHelper;

/**
 * 模板形式导出Excel文件
 */
public class JxlsUtils {
	private static final String TEMPLATE_PATH = "jxls-template";

	public static void exportExcel(InputStream is, OutputStream os, Map<String, Object> model) throws IOException {
		Context context = PoiTransformer.createInitialContext();
		if (model != null) {
			for (Entry<String, Object> e: model.entrySet()) {
				context.putVar(e.getKey(), e.getValue());
			}
		}
		JxlsHelper jxlsHelper = JxlsHelper.getInstance();
		Transformer transformer = jxlsHelper.createTransformer(is, os);
		// 获得配置
		JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig()
				.getExpressionEvaluator();
		// 设置静默模式，不报警告
		evaluator.getJexlEngine().setSilent(true);
		jxlsHelper.setUseFastFormulaProcessor(false).processTemplate(context, transformer);
	}

	public static void exportExcel(File xls, File out, Map<String, Object> model)
			throws IOException {
		exportExcel(new FileInputStream(xls), new FileOutputStream(out), model);
	}

	public static void exportExcel(HttpServletResponse response, String templateName, String fileName,
			Map<String, Object> model) throws IOException {
		File template = getTemplate(templateName);
		if (template != null) {
			// 让浏览器弹出文件下载框
			response.reset();
			response.setContentType("application/octet-stream; charset=utf-8");
			response.setHeader("Content-Disposition", "attachment; filename=" + Encodes.urlEncode(fileName));
			OutputStream os = response.getOutputStream();
			exportExcel(new FileInputStream(template), os, model);
			os.close();
		}
	}

	/**
	 *  获取jxls模版文件
	 */
	public static File getTemplate(String name) {
		String templatePath = JxlsUtils.class.getClassLoader().getResource(TEMPLATE_PATH).getPath();
		File template = new File(templatePath, name);
		if (template.exists()) {
			return template;
		}
		return null;
	}

}