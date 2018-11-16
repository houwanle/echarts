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

@WebServlet("/SaveDatabaseServlet")
public class SaveDatabaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ip = request.getParameter("ip");
		String port = request.getParameter("port");
		String databaseName = request.getParameter("databaseName").trim();
		String user = request.getParameter("user").trim();
		String password = request.getParameter("password").trim();
		String type = request.getParameter("type");
		String conn_name = request.getParameter("conn_name");
		conn_name = new String(conn_name.getBytes("ISO-8859-1"),"UTF-8");
		
		String result = null;
		
		//校验数据库连接是否正常
		DataSource ds = new DataSource();
		ds.setIp(ip);
		ds.setPort(port);
		ds.setDatabaseName(databaseName);
		ds.setUser(user);
		ds.setPassword(password);
		ds.setType(type);
		DbUtils db = new DbUtils();
		db.setDs(ds);
		db.getConnection();
		if(db.getConn() == null) {
			result = "无法连接到该数据源，请核对信息或与数据库管理员取得联系！";
		} else {
			db.closeConn();
			if((!"".equals(ip))
				&&(!"".equals(port))
				&&(!"".equals(databaseName))
				&&(!"".equals(user))
				&&(!"".equals(password))) {
				DataSourceDao dataSourceDao = new DataSourceDao();
				int rs = dataSourceDao.add(CommonUtils.getInnerDataSource(), ip, port, databaseName, user, password, type, conn_name);
				if(rs > 0) {
					result = "添加数据库成功！";
				} else {
					result = "数据库信息无法录入！请与维护人员取得联系！";
				}
			} else {
				result = "发生错误！请检查信息是否完整！";
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
