package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/System2Servlet")
public class System2Servlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		DataSource ds=CommonUtils.getInnerDataSource();
		System2dataDao s2=new System2dataDao();
		List<List<String>> tableList = s2.getName(ds);
		String type = request.getParameter("type");
		String reply="<h4>请选择表</h4><div id=\""+type+"Db\" style=\"margin-left: 5%; \">";
		//request.setAttribute("tableList", tableList);	
		//request.getRequestDispatcher("System2.jsp").forward(request,response);
		//request.getRequestDispatcher("index.jsp").forward(request,response);
		
		if(type.equals("bar")||type.equals("line")||type.equals("radar")){
			for (int i = 1; i < tableList.size(); i++) {
				reply=reply+"<div id="+type+"_"+i+"style=\"font-size: 20px; margin-left: 5%;\">";
				//reply=reply+"<a href=\"#\" onclick=\"loadtype('"+tableList.get(i).get(0)+"',0,'"+type+"');\">"+tableList.get(i).get(0)+"</a>";
				reply=reply+"<a href=\"#\" onclick=\"btn_click('"+tableList.get(i).get(0)+"_"+type+"');\">"+tableList.get(i).get(0)+"</a>";
				reply=reply+"</div>";
			}
		}
		else{
			for (int i = 1; i < tableList.size(); i++) {
				reply=reply+"<div id="+type+"_"+i+"style=\"font-size: 20px; margin-left: 5%;\">";
				reply=reply+"<a href=\"#\" onclick=\"assignmentview('"+tableList.get(i).get(0)+"',0,'"+type+"');\">"+tableList.get(i).get(0)+"</a>";
				reply=reply+"</div>";
			}
			
		}
		reply=reply+"</div>";
		//System.out.println(reply);
		PrintWriter out = response.getWriter();
		out.println(reply);
		out.close();
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				doGet(request, response);
	}
}
