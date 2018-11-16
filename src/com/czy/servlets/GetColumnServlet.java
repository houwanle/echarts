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

@WebServlet("/GetColumnServlet")
public class GetColumnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String tableName = request.getParameter("tableName");
		if("".equals(tableName)) {
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			out.println();
			out.close();
		}
		//获得第三方数据源
		DataSourceDao dataSourceDao = new DataSourceDao();
		DataSource externalSource = dataSourceDao.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		//获取该表的所有字段
		List<List<String>> column_name = null;
		column_name = dataSourceDao.get(externalSource, "select * from " + tableName);
//		if("mysql".equals(externalSource.getType())) {
//		} else if("oracle".equals(externalSource.getType())) {
//		} else if("sqlserver".equals(externalSource.getType())) {
//		}
		String result = "";
		for(int i = 0; i < column_name.get(0).size(); i++) {
			result = result + column_name.get(0).get(i);
			if(i + 1 < column_name.get(0).size()) {
				result += ";";
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
