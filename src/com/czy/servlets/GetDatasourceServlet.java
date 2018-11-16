package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.dao.BaseDao;
import com.czy.utils.CommonUtils;

/**
 * Servlet implementation class GetDatasourceServlet
 */
@WebServlet("/GetDatasourceServlet")
public class GetDatasourceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BaseDao bd = new BaseDao();
		
		//the counts of all pages 
		int pageSum;
		//the number of the current page
		int pageCur;
		//the counts of entries in one page 
		int pageCon = 10;
		
		if("".equals(request.getParameter("pageSum"))) {
			List<List<String>> sum = bd.get(CommonUtils.getInnerDataSource(), "SELECT CEILING(COUNT(id) / " + pageCon + ") AS pagesum FROM datasource");
			pageSum = Integer.parseInt(sum.get(1).get(0));
		} else {
			pageSum = Integer.parseInt(request.getParameter("pageSum"));
		}
		
		if("".equals(request.getParameter("pageCur"))) {
			pageCur = 1;
		} else {
			pageCur = Integer.parseInt(request.getParameter("pageCur"));
		}
		
		List<List<String>> list = bd.get(CommonUtils.getInnerDataSource(), "SELECT id, conn_name, ip, PORT, databaseName, USER, PASSWORD, TYPE FROM datasource ORDER BY id DESC LIMIT " + (pageCur - 1) * pageCon + ", " + pageCon);
		
		String res1 = "<div id=\"columnContent2\" style=\"padding-top:0.5%;margin:auto;text-align:left;width:95%;height:9%;border-bottom: 1px solid #d7d7d7;border-top: 1px solid #d7d7d7\">"
					+ "<div style=\"float:left;width:3%;height:100%\"><input type=\"checkbox\" id=\"checkall\" onclick=\"changcheck('getDatasourcePage')\"/></div>"
					+ "<div style=\"float:left;width:17%;height:100%\">名字</div>"
					+ "<div style=\"float:left;width:20%;height:100%\">ip</div>"
					+ "<div style=\"float:left;width:15%;height:100%\">端口</div>"
					+ "<div style=\"float:left;width:15%;height:100%\">数据库</div>"
					+ "<div style=\"float:left;width:10%;height:100%\">用户名</div>"
					+ "<div style=\"float:left;width:10%;height:100%\">类型</div>"
					+ "<div style=\"float:left;width:10%;height:100%\">操作</div></div>";
		
		String res2 = "";
		
		for(int i = 1; i < list.size(); i++) {
			res2 += "<div style=\"padding-top:0.5%;margin:auto;text-align:left;width:95%;height:7%;border-bottom: 1px solid #d7d7d7\">"
				 + "<div style=\"float:left;width:3%;height:100%\"><input type=\"checkbox\" name=\"check\" value=\"" + list.get(i).get(0) + "\"/></div>"
				 + "<div style=\"float:left;width:17%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">" + list.get(i).get(1) + "</div>"
				 + "<div style=\"float:left;width:20%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">" + list.get(i).get(2) + "</div>"
				 + "<div style=\"float:left;width:15%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">" + list.get(i).get(3) + "</div>"
				 + "<div style=\"float:left;width:15%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">" + list.get(i).get(4) + "</div>"
				 + "<div style=\"float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">" + list.get(i).get(5) + "</div>"
				 + "<div style=\"float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">" + list.get(i).get(7) + "</div>"
				 + "<div style=\"float:left;width:10%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\"><a href=\"javascript:delds(" + list.get(i).get(0) + ")\">删除</a></div></div>";
		}
		
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(pageSum + "|" + pageCur + "|" + res1 + res2);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
