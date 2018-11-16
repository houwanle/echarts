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
import com.czy.dao.BaseDao;
import com.czy.dao.ScreenDao;
import com.czy.utils.CommonUtils;

@WebServlet("/GetScreenServlet")
public class GetScreenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ScreenDao sd = new ScreenDao();
		//List<List<String>> sum = sd.get(CommonUtils.getInnerDataSource(), "SELECT CEILING(COUNT(*)/10) AS pagesum FROM screen");
		
		
		response.setContentType("text/html;charset=utf-8");
		
		int pageCon = 5;
		int pageCur = 0;
		
		List<List<String>> sum = sd.get(CommonUtils.getInnerDataSource(), "SELECT CEILING(COUNT(*)/"+pageCon+") AS pagesum FROM screen");
		int pageSum = Integer.parseInt(sum.get(1).get(0));
		
		if("".equals(request.getParameter("pageCur"))) {
			pageCur = 1;
		} else {
			pageCur = Integer.parseInt(request.getParameter("pageCur"));
		}
		
		/*System.out.println("pageSum:"+pageSum);
		System.out.println("pageCur:"+pageCur);*/
		
		
		List<List<String>> list = sd.get(CommonUtils.getInnerDataSource(), "SELECT * FROM screen ORDER BY id DESC LIMIT " + (pageCur - 1) * pageCon + ", " + pageCon);
		
		StringBuilder  sb = new StringBuilder ();
		sb.append("<div style=\"height:80%;width:100%;margin:auto;\"><div id=\"columnContent3\" style=\"padding-top:0.5%;text-align:left;width:97%;height:9%;border-bottom: 1px solid #d7d7d7;border-top: 1px solid #d7d7d7\">"+
		"<div style=\"float:left;width:3%;height:100%\"><input type=\"checkbox\" id=\"checkall\" onclick=\"changcheck('screen_manage')\"/></div>"+
		"<div style=\"float:left;width:30%;height:100%\">文件名</div>"+
		"<div style=\"float:left;width:22%;height:100%\">行</div>"+
		"<div style=\"float:left;width:22%;height:100%\">列</div>"+
		"<div style=\"float:left;width:10%;height:100%\">操作</div>"+
		"</div>");
		if(list != null) {
			for(int i = 1; i < list.size(); i++) {
				sb.append(
						"<div style=\"padding-top:0.5%;text-align:left;width:97%;height:7%;border-bottom: 1px solid #d7d7d7\">\n"+
						"<div style=\"float:left;width:3%;height:100%\"><input type=\"checkbox\" name=\"check\" value=\""+list.get(i).get(0)+"\"/></div>\n"+
						"<div style=\"float:left;width:30%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">"+list.get(i).get(3)+"</div>"+
						"<div style=\"float:left;width:22%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">"+list.get(i).get(1)+"</div>"+
						"<div style=\"float:left;width:22%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\">"+list.get(i).get(2)+"</div>"+
						"<div style=\"float:left;width:16%;height:100%;white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow:hidden;\"><a href=\"JavaScript:show_item("+list.get(i).get(0)+")\" >查看</a>&nbsp;<a href=\"JavaScript:delete_item("+list.get(i).get(0)+")\">删除</a></div>&nbsp;<a href=\"ScreenViewServlet?s_id="+list.get(i).get(0)+"&import=true)\">导出</a>"+
						"</div>");
				// type=\"hidden\"
			}
		}
		sb.append("</div><div id=\"pageContent3\" style=\"margin-left:2%;margin-top:2%;width:90%;height:4%;\">"+
				"<ul id=\"pageClick\" class=\"pagination\" style=\"margin:auto;float:right;\">"+
				"</div>"+
				"<input type=\"hidden\" id=\"pageSum2\" name=\"pageSum\" value=\""+pageSum+"\"/>"
				);
		
		PrintWriter out = response.getWriter();
		out.println(sb.toString()); 
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
