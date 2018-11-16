package com.czy.echarts;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.github.abel533.echarts.code.Orient;
import com.github.abel533.echarts.code.Position;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.code.X;
import com.github.abel533.echarts.data.Data;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Pie;

public class PieTp implements EchartInterface {
	
	private GsonOption option = new GsonOption();
	
	/**Map<String,Object> property = new HashMap<String,Object>;
	 * map.put("title","title");//ͼ�����
	 * map.put("orient","vertical");//ͼ����
	 * map.put("position","left");//ͼ��λ��
	 * map.put("radiusIn","30%");//�ڰ뾶
	 * map.put("radiusOut","70%");//��뾶
	 * map.put("fontSize",20);//�����С
	 * map.put("fontWeight","bold");//�����ϸ normal bold bolder lighter
	 * */

	@Override
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
		List<Data> list0 = new ArrayList<Data>();
		List<Data> list1 = new ArrayList<Data>();
		
		// ��װ���
		for (int i = 1; i < data.size(); i++) {

			list0.add(new Data(data.get(i).get(0).toString()));
			list1.add(new Data(data.get(i).get(0).toString(), data
					.get(i).get(1)));

		}
		option.backgroundColor("#ffffff");
		option.title((String) property.get("titleText"));
		option.title().bottom(10);
		
		option.tooltip().trigger(Trigger.item)
				.formatter("{a} <br/>{b}: {c} ({d}%)");
		
		option.toolbox().show(true).feature(Tool.mark,Tool.saveAsImage,Tool.dataView,Tool.restore);
		
		option.legend().orient(Orient.valueOf((String) property.get("orient")))
				.x(X.valueOf((String) property.get("position")));
		option.legend().setData(list0);

		Pie pie = new Pie();
		pie.name("DataForm")
				.radius(property.get("radiusIn"), property.get("radiusOut"))
				.label().normal().show(false).position(Position.left);
		
		pie.itemStyle().normal().opacity(0.7);
		
		pie.label().emphasis().show(true).textStyle().fontSize(Integer.parseInt(property.get("fontSize").toString()))
				.fontWeight(property.get("fontWeight"));
		pie.setData(list1);
		option.series(pie);
		//System.out.println(option);
		return option.toString();
	}

}
