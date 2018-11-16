package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.Magic;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.feature.MagicType;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Bar;


public class BarTp implements EchartInterface {

	private GsonOption option = new GsonOption();
	/**
	 * Map<String, Object> property = new HashMap<String, Object>();
	 * property.put("chartName", chartname);
	 * property.put("fontSize", 12);
	 * property.put("barGap", "30%");
	 * property.put("fontWeight", "normal");
	 * property.put("yUnit", "normal");
	 * itemList=null;
	 */
	public String getJson(Map<String, Object> property, List<List<String>>data){
		//System.out.println(data);
		List<String> typeArray =new ArrayList<String>();
		List<Object> title =new ArrayList<Object>();
		List<Object> data_1 =new ArrayList<Object>();
		
		for(int i=1;i<data.size();i++){
			title.add(data.get(i).get(0));
		}
		
		for(int i=1;i<data.get(0).size();i++)
        {
			typeArray.add(data.get(0).get(i));
        }
		for(int i=1;i<data.size();i++){
			for(int j=1;j<=typeArray.size();j++)
				data_1.add(data.get(i).get(j));
		}
		option.backgroundColor("#ffffff");
        option.title().text(property.get("titleText").toString());
        
        option.tooltip().trigger(Trigger.axis);
        option.toolbox().show(true).feature(Tool.mark, Tool.dataView, new MagicType(Magic.line, Magic.bar).show(true), Tool.restore, Tool.saveAsImage);
        option.calculable(true);
        CategoryAxis axis = new CategoryAxis();
        axis.name();
        axis.setPosition("bottom");//
        for(int i=0;i<title.size();i++){
        	axis.data(title.get(i));
        }
        axis.position("bottom");//
        option.xAxis((axis));
        option.yAxis(new ValueAxis().name(property.get("yUnit").toString()).position("left"));//
        int j=0;
        for(int i=0;i<typeArray.size();i++)
        {       	
        	 option.legend(typeArray.get(i));
        	 Bar bar = new Bar(typeArray.get(i));
        	 bar.setData(data_1.subList(j, title.size()+j)); 
        	 bar.itemStyle().normal().textStyle().fontSize(Integer.parseInt(property.get("fontSize").toString())).fontWeight(property.get("fontWeight").toString());
        	 bar.barGap(property.get("barGap").toString());
        	 option.series(bar);
        	 j+=title.size();
        }      
        String json=option.toString() ;
        return json;
	}
	

}
