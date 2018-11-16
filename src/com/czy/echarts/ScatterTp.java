package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.LineType;
import com.github.abel533.echarts.code.PointerType;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Scatter;
import com.github.abel533.echarts.style.TextStyle;

public class ScatterTp implements EchartInterface {

	private GsonOption option = new GsonOption();
	
	/**Map<String,Object> property = new HashMap<String,Object>
	 * property.put("title","title")//ͼ�����
	 * map.put("fontSize",20);//�����С
	 * map.put("fontWeight","bold");//��ϸ
	 * property.put("xmax",xmax);//x�����ֵ
	 * property.put("xmin",xmin);//x����Сֵ
	 * property.put("ymax",ymax);//y�����ֵ
	 * property.put("ymin",ymin);//y����Сֵ
	 * property.put("xUnit","km");//x�ᵥλ
	 * property.put("yUnit","h");//y�ᵥλ
	 * **/
	
	@Override
	public String getJson(Map<String, Object> property, List<List<String>> data) {
		
		List<double[]> list = new ArrayList<double[]>();
		
		double a[] = null;
		
		//��װ���
		for (int i = 1; i < data.size(); i++) {
			a = new double[2];
			a[0] = Double.parseDouble(data.get(i).get(0).toString());
			a[1] = Double.parseDouble(data.get(i).get(1).toString());
			list.add(a);
		}
		option.grid().bottom(80);
		option.backgroundColor("#ffffff");
		option.title(property.get("titleText").toString());
		
		option.tooltip().formatter("({c})").trigger(Trigger.axis).showDelay(0).
				zlevel(1).axisPointer().show(true).type(PointerType.cross)
				.lineStyle().type(LineType.dotted).width(3);

		option.toolbox().show(true).feature(Tool.mark,Tool.saveAsImage,Tool.dataView,Tool.restore);
				
		ValueAxis xvalueaxis = new ValueAxis();
		xvalueaxis.scale(true).gridIndex(0).max(property.get("xmax"))
				.min(property.get("xmin"));
		xvalueaxis.name((String) property.get("xUnit"));
		option.xAxis(xvalueaxis);

		ValueAxis yvalueaxis = new ValueAxis();
		yvalueaxis.scale(true).gridIndex(0).max(property.get("ymax"))
				.min(property.get("ymin"));
		yvalueaxis.name((String) property.get("yUnit"));
		option.yAxis(yvalueaxis);

		Scatter scatter = new Scatter();
		scatter.large(true);
		scatter.itemStyle().normal().label().show(true).textStyle(new TextStyle()
			.fontSize(Integer.parseInt(property.get("fontSize").toString()))
			.fontWeight(property.get("fontWeight")));
		
		
		scatter.setData(list);

		option.series(scatter);
		return option.toString();
		
	}

}
