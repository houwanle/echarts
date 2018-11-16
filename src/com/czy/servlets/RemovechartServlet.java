package com.czy.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/RemovechartServlet")
public class RemovechartServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds=CommonUtils.getInnerDataSource();
		System2dataDao s2 = new System2dataDao();
		//String chart = request.getParameter("chart");
		String id = request.getParameter("id");
		//System.out.println("chartid:"+id);
		//String[] StrArray = chart.split("_");
		//String tableName=StrArray[0];
		//String chartType=StrArray[1];
		//tableName = java.net.URLDecoder.decode(tableName , "UTF-8");
		//Map<String, String>map=new HashMap<String, String>();
		//s2.removeUser(ds, id);
		//System.out.println("removeid="+id);
		//int flag=0;//1ÎªÕýÈ·
		//System.out.println("chartType:"+chartType);
		//System.out.println("id:"+id);
		//s2.removeType(ds,chartType, id);
		s2.removeView(ds,id);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
