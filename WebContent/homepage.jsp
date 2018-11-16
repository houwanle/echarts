<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YZChart</title>
<style type="text/css">
html,body {
	height: 100%;
	margin: 0px;
	
}
.system2_button{
		background-color:#2ec7c9;
		border:1px solid #2ec7c9;
		border-radius:5px;
		font-size:16px;
		font-weight:700;
		margin:0% 5%;
		color:#ffffff;
		outline:none;
		width:200px;height:45px;font-size:25px;
		
	}
	.system2_button:hover{
		background-color:#3285FF;
		border:1px solid #3285FF;
		width:200px;height:60px;font-size:30px;}
</style>
</head>
<body>
<div id="welcomeindex"  style="width:100%;height:100%;">
<div  style="width:100%;height:78%;position:fixed;text-align:center;"><img  style="width:100%;" src="img/welcome2.png"/></div>
<!-- <img width="100%" height="100%" src="img/welcome.png"> -->
<div style="width:100%;height:30%;position:fixed;top:70%;">
	<div style="width:100%;height:100%;margin: auto;text-align: center;"> 
		<div style="margin-top:120px">
			<input class="system2_button" type="button"  onclick="window.location.href='index.jsp';" value="开始">
			
			<input class="system2_button" type="button" onclick="window.location.href='help.jsp'" value="教学">
		</div>
	</div>	
</div>
</div>
<div id="help" style="width:100%;height:100%;position:fixed;overflow:auto;display:none">
	<div style="width:100%;height:100%;margin: auto;text-align: center;"> 
 		<img   height="95%" src="img/help.png">
 	</div>
</div>
<script>
function help(){
	document.getElementById("welcomeindex").style.display="none";
	document.getElementById("help").style.display="";
}

</script>
</body>
</html>