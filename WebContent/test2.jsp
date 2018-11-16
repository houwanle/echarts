<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.czy.dao.BaseDao"%>
<%@page import="com.czy.beans.DataSource"%>
<%@page import="com.czy.dao.DataSourceDao"%>
<%@page import="com.czy.utils.CommonUtils"%>
<%@page import="java.util.List"%>
<!DOCTYPE HTML>
<html>
<head>
<style>
html,body {
	height: 100%;
	margin: 0px;
}

.left {
	float: left;
	height: 100%;
	width: 14%;
	margin: 0 auto;
}

.right {
	margin: 0 auto;
	float: left;
	height: 100%;
	width: 84%;
}

#split div {
	float: left;
	margin: 2px;
	text-align: center;
}

.droptarget {
	cursor: move;
}

.update {
	margin-top:20px;
	display: none;
}
</style>
<script src="js/echarts.js"></script>
<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
</head>
<body>
	<div id="main"
		style="left: 5%; top: 5%; width: 90%; height: 90%; position: absolute;">
		<div class="left">
			<div style="height:100%;">
				<!-- 柱状图  -->
				<div id="barNode" style="font-size: 20px; font-weight: bold">
					<img id="barImg" src="img/expand.png" /><a href="#"
						onclick="expand('barDb')">柱形图</a>
				</div>
				<!-- 柱形图 -->
				<div id="barDb">
					<%
					List<List<String>> list = null;
					list = (List)request.getAttribute("bar");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
						%>
						<div id="bar" style="font-size: 20px; margin-left: 5%;">
							<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
						</div>
						<%
						}
					}
					%>
				</div>
				<!-- 折线  -->
				<div id="lineNode" style="font-size: 20px; font-weight: bold">
					<img id="lineImg" src="img/expand.png" /><a href="#"
						onclick="expand('lineDb')">折线图</a>
				</div>
				<div id="lineDb" style="margin-left: 5%">
					<%
					list = (List)request.getAttribute("line");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
					%>
					<div id="line" style="font-size: 20px; margin-left: 5%;">
						<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
					</div>
					<%
						}
					}
					%>
				</div>
				
				<!-- 饼图  -->
				<div id="pieNode" style="font-size: 20px; font-weight: bold">
					<img id="pieImg" src="img/expand.png" /><a href="#"
						onclick="expand('pieDb')">饼图</a>
				</div>
				<div id="pieDb" style="margin-left: 5%">
					<%
					list = (List)request.getAttribute("pie");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
					%>
					<div id="pie" style="font-size: 20px; margin-left: 5%;">
						<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
					</div>
					<%
						}
					}
					%>
				</div>
				
				<!-- 漏斗图  -->
				<div id="funnelNode" style="font-size: 20px; font-weight: bold">
					<img id="funnelImg" src="img/expand.png" /><a href="#"
						onclick="expand('funnelDb')">漏斗图</a>
				</div>
				<div id="funnelDb" style="margin-left: 5%">
					<%
					list = (List)request.getAttribute("funnel");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
					%>
					<div id="funnel" style="font-size: 20px; margin-left: 5%;">
						<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
					</div>
					<%
						}
					}
					%>
				</div>
					
				<!-- 散点图 -->
				<div id="scatterNode" style="font-size: 20px; font-weight: bold">
					<img id="scatterImg" src="img/expand.png" /><a href="#"
						onclick="expand('scatterDb')">散点图</a>
				</div>
				<div id="scatterDb" style="margin-left: 5%">
					<%
					list = (List)request.getAttribute("scatter");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
					%>
					<div id="scatter" style="font-size: 20px; margin-left: 5%;">
						<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
					</div>
					<%
						}
					}
					%>
				</div>
				<!-- 树图  -->
				<div id="treemapNode" style="font-size: 20px; font-weight: bold">
					<img id="treemapImg" src="img/expand.png" /><a href="#"
						onclick="expand('treemapDb')">树图</a>
				</div>
				<div id="treemapDb" style="margin-left: 5%">
					<%
					list = (List)request.getAttribute("treemap");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
					%>
					<div id="treemap" style="font-size: 20px; margin-left: 5%;">
						<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
					</div>
					<%
						}
					}
					%>
				</div>
				<!-- k线图 -->
				<div id="candlestickNode" style="font-size: 20px; font-weight: bold">
					<img id="candlestickImg" src="img/expand.png" /><a href="#"
						onclick="expand('candlestickDb')">K线图</a>
				</div>
				<div id="candlestickDb" style="margin-left: 5%">
					<%
					list = (List)request.getAttribute("candlestick");
					if(list != null) {
						for(int i = 1; i < list.size(); i++) {
					%>
					<div id="candlestick" style="font-size: 20px; margin-left: 5%;">
						<div class="droptarget" draggable="true" id="<%=list.get(i).get(0)%>"><%=list.get(i).get(1)%></div>
					</div>
					<%
						}
					}
					%>
				</div>
			
				请输入分屏比例：<br /> <input value="1" style="width: 35%;" type="text" id="x" name="x"/>* 
					<input value="1" style="width: 35%;" type="text" id="y" name="y" oninput="create()" /><br />
				请输入屏幕名称：<br /> <input value="" style="width: 80%" type="text"
					id="name"><br />
				<div class="update">
					<div id="divName" style="margin: 2px;"></div>
					<div id="chartNum" style=""></div>
					<div id="chartType" style=""></div>
					字体大小<br />
					<input type="range" id="fontSize" name="fontSize" min="15" max="30" onchange="usersubmit('update')"/><br/>
					字体类型<br/>
					<select onchange="usersubmit('update')" id="fontWeight" name="fontWeight">
						<option value="lighter">lighter</option>
						<option value="normal">normal</option>
						<option value="bold">bold</option>
						<option value="bolder">bolder</option>
					</select><br /> 
					主题<br/>
					<select onchange="usersubmit('update')" id="theme" name="theme">
						<option
							value="['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']">
							默认</option>
						<option
							value="['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B','#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0']">
							infographic</option>
						<option
							value="['#d8361b','#f16b4c','#f7b4a9','#d26666','#99311c','#c42703','#d07e75']">
							red</option>
						<option
							value="['#FE8463','#9BCA63','#FAD860','#60C0DD','#0084C6','#D7504B','#C6E579','#26C0C0','#F0805A','#F4E001','#B5C334']">
							dark</option>
						<option
							value="['#8aedd5','#93bc9e','#cef1db','#7fe579','#a6d7c2','#bef0bb','#99e2vb','#94f8a8','#7de5b8','#4dfb70']">
							mint</option>
						<option
							value="['#2ec7c9','#b6a2de','#5ab1ef','#ffb980','#d87a80','#8d98b3','#e5cf0d','#97b552','#95706d','#dc69aa','#07a2a4','#9a7fd1','#588dd5','#f5994e','#c05050','#59678c','#c9ab00','#7eb00a','#6f5553','#c14089']">
							macarons</option>
					</select><br />
					<div id="test"></div>
					<input id="submit" style="width: 80%;" type="button" value="保存用户设置"
						onclick="" />
				</div>
			</div>
		</div>
		<div class="right" id="split"></div>
	</div>
	<form id="myForm" action="SaveScreenServlet" method="post">
		<input type="hidden" id="hiddenid" />
		<input type="hidden" id="hiddenflag" />
	</form>
	<script>
		function screenBtn() {
			var x = document.getElementById("x").value;
			var y = document.getElementById("y").value;
			var name = document.getElementById("name").value;
			var xmlHttp = new XMLHttpRequest();
			//var location = document.getElementById("divName").innerHTML;
			name = encodeURI(encodeURI(name));
			xmlHttp.open("POST", "SaveScreenServlet?name=" + name + "&x=" + x
					+ "&y=" + y, true);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					if (xmlHttp.responseText > 0) {
						alert("success");

					} else {
						alert("fail");
					}
				}
			};
			xmlHttp.send(null);
		}
		
		function expand(domid) {
			dom = document.getElementById(domid);
			if(dom.style.display == "none") {
				dom.style.display = "";
			} else {
				dom.style.display = "none";
			}
		}
		
		var eleDrags = $(".droptarget"), lDrags = eleDrags.length, eleDrag = null;
		/* Events fired on the drag target */
		var $ = function(selector) {
			if (!selector) {
				return [];
			}
			var arrEle = [];
			if (document.querySelectorAll) {
				arrEle = document.querySelectorAll(selector);
			} else {
				var oAll = document.getElementsByTagName("div"), lAll = oAll.length;
				if (lAll) {
					var i = 0;
					for (i; i < lAll; i += 1) {
						if (/^\./.test(selector)) {
							if (oAll[i].className === selector.replace(".", "")) {
								arrEle.push(oAll[i]);
							}
						} else if (/^#/.test(selector)) {
							if (oAll[i].id === selector.replace("#", "")) {
								arrEle.push(oAll[i]);
							}
						}
					}
				}
			}
			return arrEle;
		};
		for ( var i = 0; i < lDrags; i += 1) {
			//alert('aaa');
			eleDrags[i].onselectedstart = function() {
				return false;
			};
			eleDrags[i].ondragstart = function(ev) {
				//ev.dataTransfer.effectAllowed = "move";
				ev.dataTransfer.setData("text", ev.target.id);
				//ev.target.style.opacity = "0.4";
				eleDrag = ev.target;
				//alert(this.id);
				//获取id值 图类型
				document.getElementById("chartNum").innerHTML = this.id;
				document.getElementById("chartType").innerHTML = this.parentElement.id;
				var chartType = this.parentElement.id;
				var xmlHttp = new XMLHttpRequest();
				var url = "PropertyServlet?chartstate=select&id=" + this.id
						+ "&chartType=" + chartType
						+ "&x=" + x + "&y=" + y;
				xmlHttp.open("POST", url, true);
				xmlHttp.onreadystatechange = function() {
					if (xmlHttp.readyState == 4) {
						eleDrag = xmlHttp.responseText;
					}
				};
				xmlHttp.send(null);

				return true;
			}
			eleDrags[i].ondragend = function(ev) {//当拖拽完成后触发的事件，此事件作用在被拖曳元素上
				ev.target.style.opacity = "1";
				;
				ev.dataTransfer.clearData("text");
				eleDrag = null;
				return false
			};

		}
		/* Events fired on the drop target */

		// When the draggable p element enters the droptarget, change the DIVS's border style
		document.addEventListener("dragenter", function(event) {
			if (event.target.className == "target") {
			}
		});

		// By default, data/elements cannot be dropped in other elements. To allow a drop, we must prevent the default handling of the element
		document.addEventListener("dragover", function(event) {
			event.preventDefault();
		});

		// When the draggable p element leaves the droptarget, reset the DIVS's border style
		document.addEventListener("dragleave", function(event) {
			if (event.target.className == "target") {
			}
		});

		document.addEventListener("drop", function(event) {
			event.preventDefault();
			if (event.target.className == "target") {
				//传入option eleDrag为给div传值的列表
				var myChart = echarts.init(event.target);
				myChart.setOption(eval("(" + eleDrag + ")"));
			}
		});

		var x = document.getElementById('x').value;
		var y = document.getElementById('y').value;
		function create() {
			for ( var i = 0; i < document.getElementById('x').value
					* document.getElementById('y').value; i++) {
				var oDiv = document.createElement('div');
				var xnum = document.getElementById('x').value;
				var ynum = document.getElementById('y').value;
				var xn = 95 / xnum;
				var yn = 95 / ynum;
				oDiv.id = 'div' + i;
				oDiv.style.width = '' + xn + '%';//''+xn+'%'
				oDiv.style.height = '' + yn + '%';//''+xn+'%'
				oDiv.setAttribute('class', 'target');
				oDiv.style.border = '1px solid #000';
				oDiv
						.addEventListener(
								"click",
								function() {
									document.getElementById("divName").innerHTML = this.id;
									document.getElementsByClassName("update")[0].style.display = "block";
								}, false);
				document.getElementById('split').appendChild(oDiv);
			}
		}
		//保存设置信息
		function usersubmit(value) {

			var fontSize = document.getElementById('fontSize').value;
			var fontWeight = document.getElementById('fontWeight').value;
			var theme = URLencode(document.getElementById('theme').value);//特殊字符转换
			var x = document.getElementById('x').value;
			var y = document.getElementById('y').value;
			var id = document.getElementById("chartNum").innerHTML;
			var chartType = document.getElementById("chartType").innerHTML;
			var location = document.getElementById("divName").innerHTML;
			var xmlHttp = new XMLHttpRequest();
			if (value === "insert") {
				xmlHttp.open("POST", "PropertyServlet?chartstate=" + value
						+ "&location=" + location +"&chartType="+chartType+ "&id=" + id + "&fontSize="
						+ fontSize + "&fontWeight=" + fontWeight + "&theme="
						+ theme + "&x=" + x + "&y=" + y, true);
				xmlHttp.onreadystatechange = function() {
					if (xmlHttp.readyState == 4) {
						if (xmlHttp.responseText == 1) {
							alert("保存成功");
						} else {
							alert("保存失败");
							//alert(location);
						}

					}
				};
			} else {
				xmlHttp.open("POST", "PropertyServlet?chartstate=" + value
						+ "&id=" + id +"&chartType="+chartType+ "&fontSize=" + fontSize
						+ "&fontWeight=" + fontWeight + "&theme=" + theme
						+ "&x=" + x + "&y=" + y, true);
				xmlHttp.onreadystatechange = function() {
					if (xmlHttp.readyState == 4) {
						var myChart = echarts.init(document.getElementById(""
								+ location + ""));
						myChart
								.setOption(eval("(" + xmlHttp.responseText+ ")"));
					}
				};
			}
			xmlHttp.send(null);
		}
		function URLencode(sStr) {
			return escape(sStr).replace(/\#/g, '%23').replace(/\+/g, '%2B')
					.replace(/\"/g, '%22').replace(/\'/g, '%27').replace(/\//g,
							'%2F');
		}
		
		
	</script>
</body>
</html>