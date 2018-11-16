package com.czy.servlets;

import java.io.IOException;
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

import com.czy.beans.DataSource;
import com.czy.beans.Property;
import com.czy.dao.BaseDao;
import com.czy.dao.DataSourceDao;
import com.czy.dao.PropertyDao;
import com.czy.echarts.BarTp;
import com.czy.echarts.FunnelTp;
import com.czy.echarts.KlineTp;
import com.czy.echarts.LineTp;
import com.czy.echarts.PieTp;
import com.czy.echarts.ScatterTp;
import com.czy.echarts.TreemapTp;
import com.czy.utils.CommonUtils;

/**
	* Servlet implementation class TestServlet
*/
@WebServlet("/PropertyServlet")
public class PropertyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	private String newoption ;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		PropertyDao pd = new PropertyDao();
		DataSource ds= CommonUtils.getInnerDataSource();
		
		String fontSize = request.getParameter("fontSize");
		String fontWeight = request.getParameter("fontWeight");
		String theme = request.getParameter("theme");
		
		String id = request.getParameter("id");
		String location = request.getParameter("location");
		
		String chartstate = request.getParameter("chartstate");
		String chartType = request.getParameter("chartType");
		
		if(chartType.contains("line")){
			chartType = "line";
		}else if(chartType.contains("pie")){
			chartType = "pie";
		}else if(chartType.contains("scatter")){
			chartType = "scatter";
		}else if(chartType.contains("treemap")){
			chartType = "treemap";
		}else if(chartType.contains("bar")){
			chartType = "bar";
		}else if(chartType.contains("funnel")){
			chartType = "funnel";
		}else if(chartType.contains("candlestick")){
			chartType = "candlestick";
		}
		
		BaseDao bd = new BaseDao();
		List<List<String>> getSid = bd.get(CommonUtils.getInnerDataSource(), "SELECT * from screen order BY id desc");		
		String s_id = getSid.get(1).get(0);
		
		if(chartstate.equals("select")){
			// 执行查询   id???
			//"SELECT * FROM "+chartType+", chartView , dataSource WHERE "+chartType+".id = "+chartViewid+" AND "+chartType+".id = chartview.id AND chartview.ds_id = datasource.id;";
			Property pr = pd.getPropertyById(ds, id,s_id);//查询userproperty 当pr为空时赋给默认值 否则从pr中读取
			if(pr == null){
				fontWeight = "normal";
				fontSize = "20";
				theme = "['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']";
			}else{
				fontWeight = pr.getFontWeight();
				fontSize = pr.getFontSize();
				theme = pr.getTheme();
			}
			List<List<String>> temp = new BaseDao().get(ds,"SELECT * FROM "+chartType+", chartView , dataSource WHERE "+chartType+".id = "+id+" AND "+chartType+".id = chartview.id AND chartview.ds_id = datasource.id;");
			Map<String, Object> property=new HashMap<String, Object>();
			property.put("fontWeight", fontWeight);
			property.put("fontSize", fontSize);
			
			
			
			if(chartType.equals("pie")){ //饼图
				property.put("titleText",temp.get(1).get(6));
				property.put("radiusIn", temp.get(1).get(1));
				property.put("radiusOut", temp.get(1).get(2));
				property.put("position",temp.get(1).get(3));
				property.put("orient", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(8));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(7).toString());
				PieTp pie = new PieTp();
				String option = pie.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
				
			}else if(chartType.equals("line")){
				property.put("yUnit", temp.get(1).get(1));
				property.put("typeaxis", temp.get(1).get(2));
				property.put("titleText", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(6));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(5).toString());
				
				String typeaxis = temp.get(1).get(2);
				List<String> tableHead = data.get(0);
				if(!typeaxis.equals(tableHead)){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> temp2=null;
					int k=0;
					for(int i=0;i<tableHead.size();i++){
						if(typeaxis.equals(tableHead.get(i)))
							{k=i;}
					}
					for(int i=0;i<data.size();i++){	
						temp2=new ArrayList<String>();
						temp2.add(data.get(i).get(k));
						for(int j=0;j<tableHead.size();j++)
						{						
							if(j!=k){
								temp2.add(data.get(i).get(j));
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
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("scatter")){
				property.put("titleText", temp.get(1).get(8));
				property.put("xmin", temp.get(1).get(1));
				property.put("xmax", temp.get(1).get(2));
				property.put("ymin", temp.get(1).get(3));
				property.put("ymax", temp.get(1).get(4));
				property.put("xUnit", temp.get(1).get(5));
				property.put("yUnit", temp.get(1).get(6));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(10));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(9).toString());
				
				ScatterTp scatter = new ScatterTp();
				String option = scatter.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("bar")){
				property.put("titleText", temp.get(1).get(5));
				property.put("barGap", temp.get(1).get(1));
				property.put("yUnit",temp.get(1).get(2));
				property.put("typeaxis", temp.get(1).get(3));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(7));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(6).toString());
				
				String typeaxis = temp.get(1).get(2);
				List<String> tableHead = data.get(0);
				if(!typeaxis.equals(tableHead)){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> temp2=null;
					int k=0;
					for(int i=0;i<tableHead.size();i++){
						if(typeaxis.equals(tableHead.get(i)))
							{k=i;}
					}
					for(int i=0;i<data.size();i++){	
						temp2=new ArrayList<String>();
						temp2.add(data.get(i).get(k));
						for(int j=0;j<tableHead.size();j++)
						{						
							if(j!=k){
								temp2.add(data.get(i).get(j));
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
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("funnel")){
				property.put("sortValue", temp.get(1).get(1));
				property.put("minSize",temp.get(1).get(2));
				property.put("maxSize", temp.get(1).get(3));
				property.put("gap", temp.get(1).get(4));
				property.put("titleText",temp.get(1).get(6));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(8));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(7).toString());
				
				FunnelTp funnel = new FunnelTp();
				String option = funnel.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("treemap")){
				property.put("titleText", temp.get(1).get(6));
				property.put("mapDesc", temp.get(1).get(1));
				property.put("borderWidth", temp.get(1).get(2));
				property.put("borderColor",temp.get(1).get(3));
				property.put("mapHeight", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(8));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(7).toString());
				
				TreemapTp treemap = new TreemapTp();
				String option = treemap.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("candlestick")){
				property.put("color", temp.get(1).get(1));
				property.put("color0",temp.get(1).get(2));
				property.put("titleText", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(6));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(5).toString());
				
				KlineTp kline = new KlineTp();
				String option = kline.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}
			
			
			PrintWriter out = response.getWriter();
			out.println(newoption);   //服务器回应到浏览器
			out.close();
			
		} else if( chartstate.equals("update")){
			
			List<List<String>> temp = new BaseDao().get(ds,"SELECT * FROM "+chartType+", chartView , dataSource WHERE "+chartType+".id = "+id+"  AND "+chartType+".id = chartview.id AND chartview.ds_id = datasource.id;");
			//判断图表类型
			Map<String, Object> property=new HashMap<String, Object>();	
			property.put("fontWeight", fontWeight);
			property.put("fontSize", fontSize);
			
			System.out.println("select"+chartType);
			
			if(chartType.equals("pie")){ //饼图
				property.put("titleText",temp.get(1).get(6));
				property.put("radiusIn", temp.get(1).get(1));
				property.put("radiusOut", temp.get(1).get(2));
				property.put("position",temp.get(1).get(3));
				property.put("orient", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(8));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(7).toString());
				PieTp pie = new PieTp();
				String option = pie.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
				
			}else if(chartType.equals("line")){
				property.put("yUnit", temp.get(1).get(1));
				property.put("typeaxis", temp.get(1).get(2));
				property.put("titleText", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(6));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(5).toString());
				
				String typeaxis = temp.get(1).get(2);
				List<String> tableHead = data.get(0);
				if(!typeaxis.equals(tableHead)){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> temp2=null;
					int k=0;
					for(int i=0;i<tableHead.size();i++){
						if(typeaxis.equals(tableHead.get(i)))
							{k=i;}
					}
					for(int i=0;i<data.size();i++){	
						temp2=new ArrayList<String>();
						temp2.add(data.get(i).get(k));
						for(int j=0;j<tableHead.size();j++)
						{						
							if(j!=k){
								temp2.add(data.get(i).get(j));
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
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("scatter")){
				property.put("titleText", temp.get(1).get(8));
				property.put("xmin", temp.get(1).get(1));
				property.put("xmax", temp.get(1).get(2));
				property.put("ymin", temp.get(1).get(3));
				property.put("ymax", temp.get(1).get(4));
				property.put("xUnit", temp.get(1).get(5));
				property.put("yUnit", temp.get(1).get(6));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(10));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(9).toString());
				
				ScatterTp scatter = new ScatterTp();
				String option = scatter.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("bar")){
				property.put("titleText", temp.get(1).get(5));
				property.put("barGap", temp.get(1).get(1));
				property.put("yUnit",temp.get(1).get(2));
				property.put("typeaxis", temp.get(1).get(3));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(7));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(6).toString());
				
				String typeaxis = temp.get(1).get(2);
				List<String> tableHead = data.get(0);
				if(!typeaxis.equals(tableHead)){
					List<List<String>> data1=new ArrayList<List<String>>();
					List<String> temp2=null;
					int k=0;
					for(int i=0;i<tableHead.size();i++){
						if(typeaxis.equals(tableHead.get(i)))
							{k=i;}
					}
					for(int i=0;i<data.size();i++){	
						temp2=new ArrayList<String>();
						temp2.add(data.get(i).get(k));
						for(int j=0;j<tableHead.size();j++)
						{						
							if(j!=k){
								temp2.add(data.get(i).get(j));
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
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("funnel")){
				property.put("sortValue", temp.get(1).get(1));
				property.put("minSize",temp.get(1).get(2));
				property.put("maxSize", temp.get(1).get(3));
				property.put("gap", temp.get(1).get(4));
				property.put("titleText",temp.get(1).get(6));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(8));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(7).toString());
				
				FunnelTp funnel = new FunnelTp();
				String option = funnel.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("treemap")){
				property.put("titleText", temp.get(1).get(6));
				property.put("mapDesc", temp.get(1).get(1));
				property.put("borderWidth", temp.get(1).get(2));
				property.put("borderColor",temp.get(1).get(3));
				property.put("mapHeight", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(8));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(7).toString());
				
				TreemapTp treemap = new TreemapTp();
				String option = treemap.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}else if(chartType.equals("candlestick")){
				property.put("color", temp.get(1).get(1));
				property.put("color0",temp.get(1).get(2));
				property.put("titleText", temp.get(1).get(4));
				
				DataSource targetDs = new DataSourceDao().getDataSourceById(ds,temp.get(1).get(6));//获取数据源
				List<List<String>> data = new BaseDao().get(targetDs,temp.get(1).get(5).toString());
				
				KlineTp kline = new KlineTp();
				String option = kline.getJson(property, data);
				StringBuilder  sb = new StringBuilder (option);
				sb.insert(1, "color:"+theme+",");
				newoption = sb.toString();
			}
			
			
			PrintWriter out = response.getWriter();
			out.println(newoption);   //服务器回应到浏览器
			out.close();
			
		}else if(chartstate.equals("insert")){
			
			Property pr = pd.getPropertyByLocation(ds,id,s_id,location);//查询userproperty 当pr为空时赋给默认值 否则从pr中读取
			int rs = 0;
			if(pr == null){
				System.out.println(theme);
				rs = pd.addPropertyById(ds, fontSize, fontWeight, theme.replace("'", "''"), location, s_id, id);
			}else{
				rs = pd.updatePropertyById(ds, fontSize, fontWeight, theme.replace("'", "''"), location, s_id, id);
			}
			//System.out.println(pr+"insert");
			PrintWriter out = response.getWriter();
			out.println(rs);   //服务器回应到浏览器
			out.close();
			
			
		}
	    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}