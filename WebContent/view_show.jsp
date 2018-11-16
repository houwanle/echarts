<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%;height:100%">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>a{text-decoration:none}</style>
</head>
<body style="width:100%;height:100%;margin:0">
<div id="navi" style="margin-left:5%;width:90%;height:4.5%;font-size:22px;font-weight:bold">
<a href="source.jsp"><span style="color:#000">数据源</span></a>&nbsp;&nbsp;<a href="view_manage.jsp"><span style="color:#000">视图管理</span></a>&nbsp;&nbsp;<a href="System2Servlet"><span style="color:#000">可视化控件管理</span></a>&nbsp;&nbsp;
</div>
<div style="margin-left:5%;width:90%;height:90%;">
<div id="tableContent" style="width:100%;height:61.2%;border: 1px solid #000;overflow:auto">
<%
List<List<String>> list = (List)request.getAttribute("list");
List<List<String>> view = (List)request.getAttribute("view");
String id = request.getAttribute("id").toString();
String sql = request.getAttribute("sql").toString();
%>
数据源信息：<%=list.get(1).get(3) %>&nbsp;<%=list.get(1).get(4) %>&nbsp;<%=list.get(1).get(5) %>&nbsp;<%=list.get(1).get(6) %>
<table border="1">
<%
for(int i = 0; i < view.size(); i++) {
	%>
<tr>
<%
	for(int j = 0; j < view.get(i).size(); j++) {
		%>
<td><%=view.get(i).get(j) %></td>
		<%
	}
%>	
</tr>
	<%
}
%>
</table>
</div>
<div id="sqlContent" style="margin-top:0.5%;width:100%;height:30%;border:1px solid #000;">
<textarea id="sql" style="width:99.2%;height:95.8%;resize:none"><%=sql %></textarea>
</div>
<div style="margin-top:0.5%;width:100%;height:5%;border: 1px solid #000;">
<form id="myForm" method="post">
视图名
<input type="text" id="name" name="name" value="<%=list.get(1).get(0) %>"/>&nbsp;
<input type="button" value="执行" onclick="exec()" />&nbsp;
<input type="button" value="保存" onclick="save()" />
<input type="hidden" id="hiddenid" name="hiddenid" value="<%=id %>" /> 
<input type="hidden" id="hiddensql" name="hiddensql" /> 
</form>
</div>
</div>
<div id="navi" style="margin-left:5%;margin-top:0;width:90%;height:4.5%;text-align:center;font-size:22px;">
版权所有
</div>
<script type="text/javascript">
function exec() {
	document.getElementById("hiddensql").value = document.getElementById("sql").value;
	var form = document.getElementById("myForm");
	form.action = "ExecuteSqlServlet";
	form.submit();
}

function save() {
	document.getElementById("hiddensql").value = document.getElementById("sql").value;
	var form = document.getElementById("myForm");
	form.action = "UpdateViewServlet";
	form.submit();
}
</script>
</body>
</html>