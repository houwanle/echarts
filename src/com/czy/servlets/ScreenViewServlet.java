package com.czy.servlets;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JFileChooser;

import com.czy.beans.DataSource;
import com.czy.beans.Screen;
import com.czy.dao.BaseDao;
import com.czy.dao.DataSourceDao;
import com.czy.dao.ScreenDao;
import com.czy.echarts.BarTp;
import com.czy.echarts.FunnelTp;
import com.czy.echarts.HeatmapTp;
import com.czy.echarts.BaidumapTp;
import com.czy.echarts.KlineTp;
import com.czy.echarts.LineTp;
import com.czy.echarts.PieTp;
import com.czy.echarts.RadarTp;
import com.czy.echarts.ScatterTp;
import com.czy.echarts.TreemapTp;
import com.czy.utils.CommonUtils;

@WebServlet("/ScreenViewServlet")
public class ScreenViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String newoption;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String s_id = request.getParameter("s_id");
		BaseDao bd = new BaseDao();
		DataSource ds = CommonUtils.getInnerDataSource();
		
		ScreenDao sd= new ScreenDao();
		Screen screen = new Screen();
		screen = sd.getScreenById(ds, s_id);
		
		String x = screen.getX(); //x
		String y = screen.getY();//y
		String name = screen.getName();//���
		
		List<List<String>> propertymap = bd.get(ds, "select * from userproperty where s_id = "+s_id+"");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		//System.out.println(s_id+"\n"+propertymap);
		
		for(int i=1;i<propertymap.size();i++){
			Map<String, Object> map = new HashMap<String,Object>();
			String vt_id =  propertymap.get(i).get(6);
			
			List<List<String>> chartType = bd.get(ds, "select * from view_type where id = "+vt_id+";");
			String type = chartType.get(1).get(1);
			if(type.equals("baidu")){
				type="heatbaidu";
			}
			//System.out.println(i+type);
			List<List<String>> temp = new BaseDao().get(ds,"SELECT * FROM "+type+" t1 , view_type t2, chartview t3 WHERE t1.id = "+vt_id+" AND t1.id = t2.id AND t2.v_id = t3.id");
			
			//System.out.println("SELECT * FROM "+type+" t1 , view_type t2, chartview t3 WHERE t1.id = "+vt_id+" AND t1.id = t2.id AND t2.v_id = t3.id");
			Map<String, Object> property=new HashMap<String, Object>();	
			property.put("fontWeight", propertymap.get(i).get(2));
			property.put("fontSize", propertymap.get(i).get(1));
			
			if(type.equals("pie")){
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(11));
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(10).toString());
				
				property.put("titleText",temp.get(1).get(9));
				property.put("radiusIn", temp.get(1).get(1));
				property.put("radiusOut", temp.get(1).get(2));
				property.put("position",temp.get(1).get(3));
				property.put("orient", temp.get(1).get(4));
				
				PieTp pie = new PieTp();
				String option = pie.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				
				
			}else if(type.equals("line")){
				property.put("yUnit", temp.get(1).get(1));
				property.put("typeaxis", temp.get(1).get(2));
				property.put("titleText", temp.get(1).get(7));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(9));//��ȡ���Դ
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(8).toString());
				
				String typeaxis = temp.get(1).get(2);
				List<String> tableHead = data.get(0);
				if(!typeaxis.equals(tableHead)){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> temp2=null;
					int k=0;
					for(int m=0;m<tableHead.size();m++){
						if(typeaxis.equals(tableHead.get(m)))
							{k=m;}
					}
					for(int m=0;m<data.size();m++){	
						temp2=new ArrayList<String>();
						temp2.add(data.get(m).get(k));
						for(int n=0;n<tableHead.size();n++)
						{						
							if(n!=k){
								temp2.add(data.get(m).get(n));
							}
						}
						data1.add(temp2);	
					}	
					data.clear();				
					data=data1;
				}
				
				LineTp pie = new LineTp();
				String option = pie.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				

				
			}else if(type.equals("scatter")){
				property.put("titleText", temp.get(1).get(11));
				//System.out.println("temp:"+temp);
				property.put("xUnit", temp.get(1).get(5));
				property.put("yUnit", temp.get(1).get(6));
				
				String xmax = temp.get(1).get(2);
				String xmin = temp.get(1).get(1);
				String ymax = temp.get(1).get(4);
				String ymin = temp.get(1).get(3);
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(13));//��ȡ���Դ
				
				//System.out.println(temp);
				
				String stmt=temp.get(1).get(12).toString();
				List<List<String>> data = bd.get(targetDs, stmt);
				
				double xmax1=Double.parseDouble(data.get(1).get(0)),xmin1=Double.parseDouble(data.get(1).get(0)),ymax1=Double.parseDouble(data.get(1).get(1)),ymin1=Double.parseDouble(data.get(1).get(1));
				
			//	System.out.println(data);
				
				for(int j=1;j<data.size();j++){
					if(Double.parseDouble(data.get(j).get(0))>xmax1)xmax1=Double.parseDouble(data.get(j).get(0));
					if(Double.parseDouble(data.get(j).get(0))<xmin1)xmin1=Double.parseDouble(data.get(j).get(0));
					if(Double.parseDouble(data.get(j).get(1))<ymin1)ymin1=Double.parseDouble(data.get(j).get(1));
					if(Double.parseDouble(data.get(j).get(1))>ymax1)ymax1=Double.parseDouble(data.get(j).get(1));
				}
				xmax=String.valueOf(xmax1*Integer.parseInt(xmax)/100);
				xmin=String.valueOf(xmin1*Integer.parseInt(xmin)/100);
				ymax=String.valueOf(ymax1*Integer.parseInt(ymax)/100);
				ymin=String.valueOf(ymin1*Integer.parseInt(ymin)/100);
				
				property.put("xmin", xmin);
				property.put("xmax", xmax);
				property.put("ymin", ymin);
				property.put("ymax", ymax);
				ScatterTp scatter = new ScatterTp();
				String option = scatter.getJson(property,data);
				StringBuilder  sb = new StringBuilder (option);
				
				//System.out.println(xmin+" "+xmax+" "+ymin+" "+ymax);
				
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();


			}else if(type.equals("bar")){
				property.put("titleText", temp.get(1).get(8));
				property.put("barGap", temp.get(1).get(1)+"%");
				property.put("yUnit",temp.get(1).get(2));
				property.put("typeaxis", temp.get(1).get(3));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(10));//��ȡ���Դ
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(9).toString());
				
				String typeaxis = temp.get(1).get(2);
				List<String> tableHead = data.get(0);
				if(!typeaxis.equals(tableHead)){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> temp2=null;
					int k=0;
					for(int m=0;m<tableHead.size();m++){
						if(typeaxis.equals(tableHead.get(m)))
							{k=m;}
					}
					for(int m=0;m<data.size();m++){	
						temp2=new ArrayList<String>();
						temp2.add(data.get(m).get(k));
						for(int n=0;n<tableHead.size();n++)
						{						
							if(n!=k){
								temp2.add(data.get(m).get(n));
							}
						}
						data1.add(temp2);	
					}	
					data.clear();				
					data=data1;
				}

				
				BarTp bar = new BarTp();
				String option = bar.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				

			}else if(type.equals("funnel")){
				property.put("sortValue", temp.get(1).get(1));
				property.put("minSize",temp.get(1).get(2)+"%");
				property.put("maxSize", temp.get(1).get(3)+"%");
				property.put("gap", temp.get(1).get(4));
				property.put("titleText",temp.get(1).get(9));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(11));//��ȡ���Դ
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(10).toString());
				
				FunnelTp funnel = new FunnelTp();
				String option = funnel.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				

			}else if(type.equals("treemap")){
				property.put("titleText", temp.get(1).get(9));
				property.put("mapDesc", temp.get(1).get(1));
				property.put("borderWidth", temp.get(1).get(2));
				property.put("borderColor",temp.get(1).get(3));
				property.put("mapHeight", temp.get(1).get(4)+"%");
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(11));//��ȡ���Դ
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(10).toString());
				
				TreemapTp treemap = new TreemapTp();
				String option = treemap.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				
			}else if(type.equals("candlestick")){
				property.put("color", temp.get(1).get(1));
				property.put("color0",temp.get(1).get(2));
				property.put("titleText", temp.get(1).get(7));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(9));//��ȡ���Դ
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(8).toString());
				
				KlineTp kline = new KlineTp();
				String option = kline.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				

			}else if(type.equals("heatmap")){
				property.put("titleText",temp.get(1).get(7));
				property.put("subText","");
				property.put("background","#dfdfdf");
				property.put("max",temp.get(1).get(1));
				property.put("min",temp.get(1).get(2));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds, temp.get(1).get(9));
				List<List<String>> data = new BaseDao().get(targetDs, temp.get(1).get(8));
				
				HeatmapTp heatmap = new HeatmapTp();
				String option = heatmap.getJson(property, data);
				StringBuilder sb = new StringBuilder(option);
				sb.insert(1, "color:"+propertymap.get(i).get(3)+",");
				newoption = sb.toString();
				//System.out.println("heatmap:"+newoption);
			}else if(type.equals("heatbaidu")){
				//System.out.println("查看："+temp);
				property.put("radius",temp.get(1).get(1));
				property.put("maxNum",temp.get(1).get(2));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds, temp.get(1).get(9));
				
				List<List<String>> data = new BaseDao().get(targetDs, temp.get(1).get(8));
				
				BaidumapTp heatmap = new BaidumapTp();
				newoption = heatmap.getJson(property, data);
				
			} if("map".equals(type)){
				//[[id, mapmin, mapmax, v_id, type_name, id, id, name, stmt, ds_id],
				///System.out.println(temp);
								
				String stmt = temp.get(1).get(8);
				String mapmin = temp.get(1).get(1);
				String mapmax = temp.get(1).get(2);
				newoption = "{backgroundColor:\"#ffffff\",title: {text: '"+temp.get(1).get(7)+"',subtext: '纯属虚构',left: 'center'},tooltip: {trigger: 'item'},legend: {orient: 'vertical',left: 'left',data:[";
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(9));//��ȡ���Դ
				List<List<String>> data = bd.get(targetDs, temp.get(1).get(8));
				if(data.get(1).get(0).matches("[0-9]+")){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> tmp=null;
					int k=0;
					for(int i1=0;i1<data.get(0).size();i1++){
						if(!data.get(1).get(i1).matches("[0-9]+")){k=i1;}
					}
					for(int i1=0;i1<data.size();i1++){	
						tmp=new ArrayList<String>();
						tmp.add(data.get(i1).get(k));
						for(int j=0;j<data.get(0).size();j++)
						{						
							if(j!=k){
								tmp.add(data.get(i1).get(j));
							}
						}
						data1.add(tmp);
			
					}
				
					data.clear();				
					data=data1;
					//System.out.println("data="+data);
				}
