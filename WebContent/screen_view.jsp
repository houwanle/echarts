<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<% 
	String x = request.getAttribute("x").toString();
	String y = request.getAttribute("y").toString();
	String name = request.getAttribute("name").toString();
	List<Map<String, Object>> optionlist = (List) request.getAttribute("optionlist");
	
	%>
<!DOCTYPE html>
<html>
<head>
<style>
		html,body
        {
            height: 100%;
            margin: 0px;
        }
</style>
<script src="js/echarts.js"></script>
<script src="js/points.js"></script>
<script src="js/hubei.js"></script>
<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=name %></title>
</head>
<body>
	
	<div style="width:97%;height:90%;left:1.5%;top:1.5%;position:absolute" id="chartView"></div>	
	<script type="text/javascript">
	createDiv();
	function createDiv(){
		for(var i = 0;i< <%=x%>*<%=y%>;i++){
			var oDiv = document.createElement('div');
			var xn =97/<%=x%>;
			var yn =97/<%=y%>;
			oDiv.id= i;
			oDiv.style.width= ''+xn+'%';//''+xn+'%'
			oDiv.style.height= ''+yn+'%';//''+xn+'%'
			oDiv.style.border = '1px solid #000';oDiv.style.margin = '1px';
			oDiv.style.float = 'left';
	    	document.getElementById('chartView').appendChild(oDiv);
	   	}
	}
	<%for (Map<String, Object> m : optionlist) {
			String location = m.get("location").toString();
			String option = m.get("option").toString();
			String type = m.get("type").toString();
			System.out.println(type);
			if(type.equals("heatbaidu")){%>
				
				var Div = document.createElement('div');
				Div.id='container';
				Div.style.width="99%";
				Div.style.height="99%";
				(document.getElementById("<%=location%>")).appendChild(Div);
				<%=option%>
				
			<%}else{%>
				var myChart = echarts.init(document.getElementById("<%=location%>"));
				myChart.setOption(<%=option%>);
		<%}%>
	<%}%>
	</script>
</body>
</html>