package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.github.abel533.echarts.DataZoom;
import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.DataZoomType;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Candlestick;

public class KlineTp implements EchartInterface {

	@Override
	public String getJson(Map<String, Object> property,List<List<String>> data) {
		// TODO Auto-generated method stub
		
		List<String[]> list0 = new ArrayList<String[]>();//�������  ���ڸ�ʽ 2015/12/31
		List<Object> title =new ArrayList<Object>();
		for(int i=1;i<data.size();i++){
			title.add(data.get(i).get(0));
		}
		String a[] = null;
		for (int i = 1; i < data.size(); i++) {
						
			a = new String[4];
			a[0] = "+"+data.get(i).get(1).toString();//��ȡ��� ������ 
			a[1] = "+"+data.get(i).get(2).toString();
			a[2] = "+"+data.get(i).get(3).toString(); //�� ��5�� ��һ�з���ʱ�䣨2015/12/31��
			a[3] = "+"+data.get(i).get(4).toString();
			list0.add(a);
		}
		
		GsonOption option=new GsonOption();
		option.title(property.get("titleText").toString()).color("#ffffff");
		option.backgroundColor("#ffffff"); //������ɫ
		option.legend().data("k").textStyle().color("#ffffff").fontSize(Integer.parseInt(property.get("fontSize").toString())).fontWeight(property.get("fontWeight").toString());; //ͼ��������ɫ
		
		option.tooltip().trigger(Trigger.axis)
				.axisPointer().
					lineStyle().color("#376df4").width(2); //
		
		CategoryAxis xCategory=new CategoryAxis();
		
		xCategory.setData(title);	  
		
		xCategory.axisLine().lineStyle().color("#8392A5");
		option.xAxis(xCategory);
		
		ValueAxis yValue=new ValueAxis();
		yValue.scale(true);
		yValue.axisLine().lineStyle().color("#8392A5");
		option.yAxis(yValue);
		
		DataZoom dataZoom = new DataZoom();
		dataZoom.type(DataZoomType.inside);
		dataZoom.handleSize(80);
		dataZoom.dataBackgroundColor("#8392A5");
		dataZoom.handleColor("ffffff");
		option.dataZoom(dataZoom);
		
		option.animation(false);		
		
		Candlestick kStick = new Candlestick();
		kStick.name("k")
				.itemStyle().normal()
							.color(property.get("color").toString())
							.color0(property.get("color0").toString())
							.borderColor(property.get("color").toString());
		
		
		kStick.setData(list0);
		
		option.series(kStick);
		return option.toString(); 
		
	}

}
