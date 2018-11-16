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

/**
 * Servlet implementation class ExecuteSqlServlet
 */
@WebServlet("/ExecuteSqlServlet")
public class ExecuteSqlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("hiddenid");
		String sql = request.getParameter("hiddensql");
		DataSourceDao dsd = new DataSourceDao();
		List<List<String>> list = dsd.get(CommonUtils.getInnerDataSource(), "SELECT NAME, stmt, t2.id, ip, PORT, databaseName, TYPE FROM chartview t1, datasource t2 WHERE t1.ds_id=t2.id and t1.id = " + id);
		DataSource ds = dsd.getDataSourceById(CommonUtils.getInnerDataSource(), list.get(1).get(2));
		List<List<String>> view = dsd.get(ds, sql);
		String res = "<table class=\"table\">";
		for(int i = 0; i < view.size(); i++) {
			res += "<tr>";
			for(int j = 0; j < view.get(0).size(); j++) {
				res += "<td>" + view.get(i).get(j) + "</td>";
			}
			res += "</tr>";
		}
		res += "</table>";
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(list.get(1).get(1) + "|" + id + "|" + list.get(1).get(0) + "|" + res);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
