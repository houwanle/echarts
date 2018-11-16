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
import com.czy.utils.DbUtils;

@WebServlet("/TestDatabaseServlet")
public class TestDatabaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		DataSourceDao dsd = new DataSourceDao();
		DataSource ds = dsd.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		DbUtils db = new DbUtils();
		db.setDs(ds);
		db.getConnection();
		String result = null;
		if(db.getConn() == null) {
			result = "无法连接到该数据源，请核对信息或与数据库管理员取得联系！";
		} else {
			db.closeConn();
			result = "该数据源连接正常！";
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
