<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sun.org.apache.xpath.internal.operations.Variable"%>
<%@page import="com.czy.utils.CommonUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html style="height:100%;width:100%;">
<head>
<script src="js/echarts.js"></script>
<script src="js/hubei.js"></script>

<!-- 
<script type="text/javascript"
	src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
<script type='text/javascript'
	src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js"></script> -->
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.6.4/jquery.js"></script>
<script type='text/javascript' src="js/bootstrap-slider.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
<!-- <link
	href="http://libs.useso.com/js/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet"> -->
<link href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link href="js/bootstrap-slider.min.css" rel="stylesheet">
<!-- MiniColors -->
<script src="js/jquery.minicolors.js"></script>
<link rel="stylesheet" href="js/jquery.minicolors.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	html,body {
		height: 100%;
		margin: 0px;
		font-family:"微软雅黑",sans-serif;
	}

	/*input text class=textinput */
	.textinput{
		
		background:#f0f1f7;
		border: 1px solid #e5e5e5;
		border-radius:4px;
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
		
		padding: 6px 12px;
		font-size: 14px;
		line-height: 1.428571429;
		color: #555555;
		vertical-align: middle;
		margin:auto;  
	}
	.textinput:focus
	{
		box-shadow: inset 0 1px 1px rgba(0,0,0,.075); 
	}
	/*right_bottom*/
	#right_bottom{
		position:absolute;
		margin:auto 1%;
		background:#ffffff;
		width:80%;
		height:85%;
		border:1px solid #ffffff;
		border-radius:2px;}
	/*drop box*/

	.btn-group{margin-left:1%;width:20%;text-align:center;font-family:"微软雅黑",sans-serif;float:right;}
	.btn-group>.btn{
				color:#ffffff;
				height:95%;
				width:80%;
				margin:10px 2px;				
				font-size:18px;
				font-weight:700;
				padding:2px 2px 10px 2px;
				border:none;
				background-color:transparent;
				outline:none;
	}
	
	.btn-group>.btn:hover{border-bottom:2px solid #2ec7c9;}
	
	.menu{
		display:block;
		width:80%;
		height:auto;
		margin-top:21%;
		background-color:#ffffff;
		border:1px solid #cecece;
		border-radius: 6px;
		padding:0px;
		position:relative;
		box-shadow: 0 0 8px #dddddd;
		z-index:9999
	}
	
	.menu-display{
     	opacity: 0;
		display:none;
		}
	
	.menu>li{color:#bdbdbd;font-size:18px;list-style-type:none;width:97.5%;display:block;padding:8px 1px;margin:auto;font-weight:700;}
	.menu>li>a{color:#bdbdbd;text-decoration:none;width:99%;display:block;}
	.menu>li>a:hover{color:#2ec7c9;font-weight:750;}
	
	#tree_menu{
		background-color:#ffffff;
		width:16%;
		height:40%;
		margin-left:1.8%;
		padding:2px;
		border:1px solid #e9e9e9;
		border-radius:5px;
		display:block;
		overflow-y:scroll;
		position:absolute;
		}
	#tree_menu>a,div{text-decoration:none;color:#000000;font-size:16px;}/*color:#000000;*/
	
	a:visited{text-decoration:none;}
	a:link{text-decoration:none;}
	a:hover{text-decoration:none;}
	/*select 选框*/
	.styled-select {
	    margin:auto;
	    
	    background: url("img/arrow.png") no-repeat right #f0f1f7;
	    border:1px solid #e5e5e5e;
	    border-radius:5px;
	}

	.styled-select select {   
	    background: transparent;   
	    width: 100%;   
	    padding: 5px;   
	    font-size: 16px;   
	    border:1px solid #e5e5e5;
	    border-radius:5px;
	   
	    -webkit-appearance: none; 
	}
	.styled-select select:focus
	{
		box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, 0.6); 
	}
	
	.childstyle{
		width:100%;
		height:100%;
		display:none;
		margin:auto 1.2%;
		}
	
	/*save*/
	.save_button{
			background-color:#2ec7c9;
			border:1px solid #2ec7c9;
			border-radius:5px;	
			
			font-size:16px;
			font-weight:700;
			color:#ffffff;
			outline:none;
			margin-top:2px;
		}
	/**screen_manage
	 *
	 **/
	.screenstyle{
		
		margin:auto;
		width:100%;
		height:100%;
		padding:5px;
		background-color:#ffffff;
		padding-top:2%;
		padding-left:3%;
		
	}
</style>
</head>
<body style="height:100%;width:100%;margin:0">
<div style="width:100%;height:100%;">

<!-- this is left content -->
<div style="width:18%;height:100%;float:left;background:#f0f1f7">
	<div style="width:100%;height:auto;margin-bottom:8%"><img src="img/logo.png" style="margin:auto;display:block;"/></div>
	<div id="newscreen" onclick="split()" style="letter-spacing:2px;font-size:18px;font-weight:650;margin-bottom:4%;margin-left:10%;">新建</div>
	
	<div id="openfile" onclick="show_screen()" style="letter-spacing:2px;font-size:18px;font-weight:650;margin-bottom:6%;margin-left:10%;">最近打开文件</div>
	
	<hr style="width:80%;margin-left:4%;margin-bottom:4%;display:block" color="#E5E5E5"/>
	
	<div style="letter-spacing:2px;font-size:20px;font-weight:700;color:#bdbdbd;margin-bottom:6%;margin-left:10%;">工具</div>
	<div style="width:90%;margin-bottom:4%;margin-left:10%;">
		<div style="letter-spacing:2px;font-size:18px;margin-bottom:2%;">项目名称</div>
		<input id="sname" type="text" style="width:86%;height:10%;" class="textinput"/>
	</div>
<!-- 属性表单 -->
<form id="propertyForm" action="SaveScreenServlet" method="post">
</form>

<div style="width:90%;margin-bottom:4%;margin-left:10%;">
	<div style="letter-spacing:2px;margin-bottom:2%;font-size:18px;">分屏</div>
	
	<div style="color:#bdbdbd;width:20%;float:left;font-size:18px;">行</div>
	<div style="letter-spacing:12px;width:70%;float:left;">
		<img onclick="minusvalue('row')" style="float:left;width:18px;margin-right:2px;" src="img/minus.png"></img>
		<div id="row" style="float:left;width:30px;height:18px;padding-left:6px;">0</div>
		<img onclick="plusvalue('row')" style="float:left;width:18px;margin:0 1px;" src="img/plus.png"></img>
	</div>
	<div style="clear:both;"></div>
	<div style="color:#bdbdbd;width:20%;float:left;font-size:18px;">列</div>
	<div style="letter-spacing:12px;width:70%;float:left;">
		<img onclick="minusvalue('col')"  style="float:left;height:18px;margin-right:2px;" src="img/minus.png"></img>
		<div id="col" style="float:left;width:30px;height:18px;padding-left:6px;">2</div>
		<img onclick="plusvalue('col')" style="float:left;height:18px;margin:0 1px;" src="img/plus.png"></img>
	</div>

</div>

<div style="clear:both;margin-bottom:4%"></div>

<!-- 视图 -->
<div id="showtable" onclick="show_tablemenu('tree_menu')" style="width:90%;margin-bottom:2%;margin-left:10%;font-size:18px;">图表类型<img src="img/arrow.png"/></div>
<div id="tree_menu" style="display:none;" ></div>

<div style="width:99%;margin-bottom:4%;margin-left:10%;">
	<div name="infontSize" style="letter-spacing:2px;font-size:18px;margin-bottom:2%;" >字体大小</div>
	<div style="width:86%;height:30px;margin-right:15%;" class="textinput">
		<input id="infontSize" style="width:70%;outline:none;;text-align:left;float:left;background:transparent;border:none;height:100%;" type="text" />
		<input disabled="disabled" style="width:30%;float:left;background:transparent;font-size:16px;color:#bdbdbd;border:none;height:100%;" value="像素"/>
	</div>
</div>

<!-- if you want to get the select's value, just get the hidden's value -->
<div style="width:99%;margin-bottom:4%;margin-left:10%;">
	<div style="letter-spacing:2px;font-size:18px;margin-bottom:2%;">字体类型</div>
	<div style="width:86%;margin-right:15%;" class="styled-select">
		<select id="infontWeight" name="infontWeight">
			<option value="lighter">lighter</option>
			<option value="normal">normal</option>
			<option value="bold" selected="selected">bold</option>
			<option value="bolder">bolder</option>
		</select>
	</div>
</div>

<div style="clear:both;margin-bottom:4%"></div>

<!-- if you want to get the select's value, you should get the hidden(id="theme")'s value first, then get another hidden's value by the first value you get ! -->
<div style="width:99%;margin-bottom:4%;margin-left:10%;">
	<div name="theme" style="letter-spacing:2px;font-size:18px;margin-bottom:2%;">主题</div>
	<div style="width:86%;margin-right:15%;" class="styled-select">
		<select id="theme" name="theme">
			<option value="['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']" selected="selected">默认</option>
			<option value="['#C1232B','#B5C334','#FCCE10','#E87C25','#27727B','#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD','#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0']">infographic</option>
			<option value="['#d8361b','#f16b4c','#f7b4a9','#d26666','#99311c','#c42703','#d07e75']">red</option>
			<option value="['#FE8463','#9BCA63','#FAD860','#60C0DD','#0084C6','#D7504B','#C6E579','#26C0C0','#F0805A','#F4E001','#B5C334']">dark</option>
			<option value="['#8aedd5','#93bc9e','#cef1db','#7fe579','#a6d7c2','#bef0bb','#99e2vb','#94f8a8','#7de5b8','#4dfb70']">mint</option>
			<option value="['#2ec7c9','#b6a2de','#5ab1ef','#ffb980','#d87a80','#8d98b3','#e5cf0d','#97b552','#95706d','#dc69aa','#07a2a4','#9a7fd1','#588dd5','#f5994e','#c05050','#59678c','#c9ab00','#7eb00a','#6f5553','#c14089']">macarons</option>
		</select>
	</div>
</div>

	<div style="clear:both;margin-bottom:4%"></div>
	<input id="submit" class="save_button" value="保存" type="button" style="margin-left:10%;width:86%;" class="save_button" onclick="save();"/>
</div>
<!-- left content ends -->

<!-- this is right content -->
<div style="width:82%;height:100%;float:left;background:#151e45">

<!-- this is right-top content -->
<div style="margin-top:3%;width:100%;height:10%;">
	<div id="navbar" style="width:100%;height:10%;z-index:9999;">	
		<div class="btn-group">
			<button onclick="showmenu('contolmenu')" id="controlmanage" type="button" class="btn">&nbsp;可视化控件管理&nbsp;<img style="height:15px;margin-left:6px;" src="img/arrow.png"></img></button>
			<ul class="menu-display" id="contolmenu">
				<li><a id="barclick" href="#" onclick="change('bar',0)">柱形图</a></li>
				<li><a id="lineclick" href="#" onclick="change('line',0)">折线图</a></li>
				<li><a id="pieclick" href="#" onclick="change('pie',0)">饼图</a></li>
				<li><a id="scatterclick" href="#" onclick="change('scatter',0)">散点图</a></li>
				<li><a id="treemapclick" href="#" onclick="change('treemap',0)">树图</a></li>
				<li><a id="funnelclick" href="#" onclick="change('funnel',0)">漏斗图</a></li>
				<li><a id="candlestickclick" href="#" onclick="change('candlestick',0)">K线图</a></li>
				<li><a id="mapclick" href="#" onclick="change('map',0)">地图</a></li>
				<li><a id="radarclick" href="#" onclick="change('radar',0)">雷达图</a></li>
				<li><a id="heatmapclick" href="#" onclick="change('heatmap',0)">热力图</a></li>
				<li><a id="baiduclick" href="#" onclick="change('baidu',0)">百度地图</a></li>
			</ul>
		</div>
		<div class="btn-group">
			<button onclick="showmenu('viewmenu')" id="viewmanage" type="button" class="btn">&nbsp;视图管理&nbsp;<img style="height:15px;margin-left:6px;" src="img/arrow.png"></img></button>
			<ul class="menu-display" id="viewmenu">
				<li><a id="newview" href="javascript:openAddViewPage()">新建视图</a></li>
				<li><a id="showview" href="javascript:openGetViewPage()">查看视图</a></li>
			</ul>
		</div>
		<div class="btn-group">
			<button onclick="showmenu('datamenu')" id="datasource" type="button" class="btn">&nbsp;数据源&nbsp; <img style="height:15px;margin-left:6px;" src="img/arrow.png"></img></button>
			<ul class="menu-display" id="datamenu">
				<li><a id="getdataview" href="javascript:openAddDatasourcePage()">新建数据源</a></li>
				<li><a id="showdataview" href="javascript:openGetDatasourcePage()">查看数据源</a></li>
			</ul>
		</div>
	</div>
</div>
<!-- right-top content ends -->

<!-- this is right-bottom content  <div style="margin:auto;width:95%;height:84%;background:#fff;">-->
<div id="right_bottom">
	
	<!-- style="position:relative;margin:auto;width:100%;height:100%;background:#fff;display:none;background-color:#ffffff;" -->
	<div id="system2div" style="background:transparent;" class="childstyle">
		<div style="width:98%; height: 20%;background-color:#ffffff;padding-left:2%;padding-right:2%;">
			<!-- 新建视图 -->
			<div id= "leftform" style="padding:0.5%;width:40%; height:100%; border:1px ;overflow: auto;float:left;">
				<h4>请选择表</h4>
			</div>
			<!-- 已建立视图 -->
			<div style="padding:0.5%;width: 60%; height: 98%;overflow: auto;float:left;">
				<div style="width:30%;float:left"><h4>已保存</h4></div>
				<div id="removeall" style="float:right;width: 70%;text-align:right;display:none">
					<input type="button" style="width:50%;height:100%;border:1px solid #bb2026;;border-radius:5px;background:transparent;" onclick="removeall()" value="全部删除" />
				</div>
				<div style="clear:both;"></div>
				<div id="newtable"  style="width:100%;"></div>
			</div>
		</div>
		<!-- 预览 -->
		<div style="width: 98%; height:52% ;background-color:#ffffff;margin-top:0.5%;">
			
			<div id="main" style="width: 100%; height: 100%"></div>
			<input type="hidden" id="charttype1" value="" name="charttype1" />
			<!-- chart类型 -->
			<input type="hidden" id="tablename1" value="" name="tablename1" />
			<!-- 表名 -->
			<input type="hidden" id="tabletype1" value="" name="tabletype1" />	
			<!-- 表名与chart类型 -->
		</div>
		<!-- 属性 -->
		<div style="width: 99%; height: 23%;background:transparent;margin-top:0.5%;">
			<div id="property" style="background-color:#ffffff;width:49%;height: 100%;float:left;overflow: auto;padding-left:2%;padding-right:2%;">
					<div style="width:90%;height:15%;margin:auto;">
						<div style="width:50%;height:5%;float:left;">系统属性</div>
						<div style="width:50%;height:5%;float:left;">
							<div id="updatabutton" style="display: none;text-align:left;">
								<input type="button" class="save_button" style="width:100%;height:100%;" onclick="updata()" value="更新" />
							</div>
							<div id="savebutton" style="display:none;text-align:left;">
								<input type="button" class="save_button" style="width:100%;height:100%;" onclick="btn_click(0)"  value="保存"/>
							</div>
						</div>
					</div>
					
					
					<div style="width:90%;height:85%;margin:auto;">
						<!--------------------- bar --------------------- -->
						<div id="bar" style="width:100%;height:95%;display: none;">
							<div id="axischoose1" style="width:100%;height:31%;">
								<div style="float:left;width:20%;">类轴</div>
								<div class="styled_select" style="width:75%;" id="categoryaxis" style="float:left;" > 
									<select ></select>
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;height:31%;">
								<div style="float:left;width:20%;">柱间间距</div>
								<div style="float:left;width:75%;">
									<input type="range" min="1" max="100" value="20" id="barGap" name="barGap" onchange="btn_click(1);" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;height:31%;">
								<div style="float:left;width:20%;">y坐标轴单位</div>
								<div style="float:left;width:75%;">
									<input type="text" style="width:100%;"  class="textinput" id="baryUnit" name="yUnit" oninput="btn_click(1);" value="单位" />
								</div>
							</div>
						</div>
						<!--------------------- bar --------------------- -->

						<!------------------------ pie -------------------- -->
						<div id="pie" style="width: 100%;height:95%;display: none ">
							<div style="width:100%;height:24%;">
								<div style="float:left;width:20%;">内半径</div>
								<div style="float:left;width:75%;">
									<input id="innerRadius" type="range" min="1" max="100" onchange="btn_click(1)" value="70" />
								</div>
							</div>
							
							<div style="width:100%;height:24%;">
								<div style="float:left;width:20%;">外半径</div>
								<div style="float:left;width:75%;">
									<input id="externalRadius" type="range" min="1" max="100" onchange="btn_click(1)" value="80" />
								</div>
							</div>
							
							<div style="width:100%;height:24%;">
								<div style="float:left;width:20%;">饼图位置</div>
								<div style="float:left;width:75%;">
									左<input type="radio" id="piePositionRadio" checked="true" onclick="piePositionClick('left')" name="piePosition" value="left" />
									右<input type="radio" id="piePositionRadio" onclick="piePositionClick('right')" name="piePosition" value="right" />
									中间<input type="radio" id="piePositionRadio" onclick="piePositionClick('center')" name="piePosition" value="center" />
								</div>
							</div>
							 
							<div style="width:100%;height:24%;">
								<div style="float:left;width:20%;">图例方向</div>
								<div style="float:left;width:75%;">
									横向<input type="radio" id="legendPositionRadio" checked="true" onclick="legendPositionClick('horizontal')" name="legendPosition" value="horizontal" />
									竖向<input type="radio" id="legendPositionRadio" onclick="legendPositionClick('vertical')" name="legendPosition" value="vertical" />
									<input type="hidden" id="piePosition" value="left" name="piePosition" /> 
									<input type="hidden" id="legendPosition" value="horizontal" name="legendPosition" />
								</div>
							</div>
						</div>
						<!------------------------ pie -------------------- -->

						<!------------------------ line -------------------- -->
						<div id="line" style="width: 100%;height:95%;display: none">
							<div id="axischoose2" style="width:100%;height:31%;">
								<div style="float:left;width:20%;">类轴</div>
								<div class="styled_select" style="width:75%;float:left;" id="categoryaxis" > 
									<select id="typeaxis1" ></select>
								</div>
							</div>
							<div style="width:100%;height:31%;">
								<div style="float:left;width:20%;">y坐标轴单位</div>
								<div style="float:left;width:75%;">
									<input type="text" id="lineyUnit" name="yUnit" class="textinput" oninput="btn_click(1);" value="单位"/>
								</div>
							</div>
							
							
						</div>
						<!------------------------ line -------------------- -->
						<!------------------------ scatter -------------------- -->
						<div id="scatter" style="width: 100%;height:95%;display: none">
							
							<div style="width:100%;height:31%;">
								<div style="float:left;width:12%;">xmax</div>
								<div style="float:left;width:35%;">
									<input id="xmax" type="range" min="1" max="100" value="100"  onchange="btn_click(1);" name="xmax"  />
								</div>
								<div style="float:left;width:12%;">xmin</div>
								<div style="float:left;width:35%;">
									<input id="xmin" type="range" min="1" max="100" value="100" onchange="btn_click(1);" name="xmin"  />
								</div>
							</div>
							
							<div style="width:100%;height:31%;">
								<div style="float:left;width:12%;">ymax</div>
								<div style="float:left;width:35%;">
									<input id="ymax" type="range" min="1" max="100" value="100" onchange="btn_click(1);" name="ymax"  />
								</div>
								<div style="float:left;width:12%;">ymin</div>
								<div style="float:left;width:35%;">
									<input  id="ymin" type="range" min="1" max="100" value="100"onchange="btn_click(1);" name="ymin"/>
								</div>
							</div>
							
							<div style="width:100%;height:31%;">
								<div style="float:left;width:20%;">x轴单位</div>
								<div style="float:left;width:75%;">
									<input type="text" id="xUnit" oninput="btn_click(1);" class="textinput" name="xUnit" value="单位"/>
								</div>
							</div>
							<div style="width:100%;height:31%;">
								<div style="float:left;width:20%;">Y轴单位</div>
								<div style="float:left;width:75%;">
									<input type="text" class="textinput" id="yUnit" oninput="btn_click(1);" name="yUnit" value="单位"/>
								</div>
							</div>
							
						</div>
						<!------------------------ scatter -------------------- -->
						<!------------------------ funnel -------------------- -->
						<div id="funnel" style="width: 100%;height:95%;display: none">
							
							<div style="width:100%;">
								<div style="width:20%;float:left;">数据排序</div>
								<div style="width:75%;float:left;">
									升序<input type="radio" id="sort" checked="true" onclick="sort_click('ascending')" name="sort">
									降序<input type="radio" id="sort" onclick="sort_click('descending')" name="sort">
								</div>
							</div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">最小值映射宽度</div>
								<div style="width:75%;float:left;">
									<input id="minSize" type="range" min="1" max="100" onchange="btn_click(1)" value="0" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">最大值映射宽度</div>
								<div style="width:75%;float:left;">
									<input id="maxSize" type="range" min="1" max="100" onchange="btn_click(1)" value="100" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">gap</div>
								<div style="width:75%;float:left;">
									<input id="gap" type="range" min="1" max="100" value="0" onchange="btn_click(1)" name="gap" />
									<input type="hidden" id="sortValue" value="ascending" name="sortValue" />
								</div>
							</div>
						</div>
						<!------------------------ funnel -------------------- -->
						<!------------------------ treemap -------------------- -->
						<div id="treemap" style="width: 100%;height:95%;display: none">
							<!-- <div style="width:100%;">
								<div style="width:20%;float:left;"></div>
								<div style="width:75%;float:left;"></div>
							</div> -->
							
							<div style="width:100%;">
								<div style="width:20%;float:left;">树形图描述</div>
								<div style="width:75%;float:left;">
									<input type="text" id="mapDesc" class="textinput" oninput="btn_click(1);" name="mapDesc" value="矩形树图"/>
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">borderWidth</div>
								<div style="width:75%;float:left;">
									<input id="borderWidth" type="range" min="1" max="20" onchange="btn_click(1)" value="1" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">borderColor</div>
								<div style="width:75%;float:left;">
									<input style="margin: 2px;" type="text" id="borderColor" onchange="" class="demo" data-position="bottom right" value="#0088cc" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">树形图高度</div>
								<div style="width:75%;float:left;"> 
									<input id="mapHeight" type="range" min="1" max="100" value="80" onchange="btn_click(1);" name="mapHeight" />
								</div>
							</div>
						</div>
						<!------------------------ treemap -------------------- -->
						<!------------------------ candlestick ---------------------->
						<div id="candlestick" style="width: 100%;height:95%;display: none">
							
							 <div style="width:100%;">
								<div style="width:20%;float:left;">color</div>
								<div style="width:75%;float:left;">
									<input style="margin: 2px;" type="text" id="color" onchange="btn_click(1);" class="demo" data-position="bottom right" value="#fd1050" />
								</div>
							</div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">color0</div>
								<div style="width:75%;float:left;">
									<input style="margin: 2px;" type="text" id="color0" onchange="btn_click(1);" class="demo" data-position="bottom right" value="#0cf49b" />
								</div>
							</div>
						</div>
						<!------------------------ candlestick---------------------->
						<!------------------------ map ---------------------->
						<div id="map" style="width: 100%;height:95%;display: none">
							<!-- <div style="width:100%;">
								<div style="width:20%;float:left;"></div>
								<div style="width:75%;float:left;"></div>
							</div> -->
							<div style="width:100%;">
								<div style="width:20%;float:left;">最小值 min</div>
								<div style="width:75%;float:left;">
									<input id="mapmin" type="range" min="1" max="100" onchange="btn_click(1);" value="0" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">最大值 max</div>
								<div style="width:75%;float:left;">
									<input id="mapmax" type="range" min="1" max="100" onchange="btn_click(1);" value="100" />
								</div>
							</div>
						</div>
						<!------------------------ map---------------------->
						<!------------------------ heatmap ---------------------->
						<div id="heatmap" style="width: 100%;height:95%;display: none">
							<div style="width:100%;">
								<div style="width:20%;float:left;">min</div>
								<div style="width:75%;float:left;">
									<input id="heatmapmin" type="range" min="1" max="100" onchange="btn_click(1);" value="1" />
								</div>
							</div>
							<div style="clear:both;"></div>
							<div style="width:100%;">
								<div style="width:20%;float:left;">max</div>
								<div style="width:75%;float:left;">
									<input id="heatmapmax" type="range" min="1" max="100" onchange="btn_click(1);" value="100"/>
								</div>
							</div>
						</div>
						<!------------------------ heatmap---------------------->
						<!------------------------ radar ---------------------->
						<div id="radar" style="width: 100%;height:95%;display: none;">
							<div id="axischoose3">
							</div>
							
						</div>
						<!------------------------ radar---------------------->
						<!------------------------ baidu ---------------------->
						<div id="baidu" style="width: 100%;height:95%;display: none">
						
							<div style="width:100%;">
								<div style="width:20%;float:left;">半径</div>
								<div style="width:75%;float:left;">
									<input id="baiduradius" type="range" min="1" max="100" onchange="btn_click(1);" value="30" />
									<input type="hidden" id="baidumaxNum" value="100" />
								</div>
							</div>
						</div>
						<!------------------------ baidu---------------------->
					</div>
			</div>	
			<!-- 用户属性 -->
					
			<div style="margin-left:1%;width:49%;float:left;height:100%;overflow: auto;padding-left:2%;padding-right:2%;background-color:#fff;">
				<div style="width:90%;height:15%;font-size:16px;margin:auto;">用户属性</div>
				<div id="share" style="width:90%; height: 84%;margin:auto;">
					<!-- 图标名称 -->
					<div style="width:90%;height:31%;margin:1%;">
						<div style="width:20%;float:left;">图表名称</div>
						<div style="width:75%;float:left;">
							<input style="width:100%;height:100%;font-size:18px;" type="text" id="chartName" name="chartName" class="textinput" oninput="btn_click(1);" value="tableName" />
						</div>
					</div>
					<!-- 字体大小 -->
					<div style="width:90%;height:31%;margin:1%;">
						<div style="width:20%;float:left;">字体大小</div>
						<div style="width:75%;float:left;">
							<input style="width:100%;height:100%;" id="fontSize" type="range" min="10" max="30" onchange="btn_click(1)" value="20" />
						</div>
					</div>
					<!-- 字体类型 -->
					<div style="clear:both;"></div>
					<div style="width:90%;height:31%;margin:1%;">
						<div style="width:20%;float:left;">字体类型</div>
						<div style="width:75%;float:left;" class="styled-select">
							<select id="fontWeight" onchange="btn_click(1);" name="fontWeight">
								<option>lighter</option>
								<option>normal</option>
								<option>bold</option>
								<option>bolder</option>
							</select>
						</div>
					</div>
				</div>
				
			</div>
			
		</div>
	</div>
	
<!-- zzb's div-->			
<!-- this is addDatasourcePage 1-->
	<!-- style="display:none;margin:auto;margin-top:5%;width:1000px;height:500px;text-align:center;background-color:#ffffff;" -->
	<div id="addDatasourcePage" class="childstyle" style="padding-top:5%;">
		<span style="font-size:25px;text-align:center;display:block;width:100%;">配置新的数据源</span>
		<div style="padding:auto;margin:auto;width:25%;height:auto;margin-top:3%;">
			<input type="text" style="width:100%;margin-bottom:15px;" class="textinput" id="conn_name" name="conn_name" value="连接名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"/><br/>
			<input type="text" style="width:100%;margin-bottom:15px;" class="textinput" id="ip" name="ip" value="ipv4" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"/><br/>
			<input type="text" style="width:100%;margin-bottom:15px;" class="textinput" id="port" name="port" value="port" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"/><br/>
			<input type="text" style="width:100%;margin-bottom:15px;" class="textinput" id="databaseName" name="databaseName" value="数据库名称" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"/><br/>
			<input type="text" style="width:100%;margin-bottom:15px;" class="textinput" id="user" name="user" value="用户名" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"/><br/>
			<input type="password" style="width:100%;margin-bottom:15px;" class="textinput" id="password" name="password" value="" onFocus="if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999"/><br/>
		</div>
		<div style="width:25%;" class="styled-select">
			<select id="conn_type" name="conn_type">
				<option value="mysql" selected="selected">mysql</option>
				<option value="oracle">oracle</option>
				<option value="sqlserver">sqlserver</option>
				<option value="dameng">dameng</option>
			</select>
		</div>
		<div style="padding:auto;margin:auto;margin-top:1%;width:20%;height:auto;">
			<input class="save_button" style="width:100%;" type="button" onclick="saveDatabase()" value="确定"/><br/>
		</div>
		<span id="result" style="color:red;font-size:20px;font-weight:bold"></span>
	</div>
<!-- addDatasourcePage ends -->

<!-- this is getDatasourcePage 2-->
<!-- style="padding-top:1px;display:none;margin:auto;margin-top:3%;width:98%;height:100%;background-color:#ffffff;" -->
<div id="getDatasourcePage" class="childstyle">
	<div id="listContent2" style="width:100%;height:80%;padding-top:2%;"></div><!-- margin-left:2%;margin-top:1%; -->
	<div id="pageContent2" style="margin-left:2%;margin-top:2%;width:90%;height:4%;">
		<ul class="pagination" style="margin:auto;float:right;">
		</ul>
	</div>
	<input type="hidden" id="pageSum" name="pageSum" value="${requestScope.pageSum }"/>
	<input type="hidden" id="pageCur" name="pageCur" value="${requestScope.pageCur }"/>
</div>
<!-- getDatasourcePage ends -->

<!-- this is getViewPage 3-->
<!-- style="padding-top:1px;display:none;margin:auto;margin-top:3%;width:98%;height:100%;background-color:#ffffff;" -->
<div id="getViewPage" class="childstyle">
	<div id="listContent1" style="width:100%;height:80%;padding-top:2%;"></div><!-- margin-left:2%;margin-top:1%; -->
	<div id="pageContent1" style="margin-left:2%;margin-top:2%;width:90%;height:4%;">
		<ul class="pagination" style="margin:auto;float:right;">
		</ul>
	</div>
	<input type="hidden" id="pageSum" name="pageSum" value="${requestScope.pageSum }"/>
	<input type="hidden" id="pageCur" name="pageCur" value="${requestScope.pageCur }"/>
</div>
<!-- getViewPage ends -->


<!-- this is addViewPage 4-->
<!--  style="display:none;margin:auto;margin-top:2%;width:1000px;height:500px;background-color:#ffffff;" -->
<div id="addViewPage" class="childstyle">

	<!-- 数据源树结构  -->
	<div style="float:left;width:25%;height:100%;overflow:auto">
	
		<div id="mysqlNode" style="font-size:25px;font-weight:bold">
			<img id="mysqlImg" src="img/expand.png" onclick="loadDatabases('mysql')"/>mysql
		</div>
		<div id="mysqlDb" style="margin-left:5%"></div>
		
		<div id="sqlserverNode" style="font-size:25px;font-weight:bold">
			<img id="sqlserverImg" src="img/expand.png" onclick="loadDatabases('sqlserver')"/>sqlserver
		</div>
		<div id="sqlserverDb" style="margin-left:5%"></div>
		
		<div id="oracleNode" style="font-size:25px;font-weight:bold">
			<img id="oracleImg" src="img/expand.png" onclick="loadDatabases('oracle')"/>oracle
		</div>
		<div id="oracleDb" style="margin-left:5%"></div>
		<div id="damengNode" style="font-size:25px;font-weight:bold">
			<img id="damengImg" src="img/expand.png" onclick="loadDatabases('dameng')"/>dameng
		</div>
		<div id="damengDb" style="margin-left:5%"></div>
	</div>

	<!-- 右边 -->
	<div style="float:left;width:74%;height:100%;padding:1%;">
		<!-- 设置关联关系页面 5-->
		<div id="relationSetPage" style="width:100%;height:100%;display:none">
			<!-- 设置外键 margin-left:2%;margin-top:2%;-->
			<div style="width:100%;height:26%;">
				<div style="width:100%;height:16%;">
					<p style="font-size:18px;float:left;">数据表级联选择</p>
					<input type="button" style="font-size:18px;border:1px solid #2ec7c9;;border-radius:5px;background:transparent;margin-left:1%;width:12%;hegiht:12%;float:right;" value="生成视图" onclick="openViewPage()"/>
				</div>
				<div id="relationContent" style="width:100%;height:80%;overflow:auto;">
				</div>
			</div>
			<!-- 显示表内容 margin-left:2%;margin-top:2%; -->
			<div id="tableContent" style="width:100%;height:70%;margin-top:1%;overflow:auto;">
			</div>
		</div>
		<!-- 设置关联关系页面结束 -->
	</div>
	<!-- 右边 ends -->
</div>
<!-- addViewPage ends -->

<!-- 生成视图界面 6-->
<!-- style="width:100%;height:100%;background:#fff;display:none;" -->
<div id="viewPage" style="padding:1%;" class="childstyle">
	<div id="viewContent" style="width:99%;height:90%;overflow:auto"></div>
	<div style="width:99%;height:10%;padding-top:1%;">
		<form id="myForm" action="SaveViewServlet" method="post" target="_blank">
			<!-- 视图名称<br/> -->
			<input type="text" class="textinput" id="viewName" style="width:30%;height:100%;" name="viewName" value="视图1" />
			<input type="button" style="border:1px solid #2ec7c9;;border-radius:5px;background:transparent;width:20%;margin-left:1%;height:110%;" value="保存" onclick="saveView()"/>
		</form>
		
	</div>
</div>

<!-- 生成视图界面 7-->
<!-- style="width:100%;height:100%;background:#fff;display:none;" -->
<div id="viewShowPage"  class="childstyle">
	<div id="tableContent1" style="background:#ffffff;width:98%;height:65%;overflow:auto;"></div>
	<div id="sqlContent" style="background:#ffffff;margin-top:1%;width:98%;height:30%;">
		<textarea id="sql" style="width:100%;height:80%;resize:none"></textarea>
		<div style="width:100%;height:20%;">
			视图名
			<input type="text" class="textinput" style="width:30%;height:70%;" id="view_name1" name="view_name1" value=""/>&nbsp;
			<input type="button" class="save_button" style="width:10%;height:70%;" value="执行" onclick="viewShowPageExec()" />&nbsp;
			<input type="button" class="save_button" style="width:10%;height:70%;" value="保存" onclick="viewShowPageSave()" />
		</div>
	</div>
</div>

<input type="hidden" id="hiddenid" name="hiddenid"/>
<input type="hidden" id="hiddentable" name="hiddentable"/>
<input type="hidden" id="hiddensql" name="hiddensql"/>
<input type="hidden" id="hiddencol" name="hiddencol"/>
<!-- zzb's div ends -->
<!-- yyn's div start -->
<div id="yynDiv" class="childstyle">
	
</div>
<!-- yyn'n div end -->

</div>
<!-- right-bottom content ends -->

</div>
<!-- right content ends -->

</div>
<input id="showpageCur" type="hidden" name="showpageCur" value="1"/>
<script>

firstpage();
openAddDatasourcePage();
function change(type,x) {//x=0正常展开并显示属性，x=1只显示属性
	
	var alink = (document.getElementById("navbar")).getElementsByTagName("a");
	
	for(var i=0;i<alink.length;i++){
		alink[i].style.color="#bdbdbd";
	}
	document.getElementById("right_bottom").style.border="none";
	document.getElementById(type+"click").style.color="#2ec7c9";
	document.getElementById("right_bottom").style.background="transparent";
	openPage(document.getElementById("system2div"));
	document.getElementById("main").innerHTML="";
	var button1 = document.getElementById("savebutton");
	var button2 = document.getElementById("updatabutton");
	button2.style.display = "none";
	button1.style.display = "";
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
	if(x==0){
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.open("POST", "System2Servlet?type="+ type, true);
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				var reply = xmlHttp.responseText +  "";
				//alert(reply);
				var axis = document.getElementById("leftform");
				axis.innerHTML = reply;
			}
		}
		xmlHttp.send(null);
	}
}
	function loadtype(name,id,type) {//id>0有效
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
	function assignmenttype(name){			
	var c_2 = document.getElementById("charttype1");	
		c_2.value=name;
		//btn_click(1);
	
	}
	function assignmentview(name){
	//alert(name);
	var c_3 = document.getElementById("tablename1");
	c_3.value = name;
	//alert(c_3.value);
	btn_click(1);
	}
	function btn_click(x) {//0制图保存属性，1只制图	
		//alert("c_2.value");
		//alert(document.getElementById("typeaxis1").value);
	var lt;
	if(x!=0&&x!=1){
		lt=x.split("_");
		x=1;
		loadtype(lt[0],0,lt[1])
	}
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
			//alert(typeaxis);
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
				var option = xmlHttp.responseText +  "";
				//alert(option);
				if("baidu" == c_2.value){
					var Div = document.createElement('div');
					Div.id='container';
					var location=Div.id;
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
				var str = option.split("_");
				flag=str[1];
				if (flag == 1) {
					alert("保存成功");
					if (x == 0) {
						var xmlHttp5 = new XMLHttpRequest();
						xmlHttp5.open("POST", "NewtableServlet?chartType="
								+ c_2.value + "&chartName=" + tableName + "&id=" + str[0],
								true);
						xmlHttp5.onreadystatechange = function() {
							if (xmlHttp5.readyState == 4) {
								var addto = xmlHttp5.responseText;
								var axis = document.getElementById("newtable");
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
	function check(x) {
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
		change(st[1],1);
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
				var option = xmlHttp7.responseText +  "";
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
	}
	function updata() {
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
	function rewrite(x) {
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
	function removeall(){
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
	}
	function removechart(x) {
		var button1 = document.getElementById("savebutton");
		var button2 = document.getElementById("updatabutton");
		button2.style.display = "none";
		button1.style.display = "";
		var item = document.getElementById(x);
		var id = item.className;
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
		var axis = document.getElementById("newtable");
		if(axis.innerText==""||axis.innerText==null){
			var removeall = document.getElementById("removeall");
			removeall.style.display="none";
		}			
	}
	function piePositionClick(position) {
		document.getElementById("piePosition").value = position;
		btn_click(1);
	}
	function legendPositionClick(position) {
		document.getElementById("legendPosition").value = position;
		btn_click(1);
	}
	function sort_click(position) {
		document.getElementById("sortValue").value = position;
		btn_click(1);
	}

	$(document).ready(function() {

		$('.demo').each(function() {
			$(this).minicolors({
				position : $(this).attr('data-position') || 'bottom left',
			});

		});
	});
	function firstpage() {
		
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
	function showmenu(value){
		
		var buttonlink = (document.getElementById("navbar")).getElementsByTagName("button");
		for(var i=0;i<buttonlink.length;i++){
			buttonlink[i].style.border="";
		}
		
		//border-bottom:2px solid #2ec7c9;		
		if(value == "contolmenu"){
			document.getElementById("controlmanage").style.borderBottom="3px solid #2ec7c9";
			(document.getElementById("viewmenu")).className="menu-display";
			(document.getElementById("datamenu")).className="menu-display";
		}else if(value == "viewmenu"){
			document.getElementById("viewmanage").style.borderBottom="3px solid #2ec7c9";
			(document.getElementById("contolmenu")).className="menu-display";
			(document.getElementById("datamenu")).className="menu-display";
		}else if(value=="datamenu"){
			document.getElementById("datasource").style.borderBottom="3px solid #2ec7c9";
			(document.getElementById("contolmenu")).className="menu-display";
			(document.getElementById("viewmenu")).className="menu-display";
		}
		
		if((document.getElementById(value)).className == "menu"){
			(document.getElementById(value)).className="menu-display";
		}else{
			(document.getElementById(value)).className="menu";
		}
		
		global = 0;
		document.onclick = function(){
			if(global > 0) {
				closemenu();
				document.onclick = function(){};
			} else {
				global = 1;
			}
		};
		
	}
	
	function closemenu()
	{
		(document.getElementById("contolmenu")).className="menu-display";
		(document.getElementById("viewmenu")).className="menu-display";
		(document.getElementById("datamenu")).className="menu-display";
	}



/*simulated select ends*/

//打开界面
function openPage(tmp, tmp1) {
	
	document.getElementById("addDatasourcePage").style.display = "none";
	document.getElementById("getDatasourcePage").style.display = "none";
	document.getElementById("addViewPage").style.display = "none";
	document.getElementById("getViewPage").style.display = "none";
	document.getElementById("relationSetPage").style.display = "none";
	document.getElementById("viewPage").style.display = "none";
	document.getElementById("viewShowPage").style.display = "none";
	document.getElementById("system2div").style.display = "none";
	
	document.getElementById("yynDiv").style.display = "none";
	
	tmp.style.display = "block";
	if(tmp1 != undefined) {
		tmp1.style.display = "block";
	}
}

//transform url
function URLencode(sStr) {
	return escape(sStr).replace(/\#/g, '%23').replace(/\+/g, '%2B').replace(/\ /g,'%20');
}

//保存新的数据库
function saveDatabase() {
	var ip = document.getElementById("ip").value.trim();
	var port = document.getElementById("port").value.trim();
	var databaseName = document.getElementById("databaseName").value.trim();
	var user = document.getElementById("user").value.trim();
	var password = document.getElementById("password").value.trim();
	var type = document.getElementById("conn_type").value.trim();
	var conn_name = document.getElementById("conn_name").value.trim();
	
	if(conn_name == "连接名称" || conn_name == "") {
		alert("连接名称不能为空!");
		return;
	}
	
	if(ip == "" || ip == "ipv4") {
		alert("ip地址不能为空!");
		return;
	}
	
	if(port == "" || port == "port") {
		alert("port不能为空!");
		return;
	}
	
	if(databaseName == "数据库名称" || databaseName == "") {
		alert("数据库名称不能为空!");
		return;
	}
	
	if(user == "用户名" || user == "") {
		alert("用户名不能为空!");
		return;
	}
	
	if(password == "密码" || password == "") {
		alert("密码不能为空!");
		return;
	}
	
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

//打开数据源配置界面
function openAddDatasourcePage() {
	
	var alink = (document.getElementById("navbar")).getElementsByTagName("a");
	//alert(alink.length);
	//alert(alink[2].innerHTML);
	
	for(var i=0;i<alink.length;i++){
		alink[i].style.color="#bdbdbd";
	}
	document.getElementById("right_bottom").style.background="#fff";
	document.getElementById("getdataview").style.color="#2ec7c9";
	var obj = document.getElementById("addDatasourcePage");
	openPage(obj);
}

//打开查看数据源界面
function openGetDatasourcePage() {
	
	var alink = (document.getElementById("navbar")).getElementsByTagName("a");
	//alert(alink.length);
	//alert(alink[2].innerHTML);
	
	for(var i=0;i<alink.length;i++){
		alink[i].style.color="#bdbdbd";
	}
	
	document.getElementById("showdataview").style.color="#2ec7c9";
	
	document.getElementById("right_bottom").style.background="#ffffff";
	
	var obj = document.getElementById("getDatasourcePage");
	openPage(obj);
	obj.style.margin="auto";
	var page = document.getElementById("getDatasourcePage");
	var hiddens = page.getElementsByTagName("input");
	var pageSum = hiddens[0].value;
	var pageCur = hiddens[1].value;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "GetDatasourceServlet?pageCur=" + pageCur + "&pageSum=" + pageSum, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var strs = xmlHttp.responseText.split("|", 3);
			document.getElementById("listContent2").innerHTML = strs[2];
			hiddens[0].value = strs[0];
			hiddens[1].value = strs[1];
			addclick("getDatasourcePage");
		}
	};
	xmlHttp.send(null);
}

//打开查看视图界面
function openGetViewPage() {
	
	var alink = (document.getElementById("navbar")).getElementsByTagName("a");
	//alert(alink.length);
	//alert(alink[2].innerHTML);
	
	for(var i=0;i<alink.length;i++){
		alink[i].style.color="#bdbdbd";
	}
	
	document.getElementById("showview").style.color="#2ec7c9";
	
	var obj = document.getElementById("getViewPage");
	
	document.getElementById("right_bottom").style.background="#ffffff";
	obj.style.margin="auto";
	
	openPage(obj);
	var page = document.getElementById("getViewPage");
	var hiddens = page.getElementsByTagName("input");
	var pageSum = hiddens[0].value;
	var pageCur = hiddens[1].value;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "GetViewServlet?pageCur=" + pageCur + "&pageSum=" + pageSum, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var strs = xmlHttp.responseText.split("|", 3);
			document.getElementById("listContent1").innerHTML = strs[2];
			hiddens[0].value = strs[0];
			hiddens[1].value = strs[1];
			addclick("getViewPage");
		}
	};
	xmlHttp.send(null);
}

//打开新建视图界面
function openAddViewPage() {
	
	var alink = (document.getElementById("navbar")).getElementsByTagName("a");
	//alert(alink.length);
	//alert(alink[2].innerHTML);
	
	for(var i=0;i<alink.length;i++){
		alink[i].style.color="#bdbdbd";
	}
	document.getElementById("right_bottom").style.background="#ffffff";
	document.getElementById("newview").style.color="#2ec7c9";
	var obj = document.getElementById("addViewPage");
	openPage(obj);
}

//打开级联关系设置页面
function openRelationSetPage(id, tableName) {
	var obj1 = document.getElementById("addViewPage");
	var obj = document.getElementById("relationSetPage");
	openPage(obj1, obj);
	document.getElementById("hiddenid").value = id;
	document.getElementById("hiddentable").value = tableName;
	var xmlHttp = new XMLHttpRequest();
	//alert(tableName);
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
	var obj = document.getElementById("viewPage");
	openPage(obj);
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

//打开视图详情界面
function openViewShowPage(id) {
	
	document.getElementById("right_bottom").style.background="transparent";
	document.getElementById("right_bottom").style.border="none";
	var obj = document.getElementById("viewShowPage");
	openPage(obj);
	var dObj = document.getElementById("viewShowPage");
	var divs = dObj.getElementsByTagName("div");
	var texts = dObj.getElementsByTagName("textarea");
	var inputs = dObj.getElementsByTagName("input");
	//alert(divs.length + " " + texts.length + " " + inputs.length);
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "ShowViewServlet?id=" + id, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var str = xmlHttp.responseText.split("|", 4);
			document.getElementById("hiddensql").value = str[0];
			document.getElementById("hiddenid").value = str[1];
			divs[0].innerHTML = str[3];
			texts[0].innerHTML = str[0];
			inputs[0].value = str[2];
			//alert(str[3]);
			document.getElementById("viewShowPage").style.display="block";
			//alert(123);
		}
	};
	xmlHttp.send(null);
}

function viewShowPageExec() {
	document.getElementById("hiddensql").value = document.getElementById("sql").value;
	sql = document.getElementById("hiddensql").value;
	id = document.getElementById("hiddenid").value;
	var dObj = document.getElementById("viewShowPage");
	var divs = dObj.getElementsByTagName("div");
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "ExecuteSqlServlet?hiddenid=" + id + "&hiddensql=" + sql, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			var str = xmlHttp.responseText.split("|", 4);
			divs[0].innerHTML = str[3];
		}
	};
	xmlHttp.send(null);
}

function viewShowPageSave() {
	document.getElementById("hiddensql").value = document.getElementById("sql").value;
	sql = document.getElementById("hiddensql").value;
	id = document.getElementById("hiddenid").value;
	document.getElementById("hiddensql").value = sql;
	name = document.getElementById("view_name1").value;
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "UpdateViewServlet?hiddensql=" + sql + "&hiddenid=" + id + "&name=" + name, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			alert(xmlHttp.responseText);
		}
	};
	xmlHttp.send(null);
}

function delds(id) {
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "DeleteDataSourceServlet?id=" + id, true);
	xmlHttp.send(null);
	//alert(id);
	openGetDatasourcePage();
}

function delview(id) {
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "DeleteViewServlet?id=" + id, true);
	xmlHttp.send(null);
	//alert(id);
	openGetViewPage();
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

function loadSchemas(id) {
	var db = document.getElementById("db_" + id);
	if(db.style.display == "none") {
		db.style.display = "";
		var xmlHttp = new XMLHttpRequest();
		//alert(id);
		xmlHttp.open("POST", "ExpandSchemaServlet?id=" + id, true);
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

function loadTables1(id, schema) {
	var sp=id.split("_");
    id=sp[1];
	var i=sp[0];
	var db = document.getElementById("sh_" + i+"_"+id);
	if(db.style.display == "none") {
		db.style.display = "";
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.open("POST", "ExpandTablesServlet?id=" + id + "&schema=" + schema, true);
		xmlHttp.onreadystatechange = function() {
			if(xmlHttp.readyState == 4) {
				db.innerHTML = xmlHttp.responseText;
			}
		};
		xmlHttp.send(null);
		document.getElementById("img"+i+"_" + id).src="img/collapse.png";
	} else {
		db.style.display = "none";
		document.getElementById("img"+i+"_" + id).src="img/expand.png";
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
		sql = document.getElementById("hiddensql").value;
		id = document.getElementById("hiddenid").value;
		name = document.getElementById("viewName").value;
		
		if(name == "") {
			alert("视图名不能为空!");
			return;
		}
		
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.open("POST", "SaveViewServlet?hiddencol=" + col + "&hiddensql=" + sql + "&hiddenid=" + id + "&viewName=" + name, true);
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {
				alert(xmlHttp.responseText);
			}
		};
		xmlHttp.send(null);
	} else {
		alert("请选择字段名");
	}
}

/*分页相关函数*/
function operation(type, parent) {
	var dObj = document.getElementById(parent);
	var hiddens = dObj.getElementsByTagName("input");
	var pageSum = hiddens[0].value;
	var pageCur = hiddens[1].value;
	if(parent=="getDatasourcePage"){
		
		if(type=="+") {
			if(pageCur < pageSum) {
				pageCur++;
				hiddens[1].value = pageCur;
				openGetDatasourcePage();
			}
		} else if(type=="-") {
			if(pageCur - 1 > 0) {
				pageCur--;
				hiddens[1].value = pageCur;
				openGetDatasourcePage();
			}
		} else if(type=="f") {
			hiddens[1].value = 1;
			openGetDatasourcePage();
		} else if(type=="e") {
			hiddens[1].value = pageSum;
			openGetDatasourcePage();
		} else {
			hiddens[1].value = type;
			openGetDatasourcePage();
		}
		
	}else{
		if(type=="+") {
			if(pageCur < pageSum) {
				pageCur++;
				hiddens[1].value = pageCur;
				//openGetDatasourcePage();
				openGetViewPage();
			}
		} else if(type=="-") {
			if(pageCur - 1 > 0) {
				pageCur--;
				hiddens[1].value = pageCur;
				//openGetDatasourcePage();
				openGetViewPage();
			}
		} else if(type=="f") {
			hiddens[1].value = 1;
			//openGetDatasourcePage();
			openGetViewPage();
		} else if(type=="e") {
			hiddens[1].value = pageSum;
			//openGetDatasourcePage();
			openGetViewPage();
		} else {
			hiddens[1].value = type;
			//openGetDatasourcePage();
			openGetViewPage();
		}
	}
	
}

function addclick(parent) {
	var dObj = document.getElementById(parent);
	var hiddens = dObj.getElementsByTagName("input");
	var pageSum = parseInt(hiddens[0].value);
	var pageCur = parseInt(hiddens[1].value);
	var pageClick = dObj.getElementsByTagName("ul")[0];
	var str = "<li><a href=\"javascript:operation('-', '" + parent + "')\">&laquo;</a></li>";
	if(pageSum < 6) {
		for(var i = 1; i < pageSum + 1; i++) {
			if(pageCur == i) {
				str = str + "<li class='active'><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a></li>";
			} else {
				str = str + "<li><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a><li>";
			}
		}
	} else {
		if(pageCur < 4) {
			for(var i = 1; i < 6; i++) {
				if(pageCur == i) {
					str = str + "<li class='active'><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a></li>";
				} else {
					str = str + "<li><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a><li>";
				}
			}
		} else if(pageCur + 3 > pageSum) {
			for(var i = pageSum - 4; i < pageSum + 1; i++) {
				if(pageCur == i) {
					str = str + "<li class='active'><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a></li>";
				} else {
					str = str + "<li><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a><li>";
				}
			}
		} else {
			for(var i = pageCur - 2; i < pageSum + 3; i++) {
				if(pageCur == i) {
					str = str + "<li class='active'><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a></li>";
				} else {
					str = str + "<li><a href=\"javascript:operation(" + i + ", \'" + parent + "\')\">" + i + "</a><li>";
				}
			}
		}
	}
	str = str + "<li><a href=\"javascript:operation('+', '" + parent + "')\">&raquo;</a></li>";
	pageClick.innerHTML = str;
}

//实现多选框全选，反选
function changcheck(parent) {
	var dObj = document.getElementById(parent);
	var checks = dObj.getElementsByName("check");
	if(dObj.getElementById("checkall").checked) {
		for(var i = 0; i < checks.length; i++) {
			checks[i].checked = true;
		}
	} else {
		for(var i = 0; i < checks.length; i++) {
			checks[i].checked = false;
		}
	}
}
/*分页相关函数 结束

function showmenu(value){
	if((document.getElementById(value)).className == "menu"){
		(document.getElementById(value)).className="menu_display";
	}else{
		(document.getElementById(value)).className="menu";
	}
	global = 0;
	document.onclick = function(){
		if(global > 0) {
			closemenu();
			document.onclick = function(){};
		} else {
			global = 1;
		}
	};
}

function closemenu()
{
	(document.getElementById("contolmenu")).className="menu-display";
	(document.getElementById("viewmenu")).className="menu-display";
	(document.getElementById("datamenu")).className="menu-display";
}*/


function show_tablemenu(value){
	
	document.getElementById("showtable").style.color="#2ec7c9";
	document.getElementById("openfile").style.color="#000000";
	document.getElementById("newscreen").style.color="#000000";
	
	if((document.getElementById(value)).style.display == "none"){
		(document.getElementById(value)).style.display = "block";
	}else{
		(document.getElementById(value)).style.display = "none";
	}
	var xmlHttp = new XMLHttpRequest();
	//var location = document.getElementById("divName").innerHTML;	
	
	xmlHttp.open("POST", "GetViewComponentServlet", true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			document.getElementById(value).innerHTML=xmlHttp.responseText;
			
		}
	};
	xmlHttp.send(null);
}

function minusvalue(id){
	
	var value = document.getElementById(id).innerHTML;
	if(value > 0 ){
		document.getElementById(id).innerHTML = parseInt(value)-2;
		split();
	}else{
		document.getElementById(id).innerHTML = 0;
		split();
	}
}
function plusvalue(id){
	var value = document.getElementById(id).innerHTML;
	document.getElementById(id).innerHTML = parseInt(value)+2;
	split();
}

function split() {
	document.getElementById("openfile").style.color="#000000";
	document.getElementById("showtable").style.color="#000000";
	document.getElementById("newscreen").style.color="#2ec7c9";
	///split
	document.getElementById("right_bottom").style.border="none";
	document.getElementById("right_bottom").style.background="transparent";
	openPage(document.getElementById("yynDiv"));
	document.getElementById("yynDiv").style.display="block";
	document.getElementById("yynDiv").innerHTML="";
	
	var row = document.getElementById("row").innerHTML;
	var col = document.getElementById("col").innerHTML;
	var name = document.getElementById("sname").value;
	if(name == "") {
		alert("请填写项目名称!");
		return;
	}
	var right = document.getElementById("yynDiv");
	var width = parseInt(100 / col)-1;
	var height = parseInt(100 / row)-1;
	var i;
	var j;
	
	
	var text = "";
	for(i = 0; i < row; i++) {
		for(j = 0; j < col; j++) {
			text = text + "<a href=\"javascript:showProperty('" + (i * col + j) + "')\"><div id=\"box" + (i * col + j) + "\" style=\"width:" + width + "%;height:" + height + "%;float:left;border:1px solid #000;background-color:#ffffff;margin:0 0.2% 0.2% 0;\" ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\"></div></a>";
			//text = text + "<div id=\"box" + (i * col + j) + "\" style=\"width:" + width + "%;height:" + height + "%;float:left;border:1px solid #000;margin:0 0.2% 0.2% 0;\" ondrop=\"drop(event)\" ondragover=\"allowDrop(event)\"></div>";
		}
	}
	right.innerHTML = text;
	//type=\"hidden\" 
	text = "<input type=\"hidden\"  id=\"hidden_row\" name=\"hidden_row\" value=\"" + row + "\" />"
		+ "<input type=\"hidden\"  id=\"hidden_col\" name=\"hidden_col\" value=\"" + col + "\" />"
		+ "<input type=\"hidden\"  id=\"hidden_name\" name=\"hidden_name\" value=\"" + name + "\" />";
	for(i = 0; i < row * col; i++) {
		text = text 
		+ "<input type=\"hidden\"  id=\"hiddenid" + i + "\" name=\"hiddenid" + i + "\" />"
		+ "<input type=\"hidden\"  id=\"hiddentype" + i + "\" name=\"hiddentype" + i + "\" />"
		+ "<input type=\"hidden\" id=\"hiddenfs" + i + "\" name=\"hiddenfs" + i + "\" value=\"20\"/>"
		+ "<input type=\"hidden\" id=\"hiddenfw" + i + "\" name=\"hiddenfw" + i + "\" value=\"bold\"/>"
		+ "<input type=\"hidden\" id=\"hiddenth" + i + "\" name=\"hiddenth" + i + "\" value=\"['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']\"/>";
	}
	document.getElementById("propertyForm").innerHTML = text;
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
			
			if(type!="heatbaiduContent"){
				// 基于准备好的dom，初始化echarts实例
			    echarts.init(document.getElementById("box" + boxid)).setOption(eval("(" + xmlHttp.responseText + ")"));	
			}else{
				

				var Div = document.createElement('div');
				Div.id='container'+boxid+'';
				var location = 'container'+boxid+'';
				//alert(location);
				Div.style.width="99%";
				Div.style.height="99%";
				document.getElementById("box" + boxid).appendChild(Div);
				eval(xmlHttp.responseText);
			}
		}
	};
	xmlHttp.send(null);
}

