var table, form;
$(document).ready(function() {
	table = layui.table;
	form = layui.form;
	// 设定表格全局默认参数
	table.set({
	    elem: '.layui-table'
	    ,id: 'table'
	    ,even: true //开启隔行背景
	    ,page: true //开启分页
	    ,where: queryParams() //接口的其它参数
	    ,request: {pageName: 'pageNo'} //对分页请求的参数重新设定名称
	});
	// 监听表格复选框选择
	table.on('checkbox', function(obj){
		var length = table.checkStatus('table').data.length;//获取选中数目
		if(length > 0) {
			$('#btnDelete').removeClass('layui-btn-disabled');
		} else {
			$('#btnDelete').addClass('layui-btn-disabled');
		}
		$('#btnDelete').prop('disabled', !table.checkStatus('table').data.length);
	});
	// 监听排序切换
	table.on('sort', function(obj){
		var params = queryParams();//请求参数
		params['field'] = obj.field; //排序字段
		params['order'] = obj.type; //排序方式：desc（降序）、asc（升序）、null（空对象，默认排序）
		table.reload('table', {
			initSort: obj, //记录初始排序，如果不设的话，将无法标记表头的排序状态
			where: params
		});
	});
	// 搜索
	$('#btnSearch').click(function () {
		reloadTable();
	});
});

// 获取URL地址参数
function getQueryString(name, url) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    if (!url || url == ""){
	    url = window.location.search;
    }else{
    	url = url.substring(url.indexOf("?"));
    }
    r = url.substr(1).match(reg)
    if (r != null) return unescape(r[2]); return null;
}

//获取字典标签
function getDictLabel(data, value, defaultValue) {
	for (var i=0; i<data.length; i++){
		var row = data[i];
		if (row.value == value){
			return row.label;
		}
	}
	return defaultValue;
}

//打开一个子页面
function openDialog(title, url, width, height) {
	var loadIndex = layer.load();
	// 设定默认宽高
	if (typeof(width) == "undefined") {
		 width = "60%";
	}
	if (typeof(height) == "undefined"){
		 height = "85%" ;
	}
	$.get(url, function (result) {
		layer.open({
			type: 1,
			title: title,
			content: result,
			area: [width, height],
			maxmin: true,
			success: function(layero, index){
				layer.close(loadIndex);
				// 更新渲染表单
				form.render();
			}
		});
	})
}

//打开一个iframe
function openIframe(title, url, width, height) {
	var loadIndex = layer.load();
	// 设定默认宽高
	if (typeof(width) == "undefined") {
		 width = "70%";
	}
	if (typeof(height) == "undefined"){
		 height = "85%" ;
	}
	layer.open({
		type: 2,
		title: title,
		content: url,
		area: [width, height],
		maxmin: true,
		success: function(layero, index){
			layer.close(loadIndex);
			// 更新渲染表单
			form.render();
		}
	});
}

// 确认对话框
function confirmx(mess, href){
	layer.confirm(mess, {icon: 3, title:'提示'}, function(index) {
		if (typeof href == 'function') {
			href();
		} else {
			$.post(href, function(result) {
				if (result.code == '200') {
					layer.closeAll();
					reloadTable();
					layer.msg(result.msg, {icon: 1});
				} else {
					layer.alert(result.msg, {icon: 2});
				}
			});
		}
	});
}
function deleteItem(mess, href) {
	layer.confirm(mess, {icon: 3, title:'提示'}, function(index) {
		$.post(href, function(result) {
			if (result.code == '200') {
				location.reload();
			} else {
				layer.alert(result.msg, {icon: 2});
			}
		});
	});
}
// cookie操作
function cookie(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + options.path : '';
        var domain = options.domain ? '; domain=' + options.domain : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
}

//截取字符串，区别汉字和英文
function abbr(name, maxLength){
 if(!maxLength){
     maxLength = 20;
 }
 if(name==null||name.length<1){
     return "";
 }
 var w = 0;//字符串长度，一个汉字长度为2
 var s = 0;//汉字个数
 var p = false;//判断字符串当前循环的前一个字符是否为汉字
 var b = false;//判断字符串当前循环的字符是否为汉字
 var nameSub;
 for (var i=0; i<name.length; i++) {
    if(i>1 && b==false){
         p = false;
    }
    if(i>1 && b==true){
         p = true;
    }
    var c = name.charCodeAt(i);
    //单字节加1
    if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
         w++;
         b = false;
    }else {
         w+=2;
         s++;
         b = true;
    }
    if(w>maxLength && i<=name.length-1){
         if(b==true && p==true){
             nameSub = name.substring(0,i-2)+"...";
         }
         if(b==false && p==false){
             nameSub = name.substring(0,i-3)+"...";
         }
         if(b==true && p==false){
             nameSub = name.substring(0,i-2)+"...";
         }
         if(p==true){
             nameSub = name.substring(0,i-2)+"...";
         }
         break;
    }
 }
 if(w<=maxLength){
     return name;
 }
 return nameSub;
}

function reloadTable() {
	// 表格存在的情况下才刷新
	if($(".layui-table").length > 0) {
		table.reload('table', {
	        page: {
	            curr: 1//重新从第 1 页开始
	        },
			where: queryParams()
		});
	}
}

function queryParams() {
	var params = {};
    $('#searchForm').find('input[name]').each(function () {
    	if($(this).is(":checkbox") || $(this).is(":radio")) {
    		if ($(this).is(":checked")) {
                params[$(this).attr('name')] = $(this).val();
    		}
    	} else {
            params[$(this).attr('name')] = $(this).val();
    	}
    });
    $('#searchForm').find('select').each(function () {
        params[$(this).attr('name')] = $(this).val();
    });
    return params;
}

function batchDelete(href) {
	layer.confirm('确认要删除选中的项目吗', {icon: 3, title:'提示'}, function(index){
		var data = table.checkStatus('table').data;
		var ids = [];
		$.each(data, function(index, element) {
			ids.push(element.id);
		});
		$.post(href + "?ids="+ids.join(","), function(result) {
			if (result.code == '200') {
				layer.close(index);
				reloadTable();
				layer.msg(result.msg, {icon: 1});
			} else {
				layer.alert(result.msg, {icon: 2});
			}
		});
	});
}