 <%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%;height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="js/echarts.js"></script>
<script type="text/javascript" src="js/hubei.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
<script src="js/points.js"></script>

<style>a{text-decoration:none}</style>
</head>
<body style="width:100%;height:100%;margin:0">
<div id="all" style="height:100%;width:100%;">
<div id="left" style="width:20%;height:100%;float:left;">
<div id="box_control" style="width:100%;height:10%;border:1px solid #000">
row
<select id="row" name="row">
<option value="1">1</option>
<option value="2" selected="selected">2</option>
<option value="4">4</option>
<option value="6">6</option>
<option value="8">8</option>
</select>&nbsp;&nbsp;
col
<select id="col" name="col">
<option value="1">1</option>
<option value="2" selected="selected">2</option>
<option value="4">4</option>
<option value="6">6</option>
<option value="8">8</option>
</select><br/>
name<input type="text" id="sname" name="sname"/><br/>
<input type="button" value="generate" onclick="generate()" /><br/>
</div>
<div id="tree_menu" style="margin-top:2%;width:100%;height:62%;border:1px solid #000;overflow:auto">
<div style="color:red;font-size:20px;">
<a href="javascript:change('pieContent')">饼图</a>
<div id="pieContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
List<List<String>> list = null;
list = (List)request.getAttribute("pie");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('barContent')">柱形图</a>
<div id="barContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("bar");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('lineContent')">折线图</a>
<div id="lineContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("line");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('scatterContent')">散点图</a>
<div id="scatterContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("scatter");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('funnelContent')">漏斗图</a>
<div id="funnelContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("funnel");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('treemapContent')">树图</a>
<div id="treemapContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("treemap");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('candlestickContent')">K线图</a>
<div id="candlestickContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("candlestick");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('mapContent')">地图</a>
<div id="mapContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("map");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('heatmapContent')">热力图</a>
<div id="heatmapContent" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("heatmap");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('radar')">雷达图</a>
<div id="radar" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("radar");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(1) %></div>
<%
}
%>
</div>
</div>
<div style="color:red;font-size:20px;">
<a href="javascript:change('heatbaidu')">百度地图</a>
<div id="heatbaidu" style="color:#0000ff;font-size:18px;margin-left:5%;display:none">
<%
list = (List)request.getAttribute("heatbaidu");
for(int i = 1; i < list.size(); i++) {
%>
<div id="<%=list.get(i).get(0) %>" draggable="true" ondragstart="drag(event)"><%=list.get(i).get(7) %></div>
<%
}
%>
</div>
</div>
</div>
<div id="control" style="margin-top:2%;width:100%;height:25%;border:1px solid #000">
字体大小<br />
<input type="range" id="fontSize" name="fontSize" min="15" max="30" value="20"/><br/>
字体类型<br/>
<select id="fontWeight" name="fontWeight">
<option value="lighter">lighter</option>
<option value="normal">normal</option>
<option value="bold" selected="selected">bold</option>
<option value="bolder">bolder</option>
</select><br /> 
主题<br/>
<select id="theme" name="theme">
<option value="['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']" selected="selected">默认</option>
<option value="['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B','#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0']">infographic</option>
<option value="['#d8361b','#f16b4c','#f7b4a9','#d26666','#99311c','#c42703','#d07e75']">red</option>
<option value="['#FE8463','#9BCA63','#FAD860','#60C0DD','#0084C6','#D7504B','#C6E579','#26C0C0','#F0805A','#F4E001','#B5C334']">dark</option>
<option value="['#8aedd5','#93bc9e','#cef1db','#7fe579','#a6d7c2','#bef0bb','#99e2vb','#94f8a8','#7de5b8','#4dfb70']">mint</option>
<option value="['#2ec7c9','#b6a2de','#5ab1ef','#ffb980','#d87a80','#8d98b3','#e5cf0d','#97b552','#95706d','#dc69aa','#07a2a4','#9a7fd1','#588dd5','#f5994e','#c05050','#59678c','#c9ab00','#7eb00a','#6f5553','#c14089']">macarons</option>
</select><br />
<input type="hidden" id="currentBoxid"/><br/>
<input id="submit" type="button" value="保  存" onclick="save();" />
</div>
</div>
<div id="right" style="margin-left:0.5%;width:79%;height:100%;float:left;">
</div>
</div>
<!--<div draggable="true" ondragstart="drag(event)">图一</div>  
<input type="hidden" id="" name="" value="" />
-->
<form id="myForm" action="SaveScreenServlet" method="post">
</form>
<script type="text/javascript">
function generate() {
	
	var row = document.getElementById("row").value;
	var col = document.getElementById("col").value;
	var name = document.getElementById("sname").value;
	if(name == "") {
		alert("请填写屏幕名称!");
		return;
	}
	var right = document.getElementById("right");
	var width = parseInt(100 / col) - 1;
	var height = parseInt(100 / row) - 1;
	var i;
	var j;
	//var boxes = right.childNodes;
	//for(i = boxes.length - 2; i > -1; i--) {
	//	right.removeChild(document.getElementById("box" + i));
	//}
	var text = "";
	for(i = 0; i < row; i++) {
		for(j = 0; j < col; j++) {
			text = text + "<a href=\"javascript:showProperty('" + (i * col + j) + "')\"><div id=\"box" + (i * col + j) + "\" style=\"width:" + width + "%;height:" + height + "%;float:left;border:1px solid #000;margin:0 0.2% 0.2% 0;\" ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\"></div></a>";
			//text = text + "<div id=\"box" + (i * col + j) + "\" style=\"width:" + width + "%;height:" + height + "%;float:left;border:1px solid #000;margin:0 0.2% 0.2% 0;\" ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\"></div>";
		}
	}
	right.innerHTML = text;
	//right.innerHTML = "<div id=\"box0\" style=\"width:100%;height:100%;float:left;border:1px solid #000;margin:0 0.2% 0.2% 0;\" ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\"></div>";
	text = "<input type=\"hidden\" id=\"hidden_row\" name=\"hidden_row\" value=\"" + row + "\" />"
		+ "<input type=\"hidden\" id=\"hidden_col\" name=\"hidden_col\" value=\"" + col + "\" />"
		+ "<input type=\"hidden\" id=\"hidden_name\" name=\"hidden_name\" value=\"" + name + "\" />";
	for(i = 0; i < row * col; i++) {
		text = text 
		+ "<input type=\"hidden\" id=\"hiddenid" + i + "\" name=\"hiddenid" + i + "\" />"
		+ "<input  id=\"hiddentype" + i + "\" name=\"hiddentype" + i + "\" />"
		+ "<input type=\"hidden\" id=\"hiddenfs" + i + "\" name=\"hiddenfs" + i + "\" value=\"20\"/>"
		+ "<input type=\"hidden\" id=\"hiddenfw" + i + "\" name=\"hiddenfw" + i + "\" value=\"bold\"/>"
		+ "<input type=\"hidden\" id=\"hiddenth" + i + "\" name=\"hiddenth" + i + "\" value=\"['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']\"/>";
	}
	document.getElementById("myForm").innerHTML = text;
}

