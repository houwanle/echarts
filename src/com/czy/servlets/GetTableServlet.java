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

@WebServlet("/GetTableServlet")
public class GetTableServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String tableName = request.getParameter("tableName");

		DataSourceDao dataSourceDao = new DataSourceDao();
		DataSource externalSource = dataSourceDao.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		String schema = "";
		List<List<String>> tableList = null;
		List<List<String>> info = null;
		Integer limit = 100;
		if("mysql".equals(externalSource.getType())) {
			tableList = dataSourceDao.get(externalSource, "SELECT TABLE_NAME AS tableName FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + externalSource.getDatabaseName() + "'");

			info = dataSourceDao.get(externalSource, "select * from " + tableName + " limit 0, " + limit);
		} else if("oracle".equals(externalSource.getType())) {
			tableList = dataSourceDao.get(externalSource, "select table_name as tableName from user_tables");

			info = dataSourceDao.get(externalSource, "select * from " + tableName + " where rownum < " + limit);
		} else if("sqlserver".equals(externalSource.getType())) {
			tableList = dataSourceDao.get(externalSource, "SELECT Name as tableName FROM " + externalSource.getDatabaseName() + "..SysObjects Where XType='U'");

			info = dataSourceDao.get(externalSource, "select top " + limit + " * from " + tableName);
		} else if("dameng".equals(externalSource.getType())) {
			
			schema = tableName.split("\\.")[1];
			
			tableList = dataSourceDao.get(externalSource, "select table_name from all_tables where owner = '" + schema + "'");

			info = dataSourceDao.get(externalSource, "select top " + limit + " * from " + tableName);
		}
		
		
		String result = "<table class=\"table table-bordered\">";
		for(int i = 0; i < info.size(); i++) {
			result += "<tr>";
			for(int j = 0; j < info.get(i).size(); j++) {
				result = result + "<td>" + info.get(i).get(j) + "</td>";
			}
		}
		result += "</table>";
		
		String s = "<table id=\"relationTable\" border=\"1px\" border-color=\"#bdbdbd\" style=\"width:100%;height:100%;\">"
				+ "<tr><td width=\"150\"><span style=\"font-size:16px;font-weight:bold\">列名</span></td>"
				+ "<td width=\"150\"><span style=\"font-size:16px;font-weight:bold\">引用表</span></td>"
				+ "<td width=\"150\"><span style=\"font-size:16px;font-weight:bold\">引用列</span></td>"
				+ "<td width=\"40\"><span style=\"font-size:16px;font-weight:bold\">操作</span></td></tr>";

		s += "<tr>";
		s += "<td><select id=\"coltd\">";
		for(int i = 0; i < info.get(0).size(); i++) {
			s = s + "<option value=\"" + info.get(0).get(i) + "\">" + info.get(0).get(i) + "</option>";
		}
		s += "</select></td>";
		s += "<td><select id=\"tabletd\" onclick=\"loadColumns()\">";
		for(int i = 1; i < tableList.size(); i++) {
			if(!tableName.equals(tableList.get(i).get(0))) {
				if(!"".equals(schema)) {
					s = s + "<option value=\"" + schema + "." + tableList.get(i).get(0) + "\">" + tableList.get(i).get(0) + "</option>";
				} else {
					s = s + "<option value=\"" + tableList.get(i).get(0) + "\">" + tableList.get(i).get(0) + "</option>";
				}
			}
		}
		s += "</select></td>";
		s += "<td><select id=\"refcoltd\"></select></td>";
		s += "<td><a href=\"javascript:add()\">增加</a></td></tr></table>";
		result = result + "|" + s;
		
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
