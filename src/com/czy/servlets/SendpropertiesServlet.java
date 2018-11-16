package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/SendpropertiesServlet")
public class SendpropertiesServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds=CommonUtils.getInnerDataSource();
		//response.setHeader("content-type", "text/html;charset=UTF-8");  
		response.setCharacterEncoding("UTF-8");  
		//request.setCharacterEncoding("UTF-8");  
		System2dataDao s2 = new System2dataDao();
		String chart = request.getParameter("chart");
		chart = java.net.URLDecoder.decode(chart , "UTF-8");
		String id = request.getParameter("id");
		String[] StrArray = chart.split("_");
		String chartType=StrArray[1];//bar
		
		//String id=s2.getId(ds, tableName);
		
		String option="";
		
		if("bar".equals(chartType)){
			String barGap = s2.getProperties(ds, id, chartType, "barGap");
			String yUnit = s2.getProperties(ds, id, chartType, "yUnit");
			String typeaxis = s2.getProperties(ds, id, chartType, "typeaxis");	
			option=barGap+"_"+yUnit+"_"+typeaxis;
		}
		else if("pie".equals(chartType)){
			String innerRadius = s2.getProperties(ds, id, chartType, "innerRadius");
			String externalRadius = s2.getProperties(ds, id, chartType, "externalRadius");
			String piePosition = s2.getProperties(ds, id, chartType, "piePositionRadio");
			String legendPosition=s2.getProperties(ds, id, chartType, "legendPositionRadio");	
			option=innerRadius+"_"+externalRadius+"_"+piePosition+"_"+legendPosition;
		}
		else if("line".equals(chartType)){
			String yUnit =s2.getProperties(ds, id, chartType, "yUnit");
			String typeaxis = s2.getProperties(ds, id, chartType, "typeaxis");
			option=yUnit+"_"+typeaxis;
		}
		else if("scatter".equals(chartType)){
			String xmax = s2.getProperties(ds, id, chartType, "xmax");
			String xmin = s2.getProperties(ds, id, chartType, "xmin");
			String ymax = s2.getProperties(ds, id, chartType, "ymax");
			String ymin = s2.getProperties(ds, id, chartType, "ymin");
			String xUnit = s2.getProperties(ds, id, chartType, "xUnit");
			String yUnit = s2.getProperties(ds, id, chartType, "yUnit");	
			option=xmax+"_"+xmin+"_"+ymax+"_"+ymin+"_"+xUnit+"_"+yUnit;
		}
		else if("treemap".equals(chartType)){
			String mapDesc = s2.getProperties(ds, id, chartType, "mapDesc");
			String borderWidth = s2.getProperties(ds, id, chartType, "borderWidth");
			String borderColor = s2.getProperties(ds, id, chartType, "borderColor");
			String mapHeight = s2.getProperties(ds, id, chartType, "mapHeight");	
			option=mapDesc+"_"+borderWidth+"_"+borderColor+"_"+mapHeight;
			//System.out.println(option);
		}
		else if("candlestick".equals(chartType)){
			String color = s2.getProperties(ds, id, chartType, "color1");
			String color0 = s2.getProperties(ds, id, chartType, "color2");
			option=color+"_"+color0;
		}
		else if("funnel".equals(chartType)){
			String sortValue = s2.getProperties(ds, id, chartType, "sort");
			String minSize = s2.getProperties(ds, id, chartType,"minSize");
			String maxSize = s2.getProperties(ds, id, chartType, "maxSize");
			String gap = s2.getProperties(ds, id, chartType, "gap");
			option=sortValue+"_"+minSize+"_"+maxSize+"_"+gap;
		}
		else if("map".equals(chartType)){
			String mapmin = s2.getProperties(ds, id, chartType, "mapmin");
			String mapmax = s2.getProperties(ds, id, chartType,"mapmax");
			
			option=mapmax+"_"+mapmin;
		}else if("heatmap".equals(chartType)){
			String min = s2.getProperties(ds, id, chartType, "min");
			String max = s2.getProperties(ds, id, chartType,"max");
			
			option=min+"_"+max;
		}else if("baidu".equals(chartType)){
			String radius = s2.getProperties(ds, id, "heatbaidu", "radius");
			String maxNum = s2.getProperties(ds, id, "heatbaidu","maxNum");
			
			option=radius+"_"+maxNum;
		}else if("radar".equals(chartType)){
			String max = s2.getProperties(ds, id, chartType,"max");
			
			option=max;
		}
		
		//result=result+"</div>";
		//System.out.println(result);
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(option);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
