<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%;height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="js/echarts.js"></script>
<script type="text/javascript" src="js/hubei.js"></script>
<script type="text/javascript" src="js/data.js"></script>
</head>
<body style="width:100%;height:100%;margin:0">
<div style="width:90%;height:10%;border:1px solid #000">
<form id="myForm" action="DyServlet" method="post">
<input type="text" id="sql" name="sql" value="SELECT city, popu FROM analysis" style="width:90%;"/>
<input type="button" value="click me" style="width:10%;" onclick="sub()" />
<input type="button" value="show" style="width:10%;" onclick="update()" />
</form>
</div>
<div id="main" style="margin-top:1%;width:90%;height:78%;border:1px solid #000"></div>
<input type="hidden" id="data" name="data" value="${requestScope.data }"/>
<script>
function sub() {
	document.getElementById("myForm").submit();
}
function update() {
var str = document.getElementById("data").value;
//alert(str);

if(str != "") {
	var exdata = eval('(' + str + ')');

	alert(exdata.con[0].name);
	
	var chart = echarts.init(document.getElementById('main'));
	var option = {
		    tooltip: {
		        trigger: 'item'
		    },
		    visualMap: {
		        min: 0,
		        max: 2500,
		        left: 'left',
		        top: 'bottom',
		        text: ['高','低'], 
		        calculable: true
		    },
		    series: [
				{
		        type: 'map',
		        map: '湖北',
		            label: {
		                normal: {
		                    show: true
		                },
		                emphasis: {
		                    show: true
		                }
		            },
				data:exdata.con
				}
		    ]
		};
		chart.setOption(option);
	}
}
</script>
</body>
</html>