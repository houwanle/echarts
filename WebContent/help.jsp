<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<link rel="stylesheet" type="text/css" href="css/slicebox.css" />
<link rel="stylesheet" type="text/css" href="css/custom.css" />
<script type="text/javascript" src="js/modernizr.custom.46884.js"></script>
<script type='text/javascript' src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.slicebox.js"></script>
</head>
<style>
#lbutton{
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
#lbutton:hover{
		background-color:#3285FF;
		border:1px solid #3285FF;
		width:200px;height:60px;font-size:30px;}
</style>
<body>
<div class="container">
    <h1 style="font-size:90px;">YZChart教程</h1>
    
    
    <div class="wrapper">
        <ul id="sb-slider" class="sb-slider">
            <li>
                <a href="#" ><img src="img/baidu.png" alt=""/></a>
                <div class="sb-description">
                    <h3>百度地图及数据表示例</h3>
                </div>
            </li>
            <li>
                <a href="#" ><img src="img/bar.png" alt=""/></a>
                <div class="sb-description">
                    <h3>柱形图及数据表示例</h3>
                </div>
            </li>
            <li>
                <a href="#"><img src="img/line.png" alt=""/></a>
                <div class="sb-description">
                    <h3>折线图及数据表示例</h3>
                </div>
            </li>
            <li>
                <a href="#"><img src="img/pie.png" alt=""/></a>
                <div class="sb-description">
                    <h3>饼图及数据表示例</h3>
                </div>
            </li>
            <li>
                <a href="#" ><img src="img/scatter.png" alt=""/></a>
                <div class="sb-description">
                    <h3>散点图及数据表示例</h3>
                </div>
            </li>
            <li>
                <a href="#"><img src="img/treemap.png" alt=""/></a>
                <div class="sb-description">
                    <h3>树图及数据表示例</h3>
                </div>
            </li>
            <li>
                <a href="#" ><img src="img/kline.png" alt=""/></a>
                <div class="sb-description">
                    <h3>K线图及数据表示例</h3>
                </div>
            </li>
			 <li>
                <a href="#"><img src="img/funnel.png" alt=""/></a>
                <div class="sb-description">
                    <h3>漏斗图及数据表示例</h3>
                </div>
            </li>
			 <li>
                <a href="#" ><img src="img/map.png" alt=""/></a>
                <div class="sb-description">
                    <h3>地图及数据表示例（只支持市）</h3>
                </div>
            </li>
			 <li>
                <a href="#" ><img src="img/heatmap.png" alt=""/></a>
                <div class="sb-description">
                    <h3>热力图及数据表示例</h3>
                </div>
            </li>
			 <li>
                <a href="#" ><img src="img/radar.png" alt=""/></a>
                <div class="sb-description">
                    <h3>雷达图及数据表示例</h3>
                </div>
            </li>
        </ul>

        <div id="shadow" class="shadow" style="background: url(img/shadow.png) no-repeat bottom center;background-size: 100% 100%;"></div>

        <div id="nav-arrows" class="nav-arrows">
            <a href="#">Next</a>
            <a href="#">Previous</a>
        </div>

        <div id="nav-dots" class="nav-dots">
            <span class="nav-dot-current"></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
			<span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>

    </div>
</div>
<div style="width:100%;text-align:right;"> 
	<input type="button" id="lbutton" onclick="window.location.href='nexthelp.jsp'" value="查看流程图">
</div>

<script type="text/javascript">

    $(function() {

        var Page = (function() {

            var $navArrows = $( '#nav-arrows' ).hide(),
                $navDots = $( '#nav-dots' ).hide(),
                $nav = $navDots.children( 'span' ),
                $shadow = $( '#shadow' ).hide(),
                slicebox = $( '#sb-slider' ).slicebox( {
                    onReady : function() {

                        $navArrows.show();
                        $navDots.show();
                        $shadow.show();

                    },
                    onBeforeChange : function( pos ) {

                        $nav.removeClass( 'nav-dot-current' );
                        $nav.eq( pos ).addClass( 'nav-dot-current' );

                    }
                } ),
                
                init = function() {

                    initEvents();
                    
                },
                initEvents = function() {

                    // add navigation events
                    $navArrows.children( ':first' ).on( 'click', function() {

                        slicebox.next();
                        return false;

                    } );

                    $navArrows.children( ':last' ).on( 'click', function() {
                        
                        slicebox.previous();
                        return false;

                    } );

                    $nav.each( function( i ) {
                    
                        $( this ).on( 'click', function( event ) {
                            
                            var $dot = $( this );
                            
                            if( !slicebox.isActive() ) {

                                $nav.removeClass( 'nav-dot-current' );
                                $dot.addClass( 'nav-dot-current' );
                            
                            }
                            
                            slicebox.jump( i + 1 );
                            return false;
                        
                        } );
                        
                    } );

                };

                return { init : init };

        })();

        Page.init();

    });
  
</script>

</body>
</html>