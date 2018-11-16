package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/TypeaxisServlet")
public class TypeaxisServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.setHeader("content-type", "text/html;charset=UTF-8");  
		response.setCharacterEncoding("UTF-8");  
		//request.setCharacterEncoding("UTF-8");  
		DataSource ds =CommonUtils.getInnerDataSource();
		
		String tableName = request.getParameter("tableName");
		tableName = java.net.URLDecoder.decode(tableName , "UTF-8");
		String id = request.getParameter("id");
		
		String type = request.getParameter("type");
		System2dataDao s2=new System2dataDao();
		String sql=s2.getSql(ds, tableName);
		//System.out.println("tableName="+tableName);
		List<List<String>> dsInfo = s2.get(ds, "SELECT t1.id, t1.ip, t1.port, t1.`databaseName`, t1.user, t1.`password`, t1.type FROM datasource t1, chartview t2 WHERE t1.id = t2.`ds_id` AND t2.name = '" + tableName + "'");
		ds.setId(dsInfo.get(1).get(0));
		ds.setIp(dsInfo.get(1).get(1));
		ds.setPort(dsInfo.get(1).get(2));
		ds.setDatabaseName(dsInfo.get(1).get(3));
		ds.setUser(dsInfo.get(1).get(4));
		ds.setPassword(dsInfo.get(1).get(5));
		ds.setType(dsInfo.get(1).get(6));
		String option="";
		List<List<String>> data2=s2.obtainData(ds,sql);
		
		List<String> tableHead=new ArrayList<String>();
		
		for(int i=0;i<data2.get(0).size();i++)
		{		
			tableHead.add(data2.get(0).get(i).toString());
			}
		
		
		if(type.equals("bar")||type.equals("line")){
		String axis="";
		if(Integer.parseInt(id)>0){
			axis = s2.getAxis(CommonUtils.getInnerDataSource(), id);
		}
		
		axis = java.net.URLDecoder.decode(axis , "UTF-8");
		option="<div id=\"categoryaxis\"  style=\"float:left;display: inline;\" ><p>类轴</p><div  class=\"styled-select\"><select id=\"typeaxis1\"  onchange=\"btn_click(1)\" name=\"typeaxis1\">";
		if(axis!=""){
			for(int i=0;i<tableHead.size();i++){
				
				if(tableHead.get(i).equals(axis)){
					option=option+"<option name=\"optionaxis\" value=\""+tableHead.get(i)+"\" selected=\"selected\">"+tableHead.get(i)+"</option>";

				}
				else
					option=option+"<option name=\"optionaxis\" value=\""+tableHead.get(i)+"\">"+tableHead.get(i)+"</option>";
			}
		}
		else
		{
			//option=option+"<option name=\"optionaxis\" value=\""+tableHead.get(0)+"\"selected=\"selected\">"+tableHead.get(0)+"</option>";
			for(int i=0;i<tableHead.size();i++){
				
				option=option+"<option name=\"optionaxis\" value=\""+tableHead.get(i)+"\">"+tableHead.get(i)+"</option>";
			}
		}
		option=option+"</select><br/> </div></div></br>";
		}
		 if(type.equals("radar")){
			 if(id==""||id.equals("0")){
			option="<div id=\"radarmaxdata\" style=\"float:left;display: inline;\" > ";
			for(int i=1;i<tableHead.size();i++){
					option=option+"<p>"+tableHead.get(i)+"</p><input type=\"text\" class=\"system2_text\" id=\"radar_"+i+"\"  name=\"radarmax\" oninput=\"btn_click(1)\" value=\""+s2.getMax(ds, tableHead.get(i), tableName)+"\">";
			}
			option=option+"</div>";
			}
			 else {
				
				 String max = s2.getProperties(CommonUtils.getInnerDataSource(), id, "radar","max");
				 String []radarmax = max.split(" ");
				
				 option="<div id=\"radarmaxdata\" style=\"float:left;display: inline;\" > ";
					for(int i=1;i<tableHead.size();i++){
							option=option+"<p>"+tableHead.get(i)+"</p><input type=\"text\" class=\"system2_text\" id=\"radar_"+i+"\"  name=\"radarmax\" oninput=\"btn_click(1)\" value=\""+ radarmax[i-1]+"\">";
							 
					}
					option=option+"</div>";
			 }
		}
		PrintWriter out = response.getWriter();
		out.println(option);
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
