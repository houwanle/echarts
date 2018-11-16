package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/SavepropertiesServlet")
public class SavepropertiesServlet  extends HttpServlet{
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String chart = request.getParameter("chart");
		String id = request.getParameter("id");
		chart = java.net.URLDecoder.decode(chart , "UTF-8");
		String[] StrArray = chart.split("_");
		String chartType=StrArray[1];//bar
		DataSource ds=CommonUtils.getInnerDataSource();//�������Դ
		System2dataDao s2=new System2dataDao();
		response.setCharacterEncoding("UTF-8");
		//System.out.println(" tableName?"+ tableName);
		
		String vid=s2.getidVid(ds,id);
		String yUnit;
		
//		s2.removeType(ds, chartType, vid);
//		s2.removeView(ds, id);
		int flag=0;//1Ϊ�ɹ�����ʧ��
		
		if("bar".equals(chartType)) {			
			String barGap = request.getParameter("barGap");
			yUnit = request.getParameter("yUnit");
			yUnit = new String(yUnit.getBytes("iso-8859-1"), "utf-8");
			//yUnit = java.net.URLDecoder.decode(yUnit , "UTF-8");
			String typeaxis=request.getParameter("typeaxis");
			List<String> list=new ArrayList<String>();
			list.add(barGap);
			list.add(yUnit);
			list.add(typeaxis);
			if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "bar", list)!=-1)
				flag=1;
		}else if("pie".equals(chartType)){
			String innerRadius = request.getParameter("innerRadius");
			String externalRadius = request.getParameter("externalRadius");
			String piePositionRadio = request.getParameter("piePositionRadio");
			String legendPositionRadio=request.getParameter("legendPositionRadio");//////////////ע��
			List<String> list=new ArrayList<String>();
			list.add(innerRadius);
			list.add(externalRadius);
			list.add(piePositionRadio);
			list.add(legendPositionRadio);
			if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "pie", list)!=-1)
				flag=1;	
			} else if("line".equals(chartType)){
				yUnit = request.getParameter("yUnit");
				yUnit = new String(yUnit.getBytes("iso-8859-1"), "utf-8");
				String typeaxis=request.getParameter("typeaxis");
				List<String> list=new ArrayList<String>();
				list.add(yUnit);
				list.add(typeaxis);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "line", list)!=-1)
					flag=1;
				
			}else if("funnel".equals(chartType)) {
				
				String sort = request.getParameter("sortValue");
				String minSize = request.getParameter("minSize");
				String maxSize = request.getParameter("maxSize");
				String gap = request.getParameter("gap");
				List<String> list=new ArrayList<String>();
				list.add(sort);
				list.add(minSize);
				list.add(maxSize);
				list.add(gap);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "funnel", list)!=-1)
					flag=1;
				
			} else if("scatter".equals(chartType)){
				String xmax = request.getParameter("xmax");
				String xmin = request.getParameter("xmin");
				String ymax = request.getParameter("ymax");
				String ymin = request.getParameter("ymin");
				String xUnit = request.getParameter("xUnit");
				yUnit = request.getParameter("yUnit");
				xUnit = new String(xUnit.getBytes("iso-8859-1"), "utf-8");
				yUnit = new String(yUnit.getBytes("iso-8859-1"), "utf-8");
				List<String> list=new ArrayList<String>();
				list.add(xmin);
				list.add(xmax);
				list.add(ymin);
				list.add(ymax);
				list.add(xUnit);
				list.add(yUnit);	
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "scatter", list)!=-1)
					flag=1;
				
			} else if("treemap".equals(chartType)){
				String mapDesc = request.getParameter("mapDesc");
				String borderWidth = request.getParameter("borderWidth");
				String borderColor = request.getParameter("borderColor");
				String mapHeight = request.getParameter("mapHeight");
				mapDesc = new String(mapDesc.getBytes("iso-8859-1"), "utf-8");
				List<String> list=new ArrayList<String>();
				list.add(mapDesc);
				list.add(borderWidth);
				list.add(borderColor);
				list.add(mapHeight);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "treemap", list)!=-1)
					flag=1;
			} else if("candlestick".equals(chartType)) {
				String color = request.getParameter("color");
				String color0 = request.getParameter("color0");
				List<String> list=new ArrayList<String>();
				list.add(color);
				list.add(color0);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "candlestick", list)!=-1)
					flag=1;
			}else if("baidu".equals(chartType)) {
				String radius = request.getParameter("radius");
				String maxNum = request.getParameter("maxNum");
				List<String> list=new ArrayList<String>();
				list.add(radius);
				list.add(maxNum);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "baidu", list)!=-1)
					flag=1;
			}else if("map".equals(chartType)) {
				String mapmin = request.getParameter("mapmin");
				String mapmax = request.getParameter("mapmax");
				List<String> list=new ArrayList<String>();
				list.add(mapmax);
				list.add(mapmin);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "map", list)!=-1)
					flag=1;
			}else if("heatmap".equals(chartType)) {
				String heatmapmin = request.getParameter("heatmapmin");
				String heatmapmax = request.getParameter("heatmapmax");
				List<String> list=new ArrayList<String>();
				list.add(heatmapmin);
				list.add(heatmapmax);
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "heatmap", list)!=-1)
					flag=1;
			}
			else if("radar".equals(chartType)) {
				String max = request.getParameter("radarmax");
				List<String> list=new ArrayList<String>();
				list.add(max);
				
				if(s2.updataview(ds, vid, chartType,id)!=-1&&s2.updatatype(ds,id, "radar", list)!=-1)
					flag=1;
			}
	
		PrintWriter out = response.getWriter();
		out.println(flag);
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
