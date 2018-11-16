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

@WebServlet("/ExpandDatabaseServlet")
public class ExpandDatabaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSourceDao dataSourceDao = new DataSourceDao();
		String type = request.getParameter("type");
		String result = "";
		List<DataSource> dsList = dataSourceDao.getDataSourceByType(CommonUtils.getInnerDataSource(), type);
		if("dameng".equals(type)) {
			for(int i = 1; i < dsList.size(); i++) {
				result = result + "<div><img id=\"img_" + dsList.get(i).getId() + "\" src=\"img/expand.png\" onclick=\"loadSchemas('" + dsList.get(i).getId() + "')\"/>" + dsList.get(i).getConn_name() + "<div id=\"db_" + dsList.get(i).getId() + "\" style=\"margin-left:10%;display:none\"></div></div>";
			}
		} else {
			for(int i = 1; i < dsList.size(); i++) {
				result = result + "<div><img id=\"img_" + dsList.get(i).getId() + "\" src=\"img/expand.png\" onclick=\"loadTables('" + dsList.get(i).getId() + "')\"/>" + dsList.get(i).getConn_name() + "<div id=\"db_" + dsList.get(i).getId() + "\" style=\"margin-left:10%;display:none\"></div></div>";
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
