package com.czy.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.dao.ChartViewDao;
import com.czy.utils.CommonUtils;

@WebServlet("/DeleteViewServlet")
public class DeleteViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		ChartViewDao cvd = new ChartViewDao();
		cvd.delete(CommonUtils.getInnerDataSource(), id);
		response.sendRedirect("view_manage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
