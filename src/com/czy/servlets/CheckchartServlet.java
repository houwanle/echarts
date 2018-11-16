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

@WebServlet("/CheckchartServlet")
public class CheckchartServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.setHeader("content-type", "text/html;charset=UTF-8");  
		response.setCharacterEncoding("UTF-8");  
		//request.setCharacterEncoding("UTF-8");  
		DataSource ds=CommonUtils.getInnerDataSource();
		String chartName = request.getParameter("chartName");
		//chartName = java.net.URLDecoder.decode(chartName , "UTF-8");
		chartName = new String(chartName.getBytes("iso-8859-1"), "utf-8");
		String fontSize = request.getParameter("fontSize");
		String fontWeight = request.getParameter("fontWeight");
		System2dataDao s2 = new System2dataDao();
		String chart = request.getParameter("chart");
		chart = java.net.URLDecoder.decode(chart , "UTF-8");
		String id = request.getParameter("id");
		
		
		String[] StrArray = chart.split("_");
		String tableName=StrArray[0];//view1	
		String chartType=StrArray[1];//bar
		//System.out.println("checktablename="+tableName);
		//tableName = java.net.URLDecoder.decode(tableName , "UTF-8");
		//System.out.println("checktablename="+chartType);
		//String id=s2.getId(ds, tableName);
		String option="";
		String sql=s2.getSql(CommonUtils.getInnerDataSource(), tableName);
		List<List<String>> dsInfo = s2.get(CommonUtils.getInnerDataSource(), "SELECT t1.id, t1.ip, t1.port, t1.`databaseName`, t1.user, t1.`password`, t1.type FROM datasource t1, chartview t2 WHERE t1.id = t2.`ds_id` AND t2.name = '" + tableName + "'");
		ds.setId(dsInfo.get(1).get(0));
		ds.setIp(dsInfo.get(1).get(1));
		ds.setPort(dsInfo.get(1).get(2));
		ds.setDatabaseName(dsInfo.get(1).get(3));
		ds.setUser(dsInfo.get(1).get(4));
		ds.setPassword(dsInfo.get(1).get(5));
		ds.setType(dsInfo.get(1).get(6));
		
		List<List<String>> data2=s2.obtainData(ds,sql);
		response.setCharacterEncoding("UTF-8");
		List<String> tableHead=new ArrayList<String>();
		
		//System.out.println("chart:"+data2);
		//System.out.println("id:"+id);
		for(int i=0;i<data2.get(0).size();i++)
		{
			
			tableHead.add(data2.get(0).get(i).toString());
			}
		ds = CommonUtils.getInnerDataSource();
		if("bar".equals(chartType)){
			String barGap = s2.getProperties(ds, id, chartType, "barGap");
			String yUnit = s2.getProperties(ds, id, chartType, "yUnit");
			yUnit = java.net.URLDecoder.decode(yUnit , "UTF-8");
			String typeaxis = s2.getProperties(ds, id, chartType, "typeaxis");
			typeaxis = java.net.URLDecoder.decode(typeaxis , "UTF-8");
			if(!typeaxis.equals(tableHead.get(0))){
				List<List<String>> data1=new ArrayList<List<String>>();
				List<String> temp=null;
				int k=0;
				for(int i=0;i<tableHead.size();i++){
					if(typeaxis.equals(tableHead.get(i))){k=i;}
				}
				for(int i=0;i<data2.size();i++){	
					temp=new ArrayList<String>();
					temp.add(data2.get(i).get(k));
					for(int j=0;j<tableHead.size();j++)
					{						
						if(j!=k){
							temp.add(data2.get(i).get(j));
						}
					}
					data1.add(temp);
		
				}
			
				data2.clear();				
				data2=data1;
			}
			Map<String, Object> property = new HashMap<String, Object>();
			property.put("titleText", chartName);
			property.put("fontSize", fontSize);
			property.put("fontWeight", fontWeight);
			property.put("barGap", barGap+"%");
			property.put("yUnit",yUnit);
			BarTp bar=new BarTp();
			option=bar.getJson(property,data2);
				}
		else if("pie".equals(chartType)){
			String innerRadius = s2.getProperties(ds, id, chartType, "innerRadius");
			String externalRadius = s2.getProperties(ds, id, chartType, "externalRadius");
			String piePosition = s2.getProperties(ds, id, chartType, "piePositionRadio");
			String legendPosition=s2.getProperties(ds, id, chartType, "legendPositionRadio");
		
			Map<String, Object> property=new HashMap<String, Object>();
			property.put("titleText", chartName);
			property.put("fontSize", fontSize);
			property.put("fontWeight", fontWeight);
			property.put("radiusIn", innerRadius+"%");
			property.put("radiusOut", externalRadius+"%");
			property.put("position", piePosition);
			property.put("orient", legendPosition);
			
			PieTp pie=new PieTp();
			option=pie.getJson(property, data2);
		}
		else if("line".equals(chartType)){
			String yUnit =s2.getProperties(ds, id, chartType, "yUnit");
			yUnit = java.net.URLDecoder.decode(yUnit , "UTF-8");
			String typeaxis = s2.getProperties(ds, id, chartType, "typeaxis");
			typeaxis = java.net.URLDecoder.decode(typeaxis , "UTF-8");
			if(!typeaxis.equals(tableHead.get(0))){
				List<List<String>> data1=new ArrayList<List<String>>();
				List<String> temp=null;
				int k=0;
				for(int i=0;i<tableHead.size();i++){
					if(typeaxis.equals(tableHead.get(i))){k=i;}
				}
				for(int i=0;i<data2.size();i++){	
					temp=new ArrayList<String>();
					temp.add(data2.get(i).get(k));
					for(int j=0;j<tableHead.size();j++)
					{						
						if(j!=k){
							temp.add(data2.get(i).get(j));
						}
					}
					data1.add(temp);
		
				}
			
				data2.clear();				
				data2=data1;
			}
			
			Map<String, Object> property=new HashMap<String, Object>();
			property.put("titleText", chartName);
			property.put("fontSize", fontSize);
			property.put("fontWeight", fontWeight);
			property.put("yUnit", yUnit);
			
			LineTp line =new LineTp();
			option=line.getJson(property,data2);
			
		}
		else if("scatter".equals(chartType)){
			String xmax = s2.getProperties(ds, id, chartType, "xmax");
			String xmin = s2.getProperties(ds, id, chartType, "xmin");
			String ymax = s2.getProperties(ds, id, chartType, "ymax");
			String ymin = s2.getProperties(ds, id, chartType, "ymin");
			String xUnit = s2.getProperties(ds, id, chartType, "xUnit");
			String yUnit = s2.getProperties(ds, id, chartType, "yUnit");
			xUnit = java.net.URLDecoder.decode(xUnit , "UTF-8");
			yUnit = java.net.URLDecoder.decode(yUnit , "UTF-8");
			
			double xmax1=Double.parseDouble(data2.get(1).get(0)),xmin1=Double.parseDouble(data2.get(1).get(0)),ymax1=Double.parseDouble(data2.get(1).get(1)),ymin1=Double.parseDouble(data2.get(1).get(1));
			for(int i=1;i<data2.size();i++){
				if(Double.parseDouble(data2.get(i).get(0))>xmax1)xmax1=Double.parseDouble(data2.get(i).get(0));
				if(Double.parseDouble(data2.get(i).get(0))<xmin1)xmin1=Double.parseDouble(data2.get(i).get(0));
				if(Double.parseDouble(data2.get(i).get(1))<ymin1)ymin1=Double.parseDouble(data2.get(i).get(1));
				if(Double.parseDouble(data2.get(i).get(1))>ymax1)ymax1=Double.parseDouble(data2.get(i).get(1));
			}
			xmax=String.valueOf(xmax1*Integer.parseInt(xmax)/100);
			xmin=String.valueOf(xmin1*Integer.parseInt(xmin)/100);
			ymax=String.valueOf(ymax1*Integer.parseInt(ymax)/100);
			ymin=String.valueOf(ymin1*Integer.parseInt(ymin)/100);

			
			Map<String, Object> property = new HashMap<String, Object>();
			property.put("xmax", xmax);
			property.put("xmin", xmin);
			property.put("ymax", ymax);
			property.put("ymin", ymin);
			property.put("xUnit", xUnit);
			property.put("yUnit", yUnit);
			property.put("titleText", chartName);
			property.put("fontSize",fontSize);//�����С
			property.put("fontWeight", fontWeight);
			
			ScatterTp scatter = new ScatterTp();
			option=scatter.getJson(property, data2);
		}
		else if("treemap".equals(chartType)){
			String mapDesc = s2.getProperties(ds, id, chartType, "mapDesc");
			mapDesc = java.net.URLDecoder.decode(mapDesc , "UTF-8");
			String borderWidth = s2.getProperties(ds, id, chartType, "borderWidth");
			String borderColor = s2.getProperties(ds, id, chartType, "borderColor");
			String mapHeight = s2.getProperties(ds, id, chartType, "mapHeight");
			
			HashMap<String, Object> property = new HashMap<String, Object>();
			property.put("titleText", chartName);
			property.put("borderWidth",borderWidth);//�߽��߿��
			property.put("borderColor", borderColor);
			property.put("fontSize",fontSize);//�����С
			property.put("fontWeight", fontWeight);
			property.put("mapDesc",mapDesc);
			property.put("mapHeight", mapHeight+"%");
						
			TreemapTp treemap = new TreemapTp();
			option=treemap.getJson(property,data2);
		}
		else if("candlestick".equals(chartType)){
			String color = s2.getProperties(ds, id, chartType, "color1");
			String color0 = s2.getProperties(ds, id, chartType, "color2");
			HashMap<String, Object> property = new HashMap<String, Object>();
			property.put("titleText", chartName);
			property.put("color",color);//�߽��߿��
			property.put("color0", color0);
			property.put("fontSize",fontSize);//�����С
			property.put("fontWeight", fontWeight);
			option = new KlineTp().getJson(property,data2);
		}
		else if("baidu".equals(chartType)){
			String radius = s2.getProperties(ds, id, "heatbaidu", "radius");
			String maxNum = s2.getProperties(ds, id, "heatbaidu", "maxNum");
			HashMap<String, Object> property = new HashMap<String, Object>();		
			property.put("radius",radius);//�߽��߿��
			property.put("maxNum", maxNum);
			option = new BaidumapTp().getJson(property,data2);
		}
		else if("funnel".equals(chartType)){
			String sortValue = s2.getProperties(ds, id, chartType, "sort");
			String minSize = s2.getProperties(ds, id, chartType,"minSize");
			String maxSize = s2.getProperties(ds, id, chartType, "maxSize");
			String gap = s2.getProperties(ds, id, chartType, "gap");
			
			HashMap<String, Object> property = new HashMap<String, Object>();
			property.put("fontWeight", fontWeight);//����״̬�����С
			property.put("fontSize", fontSize);//����״̬�����С
			property.put("titleText", chartName);//ͼ��width
			property.put("minSize", minSize+"%");//�����Сֵ min ӳ��Ŀ�ȡ�
			property.put("maxSize", maxSize+"%");//������ֵ max ӳ��Ŀ�ȡ�
			property.put("sortValue", sortValue);
			property.put("gap", gap);
			
			FunnelTp funnel = new FunnelTp();
			option=funnel.getJson(property,data2);
		}else if("heatmap".equals(chartType)){
			String heatmapmin = s2.getProperties(ds, id, chartType, "min");
			String heatmapmax = s2.getProperties(ds, id, chartType,"max");
			double heatmapmax1=Double.parseDouble(data2.get(1).get(1)),heatmapmin1=Double.parseDouble(data2.get(1).get(1));
			for(int i=1;i<data2.size();i++){			
					if(Double.parseDouble(data2.get(i).get(1))>heatmapmax1)heatmapmax1=Double.parseDouble(data2.get(i).get(1));
					if(Double.parseDouble(data2.get(i).get(1))<heatmapmin1)heatmapmin1=Double.parseDouble(data2.get(i).get(1));
			}
			heatmapmax=String.valueOf(heatmapmax1*Integer.parseInt(heatmapmax)/100).split("\\.")[0];
			heatmapmin=String.valueOf(heatmapmin1*Integer.parseInt(heatmapmin)/100).split("\\.")[0];
			HashMap<String, Object> property = new HashMap<String, Object>();
			property.put("fontWeight", fontWeight);//����״̬�����С
			property.put("fontSize", fontSize);//����״̬�����С
			property.put("titleText", chartName);//ͼ��width
			property.put("subText", "");
			property.put("min", heatmapmin);//�����Сֵ min ӳ��Ŀ�ȡ�
			property.put("max", heatmapmax);//������ֵ max ӳ��Ŀ�ȡ�
			
			
			HeatmapTp heatmap = new HeatmapTp();
			option=heatmap.getJson(property,data2);
		}else if("radar".equals(chartType)){
			String radarmax = s2.getProperties(ds, id, chartType, "max");
			HashMap<String, Object> property = new HashMap<String, Object>();
			//System.out.println(chartName);
			property.put("titleText", chartName);		
			property.put("max", radarmax);
			option = new RadarTp().getJson(property,data2);
		}else if("map".equals(chartType)){
			if(data2.get(1).get(0).matches("[0-9]+")){
				List<List<String>> data1=new ArrayList<List<String>>();
				List<String> temp=null;
				int k=0;
				for(int i=0;i<data2.get(0).size();i++){
					if(!data2.get(1).get(i).matches("[0-9]+")){k=i;}
				}
				for(int i=0;i<data2.size();i++){	
					temp=new ArrayList<String>();
					temp.add(data2.get(i).get(k));
					for(int j=0;j<data2.get(0).size();j++)
					{						
						if(j!=k){
							temp.add(data2.get(i).get(j));
						}
					}
					data1.add(temp);
		
				}
			
				data2.clear();				
				data2=data1;
				//System.out.println("data="+data);
			}
			String mapmin =  s2.getProperties(ds, id, chartType,"mapmin");
			String mapmax =s2.getProperties(ds, id, chartType,"mapmax");
			double mapmax1=Double.parseDouble(data2.get(1).get(1)),mapmin1=Double.parseDouble(data2.get(1).get(1));
			for(int i=1;i<tableHead.size();i++){
				for(int j=1;j<data2.size();j++){
					if(Double.parseDouble(data2.get(j).get(i))>mapmax1)mapmax1=Double.parseDouble(data2.get(j).get(i));
					if(Double.parseDouble(data2.get(j).get(i))<mapmin1)mapmin1=Double.parseDouble(data2.get(j).get(i));
				
				}
			}
			mapmax=String.valueOf(mapmax1*Integer.parseInt(mapmax)/100).split("\\.")[0];
			mapmin=String.valueOf(mapmin1*Integer.parseInt(mapmin)/100).split("\\.")[0];
			option="";
			option=option+"{title: {text: '"+chartName+"',subtext: '纯属虚构',left: 'center'},tooltip: {trigger: 'item'},legend: {orient: 'vertical',left: 'left',data:[";
			for(int i=1;i<tableHead.size();i++){
				if(i!=tableHead.size()-1)
					option=option+"'"+tableHead.get(i)+"',";
				else
					option=option+"'"+tableHead.get(i)+"'";
				}
				
			option=option+"]},visualMap: {min: "+mapmin+",max:"+mapmax+",left: 'left',top: 'bottom',text: ['高','低'], calculable: true}, toolbox: {show: true,orient: 'vertical',left: 'right',top: 'center',feature: {dataView: {readOnly: false}, restore: {},saveAsImage: {}} },series: [";
			for(int k=1;k<tableHead.size();k++){
				option=option+"{name:";
					option=option+"'"+tableHead.get(k)+"',";
			option=option+" type: 'map',mapType: '湖北',roam: false, label: {normal: { show: true}, emphasis: {show: true}},data:[";
			for(int i=1;i<data2.size();i++){
				if(i!=data2.size()-1)
				option=option+" {name: '"+data2.get(i).get(0)+"',value: "+data2.get(i).get(k)+" },";
				else{
					option=option+" {name: '"+data2.get(i).get(0)+"',value: "+data2.get(i).get(k)+" }";

				}
			}
			if(k!=tableHead.size()-1)option=option+"]},";
			else option=option+"]}";
				
			
		    		}
			option=option+"]}";
		}
		
		//result=result+"</div>";
		//System.out.println("option="+option);
		
		PrintWriter out = response.getWriter();
		out.println(option);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
