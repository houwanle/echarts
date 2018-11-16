<%@page import="com.sun.org.apache.xpath.internal.operations.Variable"%>
<%@page import="com.czy.utils.CommonUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html style="width:100%;height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/echarts.js"></script>
<script src="js/hubei.js"></script>
<script src="js/china.js"></script>

<script type="text/javascript"
	src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
<script type='text/javascript'
	src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js"></script>
<script type='text/javascript' src="js/bootstrap-slider.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
<link
	href="http://libs.useso.com/js/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet">
<link href="js/bootstrap-slider.min.css" rel="stylesheet">
<!-- MiniColors -->
<script src="js/jquery.minicolors.js"></script>
<link rel="stylesheet" href="js/jquery.minicolors.css">

</head>
<body onload="firstpage()" style="width:100%;height:100%;margin:0">
<div id="navi" style="margin-left:5%;width:90%;height:4.5%;font-size:22px;font-weight:bold">
<a href="source.jsp"><span style="color:#000">数据源</span></a>&nbsp;&nbsp;<a href="view_manage.jsp"><span style="color:#000">视图管理</span></a>&nbsp;&nbsp;<a href="System2Servlet"><span style="color:red">可视化控件管理</span></a>&nbsp;&nbsp;
</div>
<div style="margin-left:5%;width:90%;height:90%;">
		<div style="width: 100%; height: 100%;">
			<%
				//List<Table> tableList =(List)request.getAttribute("tableList"); 
				//Map<Integer, List<Item>> echartList =(Map)request.getAttribute("echartList");
				//String chartType =null; 

				List<String> tableHead2 = (List) request.getAttribute("tableHead2");//表头
				List<List<String>> tableList = (List) request
						.getAttribute("tableList");//chartview所有表明
			%>

			<div class="left"
				style="float: left; width: 15%; height: 98%; overflow: auto;border:1px solid #000;float:left;">
				<div style="width: 50%; height: 5%;float: left;">
				<input type="button"
					style=" width: 100%; height: 100%;background: #DBDBDB"
					onclick="newevent()" value="新建" /></div>
				<div id="removeall" style="float: left;width: 50%; height: 5%;display:none">
					<input type="button"				
					style="width: 100%; height: 100%;background: #DBDBDB;"
					onclick="removeall()" value="全部删除" /></div>
					
				<div id="newtable"  style="float: left;width:100%"></div>
				<div id="chartform" style="float: left;width:100%;display: none">
					<div id="barNode" style="font-size: 20px; font-weight: bold">
						<img id="barImg" src="img/expand.png" /><a href="#"
							onclick="change('bar',0);">柱形图</a>
					</div>
					<div id="barDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="bar_<%=i%>" style="font-size: 20px; margin-left: 5%">
							<a href="#" onclick="loadtype('<%=tableList.get(i).get(0)%>',0,'bar');"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>
					<div id="lineNode" style="font-size: 20px; font-weight: bold">
						<img id="lineImg" src="img/expand.png" /><a href="#"
							onclick="change('line',0)">折线图</a>
					</div>
					<div id="lineDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="line_<%=i%>" style="font-size: 20px; margin-left: 5%">
							<a href="#" onclick="loadtype('<%=tableList.get(i).get(0)%>',0,'line');"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>

					<div id="pieNode" style="font-size: 20px; font-weight: bold">
						<img id="pieImg" src="img/expand.png" /><a href="#"
							onclick="change('pie',0)">饼图</a>
					</div>
					<div id="pieDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="pie_<%=i%>" style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>

					<div id="funnelNode" style="font-size: 20px; font-weight: bold">
						<img id="funnelImg" src="img/expand.png" /><a href="#"
							onclick="change('funnel',0)">漏斗图</a>
					</div>
					<div id="funnelDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="funnel_<%=i%>" style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>

					<div id="scatterNode" style="font-size: 20px; font-weight: bold">
						<img id="scatterImg" src="img/expand.png" /><a href="#"
							onclick="change('scatter',0)">散点图</a>
					</div>
					<div id="scatterDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="scatter_<%=i%>" style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>

					<div id="treemapNode" style="font-size: 20px; font-weight: bold">
						<img id="treemapImg" src="img/expand.png" /><a href="#"
							onclick="change('treemap',0)">树图</a>
					</div>
					<div id="treemapDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="treemap_<%=i%>" style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>

					<div id="candlestickNode"
						style="font-size: 20px; font-weight: bold">
						<img id="candlestickImg" src="img/expand.png" /><a href="#"
							onclick="change('candlestick',0)">K线图</a>
					</div>
					<div id="candlestickDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="candlestick_<%=i%>"
							style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>
					
					<div id="mapNode"
						style="font-size: 20px; font-weight: bold">
						<img id="mapImg" src="img/expand.png" /><a href="#"
							onclick="change('map',0)">地图</a>
					</div>
					<div id="mapDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="map_<%=i%>"
							style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>
					
					<div id="heatmapNode"
						style="font-size: 20px; font-weight: bold">
						<img id="heatmapImg" src="img/expand.png" /><a href="#"
							onclick="change('heatmap',0)">热力图</a>
					</div>
					<div id="heatmapDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="heatmap_<%=i%>"
							style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>
					
					<div id="radarNode"
						style="font-size: 20px; font-weight: bold">
						<img id="radarImg" src="img/expand.png" /><a href="#"
							onclick="change('radar',0)">雷达图</a>
					</div>
					<div id="radarDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="radar_<%=i%>"
							style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="loadtype('<%=tableList.get(i).get(0)%>',0,'radar');"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>
						
					<div id="baiduNode"
						style="font-size: 20px; font-weight: bold">
						<img id="baiduImg" src="img/expand.png" /><a href="#"
							onclick="change('baidu',0)">百度地图</a>
					</div>
					<div id="baiduDb" style="margin-left: 5%; display: none">
						<%
							for (int i = 1; i < tableList.size(); i++) {
						%>
						<div id="baidu_<%=i%>"
							style="font-size: 20px; margin-left: 5%;">
							<a href="#" onclick="assignmentview('<%=tableList.get(i).get(0)%>')"><%=tableList.get(i).get(0)%></a>
						</div>
						<%
							}
						%>
					</div>
						
					</div>
				</div>
			


			<div class="right"
				style="float: left; margin-left:1%;width: 83%; height: 98%">

				<div id="property" class="left"
					style="width: 30%;height: 100%;float:left">
					<div class="top"
						style="width: 100%; border: 1px solid #000; height: 60%;">
						<h4>系统属性</h4>
					<div style="width:100%;height:70%;">
						<!--------------------- bar --------------------- -->
						<div id="bar"
							style="padding: 20px; width: 100%;display: none;">
							<p id="axischoose1"></p><br/>
							<br/><br/>
							柱间间距<br /> <input type="range" min="1" max="100" value="20" id="barGap"
								name="barGap" onchange="btn_click(1);" /><br /> y坐标轴单位<br /> <input
								type="text" id="baryUnit" name="yUnit" oninput="btn_click(1);" value="单位" /><br />
						</div>
						<!--------------------- bar --------------------- -->

						<!------------------------ pie -------------------- -->
						<div id="pie"
							style="padding: 20px; width: 100%;display: none ">

							内半径<br /> <input id="innerRadius" type="range" min="1" max="100"
								onchange="btn_click(1)" value="70" /><br /> 
							外半径<br />
							<input id="externalRadius" type="range" min="1" max="100"
								onchange="btn_click(1)" value="80" /><br /> 饼图位置<br /> 左<input
								type="radio" id="piePositionRadio" checked="true"
								onclick="piePositionClick('left')" name="piePosition"
								value="left" /><br />右<input type="radio" id="piePositionRadio"
								onclick="piePositionClick('right')" name="piePosition"
								value="right" /><br /> 中间<input type="radio"
								id="piePositionRadio" onclick="piePositionClick('center')"
								name="piePosition" value="center" /><br /> 图例方向<br /> 横向<input
								type="radio" id="legendPositionRadio" checked="true"
								onclick="legendPositionClick('horizontal')"
								name="legendPosition" value="horizontal" />&nbsp;&nbsp; 竖向<input
								type="radio" id="legendPositionRadio"
								onclick="legendPositionClick('vertical')" name="legendPosition"
								value="vertical" />&nbsp;&nbsp;<br /> <input type="hidden"
								id="piePosition" value="left" name="piePosition" /> <input
								type="hidden" id="legendPosition" value="horizontal"
								name="legendPosition" />
						</div>
						<!------------------------ pie -------------------- -->

						<!------------------------ line -------------------- -->
						<div id="line"
							style="padding: 20px; width: 100%;display: none">
							<p id="axischoose2"></p><br/><br/><br/>
							y坐标轴单位<br /> <input type="text" id="lineyUnit" name="yUnit"
								oninput="btn_click(1);" value="单位"/><br />
						</div>
						<!------------------------ line -------------------- -->
						<!------------------------ scatter -------------------- -->
						<div id="scatter"
							style="padding:20px;width: 100%;display: none">

							xmax<input id="xmax" type="range" min="1" max="100" value="100"  onchange="btn_click(1);"
								name="xmax"  /><br /> 
							xmin <input id="xmin" type="range" min="1" max="100" value="100"
								 onchange="btn_click(1);" name="xmin"  /><br />
							ymax <input id="ymax" type="range" min="1" max="100" value="100" onchange="btn_click(1);"
								name="ymax"  /><br /> 
							ymin <input  id="ymin" type="range" min="1" max="100" value="100"onchange="btn_click(1);" name="ymin"/><br />
							
							x轴单位<br /> <input type="text" id="xUnit" oninput="btn_click(1);"
								name="xUnit" value="单位"/><br /> y轴单位<br /> <input type="text"
								id="yUnit" oninput="btn_click(1);" name="yUnit" value="单位"/><br />
						</div>
						<!------------------------ scatter -------------------- -->
						<!------------------------ funnel -------------------- -->
						<div id="funnel"
							style="padding: 20px; width: 100%;display: none">

							数据排序<br /> 升序<input type="radio" id="sort" checked="true"
								onclick="sort_click('ascending')" name="sort">&nbsp;&nbsp;
							降序<input type="radio" id="sort"
								onclick="sort_click('descending')" name="sort"><br />
							数据最小值 min 映射的宽度<br /> <input id="minSize" type="range" min="1"
								max="100" onchange="btn_click(1)" value="0" /><br /> 数据最大值 max
							映射的宽度<br /> <input id="maxSize" type="range" min="1" max="100"
								onchange="btn_click(1)" value="100" /><br /> 
							gap<br /> <input
								 id="gap" type="range" min="1" max="100" value="0" onchange="btn_click(1)" name="gap" /><br />
							<input type="hidden" id="sortValue" value="ascending"
								name="sortValue" />
						</div>
						<!------------------------ funnel -------------------- -->
						<!------------------------ treemap -------------------- -->
						<div id="treemap"
							style="padding: 20px; width: 100%;display: none">

							树形图描述<br /> <input type="text" id="mapDesc"
								oninput="btn_click(1);" name="mapDesc" value="矩形树图"/><br /> borderWidth<br />
							<!--  <input type="text" value="1" id="borderWidth" oninput="" name="borderWidth" /><br/>
	-->
							<input id="borderWidth" type="range" min="1" max="20"
								onchange="btn_click(1)" value="1" /><br /> borderColor <input
								style="margin: 2px;" type="text" id="borderColor" onchange=""
								class="demo" data-position="bottom right" value="#0088cc" /><br />
							树形图高度<br /> <input id="mapHeight" type="range" min="1" max="100" value="80"
								onchange="btn_click(1);" name="mapHeight" /><br />
						</div>
						<!------------------------ treemap -------------------- -->
						<!------------------------ candlestick ---------------------->
						<div id="candlestick"
							style="padding: 20px; width: 100%;display: none">

							color<br /> <input style="margin: 2px;" type="text" id="color"
								onchange="btn_click(1);" class="demo"
								data-position="bottom right" value="#fd1050" /><br /> color0<br />
							<input style="margin: 2px;" type="text" id="color0"
								onchange="btn_click(1);" class="demo"
								data-position="bottom right" value="#0cf49b" /><br />
						</div>
						<!------------------------ candlestick---------------------->
						<!------------------------ map ---------------------->
						<div id="map"
							style="padding: 20px; width: 100%;display: none">
							最小值 min<br /> <input id="mapmin" type="range" min="1"
								max="100" onchange="btn_click(1);" value="0" /><br /> 最大值 max
							<br /> <input id="mapmax" type="range" min="1" max="100"
								onchange="btn_click(1);" value="100" /><br /> 
							
						</div>
						<!------------------------ map---------------------->
						<!------------------------ heatmap ---------------------->
						<div id="heatmap"
							style="padding: 20px; width: 100%;display: none">
							min<br /> <input id="heatmapmin" type="range" min="1"
								max="100" onchange="btn_click(1);" value="1" /><br /> 
							max<br /> <input id="heatmapmax" type="range" min="1"
								max="100" onchange="btn_click(1);" value="100"/><br />
							
						</div>
						<!------------------------ heatmap---------------------->
						<!------------------------ radar ---------------------->
						<div id="radar"
							style="padding: 20px; width: 100%;display: none">
							<p id="axischoose3"></p><br/>
							
						</div>
						<!------------------------ radar---------------------->
						<!------------------------ baidu ---------------------->
						<div id="baidu"
							style="padding: 20px; width: 100%;display: none">
							半径<br /> <input id="baiduradius" type="range" min="1"
								max="100" onchange="btn_click(1);" value="30" /><br /> 
							<br /> <input type="hidden" id="baidumaxNum" value="100" /><br /> 
						</div>
						<!------------------------ baidu---------------------->
						</div>
						<div>
							<div id="updatabutton" style="display: none">
								<input type="button"
									style="font-size: 25px; background: #FF9933；"
									onclick="updata()" value="更新" />
							</div>
							<div id="savebutton" style="display:">
								<input type="button"
									style="font-size: 25px; background: #FF9933"
									onclick="btn_click(0)" value="保存" />
							</div>
						</div>
						
					</div>

					<div id="bottom" class="bottom"
						style="margin-top:1.5%;width: 100%; border: 1px solid #000; height: 39%;">
						<h4>用户属性</h4>
						<div id="share" style="padding: 20px; width: 100%; height: 100%">
							图表名称<br /> <input type="text" id="chartName" name="chartName"
								oninput="btn_click(1);" value="tableName" /><br /> 字体大小<br />
							<!--  <input type="text" value="20" id="fontSize" name="fontSize" oninput=""/><br/>
	-->
							<input id="fontSize" type="range" min="10" max="30"
								onchange="btn_click(1)" value="20" /><br /> 字体类型<br />
							<!-- <input type="text" id="fontWeight" name="fontWeight" oninput=""/><br/>
	 -->
							<select id="fontWeight" onchange="btn_click(1);"
								name="fontWeight">
								<option>lighter</option>
								<option>normal</option>
								<option>bold</option>
								<option>bolder</option>
							</select><br />
						</div>
					</div>
				</div>
				
				<div class="right"
					style="float: left; margin-left:1%;width: 68%; height: 100% ;border:1px solid #000">
					<div id="main"
						style="margin-left:10%;margin-top:20%;width: 80%; height: 60%"></div>
					<input type="hidden" id="charttype1" value="" name="charttype1" />
					<!-- chart类型 -->
					<input type="hidden" id="tablename1" value="" name="tablename1" />
					<!-- 表名 -->
					<input type="hidden" id="tabletype1" value="" name="tabletype1" />
					
					<!-- 表名与chart类型 -->
				</div>
				
			</div>
		</div>