//当被拖动对象被拖动到目标区域上方时触发
function allowDrop(ev) {
	ev.preventDefault();
}

//当开始拖动时触发
function drag(ev) {
	ev.dataTransfer.setData("vtid",ev.target.id);
	
}

//当被拖动对象被拖动到目标区域并完成拖放时触发
function drop(ev) {
	ev.preventDefault();
	var vtid = ev.dataTransfer.getData("vtid");
	
	//ev.target.innerHTML=document.getElementById(box_id).innerHTML;
	var boxid = ev.target.id.substring(3);
	
	document.getElementById("hiddenid" + boxid).value = vtid;
	getJson(vtid, boxid);
}

//获取json，并将图表显示
function getJson(vtid, boxid) {
	var chart = (document.getElementById(vtid)).parentElement.id;  
	//alert(chart);
	document.getElementById("hiddentype"+boxid).value= chart;
	var fs = document.getElementById("hiddenfs" + boxid).value;
	var fw = document.getElementById("hiddenfw" + boxid).value;
	var th = document.getElementById("hiddenth" + boxid).value;
	//alert(fs + "\n" + fw + "\n" + th + "\n" + vtid);
	th = URLencode(th);
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "GetChartJsonServlet?vtid=" + vtid + "&fs=" + fs + "&fw=" + fw + "&th=" + th, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
		
			var type = document.getElementById("hiddentype" + boxid).value;
			if(type!="heatbaidu"){
				// 基于准备好的dom，初始化echarts实例
			    echarts.init(document.getElementById("box" + boxid)).setOption(eval("(" + xmlHttp.responseText + ")"));	
			}else{
				var Div = document.createElement('div');
				Div.id='container';
				Div.style.width="99%";
				Div.style.height="99%";
				document.getElementById("box" + boxid).appendChild(Div);
				eval(xmlHttp.responseText);
			}
		    
			// 
			
		}
	};
	xmlHttp.send(null);
}

//动态更新control中各控件值
function showProperty(boxid) {
	var fs = document.getElementById("fontSize");
	var fw = document.getElementById("fontWeight");
	var th = document.getElementById("theme");
	fs.value = document.getElementById("hiddenfs" + boxid).value;
	fw.value = document.getElementById("hiddenfw" + boxid).value;
	th.value = document.getElementById("hiddenth" + boxid).value;
	var vtid = document.getElementById("hiddenid" + boxid).value;
	if(vtid != "") {
		fs.onchange=function() {
			document.getElementById("hiddenfs" + boxid).value = document.getElementById("fontSize").value;
			document.getElementById("hiddenfw" + boxid).value = document.getElementById("fontWeight").value;
			document.getElementById("hiddenth" + boxid).value = document.getElementById("theme").value;
			getJson(vtid, boxid);
		};
		fw.onchange=function() {
			document.getElementById("hiddenfs" + boxid).value = document.getElementById("fontSize").value;
			document.getElementById("hiddenfw" + boxid).value = document.getElementById("fontWeight").value;
			document.getElementById("hiddenth" + boxid).value = document.getElementById("theme").value;
			getJson(vtid, boxid);
		};
		th.onchange=function() {
			document.getElementById("hiddenfs" + boxid).value = document.getElementById("fontSize").value;
			document.getElementById("hiddenfw" + boxid).value = document.getElementById("fontWeight").value;
			document.getElementById("hiddenth" + boxid).value = document.getElementById("theme").value;
			getJson(vtid, boxid);
		};
	} else {
		fs.onchange=function(){};
		fw.onchange=function(){};
		th.onchange=function(){};
	}
}
//保存
function save() {
	var row = document.getElementById("hidden_row");
	if(row == null) {
		alert("请先点击generate生成分屏!");
		return;
	}
	document.getElementById("myForm").submit();
}
//展开
function change(id) {
	var obj = document.getElementById(id);
	if(obj.style.display == "") {
		obj.style.display = "none";
	} else {
		obj.style.display = "";
	}
}

function URLencode(sStr) {
	return escape(sStr).replace(/\#/g, '%23').replace(/\+/g, '%2B');
}
</script>
</body>
</html>