//动态更新control中各控件值
function showProperty(boxid) {
	var fs = document.getElementById("infontSize");
	var fw = document.getElementById("infontWeight");
	var th = document.getElementById("theme");
	fs.value = document.getElementById("hiddenfs" + boxid).value;
	fw.value = document.getElementById("hiddenfw" + boxid).value;
	th.value = document.getElementById("hiddenth" + boxid).value;
	var vtid = document.getElementById("hiddenid" + boxid).value;
	if(vtid != "") {
		fs.onchange=function() {
			document.getElementById("hiddenfs" + boxid).value = document.getElementById("infontSize").value;
			document.getElementById("hiddenfw" + boxid).value = document.getElementById("infontWeight").value;
			document.getElementById("hiddenth" + boxid).value = document.getElementById("theme").value;
			getJson(vtid, boxid);
		};
		fw.onchange=function() {
			document.getElementById("hiddenfs" + boxid).value = document.getElementById("infontSize").value;
			document.getElementById("hiddenfw" + boxid).value = document.getElementById("infontWeight").value;
			document.getElementById("hiddenth" + boxid).value = document.getElementById("theme").value;
			getJson(vtid, boxid);
		};
		th.onchange=function() {
			document.getElementById("hiddenfs" + boxid).value = document.getElementById("infontSize").value;
			document.getElementById("hiddenfw" + boxid).value = document.getElementById("infontWeight").value;
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
		alert("请先生成分屏!");
		return;
	}
	document.getElementById("propertyForm").submit();
	
	var xmlHttp = new XMLHttpRequest();
	xmlHttp.open("POST", "SaveScreenServlet", true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			alert("保存成功");
		}
	};
	xmlHttp.send(null);
	
}
function show_screen(){
	document.getElementById("openfile").style.color="#2ec7c9";
	document.getElementById("newscreen").style.color="#000000";
	document.getElementById("showtable").style.color="#000000";
	
	openPage(document.getElementById("yynDiv"));
	var obj = document.getElementById("yynDiv");
	
	document.getElementById("right_bottom").style.background="transparent";
	document.getElementById("yynDiv").style.margin="auto";
	obj.innerHTML = "";
	var oDiv = document.createElement('div');
	oDiv.id = "screen_manage";
	oDiv.className="screenstyle";
	obj.appendChild(oDiv);

	var xmlHttp = new XMLHttpRequest();
	//var location = document.getElementById("divName").innerHTML;	
	
	var	pageCur = parseInt(document.getElementById("showpageCur").value);
	xmlHttp.open("POST", "GetScreenServlet?pageSum="+2+"&pageCur="+pageCur, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			oDiv.innerHTML=xmlHttp.responseText;
			//alert(xmlHttp.responseText);
			addclick1();
		}
	};
	xmlHttp.send(null);
	
}

