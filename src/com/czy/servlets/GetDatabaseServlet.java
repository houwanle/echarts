package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.DataSourceDao;
import com.czy.utils.CommonUtils;

@WebServlet("/GetDatabaseServlet")
public class GetDatabaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		DataSourceDao dataSourceDao = new DataSourceDao();
		DataSource externalSource = dataSourceDao.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		String result = externalSource.getType() + ";" + externalSource.getIp() + ";" + externalSource.getPort() + ";" + externalSource.getDatabaseName() + ";" + externalSource.getUser() + ";" + externalSource.getPassword();
		
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write(result);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
