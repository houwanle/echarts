<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<script src="http://static.runoob.com/assets/jquery/2.0.3/jquery.min.js"></script>
<body>
	<h2>Retrieve data from XML file</h2>
	<p><b>Status:</b><span id="A1"></span></p>
	<p><b>Status text:</b><span id="A2"></span></p>
	<p><b>Response:</b><span id="A3"></span></p>
	<p><b>Time:</b><span id="A4"></span></p>
	<button onclick="loadXMLDoc('note.xml')">Get XML data</button>
	
	<p>
	Name:<span id="jname"></span><br/>
	Street:<span id="jstreet"></span><br/>
	Phone:<span id="jphone"></span><br/>
	</p>
</body>
<script>
//document.getElementById(id).attribute=新属性值
//document.getElementById("myBtn").addEventListener("click", displayDate);

/*
 *JSON 
 *JSON的值可以为数字(整数或浮点数)、字符串(在双引号中)、逻辑值(true、false)
 *数组(方括号中)、对象(在花括号中)、null
 *
 */
var JSONObject={
		"name":"yyn",
		"street":"Xueyuanlu",
		"phone":"123123"
};
document.getElementById("jname").innerHTML=JSONObject.name;
document.getElementById("jstreet").innerHTML=JSONObject.street;
document.getElementById("jphone").innerHTML=JSONObject.phone;
//包含三个对象的数组
var JSONObject2=[
				{ "firstName":"John" , "lastName":"Doe" }, 
				{ "firstName":"Anna" , "lastName":"Smith" }, 
				{ "firstName":"Peter" , "lastName": "Jones" }
];
var js = JSONObject2[1].firstName;
alert(js);

//使用eval()可将json文本转换为JavaScript对象
var txt = '{ "employees" : [' +
'{ "firstName":"John" , "lastName":"Doe" },' +
'{ "firstName":"Anna" , "lastName":"Smith" },' +
'{ "firstName":"Peter" , "lastName":"Jones" } ]}';
var obj = eval("("+txt+")");
alert("obj "+obj.employees[0].firstName);

/*
 * AJAX请求
 */
function loadXMLDoc(url)
{
	var xmlhttp;
	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById('A1').innerHTML=xmlhttp.status;
			document.getElementById('A2').innerHTML=xmlhttp.statusText;
			document.getElementById('A3').innerHTML=xmlhttp.responseText;
			document.getElementById('A4').innerHTML=Date();
		}
	 }
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
}
</script>
</html>