//实现翻页
function addclick1() {
	var pageSum = parseInt(document.getElementById("pageSum2").value);
	var pageCur = parseInt(document.getElementById("showpageCur").value);
	var pageClick = document.getElementById("pageClick");
	var str = "<li><a href=\"javascript:operationyyn('-')\">&laquo;</a></li>";
	if(pageSum < 6) {
		for(var i = 1; i < pageSum + 1; i++) {
			if(pageCur == i) {
				str = str + "<li class='active'><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a></li>";
			} else {
				str = str + "<li><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a></li>";
			}
		}
	} else {
		if(pageCur < 4) {
			for(var i = 1; i < 6; i++) {
				if(pageCur == i) {
					str = str + "<li class='active'><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</li>";
				} else {
					str = str + "<li><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a></li>";
				}
			}
		} else if(pageCur + 3 > pageSum) {
			for(var i = pageSum-4; i < pageSum + 1; i++) {
				if(pageCur == i) {
					str = str + "<li class='active'><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a>&nbsp;";
				} else {
					str = str + "<li><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a></li>";
				}
			}
		} else {
			for(var i = pageCur - 2; i < pageSum + 3; i++) {
				if(pageCur == i) {
					str = str + "<li class='active'><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a></li>";
				} else {
					str = str + "<li><a href=\"javascript:operationyyn(" + i + ")\">" + i + "</a></li>";
				}
			}
		}
	}
	str = str + "<li><a href=\"javascript:operationyyn('+')\">&raquo;</a></li>";
	pageClick.innerHTML = str;
}

