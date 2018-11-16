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
import com.czy.dao.BaseDao;
import com.czy.dao.DataSourceDao;
import com.czy.utils.CommonUtils;

@WebServlet("/CreateViewServlet")
public class CreateViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String param = request.getParameter("param");
		String[] params = param.split(";");
		String tableName = request.getParameter("tableName");
		BaseDao bd = new BaseDao();
		String sql = null;
		Integer limit = 100;
		
		DataSourceDao dataSourceDao = new DataSourceDao();
		DataSource externalSource = dataSourceDao.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		List<String> colNames = bd.get(externalSource, "select * from " + tableName + " limit 0").get(0);
		
		int i;
		if("mysql".equals(externalSource.getType())) {
			sql = "select ";
			for(i = 0; i < colNames.size() - 1; i++) {
				sql += tableName + "." + colNames.get(i) + ", ";
			}
			if(params.length > 0) {
				String[] col1 = params[0].split(" ");
				String[] table = params[1].split(" ");
				String[] col2 = params[2].split(" ");
				sql += tableName + "." + colNames.get(i) + ", ";
				for(i = 0; i < table.length; i++) {
					colNames = bd.get(externalSource, "select * from " + table[i] + " limit 0").get(0);
					for(int j = 0; j < colNames.size(); j++) {
						sql += table[i] + "." + colNames.get(j) + ", ";
					}
				}
				sql = sql.substring(0, sql.length() - 2);
				sql += " from " + tableName + ", ";
				for(i = 0; i < table.length - 1; i++) {
					sql += table[i] + ", ";
				}
				sql += table[i] + " where ";
				for(i = 0; i < col1.length; i++) {
					sql = sql + tableName + "." + col1[i] + "=" + table[i] + "." + col2[i];
					if(i + 1 < col1.length) {
						sql += " and ";
					}
				}
			} else {
				sql += tableName + "." + colNames.get(i) + " from " + tableName;
			}
			sql = sql + " limit 0, " + limit;
		} else if("oracle".equals(externalSource.getType())) {
			sql = "select ";
			for(i = 0; i < colNames.size() - 1; i++) {
				sql += tableName + "." + colNames.get(i) + ", ";
			}
			if(params.length > 0) {
				String[] col1 = params[0].split(" ");
				String[] table = params[1].split(" ");
				String[] col2 = params[2].split(" ");
				sql += tableName + "." + colNames.get(i) + ", ";
				for(i = 0; i < table.length; i++) {
					colNames = bd.get(externalSource, "select * from " + table[i] + " limit 0").get(0);
					for(int j = 0; j < colNames.size(); j++) {
						sql += table[i] + "." + colNames.get(j) + ", ";
					}
				}
				sql = sql.substring(0, sql.length() - 2);
				sql += " from " + tableName + ", ";
				for(i = 0; i < table.length - 1; i++) {
					sql += table[i] + ", ";
				}
				sql += table[i] + " where ";
				for(i = 0; i < col1.length; i++) {
					sql = sql + tableName + "." + col1[i] + "=" + table[i] + "." + col2[i];
					if(i + 1 < col1.length) {
						sql += " and ";
					}
				}
				sql = sql + " rownum < " + limit;
			} else {
				sql += tableName + "." + colNames.get(i) + " from " + tableName;
				sql += " where rownum < " + limit;
			}
		} else if("sqlserver".equals(externalSource.getType()) || "dameng".equals(externalSource.getType())) {
			sql = "select top " + limit + " ";
			for(i = 0; i < colNames.size() - 1; i++) {
				sql += tableName + "." + colNames.get(i) + ", ";
			}
			if(params.length > 0) {
				String[] col1 = params[0].split(" ");
				String[] table = params[1].split(" ");
				String[] col2 = params[2].split(" ");
				sql += tableName + "." + colNames.get(i) + ", ";
				for(i = 0; i < table.length; i++) {
					colNames = bd.get(externalSource, "select * from " + table[i] + " limit 0").get(0);
					for(int j = 0; j < colNames.size(); j++) {
						sql += table[i] + "." + colNames.get(j) + ", ";
					}
				}
				sql = sql.substring(0, sql.length() - 2);
				sql += " from " + tableName + ", ";
				for(i = 0; i < table.length - 1; i++) {
					sql += table[i] + ", ";
				}
				sql += table[i] + " where ";
				for(i = 0; i < col1.length; i++) {
					sql = sql + tableName + "." + col1[i] + "=" + table[i] + "." + col2[i];
					if(i + 1 < col1.length) {
						sql += " and ";
					}
				}
			} else {
				sql += tableName + "." + colNames.get(i) + " from " + tableName;
			}
		}
		System.out.println(sql);
		List<List<String>> list = bd.get(externalSource, sql);
		String result = "<table class=\"table\"><tr>";
		for(i = 0; i < list.get(0).size(); i++) {
			result = result + "<td>" + list.get(0).get(i) + "<input type=\"checkbox\" name=\"col_checkbox\" value=\"" + list.get(0).get(i) + "\" /></td>";
		}
		result += "</tr>";
		for(i = 1; i < list.size(); i++) {
			result += "<tr>";
			for(int j = 0; j < list.get(i).size(); j++) {
				result = result + "<td>" + list.get(i).get(j) + "</td>";
			}
		}
		result += "</table>";
		
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(result + ";" + sql);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
