package com.czy.echarts;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.czy.dao.System2dataDao;
import com.github.abel533.echarts.Geo;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Heatmap;

public class HeatmapTp implements EchartInterface {
	/*Map<String, Object> property = new HashMap<String, Object>();
	 *property.put("titleText","标题");
	 *property.put("subText","副标题");
	 *property.put("background",#dfdfdf);
	 *property.put("fontSize", 12);
	 *property.put("fontWeight", "normal");
	 *property.put("max",500);
	 *property.put("min",0);
	 * */

	@Override
	public String getJson(Map<String, Object> property, List<List<String>> data) {
		// TODO Auto-generated method stub
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
		GsonOption option = new GsonOption();
		option.title(property.get("titleText").toString(),property.get("subText").toString());
		option.title().textStyle().color("#000000");
		option.backgroundColor(property.get("background"));		
		Geo geo = new Geo();
		geo.map("湖北").label().emphasis().show(true).textStyle().color("#fff").fontSize(Integer.parseInt(property.get("fontSize").toString())).fontWeight(property.get("fontWeight").toString());
		geo.itemStyle().normal().color("#323c48");
		geo.itemStyle().emphasis().color("#2a333d");
		option.geo(geo);
		option.visualMapNew().min(Integer.parseInt(property.get("min").toString())).max(Integer.parseInt(property.get("max").toString())).splitNumber(5).textStyle().color("fff");		
		Heatmap heatmap = new Heatmap();
		heatmap.name(property.get("titleText").toString());
		heatmap.coordinateSystem("geo");
		option.series(heatmap);
		String str = option.toString();
		StringBuffer stringBuffer = new StringBuffer(str);
		String points = "[";
		int i;
		for(i = 1; i < data.size() - 1; i++) {
			points += "[" + s2.getX(data.get(i).get(0)) + ", " + s2.getY(data.get(i).get(0)) + ", " + data.get(i).get(1) + "],";
		}
		points += "[" + s2.getX(data.get(i).get(0)) + ", " + s2.getY(data.get(i).get(0)) + ", " + data.get(i).get(1) + "]]";
		i=str.indexOf("\"series\": [{");
		stringBuffer.insert(i+12, "data:" + points + ",");	//data[{"name": "武汉市","value": 100 }]	
		str = stringBuffer.toString();							//converData 写在js中的一个转换函数
		
		int j=str.indexOf("\"geo\": {");
		stringBuffer.insert(j+8,"roam: true,");
		str = stringBuffer.toString();
		//System.out.println(str);
		return str;
	}
}
