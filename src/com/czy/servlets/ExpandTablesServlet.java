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
import com.czy.dao.DataSourceDao;
import com.czy.utils.CommonUtils;

@WebServlet("/ExpandTablesServlet")
public class ExpandTablesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		List<List<String>> list = null;
		DataSourceDao dsd = new DataSourceDao();
		System.out.println(id);
		DataSource ds = dsd.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		String result = "";
		if("dameng".equals(ds.getType())) {
			String schema = request.getParameter("schema");
			list = dsd.get(ds, "select table_name from all_tables where owner = '" + schema + "'");
			for(int i = 1; i < list.size(); i++) {
				result = result + "<div><a href=\"javascript:openRelationSetPage('" + id + "', '" + schema + "." + list.get(i).get(0) + "', '" + schema + "')\">" + list.get(i).get(0) + "</a></div>";
			}
			
		} else {
			if("mysql".equals(ds.getType())) {//type����ΪMYSQL
				//��ø���ݿ��µ������û���
				list = dsd.get(ds, "SELECT TABLE_NAME AS tableName FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + ds.getDatabaseName() + "'");
			} else if("oracle".equals(ds.getType())) {
				//��ø���ݿ��µ������û���
				list = dsd.get(ds, "select table_name as tableName from user_tables");
			} else if("sqlserver".equals(ds.getType())){
				//��ø���ݿ��µ������û���
				list = dsd.get(ds, "SELECT Name as tableName FROM " + ds.getDatabaseName() + "..SysObjects Where XType='U'");
			}
			for(int i = 1; i < list.size(); i++) {
				result = result + "<div><a href=\"javascript:openRelationSetPage('" + id + "', '" + list.get(i).get(0) + "')\">" + list.get(i).get(0) + "</a></div>";
			}
		}
		
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