//点击按钮
function operationyyn(type) {
	
	var pageSum = parseInt(document.getElementById("pageSum2").value);
	var pageCur = parseInt(document.getElementById("showpageCur").value);
	
	if(type=="+") {
		if(pageCur < pageSum) {
			pageCur++;
			document.getElementById("showpageCur").value = pageCur;
			
			show_screen();
		}
	} else if(type=="-") {
		if(pageCur - 1 > 0) {
			pageCur--;
			document.getElementById("showpageCur").value = pageCur;
			
			show_screen();
		}
	} else if(type=="f") {
		document.getElementById("showpageCur").value = 1;
		
		show_screen();
	} else if(type=="e") {
		document.getElementById("showpageCur").value = pageSum;
		
	} else {
		document.getElementById("showpageCur").value = type;
		
		show_screen();
	}
}
function delete_item(id){
	
	var xmlHttp = new XMLHttpRequest();
	//var location = document.getElementById("divName").innerHTML;	
	
	xmlHttp.open("POST", "DeleteScreenServlet?s_id="+id, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {
			show_screen();
		}
	};
	xmlHttp.send(null);
}

function show_item(id){
	
	document.getElementById("right_bottom").style.border="none";
	var xmlHttp = new XMLHttpRequest();
	//var location = document.getElementById("divName").innerHTML;	
	//alert(id);
	xmlHttp.open("POST", "ScreenViewServlet?s_id="+id, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState == 4) {

			eval(xmlHttp.responseText);
		}
	};
	xmlHttp.send(null);	
}

//展开
function changeview(id,aid) {
	
	var alink = (document.getElementById("tree_menu")).getElementsByTagName("a");
	
	for(var i=0;i<alink.length;i++){
		alink[i].style.color="#a2a2a2";
	}
	document.getElementById(aid).style.color="#2ec7c9";

	var obj = document.getElementById(id);
	if(obj.style.display == "") {
		obj.style.display = "none";
	} else {
		obj.style.display = "";
	}
}

</script>
</body>
</html>