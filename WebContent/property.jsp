<%@page import="com.czy.utils.CommonUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta  name="save"   content="history"> 
<title>设置属性</title>
<script src="js/echarts.js"></script>
<script type="text/javascript" src="http://lib.sinaapp.com/js/jquery/1.9.1/jquery-1.9.1.min.js"></script>
<script type='text/javascript' src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js"></script>
<script type='text/javascript' src="js/bootstrap-slider.min.js"></script>
<link href="http://libs.useso.com/js/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link href="js/bootstrap-slider.min.css" rel="stylesheet">
<!-- MiniColors -->
<script src="js/jquery.minicolors.js"></script>
<link rel="stylesheet" href="js/jquery.minicolors.css">

</head>
<body >
<div id="ccc">
<div id="content"><input id="fontSize" onchange="" data-slider-id='ex1Slider' type="text" data-slider-min="10" data-slider-max="30" data-slider-step="1" data-slider-value="20"/></div>
</div>
	
	<script type="text/javascript">
	$(document).ready( function() {
		
        $('.demo').each( function() { 
			$(this).minicolors({
				position: $(this).attr('data-position') || 'bottom left',
			});
            
        });
	});
	$(document).ready(fontSize());
	function fontSize() {
    	$('#fontSize').slider({
          	formatter: function(value) {
            	return value;
          	}
        });
	}
</script>
</body>
</html>