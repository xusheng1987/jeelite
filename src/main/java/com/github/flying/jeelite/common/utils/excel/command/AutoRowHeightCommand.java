package com.github.flying.jeelite.common.utils.excel.command;

import org.apache.poi.ss.usermodel.Row;
import org.jxls.area.Area;
import org.jxls.command.AbstractCommand;
import org.jxls.common.CellRef;
import org.jxls.common.Context;
import org.jxls.common.Size;
import org.jxls.transform.poi.PoiTransformer;

/**
 * jxls自定义命令-自动调整行高，需同步修改
 * 1：模板文件中相应的单元格格式设置为自动换行
 * 2：批注：jx:each下另起一行，加上jx:autoRowHeight(lastCell="XX")
 *
 */
public class AutoRowHeightCommand extends AbstractCommand {

	@Override
	public String getName() {
		return "autoRowHeight";
	}

	@Override
	public Size applyAt(CellRef cellRef, Context context) {
		Area area = this.getAreaList().get(0);
		Size size = area.applyAt(cellRef, context);

		PoiTransformer transformer = (PoiTransformer) area.getTransformer();
		Row row = transformer.getWorkbook().getSheet(cellRef.getSheetName()).getRow(cellRef.getRow());
		row.setHeight((short) -1);

		return size;
	}

}