//				System.out.println("data"+data);
//				System.out.println(mapmax);
				double mapmax1=Double.parseDouble(data.get(1).get(1));
				double mapmin1=Double.parseDouble(data.get(1).get(1));
				for(int m=1;m<data.get(0).size();m++){
					for(int n=1;n<data.size();n++){
						if(Double.parseDouble(data.get(n).get(m))>mapmax1)mapmax1=Double.parseDouble(data.get(n).get(m));
						if(Double.parseDouble(data.get(n).get(m))<mapmin1)mapmin1=Double.parseDouble(data.get(n).get(m));
					}
				}
				
				mapmax=String.valueOf(mapmax1*Integer.parseInt(mapmax)/100);
				mapmin=String.valueOf(mapmin1*Integer.parseInt(mapmin)/100);
				//System.out.println("mapmax:"+mapmax+"mapmin:"+mapmin);
				//[[id, mapmin, mapmax, v_id, type_name, id, id, name, stmt, ds_id],
				
				for(int m=1;m<data.get(0).size();m++){
					if(m!=data.get(0).size()-1)
						newoption = newoption+"'"+data.get(0).get(m)+"',";
					else
						newoption = newoption+"'"+data.get(0).get(m)+"'";
				}
				//System.out.println("data:"+data);
				newoption = newoption +"]},visualMap: {min: "+mapmin+",max:"+mapmax+",left: 'left',top: 'bottom',text: ['高','低'], calculable: true}, toolbox: {show: true,orient: 'vertical',left: 'right',top: 'center',feature: {dataView: {readOnly: false}, restore: {},saveAsImage: {}} },series: [";
				for(int k=1;k<data.get(0).size();k++){
					newoption = newoption + "{name:";
					newoption = newoption + "'" + data.get(0).get(k) + "',";
					newoption = newoption + " type: 'map',mapType: '湖北',roam: false, label: {normal: { show: true}, emphasis: {show: true}},data:[";
					for(int m=1;m<data.size();m++){
						if(m!=data.size()-1)
							newoption = newoption + " {name: '"+data.get(m).get(0)+"',value: "+data.get(m).get(k)+" },";
						else{
							newoption = newoption + " {name: '"+data.get(m).get(0)+"',value: "+data.get(m).get(k)+" }";
						}
					}
					if(k!=data.get(0).size()-1)newoption = newoption + "]},";
					else newoption = newoption + "]}";
			    }
				newoption = newoption + "]}";
				
			}else if("radar".equals(type)) {
				System.out.println("radar:"+temp);
				property.put("max", temp.get(1).get(1));
				property.put("titleText", temp.get(1).get(6));
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds, temp.get(1).get(8));
				
				List<List<String>> data = new BaseDao().get(targetDs, temp.get(1).get(7));
				RadarTp rt = new RadarTp();
				newoption = rt.getJson(property, data);
				//System.out.println(newoption);
			}
			
			map.put("option", newoption);
			map.put("type", type);
			map.put("location",propertymap.get(i).get(4));
			list.add(map);
			
		}
		
		StringBuilder sb = new StringBuilder();
		//
		//
		//"document.getElementById(\"yynDiv\").style.padding=\"0 1% 0 1.5%\";"+
		sb.append(
		"document.getElementById(\"yynDiv\").innerHTML=\"\";"+
		"document.getElementById(\"right_bottom\").style.background=\"transparent\";"+
		"for(var i = 0;i< "+x+"*"+y+";i++){"+
			"var oDiv = document.createElement('div');"+
			"oDiv.style.background=\"#ffffff\";"+
			"var xn =98/"+y+";"+
			"var yn =98/"+x+";"+
			"oDiv.id= 'location'+i;"+
			"oDiv.style.width= ''+xn+'%';"+
			"oDiv.style.height= ''+yn+'%';"+
			"oDiv.style.border = '1px solid #000';oDiv.style.margin = '1px';"+
			"oDiv.style.float = 'left';"+
	    	"document.getElementById('yynDiv').appendChild(oDiv);"+
	   	"}\n");
		
		
		for (Map<String, Object> m : list) {
			String i=m.get("location").toString();
			String location = "location"+m.get("location").toString();
			String option = m.get("option").toString();
			String type = m.get("type").toString();
			//System.out.println(location);
			if(type.equals("heatbaidu")){
				
				sb.append("var Div = document.createElement('div');"+
				"Div.id='container"+i+"';"+
				"var location = 'container"+i+"';"+
				"Div.style.width=\"99%\";"+
				"Div.style.height=\"99%\";"+
				"(document.getElementById('"+location+"')).appendChild(Div);"+
				""+option+"\n");
				
			}else{
				sb.append("var myChart = echarts.init(document.getElementById('"+location+"'));"+
				"myChart.setOption("+option+");\n");
			}
		}
		response.setContentType("text/html;charset=utf-8");
		
		String importJs = request.getParameter("import");
		//System.out.println(sb.toString());
		if(importJs == null){
			PrintWriter out = response.getWriter();
			out.println(sb.toString()); 
			out.close();
		}else{
			
			String s = "document.getElementById(\"right_bottom\").style.background=\"transparent\";";

			//String s1 = s.replace（‘a’，‘1’）；
			String fileName=""+name+".html";
			
			String html = "<html>\n"+
					"<head>\n"+
					"<title>"+fileName+"</title>\n"+
					"<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=utf-8\">\n"+
					"<script src=\"echarts.js\"></script><!--导入echarts.js包-->\n"+
					"<script src=\"hubei.js\"></script><!--导入hubei.js包-->\n"+
					"<script type='text/javascript' src=\"http://libs.useso.com/js/jquery/2.1.1/jquery.min.js\"></script>\n"+
					"<script type=\"text/javascript\" src=\"http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM\"></script>\n"+
					"<script type=\"text/javascript\" src=\"http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js\"></script>\n"+
					"</head>\n"+
					"<body>\n"+
					"<div id=\"right_bottom\"></div>\n"+
					"<div id=\"yynDiv\" style=\"widht:100%;height:100%;margin:auto;\"></div>\n"+
					"</body>\n"+
					"<script>"+sb.toString()+"</script>\n"+
					"</html>\n";
				//html.replace("document.getElementById(\"right_bottom\").style.background=\"transparent\";","");
			
			/**生成文件**/
			String path = this.getServletContext().getRealPath("");
			File f= new File(path);
			System.out.println(path);
			File file = new File(f,fileName);
			
				try {
					file.createNewFile();
					try{
						FileWriter fw = new FileWriter(file,true);
						BufferedWriter write = new BufferedWriter(fw);
						write.write(html);
						write.flush();
						write.close();
						fw.close();
						System.out.println("create file");
					}catch(IOException e){
						e.printStackTrace();
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
						e.printStackTrace();
				}
			
			/**下载**/
	        response.setContentType(getServletContext().getMimeType(fileName));  
	        //设置Content-Disposition  
	        response.setHeader("Content-Disposition", "attachment;filename="+fileName);  
	        //读取目标文件，通过response将目标文件写到客户端  
	        //获取目标文件的绝对路径  
	        String fullFileName = getServletContext().getRealPath("/" + fileName);  
	        //System.out.println(fullFileName);  
	        //读取文件  
	        InputStream in = new FileInputStream(fullFileName);  
	        OutputStream out = response.getOutputStream();  
	          
	        //写文件  
	        int b;  
	        while((b=in.read())!= -1)  
	        {  
	            out.write(b);  
	        }  
	        in.close();  
	        out.close();  
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doGet(request, response);
	}
}
