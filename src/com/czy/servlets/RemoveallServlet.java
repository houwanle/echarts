package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.System2dataDao;
import com.czy.utils.CommonUtils;

@WebServlet("/RemoveallServlet")
public class RemoveallServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds=CommonUtils.getInnerDataSource();
		System2dataDao s2 = new System2dataDao();		
		int flag=0;//1ÎªÕýÈ·	
		flag=s2.clearView(ds);
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(flag);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
