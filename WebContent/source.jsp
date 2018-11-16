<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%;height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据源与视图组件的选择与维护</title>
<style>a{text-decoration:none}</style>
</head>
<body style="width:100%;height:100%;margin:0">
<div id="navi" style="margin-left:5%;width:90%;height:4.5%;font-size:22px;font-weight:bold">
<a href="source.jsp"><span style="color:red">数据源</span></a>&nbsp;&nbsp;<a href="view_manage.jsp"><span style="color:#000">视图管理</span></a>&nbsp;&nbsp;<a href="System2Servlet"><span style="color:#000">可视化控件管理</span></a>&nbsp;&nbsp;
</div>
<div style="margin-left:5%;width:90%;height:90%;">
<div style="width:20%;height:100%;border: 1px solid #000;float:left;">

<div id="mysqlNode" style="font-size:25px;font-weight:bold">
<img id="mysqlImg" src="img/expand.png" onclick="loadDatabases('mysql')"/><a href="javascript:openDatabaseSetPage('mysql')">mysql</a></div>
<div id="mysqlDb" style="margin-left:5%"></div>

<div id="sqlserverNode" style="font-size:25px;font-weight:bold">
<img id="sqlserverImg" src="img/expand.png" onclick="loadDatabases('sqlserver')"/><a href="javascript:openDatabaseSetPage('sqlserver')">sqlserver</a></div>
<div id="sqlserverDb" style="margin-left:5%"></div>

<div id="oracleNode" style="font-size:25px;font-weight:bold">
<img id="oracleImg" src="img/expand.png" onclick="loadDatabases('oracle')"/><a href="javascript:openDatabaseSetPage('oracle')">oracle</a></div>
<div id="oracleDb" style="margin-left:5%"></div>

</div>
<div style="margin-left:1%;width:78%;height:100%;border: 1px solid #000;float:left;">

<!-- 数据库配置页面 -->
<div id="databaseSetPage" style="width:100%;height:100%;display:none">
<div style="margin-left:2%;">
<span id="dbtype" style="color:red;font-size:20px;font-weight:bold"></span><br/>
连接名称<br/>
<input type="text" id="conn_name" name="conn_name"/><br/>
ipv4地址<br/>
<input type="text" id="ip" name="ip"/><br/>
端口<br/>
<input type="text" id="port" name="port"/><br/>
数据库<br/>
<input type="text" id="databaseName" name="databaseName"/><br/>
用户名<br/>
<input type="text" id="user" name="user"/><br/>
密码<br/>
<input type="password" id="password" name="password"/><br/>
<input type="hidden" id="type" name="type"/><br/>
<input type="button" value="确定" onclick="saveDatabase()"/>
<br/>
<br/>
<span id="result" style="color:red;font-size:20px;font-weight:bold"></span>
</div>
</div>

<!-- 数据库信息页面 -->
<div id="databasePage" style="width:100%;height:100%;display:none">
<div style="margin-left:2%;">
数据库类型<br/>
<input type="text" id="type_show" readonly/><br/>
ipv4地址<br/>
<input type="text" id="ip_show" readonly/><br/>
端口<br/>
<input type="text" id="port_show" readonly/><br/>
数据库<br/>
<input type="text" id="databaseName_show" readonly/><br/>
用户名<br/>
<input type="text" id="user_show" readonly/><br/>
密码<br/>
<input type="password" id="password_show" readonly/><br/>
<br/>
<input type="button" value="删 除" onclick="delds()"><br/>
<input type="button" value="测 试" onclick="test()"><br/>
<span id="dbresult" style="color:red;font-size:20px;font-weight:bold"></span>
</div>
</div>

<!-- 设置关联关系页面 -->
<div id="relationSetPage" style="width:100%;height:100%;display:none">
<!-- 显示表内容 -->
<div id="tableContent" style="margin-left:2%;margin-top:2%;width:90%;height:60%;border: 1px solid #000;overflow:auto">
</div>
<!-- 设置外键 -->
<div style="margin-left:2%;margin-top:2%;width:90%;height:30%;border: 1px solid #000;">
<div id="relationContent" style="width:65%;height:100%;float:left;overflow:auto;">
</div>
<div style="margin-left:2%;float:left;">
<input type="button" value="生成视图" onclick="openViewPage()"/>
</div>
</div>
</div>


