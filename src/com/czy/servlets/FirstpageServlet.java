package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/FirstpageServlet")
public class FirstpageServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System2dataDao s2 = new System2dataDao();
		DataSource ds = CommonUtils.getInnerDataSource();
		String sql="SELECT * FROM view_type";
		List<List<String>> data2=s2.obtainData(ds, sql);
		//System.out.println("data2="+data2);
		if(data2.size()!=0){
			String result = "";
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
			for(int i=1;i<data2.size();i++){
				String chartType = data2.get(i).get(1);
				String chartName = s2.getName(ds, data2.get(i).get(0));
				String id = data2.get(i).get(2);
				//System.out.println("chartType="+chartType);
				result=result+"<div id=\""+chartName+"_"+chartType+"\" class=\""+id+"\">" + chartName+map.get(chartType) ;
				result=result+"<a href=\"#\" style=\"float:right\" onclick=\"removechart('"+chartName+"_"+chartType+"')\">删除</a><a href=\"#\" style=\"float:right\" onclick=\"check('"+chartName+"_"+chartType+"')\">查看</a>";

				result=result+"</div>";
			}
		//result=result+"</div>";
		//System.out.println(result);
				response.setCharacterEncoding("utf-8");
				PrintWriter out = response.getWriter();
				out.println(result);
				out.close();
		
			}
		else {}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
