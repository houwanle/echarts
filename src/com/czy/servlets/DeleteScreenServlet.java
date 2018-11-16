package com.czy.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.beans.DataSource;
import com.czy.dao.BaseDao;
import com.czy.utils.CommonUtils;

@WebServlet("/DeleteScreenServlet")
public class DeleteScreenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String s_id = request.getParameter("s_id");
		BaseDao bd = new BaseDao();
		DataSource ds = CommonUtils.getInnerDataSource();
		//bd.update(ds, "DELETE FROM userproperty WHERE s_id = "+s_id+"");//É¾³ýuserproperty
		bd.update(ds, "DELETE FROM screen WHERE id= " + s_id);//É¾³ýscreen
		response.sendRedirect("screen_manage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doGet(request, response);
		
		
	}
}