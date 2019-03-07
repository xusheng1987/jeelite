$(document).ready(function() {
	// 关闭子页面
	$('#btnClose').click(function () {
		layer.closeAll();
	});
	// 提交表单
	$('#btnSubmit').click(function () {
		submitData(false);
	});
});
// 树表的form保存表单需调用此方法
function save() {
	submitData(true);
}
//isTreePage：是否为tree页面
function submitData(isTreePage) {
	if($("#inputForm").valid()) {//前端校验
		var loadIndex = layer.load();
		// 提交前执行方法，需在各页面单独定义
		if (typeof submitHandler != "undefined") {
			submitHandler();
		}
		$.post($("#inputForm").attr("action"), $("#inputForm").serialize(), function (result) {
			if (result.code == '200') {
				layer.closeAll();
				if (isTreePage) {
					// 刷新树表数据，此方法需要在树表页面单独定义
					reloadTree();
				} else {
					// 刷新表格数据
					reloadTable();
				}
				layer.msg(result.msg, {icon: 1});
			} else {
				layer.close(loadIndex);
				layer.alert(result.msg, {icon: 2});
			}
		});
	}
}