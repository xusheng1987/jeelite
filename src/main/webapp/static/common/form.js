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
//isReloadPage：是否重新加载当前页面
function submitData(isReloadPage) {
	if($("#inputForm").valid()) {//前端校验
		var loadIndex = layer.load();
		// 提交前执行方法，需在各页面单独定义
		if (typeof submitHandler != "undefined") {
			submitHandler();
		}
		$.post($("#inputForm").attr("action"), $("#inputForm").serialize(), function (result) {
			if (result.code == '200') {
				if (isReloadPage) {
					location.reload();
				} else {
					layer.closeAll();
					reloadTable();
					layer.msg(result.msg, {icon: 1});
				}
			} else {
				layer.close(loadIndex);
				layer.alert(result.msg, {icon: 2});
			}
		});
	}
}