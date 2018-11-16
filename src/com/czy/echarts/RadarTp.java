package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 
 * @author tom
 *
 *	property.put("max", "100 100 100");
 *	property.put("title", "成绩分布");
 *	data = {
 *		{'姓名' , '语文'， '数学', '英语'},
 *		{'小明' , '33'， '33', '44'},
 *		{'小红' , '44'， '33', '33'}
 *	}
 */
public class RadarTp {
	public String getJson(Map<String, Object> property, List<List<String>> data) {
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
		String option = "";
		String legend = "[";
		int i, j = 0;
		for(i = 1; i < data.size() - 1; i++) {
			legend += "'" + data.get(i).get(0) + "',";
		}
		legend += "'" + data.get(i).get(0) + "']";
		String[] indicators = property.get("max").toString().split(" ");
		String ind = "[";
		for(i = 0; i < indicators.length - 1; i++) {
			ind += "{name: '" + data.get(0).get(i+1) + "', max: " + indicators[i] + "},";
		}
		ind += "{name: '" + data.get(0).get(i + 1) + "', max: " + indicators[i] + "}]";
		String datastr = "[";
		String valuestr = "";
		for(i = 1; i < data.size() - 1; i++) {
			valuestr = "[";
			for(j = 1; j < data.get(0).size() - 1; j++) {
				valuestr += data.get(i).get(j) + ",";
			}
			valuestr += data.get(i).get(j) + "]";
			datastr += "{value : " + valuestr + ",name : '" + data.get(i).get(0) + "'},";
		}
		valuestr = "[";
		for(j = 1; j < data.get(0).size() - 1; j++) {
			valuestr += data.get(i).get(j) + ",";
		}
		valuestr += data.get(i).get(j) + "]";
		datastr += "{value : " + valuestr + ",name : '" + data.get(i).get(0) + "'}]";
		option = "{backgroundColor:\"#ffffff\",title: {text: '" + property.get("titleText") + "'},tooltip: {},legend: {data: " + legend + "},radar: {indicator:" + ind + "},series: [{type: 'radar',data: " + datastr + "}]}";
		return option;
	}
}