</div>
<div id="navi" style="margin-left:5%;margin-top:0;width:90%;height:4.5%;text-align:center;font-size:22px">
版权所有
</div>
	<script type="text/javascript">
		function change(type, x) {//x=0正常展开并显示属性，x=1只显示属性//done
			document.getElementById("main").innerHTML="";
			var button1 = document.getElementById("savebutton");
			var button2 = document.getElementById("updatabutton");

			button2.style.display = "none";
			button1.style.display = "";
			var type1 = document.getElementById("barDb").style.display;
			var type2 = document.getElementById("lineDb").style.display;
			var type3 = document.getElementById("pieDb").style.display;
			var type4 = document.getElementById("treemapDb").style.display;
			var type5 = document.getElementById("candlestickDb").style.display;
			var type6 = document.getElementById("funnelDb").style.display;
			var type7 = document.getElementById("scatterDb").style.display;
			var type8 = document.getElementById("mapDb").style.display;
			var type9 = document.getElementById("heatmapDb").style.display;
			var type10 = document.getElementById("radarDb").style.display;
			var type11 = document.getElementById("baiduDb").style.display;
			var subMenu = document.getElementById(type + "Db");
			
			if (x == 0) {
				if (type1 == "none" && type2 == "none" && type3 == "none"
						&& type4 == "none" && type5 == "none"
						&& type6 == "none" && type7 == "none"
						&& type8 == "none"&& type9 == "none"
						&& type10 == "none"&& type11 == "none") {//该项已经被收缩了，接下来要把它的所有子项显示
					subMenu.style.display = "";
					var y = document.getElementById(type + "Img");
					y.src = "img/collapse.png";

				} else if (subMenu.style.display == "") { //该项已经被展开了，接下来要把它的所有子项隐藏
					subMenu.style.display = "none";
					var y = document.getElementById(type + "Img");
					y.src = "img/expand.png";

				}

			}
			var mydiv1 = document.getElementById("bar");
			var mydiv2 = document.getElementById("line");
			var mydiv3 = document.getElementById("pie");
			var mydiv4 = document.getElementById("scatter");
			var mydiv5 = document.getElementById("candlestick");
			var mydiv6 = document.getElementById("treemap");
			var mydiv7 = document.getElementById("funnel");
			var mydiv8 = document.getElementById("map");
			var mydiv9 = document.getElementById("heatmap");
			var mydiv10 = document.getElementById("radar");
			var mydiv11 = document.getElementById("baidu");
			if (type == "bar") {
				assignmenttype("bar");
				mydiv1.style.display = "";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv9.style.display = "none";
				mydiv10.style.display = "none";
				mydiv8.style.display = "none";
				mydiv11.style.display = "none";
			} else if (type == "line") {
				assignmenttype("line");
				mydiv2.style.display = "";
				mydiv1.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv9.style.display = "none";
				mydiv10.style.display = "none";
				mydiv11.style.display = "none";
			} else if (type == "pie") {
				assignmenttype("pie");
				mydiv3.style.display = "";
				mydiv10.style.display = "none";
				mydiv1.style.display = "none";
				mydiv2.style.display = "none";
				mydiv9.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv11.style.display = "none";
			} else if (type == "scatter") {
				assignmenttype("scatter");
				mydiv4.style.display = "";
				mydiv1.style.display = "none";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv9.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv10.style.display = "none";
				mydiv11.style.display = "none";
			} else if (type == "candlestick") {
				assignmenttype("candlestick");
				mydiv5.style.display = "";
				mydiv1.style.display = "none";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv9.style.display = "none";
				mydiv10.style.display = "none";
				mydiv11.style.display = "none";
			} else if (type == "treemap") {
				assignmenttype("treemap");
				mydiv6.style.display = "";
				mydiv9.style.display = "none";
				mydiv1.style.display = "none";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv10.style.display = "none";
				mydiv11.style.display = "none";
			} else if (type == "funnel") {
				assignmenttype("funnel");
				mydiv7.style.display = "";
				mydiv1.style.display = "none";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv8.style.display = "none";
				mydiv9.style.display = "none";
				mydiv10.style.display = "none";
				mydiv11.style.display = "none";
			}else if (type == "map") {
				assignmenttype("map");
				mydiv8.style.display = "";
				mydiv1.style.display = "none";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv9.style.display = "none";
				mydiv10.style.display = "none";
				mydiv11.style.display = "none";
			}else if (type == "heatmap") {
				assignmenttype("heatmap");
				mydiv9.style.display = "";
				mydiv1.style.display = "none";
				mydiv11.style.display = "none";
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv10.style.display = "none";
			}else if (type == "radar") {
				assignmenttype("radar");				
				mydiv10.style.display = "";
				mydiv1.style.display = "none";			
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv9.style.display = "none";
				mydiv11.style.display = "none";
			}else if (type == "baidu") {
				assignmenttype("baidu");				
				mydiv11.style.display = "";
				mydiv1.style.display = "none";			
				mydiv2.style.display = "none";
				mydiv3.style.display = "none";
				mydiv4.style.display = "none";
				mydiv5.style.display = "none";
				mydiv6.style.display = "none";
				mydiv7.style.display = "none";
				mydiv8.style.display = "none";
				mydiv9.style.display = "none";
				mydiv10.style.display = "none";
			}

			else {

			}
		}
		function removeall(){//done
			var xmlHttp11 = new XMLHttpRequest();
			xmlHttp11.open("POST", "RemoveallServlet", true);
			xmlHttp11.onreadystatechange = function() {
				if (xmlHttp11.readyState == 4) {

					var flag = xmlHttp11.responseText;
					var removeall = document.getElementById("removeall");
					removeall.style.display="none";
					var newevent= document.getElementById("newtable");
					newevent.innerHTML="";
				}
			};
			xmlHttp11.send(null);
			var chartform = document.getElementById("chartform");
			chartform.style.display="none";
		}
		function newevent() {
			document.getElementById("barDb").style.display="none";
			document.getElementById("lineDb").style.display="none";
			document.getElementById("pieDb").style.display="none";
			document.getElementById("treemapDb").style.display="none";
			document.getElementById("candlestickDb").style.display="none";
			document.getElementById("funnelDb").style.display="none";
			document.getElementById("scatterDb").style.display="none";
			document.getElementById("heatmap").style.display="none";
			document.getElementById("mapDb").style.display="none";
			document.getElementById("radarDb").style.display="none";
			document.getElementById("baiduDb").style.display="none";
			var form = document.getElementById("chartform");
			if (form.style.display == "none")
				form.style.display = "";
			else
				form.style.display = "none";
			var button1 = document.getElementById("savebutton");
			var button2 = document.getElementById("updatabutton");
			button2.style.display = "none";
			button1.style.display = "";
		}
		function loadtype(name,id,type) {//id>0有效//done
			var c_3 = document.getElementById("tablename1");
			c_3.value = name;
			
			name = encodeURI(encodeURI(name));
		
			var xmlHttp4 = new XMLHttpRequest();
			xmlHttp4.open("POST", "TypeaxisServlet?tableName=" + name+ "&id=" + id+ "&type=" + type, true);
			xmlHttp4.onreadystatechange = function() {
				if (xmlHttp4.readyState == 4) {
					var option = xmlHttp4.responseText;
					option=decodeURIComponent(option);
					//alert(option);
					if("bar" == type) {
						var axis = document.getElementById("axischoose1");
					} else if("line" == type) {
						var axis = document.getElementById("axischoose2");
					}
					else if("radar" == type) {
						var axis = document.getElementById("axischoose3");
					}
					axis.innerHTML = option;
					//alert("123");
				}
			};
			xmlHttp4.send(null);
			var button1 = document.getElementById("savebutton");
			var button2 = document.getElementById("updatabutton");
			button2.style.display = "none";
			button1.style.display = "";
			
			//btn.click(1);
			
		}
		function firstpage() {//done
			
			var xmlHttp10 = new XMLHttpRequest();
			xmlHttp10.open("POST", "FirstpageServlet", true);
			xmlHttp10.onreadystatechange = function() {
				if (xmlHttp10.readyState == 4) {
					var addto = xmlHttp10.responseText;
					var axis = document.getElementById("newtable");			
					axis.innerHTML = axis.innerHTML + addto;
					//alert(addto);
					if(addto!=null){
						var axis = document
						.getElementById("newtable");
						if(axis.innerText==""||axis.innerText==null){
					var removeall = document
					.getElementById("removeall");
					removeall.style.display="none";
				}			
						else{var removeall = document
							.getElementById("removeall");
							removeall.style.display="";
							
						}
					}
				}			
			};
			xmlHttp10.send(null);					
		}
		function assignmenttype(name){//done			
			var c_2 = document.getElementById("charttype1");	
				c_2.value=name;
				//btn_click(1);
			
		}
		function assignmentview(name){//done
			//alert(name);
			var c_3 = document.getElementById("tablename1");
			c_3.value = name;
			//alert(c_3.value);
			btn_click(1);
		}
		function createbaidu(name){
			
		}
		

		function btn_click(x) {//0制图保存属性，1只制图	//done
			//alert("c_2.value");
			var c_2 = document.getElementById("charttype1");//alert(c_2.value);
			var chartName = document.getElementById("chartName").value;
			var fontSize = document.getElementById("fontSize").value;
			var fontWeight = document.getElementById("fontWeight").value;
			var tableName = document.getElementById("tablename1").value;
			//alert(tableName);
			//chartName=encodeURI(encodeURI(chartName));
			var xmlHttp = new XMLHttpRequest();
			var xmlHttp1 = new XMLHttpRequest();
			if (fontSize == "") {
				fontSize = "20";
			}
			
			//alert(tableName);
			//tableName = encodeURI(encodeURI(tableName));
			if ("pie" == c_2.value) {

				var innerRadius = document.getElementById("innerRadius").value;
				var externalRadius = document.getElementById("externalRadius").value;
				//alert(externalRadius);
				var piePosition = document.getElementById("piePosition").value;
				var legendPosition = document.getElementById("legendPosition").value;
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight
						+ "&legendPosition=" + legendPosition + "&piePosition="
						+ piePosition + "&innerRadius=" + innerRadius
						+ "&externalRadius=" + externalRadius + "&tableName="
						+ tableName, true);
				if (x == 0) {
					//alert(piePosition);
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&legendPosition=" + legendPosition
							+ "&piePosition=" + piePosition + "&innerRadius="
							+ innerRadius + "&externalRadius=" + externalRadius
							+ "&tableName=" + tableName, true);
				}
			} else if ("bar" == c_2.value) {
				
				var barGap = document.getElementById("barGap").value;
				var yUnit = document.getElementById("baryUnit").value;
				//yUnit=encodeURI(encodeURI(yUnit));
				var typeaxis = document.getElementById("typeaxis1").value;
				//typeaxis=encodeURI(encodeURI(typeaxis));
				
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight + "&barGap="
						+ barGap + "&yUnit=" + yUnit + "&tableName="
						+ tableName + "&typeaxis=" + typeaxis, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&barGap=" + barGap + "&yUnit="
							+ yUnit + "&typeaxis=" + typeaxis + "&tableName="
							+ tableName, true);
				}
			} else if ("line" == c_2.value) {
				var yUnit = document.getElementById("lineyUnit").value;
				//yUnit=encodeURI(encodeURI(yUnit));
				var typeaxis = document.getElementById("typeaxis1").value;
				//typeaxis=encodeURI(encodeURI(typeaxis));
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight + "&yUnit="
						+ yUnit + "&tableName=" + tableName + "&typeaxis="
						+ typeaxis, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&yUnit=" + yUnit + "&typeaxis="
							+ typeaxis + "&tableName=" + tableName, true);
				}
			} else if ("funnel" == c_2.value) {

				var sortValue = document.getElementById("sortValue").value;
				var minSize = document.getElementById("minSize").value.trim();
				var maxSize = document.getElementById("maxSize").value;
				var gap = document.getElementById("gap").value;
				
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName
						+ "&fontWeight=" + fontWeight + "&sortValue="
						+ sortValue + "&fontSize=" + fontSize + "&minSize="
						+ minSize + "&maxSize=" + maxSize + "&gap=" + gap
						+ "&tableName=" + tableName, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&sortValue=" + sortValue
							+ "&minSize=" + minSize + "&maxSize=" + maxSize
							+ "&gap=" + gap + "&tableName=" + tableName, true);
				}

			} else if ("scatter" == c_2.value) {

				var xmax = document.getElementById("xmax").value;
				var xmin = document.getElementById("xmin").value;
				var ymax = document.getElementById("ymax").value;
				var ymin = document.getElementById("ymin").value;
				var xUnit = document.getElementById("xUnit").value;
				//xUnit=encodeURI(encodeURI(xUnit));
				var yUnit = document.getElementById("yUnit").value;
				//yUnit=encodeURI(encodeURI(yUnit));
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&xmax="
						+ xmax + "&xmin=" + xmin + "&ymax=" + ymax + "&ymin="
						+ ymin + "&xUnit=" + xUnit + "&yUnit=" + yUnit
						+ "&fontSize=" + fontSize + "&fontWeight=" + fontWeight
						+ "&tableName=" + tableName, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&xmax=" + xmax + "&xmin=" + xmin
							+ "&ymax=" + ymax + "&ymin=" + ymin + "&xUnit="
							+ xUnit + "&yUnit=" + yUnit + "&tableName="
							+ tableName, true);
				}
			} else if ("treemap" == c_2.value) {

				var mapDesc = document.getElementById("mapDesc").value;
				//mapDesc=encodeURI(encodeURI(mapDesc));
				var borderColor = document.getElementById("borderColor").value;
				var borderWidth = document.getElementById("borderWidth").value;
				var mapHeight = document.getElementById("mapHeight").value;
				//alert(mapHeight);
				if (borderWidth == "") {
					borderWidth = "1";
				}

				borderColor = borderColor.substring(1);

				borderColor = "%23" + borderColor;

				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight + "&mapDesc="
						+ mapDesc + "&borderColor=" + borderColor
						+ "&borderWidth=" + borderWidth + "&mapHeight="
						+ mapHeight + "&tableName=" + tableName, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&mapDesc=" + mapDesc
							+ "&borderColor=" + borderColor + "&borderWidth="
							+ borderWidth + "&mapHeight=" + mapHeight
							+ "&tableName=" + tableName, true);
				}
			} else if ("candlestick" == c_2.value) {

				var color = document.getElementById("color").value;
				var color0 = document.getElementById("color0").value;
				color = color.substring(1);
				color0 = color0.substring(1);

				color = "%23" + color;
				color0 = "%23" + color0;

				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight + "&color="
						+ color + "&color0=" + color0 + "&tableName="
						+ tableName, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value + "&color=" + color + "&color0="
							+ color0 + "&tableName=" + tableName, true);
				}
			}
			else if ("map" == c_2.value) {
				var mapmax = document.getElementById("mapmax").value;
				var mapmin = document.getElementById("mapmin").value;
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight  + "&tableName="
						+ tableName + "&mapmin="+ mapmin + "&mapmax="+ mapmax, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value  + "&mapmin="+ mapmin + "&mapmax="+ mapmax + "&tableName=" + tableName, true);
				}
			
			}
			else if ("heatmap" == c_2.value) {
				var heatmapmin = document.getElementById("heatmapmin").value;
				var heatmapmax = document.getElementById("heatmapmax").value;
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight  + "&tableName="
						+ tableName + "&heatmapmin="+ heatmapmin + "&heatmapmax="+ heatmapmax, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value  + "&heatmapmin="+ heatmapmin + "&heatmapmax="+ heatmapmax + "&tableName=" + tableName, true);
				}
			
			}else if ("baidu" == c_2.value) {
				var radius = document.getElementById("baiduradius").value;
				var maxNum = document.getElementById("baidumaxNum").value;
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight  + "&tableName="
						+ tableName + "&radius="+ radius + "&maxNum="+ maxNum, true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value  + "&radius="+ radius + "&maxNum="+ maxNum + "&tableName=" + tableName, true);
				}
			
			}else if ("radar" == c_2.value) {
				var radarmax = document.getElementsByName("radarmax");
				
				var max = "";
				for(var i=0;i<radarmax.length;i++){
					max=max+radarmax[i].value+" ";//alert(radarmax[i].value);
				}
				
				xmlHttp.open("POST", "CreateChartServlet?chartType="
						+ c_2.value + "&chartName=" + chartName + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight  + "&tableName="
						+ tableName + "&radarmax="+ max , true);
				if (x == 0) {
					xmlHttp1.open("POST", "PropertiesServlet?chartType="
							+ c_2.value  + "&radarmax="+ max + "&tableName=" + tableName, true);
				}
			
			}


			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {

					//document.getElementById('test').innerHTML=xmlHttp.responseText;
					
					// 指定图表的配置项和数据
					var option = xmlHttp.responseText +  "";
					//var option = {"title": {"text": "tableName","textStyle": {"color": "#fff"}},"series": [{data:[114.315605,30.605643,87.469039, 114.277373,30.607757,135.610738, 114.221175,30.588484,67.651569, 114.225200,30.560376,27.913074, 114.322576,30.559630,338.583981, 114.391853,30.646229,263.126046, 114.349166,30.506936,117.699381, 114.142771,30.626466,357.969455, 114.089304,30.315640,67.368207, 114.036124,30.588298,202.741362, 114.328325,30.381338,151.440485, 114.382223,30.889194,25.431204, 114.807970,30.847510,322.666375, 114.305545,29.858414,15.973621, 114.489153,29.612841,204.235375, 113.823732,29.250882,344.490335, 113.945746,29.976473,367.937752, 114.046340,29.562855,147.736435, 113.906835,29.731043,195.945358, 114.898309,30.406262,328.427292, 114.691069,30.106234,288.433334, 114.735681,30.541761,390.993088, 114.885576,30.439547,68.860927, 115.015105,31.178667,106.033318, 115.567405,29.851047,294.447136, 114.878702,30.649582,88.897686, 115.272078,30.457627,231.106611, 115.405974,30.789911,33.092343, 115.687852,30.741530,157.854676, 115.442464,30.232506,347.428263, 115.950783,30.076344,161.583202, 114.624700,31.294665,100.930177, 116.009956,29.880880,333.409747, 113.916978,30.922881,128.586649, 113.845906,30.667283,324.890913, 113.579487,30.934181,244.234662, 113.695713,31.261377,236.778004, 113.760008,31.027474,47.559489, 114.004716,31.264494,143.310041, 114.133352,31.567649,106.795199, 113.378287,31.722544,78.044097, 113.306418,31.859961,106.806022, 113.832737,31.622536,277.798107, 112.704156,30.674254,336.505946, 112.847273,30.729332,382.436798, 112.888000,30.573509,265.857447, 112.997144,30.681028,81.095674, 112.951743,30.611863,149.921520, 113.017864,30.758502,69.274181, 113.097260,30.665173,267.684004, 113.047409,30.619984,3.415728, 113.093138,30.508427,131.850497, 113.092441,30.764404,305.638821, 113.226587,30.747338,120.805634, 113.355874,30.861927,354.824136, 113.396123,30.785972,16.915998, 113.337715,30.673444,303.051044, 113.407043,30.661360,270.892539, 113.392573,30.549607,358.301886, 113.373795,30.433009,137.708916, 113.341182,30.579021,383.415700, 113.231848,30.613077,186.422414, 113.194985,30.542784,63.612112, 113.274096,30.441466,318.104389, 113.194215,30.462521,204.775967, 113.150350,30.630992,30.031084, 113.489281,30.370636,34.478262, 113.431772,30.380569,40.507221, 113.466781,30.375237,7.915426, 113.458701,30.362448,290.514141, 113.041904,30.423690,370.212197, 113.091991,30.345380,322.237563, 113.208106,30.381132,121.607388, 113.314492,30.383435,310.006808, 113.571159,30.406440,177.813960, 113.684267,30.320298,98.963171, 113.512748,30.269599,147.318658, 113.681194,30.175212,356.690338, 113.515657,30.143257,271.697867, 113.386971,30.256408,232.030349, 113.300001,30.246529,33.431984, 113.237300,30.198776,65.442704, 113.158750,30.203860,245.581980],"name": "tableName","type": "heatmap","coordinateSystem": "geo"}],"geo": {"map": "湖北","label": {"emphasis": {"show": true,"textStyle": {"color": "#fff","fontSize": 20,"fontWeight": "lighter"}}},"itemStyle": {"normal": {"color": "#323c48"},"emphasis": {"color": "#2a333d"}}},"visualMap": [{"min": 100,"max": 10,"splitNumber": 5,"textStyle": {"color": "fff"}}]}
					//myChart.setOption(option);
					//alert(option);
					if("baidu" == c_2.value){
						var Div = document.createElement('div');
						Div.id='container';
						Div.style.width="99%";
						Div.style.height="99%";
						document.getElementById('main').appendChild(Div);//id为显示图表的div的id值
						eval(option);
					}
					else {
						var myChart = echarts.init(document.getElementById('main'));
						myChart.setOption(eval("(" + option + ")"));	
					}
								
				}
			};
			xmlHttp1.onreadystatechange = function() {
				if (xmlHttp1.readyState == 4) {

					var option = xmlHttp1.responseText;
					// 使用刚指定的配置项和数据显示图表。
					var str = option.split("_");
					flag=str[1];
					//alert("id="+str[0]);
					if (flag == 1) {
						alert("保存成功");

						if (x == 0) {
							document.getElementById("barDb").style.display="none";
							document.getElementById("lineDb").style.display="none";
							document.getElementById("pieDb").style.display="none";
							document.getElementById("treemapDb").style.display="none";
							document.getElementById("candlestickDb").style.display="none";
							document.getElementById("funnelDb").style.display="none";
							document.getElementById("scatterDb").style.display="none";
							document.getElementById("mapDb").style.display="none";
							document.getElementById("heatmapDb").style.display="none";
							document.getElementById("radarDb").style.display="none";
							var form = document.getElementById("chartform");
							form.style.display = "none";
							var xmlHttp5 = new XMLHttpRequest();
							xmlHttp5.open("POST", "NewtableServlet?chartType="
									+ c_2.value + "&chartName=" + tableName + "&id=" + str[0],
									true);
							xmlHttp5.onreadystatechange = function() {
								if (xmlHttp5.readyState == 4) {

									var addto = xmlHttp5.responseText;
									var axis = document
											.getElementById("newtable");
									axis.innerHTML = axis.innerHTML + addto;

								}
							};
							xmlHttp5.send(null);
						}
					} else
						alert("保存失败");
				}
			};
			xmlHttp.send(null);
			xmlHttp1.send(null);
			var removeall = document
			.getElementById("removeall");
			removeall.style.display="";

		}
		function createMap(){
			
		}
		function updata() {//done
			var form = document.getElementById("chartform");
			form.style.display = "none";
			var c_2 = document.getElementById("charttype1");

			var chartName = document.getElementById("chartName").value;
			var fontSize = document.getElementById("fontSize").value;
			var fontWeight = document.getElementById("fontWeight").value;
			var tableName = document.getElementById("tablename1").value;
			
			
			if (fontSize == "") {
				fontSize = "20";
			}
			var ttv = document.getElementById("tabletype1").value;
			var id = document.getElementById(ttv).className;
			ttv = encodeURI(encodeURI(ttv));
			var xmlHttp8 = new XMLHttpRequest();
			if ("pie" == c_2.value) {

				var innerRadius = document.getElementById("innerRadius").value;
				var externalRadius = document.getElementById("externalRadius").value;
				var piePosition = document.getElementById("piePosition").value;
				var legendPosition = document.getElementById("legendPosition").value;
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&legendPosition="
						+ legendPosition + "&piePosition=" + piePosition
						+ "&innerRadius=" + innerRadius + "&externalRadius="
						+ externalRadius+"&id="+id, true);

			} else if ("bar" == c_2.value) {

				var barGap = document.getElementById("barGap").value;
				var yUnit = document.getElementById("baryUnit").value;
				//yUnit=encodeURI(encodeURI(yUnit));
				var typeaxis = document.getElementById("typeaxis1").value;
				typeaxis=encodeURI(encodeURI(typeaxis));
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&barGap=" + barGap
						+ "&yUnit=" + yUnit + "&typeaxis=" + typeaxis+"&id="+id, true);

			} else if ("line" == c_2.value) {
				var yUnit = document.getElementById("lineyUnit").value;
				//yUnit=encodeURI(encodeURI(yUnit));
				var typeaxis = document.getElementById("typeaxis1").value;
				typeaxis=encodeURI(encodeURI(typeaxis));
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&yUnit=" + yUnit
						+ "&typeaxis=" + typeaxis+"&id="+id, true);

			} else if ("funnel" == c_2.value) {

				var sortValue = document.getElementById("sortValue").value;
				var minSize = document.getElementById("minSize").value.trim();
				var maxSize = document.getElementById("maxSize").value;
				var gap = document.getElementById("gap").value;
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontWeight="
						+ fontWeight + "&sortValue=" + sortValue + "&fontSize="
						+ fontSize + "&minSize=" + minSize + "&maxSize="
						+ maxSize + "&gap=" + gap+"&id="+id, true);

			} else if ("scatter" == c_2.value) {

				var xmax = document.getElementById("xmax").value;
				var xmin = document.getElementById("xmin").value;
				var ymax = document.getElementById("ymax").value;
				var ymin = document.getElementById("ymin").value;
				var xUnit = document.getElementById("xUnit").value;
				//xUnit=encodeURI(encodeURI(xUnit));
				var yUnit = document.getElementById("yUnit").value;
				//yUnit=encodeURI(encodeURI(yUnit));
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&xmax=" + xmax
						+ "&xmin=" + xmin + "&ymax=" + ymax + "&ymin=" + ymin
						+ "&xUnit=" + xUnit + "&yUnit=" + yUnit + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight+"&id="+id, true);

			} else if ("treemap" == c_2.value) {

				var mapDesc = document.getElementById("mapDesc").value;
				//mapDesc=encodeURI(encodeURI(mapDesc));
				var borderColor = document.getElementById("borderColor").value;
				var borderWidth = document.getElementById("borderWidth").value;
				var mapHeight = document.getElementById("mapHeight").value;

				if (borderWidth == "") {
					borderWidth = "1";
				}

				borderColor = borderColor.substring(1);

				borderColor = "%23" + borderColor;

				xmlHttp8.open("GET", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&mapDesc=" + mapDesc
						+ "&borderColor=" + borderColor + "&borderWidth="
						+ borderWidth + "&mapHeight=" + mapHeight+"&id="+id, true);

			} else if ("candlestick" == c_2.value) {

				var color = document.getElementById("color").value;
				var color0 = document.getElementById("color0").value;
				color = color.substring(1);
				color0 = color0.substring(1);

				color = "%23" + color;
				color0 = "%23" + color0;

				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&color=" + color
						+ "&color0=" + color0+"&id="+id, true);

			}else if ("map" == c_2.value) {

				var mapmin = document.getElementById("mapmin").value;
				var mapmax = document.getElementById("mapmax").value;
				
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&mapmin=" + mapmin
						+ "&mapmax=" + mapmax+"&id="+id, true);

			}else if ("baidu" == c_2.value) {

				var radius = document.getElementById("baiduradius").value;
				var maxNum = document.getElementById("baidumaxNum").value;
				
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&radius=" + radius
						+ "&maxNum=" + maxNum+"&id="+id, true);

			}else if ("heatmap" == c_2.value) {

				var heatmapmin = document.getElementById("heatmapmin").value;
				var heatmapmax = document.getElementById("heatmapmax").value;
				
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&heatmapmin=" + heatmapmin
						+ "&heatmapmax=" + heatmapmax+"&id="+id, true);

			}else if ("radar" == c_2.value) {
				var radarmax = document.getElementsByName("radarmax");				
				var max = "";
				for(var i=0;i<radarmax.length;i++){
					max=max+radarmax[i].value+" ";//alert(radarmax[i].value);
				}
				
				xmlHttp8.open("POST", "SavepropertiesServlet?chart=" + ttv
						+ "&chartName=" + chartName + "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&radarmax=" + max
						+ "&id="+id, true);

			}


			xmlHttp8.onreadystatechange = function() {
				if (xmlHttp8.readyState == 4) {

					var flag = xmlHttp8.responseText;

					if (flag == 1)
						{
						alert("更新成功");
						}
					else {
						alert("更新失败");
					}
					var ab = document.getElementById("savebutton");
					ab.style.display = "none";

				}
			};

			xmlHttp8.send(null);
			
		}
		function rewrite(x) {//done
			var id = document.getElementById(x).className;
			var xmlHttp9 = new XMLHttpRequest();
			x = encodeURI(encodeURI(x));
			xmlHttp9.open("POST", "SendpropertiesServlet?chart=" + x+"&id="+id, true);
			xmlHttp9.onreadystatechange = function() {
				if (xmlHttp9.readyState == 4) {

					var option = xmlHttp9.responseText;
					option=decodeURIComponent(option);
					option=option.replace(/[ ]/g,"");    //去掉空格
					option=option.replace(/[\r\n]/g,"");//去掉回车换行
					//alert("|"+option+"|");
					var py = option.split("_");
					var st = x.split("_");
					if (st[1] == "bar") {
						var barGap = document.getElementById("barGap");
						barGap.value = py[0];
						var baryUnit = document.getElementById("baryUnit");
						baryUnit.value = py[1];
						var typeaxis1 = document.getElementById("typeaxis1");
						typeaxis1.value = py[2];

					} else if (st[1] == "line") {
						var lineyUnit = document.getElementById("lineyUnit");
						lineyUnit.value = py[0];
						var typeaxis1 = document.getElementById("typeaxis1");
						typeaxis1.value = py[1];

					} else if (st[1] == "map") {
						var mapmax = document.getElementById("mapmax");
						mapmax.value = py[0];
						var mapmin = document.getElementById("mapmin");
						mapmin.value = py[1];

					} 
					else if (st[1] == "pie") {
						//alert(py[2]);
						var innerRadius = document
								.getElementById("innerRadius");
						innerRadius.value = py[0];
						var externalRadius = document
								.getElementById("externalRadius");
						externalRadius.value = py[1];
						piePositionClick(py[2]);
						legendPositionClick(py[3]);
						//var teas = document.getElementById("piePosition");
						var radio = document.getElementsByName('piePosition');
						for ( var i = 0; i < radio.length; i++) {
							if (radio[i].value == py[2]) {
								radio[i].checked = true;
							}
						}
						var radio1 = document
								.getElementsByName('legendPosition');
						for ( var i = 0; i < radio1.length; i++) {
							if (radio1[i].value == py[3]) {
								radio1[i].checked = true;
							}
						}//alert("sd");

					} else if (st[1] == "treemap") {
						var mapDesc = document.getElementById("mapDesc");
						mapDesc.value = py[0];
						
						//alert(py[0]);
						var mapHeight = document.getElementById("mapHeight");
						mapHeight.value = py[3];
						var borderWidth = document
								.getElementById("borderWidth");
						borderWidth.value = py[1];
						var borderColor = document
								.getElementById("borderColor");
						borderColor.value = py[2];

					} else if (st[1] == "funnel") {
						var gap = document.getElementById("gap");
						gap.value = py[3];
						var minSize = document.getElementById("minSize");
						minSize.value = py[1];
						var maxSize = document.getElementById("maxSize");
						maxSize.value = py[2];
						var radio = document.getElementsByName('sort');
						for ( var i = 0; i < radio.length; i++) {
							if (radio[i].value == py[0]) {
								radio[i].checked = true;
							}
						}

					} else if (st[1] == "candlestick") {
						var color = document.getElementById("color");
						color.value = py[0];
						var color0 = document.getElementById("color0");
						color0.value = py[1];
					} else if (st[1] == "scatter") {
						var xmax = document.getElementById("xmax");
						xmax.value = py[0];
						var xmin = document.getElementById("xmin");
						xmin.value = py[1];
						var ymax = document.getElementById("ymax");
						ymax.value = py[2];
						var ymin = document.getElementById("ymin");
						ymin.value = py[3];
						var xUnit = document.getElementById("xUnit");
						xUnit.value = py[4];
						var yUnit = document.getElementById("yUnit");
						yUnit.value = py[5];
					}else if (st[1] == "heatmap") {
						var heatmapmin = document.getElementById("heatmapmin");
						heatmapmin.value = py[0];
						var heatmapmax = document.getElementById("heatmapmax");
						heatmapmax.value = py[1];
						
					} else if (st[1] == "baidu") {
						var baiduradius = document.getElementById("baiduradius");
						baiduradius.value = py[0];
						var baidumaxNum = document.getElementById("baidumaxNum");
						baidumaxNum.value = py[1];
						
					} else if (st[1] == "radar") {
						var py_max = py[0].split(" ");
						var radarmax = document.getElementsByName("radarmax");				
						for(var i=0;i<radarmax.length;i++){
							radarmax[i].value=py_max[i];
						}
					}

				}
			};
			xmlHttp9.send(null);
		}
		function check(x) {//done
			
			var id = document.getElementById(x).className;
			
			var st = x.split("_");//st[0]view1//st[1]bar
			var c_2 = document.getElementById("charttype1");
			c_2.value = st[1];
			var c_3 = document.getElementById("tablename1");
			c_3.value = st[0];
			var tt = document.getElementById("tabletype1");
			tt.value = x;
			var chartName = document.getElementById("chartName").value;
			var fontSize = document.getElementById("fontSize").value;
			var fontWeight = document.getElementById("fontWeight").value;
			if (fontSize == "") {
				fontSize = "20";
			}

			change(st[1], 1);
			if (st[1] == "bar" || st[1] == "line"||st[1]=="radar") {
				var st0 = encodeURI(encodeURI(st[0]));
				//alert("id");
				loadtype(st[0],id, st[1]);	
				
			}
			
			if(st[1] != "radar" )
			{rewrite(x);}
			
			x = encodeURI(encodeURI(x));
			var xmlHttp7 = new XMLHttpRequest();
			xmlHttp7.open("POST", "CheckchartServlet?chart=" + x
					+ "&chartName=" + chartName + "&fontSize=" + fontSize
					+ "&fontWeight=" + fontWeight+ "&id=" + id, true);
			xmlHttp7.onreadystatechange = function() {
				if (xmlHttp7.readyState == 4) {
//document.getElementById('test').innerHTML=xmlHttp.responseText;
					//alert("1");
					// 指定图表的配置项和数据
					var option = xmlHttp7.responseText +  "";
					//var option = {"title": {"text": "tableName","textStyle": {"color": "#fff"}},"series": [{data:[114.315605,30.605643,87.469039, 114.277373,30.607757,135.610738, 114.221175,30.588484,67.651569, 114.225200,30.560376,27.913074, 114.322576,30.559630,338.583981, 114.391853,30.646229,263.126046, 114.349166,30.506936,117.699381, 114.142771,30.626466,357.969455, 114.089304,30.315640,67.368207, 114.036124,30.588298,202.741362, 114.328325,30.381338,151.440485, 114.382223,30.889194,25.431204, 114.807970,30.847510,322.666375, 114.305545,29.858414,15.973621, 114.489153,29.612841,204.235375, 113.823732,29.250882,344.490335, 113.945746,29.976473,367.937752, 114.046340,29.562855,147.736435, 113.906835,29.731043,195.945358, 114.898309,30.406262,328.427292, 114.691069,30.106234,288.433334, 114.735681,30.541761,390.993088, 114.885576,30.439547,68.860927, 115.015105,31.178667,106.033318, 115.567405,29.851047,294.447136, 114.878702,30.649582,88.897686, 115.272078,30.457627,231.106611, 115.405974,30.789911,33.092343, 115.687852,30.741530,157.854676, 115.442464,30.232506,347.428263, 115.950783,30.076344,161.583202, 114.624700,31.294665,100.930177, 116.009956,29.880880,333.409747, 113.916978,30.922881,128.586649, 113.845906,30.667283,324.890913, 113.579487,30.934181,244.234662, 113.695713,31.261377,236.778004, 113.760008,31.027474,47.559489, 114.004716,31.264494,143.310041, 114.133352,31.567649,106.795199, 113.378287,31.722544,78.044097, 113.306418,31.859961,106.806022, 113.832737,31.622536,277.798107, 112.704156,30.674254,336.505946, 112.847273,30.729332,382.436798, 112.888000,30.573509,265.857447, 112.997144,30.681028,81.095674, 112.951743,30.611863,149.921520, 113.017864,30.758502,69.274181, 113.097260,30.665173,267.684004, 113.047409,30.619984,3.415728, 113.093138,30.508427,131.850497, 113.092441,30.764404,305.638821, 113.226587,30.747338,120.805634, 113.355874,30.861927,354.824136, 113.396123,30.785972,16.915998, 113.337715,30.673444,303.051044, 113.407043,30.661360,270.892539, 113.392573,30.549607,358.301886, 113.373795,30.433009,137.708916, 113.341182,30.579021,383.415700, 113.231848,30.613077,186.422414, 113.194985,30.542784,63.612112, 113.274096,30.441466,318.104389, 113.194215,30.462521,204.775967, 113.150350,30.630992,30.031084, 113.489281,30.370636,34.478262, 113.431772,30.380569,40.507221, 113.466781,30.375237,7.915426, 113.458701,30.362448,290.514141, 113.041904,30.423690,370.212197, 113.091991,30.345380,322.237563, 113.208106,30.381132,121.607388, 113.314492,30.383435,310.006808, 113.571159,30.406440,177.813960, 113.684267,30.320298,98.963171, 113.512748,30.269599,147.318658, 113.681194,30.175212,356.690338, 113.515657,30.143257,271.697867, 113.386971,30.256408,232.030349, 113.300001,30.246529,33.431984, 113.237300,30.198776,65.442704, 113.158750,30.203860,245.581980],"name": "tableName","type": "heatmap","coordinateSystem": "geo"}],"geo": {"map": "湖北","label": {"emphasis": {"show": true,"textStyle": {"color": "#fff","fontSize": 20,"fontWeight": "lighter"}}},"itemStyle": {"normal": {"color": "#323c48"},"emphasis": {"color": "#2a333d"}}},"visualMap": [{"min": 100,"max": 10,"splitNumber": 5,"textStyle": {"color": "fff"}}]}
					//myChart.setOption(option);
					//alert(option);
					if("baidu" == c_2.value){
						var Div = document.createElement('div');
						Div.id='container';
						Div.style.width="99%";
						Div.style.height="99%";
						document.getElementById('main').appendChild(Div);//id为显示图表的div的id值
						eval(option);
					}
					else {
						var myChart = echarts.init(document.getElementById('main'));
						myChart.setOption(eval("(" + option + ")"));	
					}
				}
			};

			xmlHttp7.send(null);
			var button1 = document.getElementById("savebutton");
			var button2 = document.getElementById("updatabutton");
			button1.style.display = "none";
			button2.style.display = "";
			var chartform = document.getElementById("chartform");
			chartform.style.display="none";
		}
		function removechart(x) {//done
			
			var form = document.getElementById("chartform");
			form.style.display = "none";
			var button1 = document.getElementById("savebutton");
			var button2 = document.getElementById("updatabutton");
			button2.style.display = "none";
			button1.style.display = "";
			var item = document.getElementById(x);
			var id = item.className;
			//alert(item.className);
			if (item != null) {
				item.parentNode.removeChild(item);
			}
			x = encodeURI(encodeURI(x));
			var xmlHttp6 = new XMLHttpRequest();
			xmlHttp6.open("POST", "RemovechartServlet?chart=" + x + "&id=" + id, true);
			xmlHttp6.onreadystatechange = function() {
				if (xmlHttp6.readyState == 4) {

					
				}
			};
			xmlHttp6.send(null);
			
			var axis = document
					.getElementById("newtable");
			//alert(axis.innerHTML);
			//alert(axis.innerHTML==null||axis.innerText=="");
			if(axis.innerText==""||axis.innerText==null){
				var removeall = document
				.getElementById("removeall");
				removeall.style.display="none";
			}			
		}
		
		function piePositionClick(position) {//done
			document.getElementById("piePosition").value = position;
			btn_click(1);
		}
		function legendPositionClick(position) {//done
			document.getElementById("legendPosition").value = position;
			btn_click(1);
		}
		function sort_click(position) {//done
			document.getElementById("sortValue").value = position;
			btn_click(1);
		}

		$(document).ready(function() {//done

			$('.demo').each(function() {
				$(this).minicolors({
					position : $(this).attr('data-position') || 'bottom left',
				});

			});
		});

		//$(document).ready(btn_click());
	</script>
</body>
</html>