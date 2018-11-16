package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.BaseDao;
import com.czy.dao.System2dataDao;
import com.czy.echarts.BaidumapTp;
import com.czy.echarts.BarTp;
import com.czy.echarts.FunnelTp;
import com.czy.echarts.HeatmapTp;
import com.czy.echarts.KlineTp;
import com.czy.echarts.LineTp;
import com.czy.echarts.PieTp;
import com.czy.echarts.RadarTp;
import com.czy.echarts.ScatterTp;
import com.czy.echarts.TreemapTp;
import com.czy.utils.CommonUtils;

/**
 * Servlet implementation class GetChartJsonServlet
 */
@WebServlet("/GetChartJsonServlet")
public class GetChartJsonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String vtid = request.getParameter("vtid");
		String fontSize = request.getParameter("fs");
		String fontWeight = request.getParameter("fw");
		String theme = request.getParameter("th");
		BaseDao bd = new BaseDao();
		DataSource ds = new DataSource();
		Map<String, Object> property=new HashMap<String, Object>();
		String newoption = null;
		List<List<String>> list = null;
		list = bd.get(CommonUtils.getInnerDataSource(), "SELECT type_name FROM view_type WHERE id = " + vtid);
		String type = list.get(1).get(0);
		//���ù�������
		//System.out.println("type"+type);
		property.put("fontSize", fontSize);
		property.put("fontWeight", fontWeight);
		property.put("theme", theme);
		//���ദ��
		if("pie".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.innerRadius, t4.externalRadius, t4.piePositionRadio, t4.legendPositionRadio FROM datasource t1, chartview t2, view_type t3, pie t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id and t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			property.put("titleText", list.get(1).get(6));
			property.put("radiusIn", list.get(1).get(8));
			property.put("radiusOut", list.get(1).get(9));
			property.put("position", list.get(1).get(10));
			property.put("orient", list.get(1).get(11));
			String stmt = list.get(1).get(7);
			list = bd.get(ds, stmt);
			PieTp pie = new PieTp();
			String option = pie.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "\"color\":" + theme + ",");
			newoption = sb.toString();
		} else if("bar".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.barGap, t4.yUnit, t4.typeaxis FROM datasource t1, chartview t2, view_type t3, bar t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("titleText", list.get(1).get(6));
			property.put("barGap", list.get(1).get(8) + "%");
			property.put("yUnit",list.get(1).get(9));
			property.put("typeaxis", list.get(1).get(10));
			String typeaxis = list.get(1).get(10);
			list = bd.get(ds, stmt);
			List<String> tableHead = list.get(0);
			if(!typeaxis.equals(tableHead)){
				List<List<String>> data1=new ArrayList<List<String>>();
				List<String> temp2=null;
				int k=0;
				for(int i=0;i<tableHead.size();i++){
					if(typeaxis.equals(tableHead.get(i)))
						{k=i;}
				}
				for(int i=0;i<list.size();i++){	
					temp2=new ArrayList<String>();
					temp2.add(list.get(i).get(k));
					for(int j=0;j<tableHead.size();j++)
					{						
						if(j!=k){
							temp2.add(list.get(i).get(j));
						}
					}
					data1.add(temp2);	
				}	
				list.clear();				
				list=data1;
			}
			BarTp bar = new BarTp();
			String option = bar.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "color:"+theme+",");
			newoption = sb.toString();
		} else if("line".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.yUnit, t4.typeaxis FROM datasource t1, chartview t2, view_type t3, line t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("yUnit", list.get(1).get(8));
			property.put("typeaxis", list.get(1).get(9));
			property.put("titleText", list.get(1).get(6));
			String typeaxis = list.get(1).get(9);
			list = bd.get(ds, stmt);
			List<String> tableHead = list.get(0);
			if(!typeaxis.equals(tableHead)){
				List<List<String>> data1=new ArrayList<List<String>>();
				List<String> temp2=null;
				int k=0;
				for(int i=0;i<tableHead.size();i++){
					if(typeaxis.equals(tableHead.get(i)))
						{k=i;}
				}
				for(int i=0;i<list.size();i++){	
					temp2=new ArrayList<String>();
					temp2.add(list.get(i).get(k));
					for(int j=0;j<tableHead.size();j++)
					{						
						if(j!=k){
							temp2.add(list.get(i).get(j));
						}
					}
					data1.add(temp2);	
				}	
				list.clear();				
				list=data1;
			}
			LineTp pie = new LineTp();
			String option = pie.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "color:"+theme+",");
			newoption = sb.toString();
		} else if("scatter".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.xmin, t4.xmax, t4.ymin, t4.ymax, t4.xUnit, t4.yUnit FROM datasource t1, chartview t2, view_type t3, scatter t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("titleText", list.get(1).get(6));
			property.put("xUnit", list.get(1).get(12));
			property.put("yUnit", list.get(1).get(13));
			String xmax = list.get(1).get(9);
			String xmin = list.get(1).get(8);
			String ymax = list.get(1).get(11);
			String ymin = list.get(1).get(10);
			list = bd.get(ds, stmt);
			double xmax1=Double.parseDouble(list.get(1).get(0)),xmin1=Double.parseDouble(list.get(1).get(0)),ymax1=Double.parseDouble(list.get(1).get(1)),ymin1=Double.parseDouble(list.get(1).get(1));
			for(int i=1;i<list.size();i++){
				if(Double.parseDouble(list.get(i).get(0))>xmax1)xmax1=Double.parseDouble(list.get(i).get(0));
				if(Double.parseDouble(list.get(i).get(0))<xmin1)xmin1=Double.parseDouble(list.get(i).get(0));
				if(Double.parseDouble(list.get(i).get(1))<ymin1)ymin1=Double.parseDouble(list.get(i).get(1));
				if(Double.parseDouble(list.get(i).get(1))>ymax1)ymax1=Double.parseDouble(list.get(i).get(1));
			}
			xmax=String.valueOf(xmax1*Integer.parseInt(xmax)/100);
			xmin=String.valueOf(xmin1*Integer.parseInt(xmin)/100);
			ymax=String.valueOf(ymax1*Integer.parseInt(ymax)/100);
			ymin=String.valueOf(ymin1*Integer.parseInt(ymin)/100);
			property.put("xmin", xmin);
			property.put("xmax", xmax);
			property.put("ymin", ymin);
			property.put("ymax", ymax);
			ScatterTp scatter = new ScatterTp();
			String option = scatter.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "color:"+theme+",");
			newoption = sb.toString();
		} else if("funnel".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.sort, t4.minSize, t4.maxSize, t4.gap FROM datasource t1, chartview t2, view_type t3, funnel t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("titleText", list.get(1).get(6));
			property.put("sortValue", list.get(1).get(8));
			property.put("minSize", list.get(1).get(9) + "%");
			property.put("maxSize", list.get(1).get(10) + "%");
			property.put("gap", list.get(1).get(11));
			list = bd.get(ds, stmt);
			FunnelTp funnel = new FunnelTp();
			String option = funnel.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "color:"+theme+",");
			newoption = sb.toString();
		} else if("treemap".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.mapDesc, t4.borderWidth, t4.borderColor, t4.mapHeight FROM datasource t1, chartview t2, view_type t3, treemap t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("titleText", list.get(1).get(6));
			property.put("mapDesc", list.get(1).get(8));
			property.put("borderWidth", list.get(1).get(9));
			property.put("borderColor",list.get(1).get(10));
			property.put("mapHeight", list.get(1).get(11)+"%");
			list = bd.get(ds, stmt);
			TreemapTp treemap = new TreemapTp();
			String option = treemap.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "color:"+theme+",");
			newoption = sb.toString();
		} else if("candlestick".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.color1, t4.color2 FROM datasource t1, chartview t2, view_type t3, candlestick t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("titleText", list.get(1).get(6));
			property.put("color", list.get(1).get(8));
			property.put("color0",list.get(1).get(9));
			list = bd.get(ds, stmt);
			KlineTp kline = new KlineTp();
			String option = kline.getJson(property, list);
			StringBuilder  sb = new StringBuilder (option);
			sb.insert(1, "color:"+theme+",");
			newoption = sb.toString();
		}else if("map".equals(type)){
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.mapmin, t4.mapmax FROM datasource t1, chartview t2, view_type t3, map t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			String mapmin = list.get(1).get(8);
			String mapmax = list.get(1).get(9);
			newoption = "{backgroundColor:\"#ffffff\",title: {text: '"+list.get(1).get(6)+"',subtext: '纯属虚构',left: 'center'},tooltip: {trigger: 'item'},legend: {orient: 'vertical',left: 'left',data:[";
			list = bd.get(ds, stmt);
			if(list.get(1).get(0).matches("[0-9]+")){
				List<List<String>> data1=new ArrayList<List<String>>();
				List<String> temp=null;
				int k=0;
				for(int i=0;i<list.get(0).size();i++){
					if(!list.get(1).get(i).matches("[0-9]+")){k=i;}
				}
				for(int i=0;i<list.size();i++){	
					temp=new ArrayList<String>();
					temp.add(list.get(i).get(k));
					for(int j=0;j<list.get(0).size();j++)
					{						
						if(j!=k){
							temp.add(list.get(i).get(j));
						}
					}
					data1.add(temp);
		
				}
			
				list.clear();				
				list=data1;
				//System.out.println("data="+data);
			}
			double mapmax1=Double.parseDouble(list.get(1).get(1)),mapmin1=Double.parseDouble(list.get(1).get(1));
			for(int i=1;i<list.get(0).size();i++){
				for(int j=1;j<list.size();j++){
					if(Double.parseDouble(list.get(j).get(i))>mapmax1)mapmax1=Double.parseDouble(list.get(j).get(i));
					if(Double.parseDouble(list.get(j).get(i))<mapmin1)mapmin1=Double.parseDouble(list.get(j).get(i));
				
				}
			}
			mapmax=String.valueOf(mapmax1*Integer.parseInt(mapmax)/100);
			mapmin=String.valueOf(mapmin1*Integer.parseInt(mapmin)/100);
			
			for(int i=1;i<list.get(0).size();i++){
				if(i!=list.get(0).size()-1)
					newoption = newoption+"'"+list.get(0).get(i)+"',";
				else
					newoption = newoption+"'"+list.get(0).get(i)+"'";
				}
				
			newoption = newoption +"]},visualMap: {min: "+mapmin+",max:"+mapmax+",left: 'left',top: 'bottom',text: ['高','低'], calculable: true}, toolbox: {show: true,orient: 'vertical',left: 'right',top: 'center',feature: {dataView: {readOnly: false}, restore: {},saveAsImage: {}} },series: [";
			for(int k=1;k<list.get(0).size();k++){
				newoption = newoption + "{name:";
				newoption = newoption + "'" + list.get(0).get(k) + "',";
				newoption = newoption + " type: 'map',mapType: '湖北',roam: false, label: {normal: { show: true}, emphasis: {show: true}},data:[";
			for(int i=1;i<list.size();i++){
				if(i!=list.size()-1)
					newoption = newoption + " {name: '"+list.get(i).get(0)+"',value: "+list.get(i).get(k)+" },";
				else{
					newoption = newoption + " {name: '"+list.get(i).get(0)+"',value: "+list.get(i).get(k)+" }";
				}
			}
			if(k!=list.get(0).size()-1)newoption = newoption + "]},";
			else newoption = newoption + "]}";
		    		}
			newoption = newoption + "]}";
		} else if("heatmap".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.max, t4.min FROM datasource t1, chartview t2, view_type t3, heatmap t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			//System.out.println("heatmap:"+list);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String name = list.get(1).get(6);
			String stmt = list.get(1).get(7);
			
			String heatmapmax=list.get(1).get(8);
			String heatmapmin=list.get(1).get(9);
			list = bd.get(ds, stmt);
			
			double heatmapmax1=Double.parseDouble(list.get(1).get(1)),heatmapmin1=Double.parseDouble(list.get(1).get(1));
			for(int i=1;i<list.size();i++){			
					if(Double.parseDouble(list.get(i).get(1))>heatmapmax1)heatmapmax1=Double.parseDouble(list.get(i).get(1));
					if(Double.parseDouble(list.get(i).get(1))<heatmapmin1)heatmapmin1=Double.parseDouble(list.get(i).get(1));
			}
			heatmapmax=String.valueOf(heatmapmax1*Integer.parseInt(heatmapmax)/100).split("\\.")[0];
			heatmapmin=String.valueOf(heatmapmin1*Integer.parseInt(heatmapmin)/100).split("\\.")[0];
			property.put("max", heatmapmax);
			property.put("min", heatmapmin);
			property.put("titleText", name);
			property.put("subText", "");
			property.put("background", "#dfdfdf");
			HeatmapTp ht = new HeatmapTp();
			newoption = ht.getJson(property, list);
		} else if("radar".equals(type)) {
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.max FROM datasource t1, chartview t2, view_type t3, radar t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			System.out.println("vtid"+vtid);
			System.out.println("list"+list);
			
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String name = list.get(1).get(6);
			String stmt = list.get(1).get(7);
			property.put("max", list.get(1).get(8));
			property.put("titleText", name);
			list = bd.get(ds, stmt);
			RadarTp rt = new RadarTp();
			newoption = rt.getJson(property, list);
			//System.out.println(newoption);
		} else if("baidu".equals(type)){
			//list = bd.get(CommonUtils.getInnerDataSource(), "SELECT * FROM heatbaidu t1 , view_type t2, chartview t3 WHERE t1.id = t2.id AND t2.v_id = t3.id AND t2.id = " + vtid);
			list = bd.get(CommonUtils.getInnerDataSource(), "SELECT t1.ip, t1.port, t1.databaseName, t1.user, t1.password, t1.type, t2.name, t2.stmt, t4.radius,t4.maxNum FROM datasource t1, chartview t2, view_type t3, heatbaidu t4 WHERE t1.id = t2.ds_id AND t3.v_id = t2.id AND t3.id = t4.id AND t3.id = " + vtid);
			ds.setIp(list.get(1).get(0));
			ds.setPort(list.get(1).get(1));
			ds.setDatabaseName(list.get(1).get(2));
			ds.setUser(list.get(1).get(3));
			ds.setPassword(list.get(1).get(4));
			ds.setType(list.get(1).get(5));
			String stmt = list.get(1).get(7);
			property.put("radius",list.get(1).get(8));
			property.put("maxNum",list.get(1).get(9));
			
			//System.out.println(list);
			list = bd.get(ds, stmt);
			BaidumapTp baidumap = new BaidumapTp();
			newoption = baidumap.getJson(property, list);
			//System.out.println("new=="+newoption);
		}
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.println(newoption); 
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
