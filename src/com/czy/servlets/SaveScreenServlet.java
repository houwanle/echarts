package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.dao.BaseDao;
import com.czy.utils.CommonUtils;

@WebServlet("/SaveScreenServlet")
public class SaveScreenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//Integer boxNum = Integer.parseInt(request.getParameter("hidden_box_num"));
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("hidden_name");
		String row = request.getParameter("hidden_row");
		String col = request.getParameter("hidden_col");
		
		Integer boxNum = Integer.parseInt(row) * Integer.parseInt(col);
		String vtid = null;
		String fontSize = null;
		String fontWeight = null;
		String theme = null;
		BaseDao bd = new BaseDao();
		bd.update(CommonUtils.getInnerDataSource(), "INSERT INTO screen(X, Y, NAME) VALUES('" + row + "', '" + col + "', '" + name + "');");
		String sid = bd.get(CommonUtils.getInnerDataSource(), "SELECT MAX(id) AS id FROM screen").get(1).get(0);
		for(int i = 0; i < boxNum; i++) {
			vtid = request.getParameter("hiddenid" + i);
			if(vtid == "") {
				continue;
			}
			fontSize = request.getParameter("hiddenfs" + i);
			fontWeight = request.getParameter("hiddenfw" + i);
			theme = request.getParameter("hiddenth" + i);
			theme = theme.replaceAll("'", "\\\\'");
			bd.update(CommonUtils.getInnerDataSource(), "INSERT INTO userproperty(fontSize, fontWeight, theme, location, s_id, vt_id) VALUES('" + fontSize + "', '" + fontWeight + "', '" + theme + "', '" + i + "', " + sid + ", " + vtid + ");");
		}
		response.setContentType("text/html;charset=utf-8");
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}