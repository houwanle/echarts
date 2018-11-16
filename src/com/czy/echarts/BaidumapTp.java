package com.czy.echarts;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.czy.dao.System2dataDao;

public class BaidumapTp implements EchartInterface {
	/*property = Map<String,Object>
	 * property.put("radius",10) radius 势力图的每个点的半径大小
	 * property.put("maxNum",100) 阈值
	 * 
	 * points来源于points.js文件
	 * var points = [{"lng":115.046008,"lat":30.211828,"count":50}]; //经纬度，温度
	 *String data = null;
	 * for(int i=1;i<data.size();i++){
			//"武汉市":[114.298572,30.584355],
			//{"name": "武汉市","value": 100 },
			data+="{\"lng\":"+data.get(i).get(1)+",\"lat\":"+data.get(i).get(2)+",\"count\":20},";
			
		}
		points + = "["+data+"]";
	 * */
	@Override
	public String getJson(Map<String, Object> property, List<List<String>> data) {
		// TODO Auto-generated method stub
		//System.out.println(data);
		if(data.get(1).get(0).matches("[0-9]+")){
			List<List<String>> data1=new ArrayList<List<String>>();
			List<String> temp=null;
			int k=0;
			for(int i=0;i<data.get(0).size();i++){
				if(!data.get(1).get(i).matches("[0-9]+")){k=i;}
			}
			for(int i=0;i<data.size();i++){	
				temp=new ArrayList<String>();
				temp.add(data.get(i).get(k));
				for(int j=0;j<data.get(0).size();j++)
				{						
					if(j!=k){
						temp.add(data.get(i).get(j));
					}
				}
				data1.add(temp);
	
			}
		
			data.clear();				
			data=data1;
			//System.out.println("data="+data);
		}
		System2dataDao s2 = new System2dataDao();
		String points = "[";
		for(int i=1;i<data.size()-1;i++){			
				points=points+"{\"lng\":"+s2.getX(data.get(i).get(0))+",\"lat\":"+s2.getY(data.get(i).get(0))+",\"count\":"+data.get(i).get(1)+"},";
		}
		points=points+"{\"lng\":"+s2.getX(data.get(data.size()-1).get(0))+",\"lat\":"+s2.getY(data.get(data.size()-1).get(0))+",\"count\":"+data.get(data.size()-1).get(1)+"}]";
		StringBuilder sb = new StringBuilder();
		//container
		String heatjs = "var map = new BMap.Map(location);\n"+
						"var point = new BMap.Point(114.334981,30.623223);\n"+
						"map.centerAndZoom(point, 8); // 初始化地图，设置中心点坐标和地图级别\n"+
						"map.enableScrollWheelZoom(); // 允许滚轮缩放\n"+
						"if(!isSupportCanvas()){\n"+
						"  alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')\n"+
						"}\n"+
						"//判断浏览区是否支持canvas\n"+
						"function isSupportCanvas(){\n"+
						"  var elem = document.createElement('canvas');\n"+
						"  return !!(elem.getContext && elem.getContext('2d'));\n"+
						"}\n";
		
		heatjs +="heatmapOverlay = new BMapLib.HeatmapOverlay({\"radius\":"+property.get("radius")+"});\n"+
				"map.addOverlay(heatmapOverlay);\n"+
				"heatmapOverlay.setDataSet({data:"+points+"});\n"+
				"heatmapOverlay.show();\n";		
	    sb.append(heatjs);	
	   
		return sb.toString();
	}

}
