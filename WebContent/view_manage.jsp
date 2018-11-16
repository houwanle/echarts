<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%;height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>视图管理</title>
<style>a{text-decoration:none}</style>
</head>
<!-- 
<div id="navi" style="left:5%;top:0;width:90%;height:4.5%;position:absolute;border: 2px solid #000;font-size:22px;font-weight:bold">
<a href="source.jsp"><span style="color:#000">数据源</span></a>&nbsp;&nbsp;<a href="view_manage.jsp"><span style="color:red">视图管理</span></a>&nbsp;&nbsp;<a href="System2Servlet"><span style="color:#000">可视化控件管理</span></a>&nbsp;&nbsp;
</div>
<div style="left:5%;top:5%;width:90%;height:90%;position:absolute;border: 2px solid #000;">
<div style="left:2%;top:4%;width:94%;height:90%;position:absolute;">
 -->
<body style="width:100%;height:100%;margin:0">
<div id="navi" style="margin-left:5%;width:90%;height:4.5%;font-size:22px;font-weight:bold">
<a href="source.jsp"><span style="color:#000">数据源</span></a>&nbsp;&nbsp;<a href="view_manage.jsp"><span style="color:red">视图管理</span></a>&nbsp;&nbsp;<a href="System2Servlet"><span style="color:#000">可视化控件管理</span></a>&nbsp;&nbsp;
</div>
<div style="margin-left:5%;width:90%;height:90%;border: 1px solid #000;">
<div style="margin-left:2%;margin-top:1%;width:94%;height:89%;">
<div id="columnContent" style="margin-top:0.1%;width:92%;height:5%;border-bottom: 1px solid #000">
<div style="float:left;width:3%;height:100%"><input type="checkbox" id="checkall" onclick="changcheck()"/></div>
<div style="float:left;width:15%;height:100%">名字</div>
<div style="float:left;width:12%;height:100%">ip</div>
<div style="float:left;width:12%;height:100%">端口</div>
<div style="float:left;width:12%;height:100%">数据库</div>
<div style="float:left;width:10%;height:100%">用户名</div>
<div style="float:left;width:10%;height:100%">密码</div>
<div style="float:left;width:10%;height:100%">类型</div>
<div style="float:left;width:10%;height:100%">操作</div>
</div>
<%
List<List<String>> list = (List)request.getAttribute("list");
if(list != null) {
	for(int i = 1; i < list.size(); i++) {
	%>
<div style="margin-top:0.1%;width:92%;height:5%;border-bottom: 1px solid #000">
<div style="float:left;width:3%;height:100%"><input type="checkbox" name="check" value="<%=list.get(i).get(0)%>"/></div>
<div style="float:left;width:15%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(1)%></div>
<div style="float:left;width:12%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(2)%></div>
<div style="float:left;width:12%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(3)%></div>
<div style="float:left;width:12%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(4)%></div>
<div style="float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(5)%></div>
<div style="float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(6)%></div>
<div style="float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><%=list.get(i).get(7)%></div>
<div style="float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;"><a href="ShowViewServlet?id=<%=list.get(i).get(0)%>" target="_blank">查看</a>&nbsp;<a href="DeleteViewServlet?id=<%=list.get(i).get(0)%>">删除</a></div>
</div>
	<%
	}
}
%>
</div>
<div id="pageContent" style="margin-left:2%;margin-top:2%;width:90%;height:4%;">
<a href="javascript:operation('f')">首页</a>&nbsp;<a href="javascript:operation('-')">上一页</a>
<span id="pageClick"></span>
<a href="javascript:operation('+')">下一页 </a>&nbsp;<a href="javascript:operation('e')">尾页</a>
</div>
</div>
<form id="myForm" action="GetViewServlet" method="post">
<input type="hidden" id="pageSum" name="pageSum" value="${requestScope.pageSum }"/>
<input type="hidden" id="pageCur" name="pageCur" value="${requestScope.pageCur }"/>
</form>
<div id="navi" style="margin-left:5%;margin-top:0;width:90%;height:4.5%;text-align:center;font-size:22px;">
版权所有
</div>
<script type="text/javascript">
function operation(type) {
	var pageSum = parseInt(document.getElementById("pageSum").value);
	var pageCur = parseInt(document.getElementById("pageCur").value);
	if(type=="+") {
		if(pageCur < pageSum) {
			pageCur++;
			document.getElementById("pageCur").value = pageCur;
			document.getElementById("myForm").submit();
		}
	} else if(type=="-") {
		if(pageCur - 1 > 0) {
			pageCur--;
			document.getElementById("pageCur").value = pageCur;
			document.getElementById("myForm").submit();
		}
	} else if(type=="f") {
		document.getElementById("pageCur").value = 1;
		document.getElementById("myForm").submit();
	} else if(type=="e") {
		document.getElementById("pageCur").value = pageSum;
		document.getElementById("myForm").submit();
	} else {
		document.getElementById("pageCur").value = type;
		document.getElementById("myForm").submit();
	}
}

function addclick() {
	var pageSum = parseInt(document.getElementById("pageSum").value);
	var pageCur = parseInt(document.getElementById("pageCur").value);
	var pageClick = document.getElementById("pageClick");
	var str = "";
	if(pageSum < 6) {
		for(var i = 1; i < pageSum + 1; i++) {
			if(pageCur == i) {
				str = str + "<a href=\"javascript:operation(" + i + ")\"><span style=\"color:red;font-size:18px;font-weight:bold\">" + i + "</span></a>&nbsp;";
			} else {
				str = str + "<a href=\"javascript:operation(" + i + ")\">" + i + "</a>&nbsp;";
			}
		}
	} else {
		if(pageCur < 4) {
			for(var i = 1; i < 6; i++) {
				if(pageCur == i) {
					str = str + "<a href=\"javascript:operation(" + i + ")\"><span style=\"color:red;font-size:18px;font-weight:bold\">" + i + "</span></a>&nbsp;";
				} else {
					str = str + "<a href=\"javascript:operation(" + i + ")\">" + i + "</a>&nbsp;";
				}
			}
		} else if(pageCur + 3 > pageSum) {
			for(var i = pageSum; i > pageSum - 5; i--) {
				if(pageCur == i) {
					str = str + "<a href=\"javascript:operation(" + i + ")\"><span style=\"color:red;font-size:18px;font-weight:bold\">" + i + "</span></a>&nbsp;";
				} else {
					str = str + "<a href=\"javascript:operation(" + i + ")\">" + i + "</a>&nbsp;";
				}
			}
		} else {
			for(var i = pageCur - 2; i < pageSum + 3; i++) {
				if(pageCur == i) {
					str = str + "<a href=\"javascript:operation(" + i + ")\"><span style=\"color:red;font-size:18px;font-weight:bold\">" + i + "</span></a>&nbsp;";
				} else {
					str = str + "<a href=\"javascript:operation(" + i + ")\">" + i + "</a>&nbsp;";
				}
			}
		}
	}
	pageClick.innerHTML = str;
}

//实现多选框全选，反选
function changcheck() {
	var checks = document.getElementsByName("check");
	if(document.getElementById("checkall").checked) {
		for(var i = 0; i < checks.length; i++) {
			checks[i].checked = true;
		}
	} else {
		for(var i = 0; i < checks.length; i++) {
			checks[i].checked = false;
		}
	}
}

if(document.getElementById("pageSum").value == "") {
	document.getElementById("myForm").submit();
} else {
	addclick();
}

</script>
</body>
</html>