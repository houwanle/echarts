package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;
/**
 * Servlet implementation class PropertiesServlet
 */
@WebServlet("/PropertiesServlet")
public class PropertiesServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String chartType = request.getParameter("chartType");
		String tableName = request.getParameter("tableName");
		tableName = java.net.URLDecoder.decode(tableName , "UTF-8");
		tableName = new String(tableName.getBytes("iso-8859-1"), "utf-8");
		DataSource ds=CommonUtils.getInnerDataSource();//�������Դ
		System2dataDao s2=new System2dataDao();
//		List<List<String>> dsInfo = s2.get(CommonUtils.getInnerDataSource(), "SELECT t1.id, t1.ip, t1.port, t1.`databaseName`, t1.user, t1.`password`, t1.type FROM datasource t1, chartview t2 WHERE t1.id = t2.`ds_id` AND t2.name = '" + tableName + "'");
//		ds.setId(dsInfo.get(1).get(0));
//		ds.setIp(dsInfo.get(1).get(1));
//		ds.setPort(dsInfo.get(1).get(2));
//		ds.setDatabaseName(dsInfo.get(1).get(3));
//		ds.setUser(dsInfo.get(1).get(4));
//		ds.setPassword(dsInfo.get(1).get(5));
//		ds.setType(dsInfo.get(1).get(6));
		
		
		String vid = s2.getcvId(ds, tableName);
		List<String>idlist=s2.getId(ds);
		String id="";
		int k=0;
		for(int i=0;i<idlist.size();i++){
			if(Integer.parseInt(idlist.get(i))>k)k=Integer.parseInt(idlist.get(i));
		}
		k++;
		id=String.valueOf(k);
		response.setCharacterEncoding("UTF-8");
		int flag=0;//1Ϊ�ɹ�����ʧ��
		//System.out.println("123");
		if("bar".equals(chartType)) {
			
			String barGap = request.getParameter("barGap");
			String yUnit = request.getParameter("yUnit");
			yUnit = new String(yUnit.getBytes("iso-8859-1"), "utf-8");
			String typeaxis=request.getParameter("typeaxis");
			if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addBar(ds,id, barGap, yUnit, typeaxis)!=-1)
				flag=1;
		}else if("pie".equals(chartType)){
			String innerRadius = request.getParameter("innerRadius");
			String externalRadius = request.getParameter("externalRadius");
			String piePositionRadio = request.getParameter("piePosition");
			//System.out.println("piePositionRadio="+piePositionRadio);
			String legendPositionRadio=request.getParameter("legendPosition");//////////////ע��
			if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addPie(ds, id, innerRadius, externalRadius, piePositionRadio, legendPositionRadio)!=-1)
				flag=1;		
			} else if("line".equals(chartType)){
				
				String yUnit = request.getParameter("yUnit");
				yUnit = new String(yUnit.getBytes("iso-8859-1"), "utf-8");
				String typeaxis=request.getParameter("typeaxis");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addLine(ds, id, yUnit, typeaxis)!=-1)
					flag=1;
			}else if("funnel".equals(chartType)) {
				
				String sort = request.getParameter("sortValue");
				String minSize = request.getParameter("minSize");
				String maxSize = request.getParameter("maxSize");
				String gap = request.getParameter("gap");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addFunnel(ds, id, sort, minSize, maxSize, gap)!=-1)
					flag=1;
				
			} else if("scatter".equals(chartType)){
				String xmax = request.getParameter("xmax");
				String xmin = request.getParameter("xmin");
				String ymax = request.getParameter("ymax");
				String ymin = request.getParameter("ymin");
				String xUnit = request.getParameter("xUnit");
				String yUnit = request.getParameter("yUnit");
				xUnit = new String(xUnit.getBytes("iso-8859-1"), "utf-8");
				yUnit = new String(yUnit.getBytes("iso-8859-1"), "utf-8");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addScatter(ds, id, xmin, xmax, ymin, ymax, xUnit, yUnit)!=-1)
					flag=1;
			} else if("treemap".equals(chartType)){
				String mapDesc = request.getParameter("mapDesc");
				String borderWidth = request.getParameter("borderWidth");
				String borderColor = request.getParameter("borderColor");
				String mapHeight = request.getParameter("mapHeight");
				mapDesc = new String(mapDesc.getBytes("iso-8859-1"), "utf-8");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addTreemap(ds, id, mapDesc, borderWidth, borderColor, mapHeight)!=-1)
					flag=1;
			} else if("candlestick".equals(chartType)) {
				String color = request.getParameter("color");
				String color0 = request.getParameter("color0");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addCandlestick(ds, id, color, color0)!=-1)
					flag=1;
			}
			else if("map".equals(chartType)) {
				String mapmin = request.getParameter("mapmin");
				String mapmax = request.getParameter("mapmax");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addMap(ds, id, mapmin, mapmax)!=-1)
					flag=1;
			}
			else if("heatmap".equals(chartType)) {
				String heatmapmin = request.getParameter("heatmapmin");
				String heatmapmax = request.getParameter("heatmapmax");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addheatmap(ds, id, heatmapmin, heatmapmax)!=-1)
					flag=1;
			}
			else if("baidu".equals(chartType)) {
				String radius = request.getParameter("radius");
				String maxNum = request.getParameter("maxNum");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addBaidu(ds, id, radius, maxNum)!=-1)
					flag=1;
			}
			else if("radar".equals(chartType)) {
				String radarmax = request.getParameter("radarmax");
				if(s2.addViewtype(ds, vid, chartType,id)!=-1&&s2.addradar(ds, id,radarmax)!=-1)
					flag=1;
			}
		id=id+"_"+String.valueOf(flag);
		PrintWriter out = response.getWriter();
		out.println(id);
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
