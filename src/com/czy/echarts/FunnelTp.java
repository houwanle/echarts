package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;




import com.github.abel533.echarts.Label;
import com.github.abel533.echarts.LabelLine;
import com.github.abel533.echarts.code.LineType;
import com.github.abel533.echarts.code.Position;
import com.github.abel533.echarts.code.Sort;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.data.Data;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Funnel;
import com.github.abel533.echarts.style.LineStyle;
import com.github.abel533.echarts.style.TextStyle;

public class FunnelTp implements EchartInterface {

	/**
	 * Map<String, Object> propety = new HashMap<String, Object>();
	 * property.put("titletext", chartname);
	 * property.put("sort", "descending");//������� ����ȡ 'ascending', 'descending'
	 * property.put("minSize", "0%");
	 * property.put("maxSize", "100%");
	 * property.put("fontSize", 12);
	 * property.put("fontWeight", "normal");//'bold''bolder''lighter''normal'
	 * tableHead=null;
	 */
	public String getJson(Map<String, Object> property, List<List<String>>data) {
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
		List<String> type =new ArrayList<String>();
		for(int i=1;i<data.size();i++){
			type.add(data.get(i).get(0));
		}
		List<Double> xdata1 =new ArrayList<Double>();  
		for(int i=1;i<data.size();i++){
			xdata1.add(Double.parseDouble(data.get(i).get(1)));
		}
		GsonOption option = new GsonOption();
		option.backgroundColor("#ffffff");
        option.title().text(property.get("titleText").toString());
        option.tooltip().trigger(Trigger.item).formatter("{a} <br/>{b} : {c}%");
        option.toolbox().show(true).feature(Tool.mark, Tool.dataView, Tool.restore, Tool.saveAsImage);      
        option.calculable(true);
        Funnel funnel = new Funnel(property.get("titleText").toString());
        option.legend(type);
        if(property.get("sortValue").toString().equals("descending"))
        {funnel.width("80%").height("80%").minSize(property.get("minSize").toString()).maxSize(property.get("maxSize").toString()).
        sort(Sort.descending).
        gap(Integer.parseInt(property.get("gap").toString()));}
        else {
        	funnel.width("80%").height("80%").minSize(property.get("minSize").toString()).maxSize(property.get("maxSize").toString()).
            sort(Sort.ascending).
            gap(Integer.parseInt(property.get("gap").toString()));
        }
        funnel.itemStyle().normal().borderColor("#fff").borderWidth(1).
        label(new Label().show(true).position(Position.inside).textStyle(new TextStyle().fontSize(Integer.parseInt(property.get("fontSize").toString())).fontWeight(property.get("fontWeight"))))
        .labelLine(new LabelLine().show(false).length(10).lineStyle(new LineStyle().width(1).type(LineType.solid)));
        funnel.itemStyle().emphasis().borderWidth(5).
        label(new Label().show(true).formatter("{b}").textStyle(new TextStyle().fontSize(((Integer.parseInt(property.get("fontSize").toString())))+5).fontWeight(property.get("fontWeight").toString()))).
        labelLine(new LabelLine().show(true));
        
        List<Data> fdata = new ArrayList<Data>();      
        for(int i=0;i<type.size();i++)
			try{fdata.add(new Data(type.get(i),xdata1.get(i)));}
        catch (Exception e) {
			System.out.println(e.toString());
		}
        funnel.setData(fdata);        	        	 
        option.series(funnel);        	      
        String json=option.toString();
        return json;
	}

}
