package com.czy.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.dao.BaseDao;
import com.czy.utils.CommonUtils;

@WebServlet("/DeleteDataSourceServlet")
public class DeleteDataSourceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		System.out.println(id);
		BaseDao bd = new BaseDao();
		bd.update(CommonUtils.getInnerDataSource(), "DELETE FROM datasource WHERE id = " + id);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
