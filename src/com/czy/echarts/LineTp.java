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
import com.github.abel533.echarts.series.Line;

public class LineTp implements EchartInterface {

	private GsonOption option = new GsonOption();
	/**
	 * Map<String, Object> propety = new HashMap<String, Object>();
	 * property.put("titletext", chartname);
	 * property.put("fontSize", 12);
	 * property.put("fontWeight", "normal");
	 * property.put("yunit", "normal");
	 * itemList=null;
	 */
	public String getJson(Map<String, Object> property, List<List<String>>data) {
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
        option.title().text(property.get("titleText").toString());//.x(X.center);
        option.toolbox().show(true).feature(
                Tool.mark,
                Tool.dataView,
                new MagicType(Magic.line, Magic.bar),
                Tool.restore,
                Tool.saveAsImage);
        option.tooltip().trigger(Trigger.item).formatter("{a} <br/>{b} : {c}");
        option.calculable(true);
        
        ValueAxis valueAxis = new ValueAxis();
	    valueAxis.axisLabel().formatter("{value}");
	    valueAxis.name(property.get("yUnit").toString());
	    option.yAxis(valueAxis);
	 
	    CategoryAxis axis=new CategoryAxis();
	    axis.axisLine().onZero(false);
	    axis.axisLabel().formatter("{value}");
	    axis.boundaryGap(false);
	    for(int i=0;i<title.size();i++){
	    	axis.data(title.get(i));
	    }
	    option.xAxis(axis);
        
        int j=0;
        for(int i =0;i<typeArray.size();i++)
        {
        	option.legend(typeArray.get(i));
        	Line line = new Line(typeArray.get(i));
        	line.itemStyle().normal().textStyle().fontSize(Integer.parseInt(property.get("fontSize").toString())).fontWeight(property.get("fontWeight").toString());
        	line.setData(data_1.subList(j, title.size()+j)); 
        	option.series(line); 
        	j+=title.size();
        }
        
        String json=option.toString() ; 
        return json;
	}

}
