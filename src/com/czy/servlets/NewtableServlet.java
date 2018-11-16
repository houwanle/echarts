package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/NewtableServlet")
public class NewtableServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String chartType = request.getParameter("chartType");
		String tableName = request.getParameter("chartName");
		String id = request.getParameter("id");
		//System.out.println("id="+id);
		String result = "";
		//System.out.println(tableList.size());
		Map<String, String>map=new HashMap<String, String>();
		map.put("bar", "柱形图");
		map.put("line", "折线图");
		map.put("pie", "饼图");
		map.put("funnel", "漏斗图");
		map.put("scatter", "散点图");
		map.put("treemap", "树图");
		map.put("candlestick", "K线图");
		map.put("map", "地图");
		map.put("heatmap", "热力图");
		map.put("radar", "雷达图");
		map.put("baidu", "百度地图");
		tableName = java.net.URLDecoder.decode(tableName , "UTF-8");
		tableName = new String(tableName.getBytes("iso-8859-1"), "utf-8");
		result=result+"<div id=\""+tableName+"_"+chartType+"\" class=\""+id+"\">" + tableName+map.get(chartType) ;
		result=result+"<a href=\"#\" style=\"float:right\" onclick=\"removechart('"+tableName+"_"+chartType+"')\">删除</a><a href=\"#\" style=\"float:right\" onclick=\"check('"+tableName+"_"+chartType+"')\">查看</a>";

		result=result+"</div>";
		//System.out.println(result);
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
