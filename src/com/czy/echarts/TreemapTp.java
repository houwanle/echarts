package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.github.abel533.echarts.Label;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.data.Data;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Treemap;
import com.github.abel533.echarts.style.TextStyle;

public class TreemapTp implements EchartInterface {

	private GsonOption option = new GsonOption();
	
	/**
	 * Map<String, Object> property = new HashMap<String, Object>();
	 * map.put("title","title");//ͼ�����
	 * map.put("mapDesc","mapDesc");//����ͼ����
	 * map.put("borderColor","#ffffff");//�����С
	 * map.put("borderWidth",2);//�߽���Color
	 * map.put("fontSize",20);//�����С
	 * map.put("fontWeight","bold");//��ϸ
	 * map.put("mapHeigt","80%");//mapTree�߶�
	 */
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
		List<String> title = new ArrayList<String>();
		List<Double> data1 = new ArrayList<Double>();

		for (int i = 1; i < data.size(); i++) {
			title.add(data.get(i).get(0).toString());
			data1.add(Double.parseDouble(data.get(i).get(1).toString()));
		}
		option.backgroundColor("#ffffff");
		option.title(property.get("titleText").toString());		
		option.tooltip().trigger(Trigger.item).formatter("{b} : {c}");	
		option.toolbox()
				.show(true)
				.feature(Tool.mark, Tool.dataView, Tool.restore,
						Tool.saveAsImage);
		option.calculable(false);	
		Treemap treemap = new Treemap(property.get("mapDesc").toString());
		treemap.itemStyle().normal().label().show(true).formatter("{b} : {c}");
		treemap.itemStyle()
				.normal()
				.borderColor(property.get("borderColor").toString())
				.borderWidth(Integer.parseInt(property.get("borderWidth").toString()))
				.label(new Label().textStyle(new TextStyle()
						.fontSize(Integer.parseInt(property.get("fontSize").toString()))
						.fontWeight(property.get("fontWeight"))));
		treemap.height(property.get("mapHeight"));
		List<Data> tdata = new ArrayList<Data>();
		
		for (int i = 0; i < title.size(); i++) {
			tdata.add(new Data(title.get(i), data1.get(i)));
		}
		
		treemap.setData(tdata);
		option.series(treemap);
		return option.toString();

	}

}
