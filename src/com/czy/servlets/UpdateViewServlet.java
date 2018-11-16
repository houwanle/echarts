package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.dao.ChartViewDao;
import com.czy.utils.CommonUtils;

@WebServlet("/UpdateViewServlet")
public class UpdateViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("hiddenid");
		String name = request.getParameter("name");
		String sql = request.getParameter("hiddensql");
		name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
		ChartViewDao cvd = new ChartViewDao();
		int rs = cvd.update(CommonUtils.getInnerDataSource(), name, sql, id);
		String msg = null;
		if(rs > 0) {
			msg = "succeeded";
		} else {
			msg = "failed";
		}
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(msg);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
