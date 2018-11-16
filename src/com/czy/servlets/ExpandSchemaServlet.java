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

@WebServlet("/ExpandSchemaServlet")
public class ExpandSchemaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		List<List<String>> list = null;
		DataSourceDao dsd = new DataSourceDao();
		DataSource ds = dsd.getDataSourceById(CommonUtils.getInnerDataSource(), id);
		list = dsd.get(ds, "select distinct object_name TABLE_SCHEMA from all_objects where object_type = 'SCH'");
		String result = "";
		//���html
		for(int i = 1; i < list.size(); i++) {
			result = result + "<div><img id=\"img"+i+"_" + id + "\" src=\"img/expand.png\" onclick=\"loadTables1('" + i+"_"+id + "', '" + list.get(i).get(0) + "')\"/>" + list.get(i).get(0) + "<div id=\"sh_" +i+"_"+id + "\" style=\"margin-left:10%;display:none\"></div></div>";
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