<div id="viewPage" style="width:100%;height:100%;display:none;">
<div id="viewContent" style="margin-left:2%;margin-top:2%;width:90%;height:60%;border: 1px solid #000;overflow:auto"></div>
<div style="margin-left:2%;margin-top:2%;width:90%;height:30%;border:1px solid #000">
<form id="myForm" action="SaveViewServlet" method="post" target="_blank">
视图名称<br/>
<input type="text" id="viewName" name="viewName" value="视图1" /><br/>
<input type="button" value="保存" onclick="saveView()"/><br/>
<input type="hidden" id="hiddenid" name="hiddenid"/>
<input type="hidden" id="hiddentable" name="hiddentable"/>
<input type="hidden" id="hiddensql" name="hiddensql"/>
<input type="hidden" id="hiddencol" name="hiddencol"/>
</form>
<span id="viewResult" style="color:red;font-size:20px;font-weight:bold"></span>
</div>
</div>

</div>
</div>
<div id="navi" style="margin-left:5%;margin-top:0;width:90%;height:4.5%;text-align:center;font-size:22px;">
版权所有
</div>
<script type="text/javascript">
//打开数据源配置界面
function openDatabaseSetPage(type) {
	document.getElementById("databasePage").style.display = "none";
	document.getElementById("relationSetPage").style.display = "none";
	document.getElementById("databaseSetPage").style.display = "";
	document.getElementById("viewPage").style.display = "none";
	document.getElementById("type").value = type;
	document.getElementById("dbtype").innerHTML = "配置新的" + type + "数据库";
}

//打开数据库信息页面
function openDatabasePage(id) {
	document.getElementById("databaseSetPage").style.display = "none";
	document.getElementById("relationSetPage").style.display = "none";
	document.getElementById("databasePage").style.display = "";
	document.getElementById("viewPage").style.display = "none";
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "GetDatabaseServlet?id=" + id, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var value = xmlHttp.responseText.split(";", 6);
			document.getElementById("hiddenid").value = id;
			document.getElementById("type_show").value = value[0];
			document.getElementById("ip_show").value = value[1];
			document.getElementById("port_show").value = value[2];
			document.getElementById("databaseName_show").value = value[3];
			document.getElementById("user_show").value = value[4];
			document.getElementById("password_show").value = value[5];
		}
	};
	xmlHttp.send(null);
}

//打开级联关系设置页面
function openRelationSetPage(id, tableName) {
	document.getElementById("databaseSetPage").style.display = "none";
	document.getElementById("relationSetPage").style.display = "";
	document.getElementById("databasePage").style.display = "none";
	document.getElementById("viewPage").style.display = "none";
	document.getElementById("hiddenid").value = id;
	document.getElementById("hiddentable").value = tableName;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "GetTableServlet?id=" + id + "&tableName=" + tableName, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var str = xmlHttp.responseText.split("|", 2);
			document.getElementById("tableContent").innerHTML = str[0];
			document.getElementById("relationContent").innerHTML = str[1];
			
		}
	};
	xmlHttp.send(null);
}

//打开视图页面
function openViewPage() {
	document.getElementById("databaseSetPage").style.display = "none";
	document.getElementById("relationSetPage").style.display = "none";
	document.getElementById("databasePage").style.display = "none";
	document.getElementById("viewPage").style.display = "";
	var table = "";
	var col1 = "";
	var col2 = "";
	var tableName = document.getElementById("hiddentable").value;
	var id = document.getElementById("hiddenid").value;
	var trId = document.getElementById("relationTable").childNodes.length;
	var tr;
	var td;
	if(trId > 1) {
		for(var i = 1; i < trId; i++) {
			tr = document.getElementById(i + "tr");
			td = tr.childNodes;
			col1 = col1 + td[0].innerHTML;
			table = table + td[1].innerHTML;
			col2 = col2 + td[2].innerHTML;
			if(i + 1 < trId) {
				col1 += "%20";
				table += "%20";
				col2 += "%20";
			}
		}
	}
	var param = col1 + ";" + table + ";" + col2;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "CreateViewServlet?tableName=" + tableName + "&param=" + param + "&id=" + id, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var str = xmlHttp.responseText.split(";", 2);
			document.getElementById("viewContent").innerHTML = str[0];
			document.getElementById("hiddensql").value = str[1];
		}
	};
	xmlHttp.send(null);
}

//保存新的数据库
function saveDatabase() {
	var ip = document.getElementById("ip").value.trim();
	var port = document.getElementById("port").value.trim();
	var databaseName = document.getElementById("databaseName").value.trim();
	var user = document.getElementById("user").value.trim();
	var password = document.getElementById("password").value.trim();
	var type = document.getElementById("type").value.trim();
	var conn_name = document.getElementById("conn_name").value.trim();
	ip = URLencode(ip);
	port = URLencode(port);
	databaseName = URLencode(databaseName);
	user = URLencode(user);
	password = URLencode(password);
	type = URLencode(type);
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "SaveDatabaseServlet?ip=" + ip + "&port=" + port + "&databaseName=" + databaseName + "&user=" + user + "&password=" + password + "&type=" + type + "&conn_name=" + conn_name, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			document.getElementById("result").innerHTML = xmlHttp.responseText;
		}
	};
	xmlHttp.send(null);
}

//载入数据库类型下所有数据库
function loadDatabases(type) {
	var typeDb = document.getElementById(type + "Db");
	if(typeDb.style.display == "none") {
		typeDb.style.display = "";
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.open("POST", "ExpandDatabaseServlet?type=" + type, true);
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				typeDb.innerHTML = xmlHttp.responseText;
			}
		};
		xmlHttp.send(null);
		document.getElementById(type + "Img").src="img/collapse.png";
	} else {
		typeDb.style.display = "none";
		document.getElementById(type + "Img").src="img/expand.png";
	}
}

//载入数据库下所有表
function loadTables(id) {
	var db = document.getElementById("db_" + id);
	if(db.style.display == "none") {
		db.style.display = "";
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.open("POST", "ExpandTablesServlet?id=" + id, true);
		xmlHttp.onreadystatechange = function() {
			if(xmlHttp.readyState == 4) {
				db.innerHTML = xmlHttp.responseText;
			}
		};
		xmlHttp.send(null);
		document.getElementById("img_" + id).src="img/collapse.png";
	} else {
		db.style.display = "none";
		document.getElementById("img_" + id).src="img/expand.png";
	}
}

//根据表名获取
function loadColumns() {
	var tableName = document.getElementById("tabletd").value;
	var id = document.getElementById("hiddenid").value;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "GetColumnServlet?id=" + id + "&tableName=" + tableName, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var col = xmlHttp.responseText.split(";");
			var sel = document.getElementById("refcoltd");
			sel.options.length = 0;
			for(var i = 0; i < col.length; i++) {
				var option = document.createElement("option");
				option.innerHTML = col[i];
				option.value = col[i];
				sel.appendChild(option);
			}
		}
	};
	xmlHttp.send(null);
}
/*
//数据库级展开
function change(type, db) {
	var subMenu = document.getElementById(type + "_" + db + "Tb"); 
	if(subMenu.style.display == "none") { //该项已经被收缩了，接下来要把它的所有子项显示
			subMenu.style.display = "";
			document.getElementById(type + "_" + db + "Img").src="img/collapse.png";
	} else if(subMenu.style.display == "") { //该项已经被展开了，接下来要把它的所有子项隐藏
			subMenu.style.display = "none";
			document.getElementById(type + "_" + db + "Img").src="img/expand.png";
	}
}
*/
function add() {
	var table = document.getElementById("relationTable");
	var trId = table.childNodes.length;
	var td1 = document.createElement("td");
	var td2 = document.createElement("td");
	var td3 = document.createElement("td");
	var td4 = document.createElement("td");
	var tr = document.createElement("tr");
	td1.innerHTML = document.getElementById("coltd").value;
	td2.innerHTML = document.getElementById("tabletd").value;
	td3.innerHTML = document.getElementById("refcoltd").value;
	td4.innerHTML = "<a href=\"javascript:del('" + trId + "tr')\">删除</a>";
	tr.appendChild(td1);
	tr.appendChild(td2);
	tr.appendChild(td3);
	tr.appendChild(td4);
	tr.id = trId + "tr";
	table.appendChild(tr);
}

function del(id) {
	var tr = document.getElementById(id);
	var table = document.getElementById("relationTable");
	table.removeChild(tr);
}

//保存视图
function saveView() {
	var col = "";
	var checkbox = document.getElementsByName("col_checkbox");
	for(var i = 0; i < checkbox.length; i++) {
		if(checkbox[i].checked) {
			col = col + checkbox[i].value + " ";
		}
	}
	if(col != "") {
		document.getElementById("hiddencol").value = col;
		document.getElementById("myForm").submit();
	} else {
		alert("请选择字段名");
	}
}

//删除数据源
function delds() {
	if(confirm("您真的要删除该数据源吗？如果删除，该数据源下的所有信息都将丢失！")) {
		window.location.href="DeleteDataSourceServlet?id=" + document.getElementById("hiddenid").value;
	}
}

//测试数据源可用性
function test() {
	var id = document.getElementById("hiddenid").value;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "TestDatabaseServlet?id=" + id, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			document.getElementById("dbresult").innerHTML = xmlHttp.responseText;
		}
	};
	xmlHttp.send(null);
}

function URLencode(sStr) {
	return escape(sStr).replace(/\#/g, '%23').replace(/\+/g, '%2B').replace(/\ /g,'%20');
}
</script>
</body>
</html>