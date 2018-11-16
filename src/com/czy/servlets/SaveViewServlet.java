package com.czy.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.czy.dao.ChartViewDao;
import com.czy.dao.DataSourceDao;
import com.czy.utils.CommonUtils;

@WebServlet("/SaveViewServlet")
public class SaveViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String sql = request.getParameter("hiddensql");
		String col = request.getParameter("hiddencol");
		String id = request.getParameter("hiddenid");
		String name = request.getParameter("viewName");
		
		name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
		sql = new String(sql.getBytes("ISO-8859-1"),"UTF-8");
		col = new String(col.getBytes("ISO-8859-1"),"UTF-8");
		
		
		String[] cols = col.split(" ");
		DataSourceDao dsd = new DataSourceDao();
		String type = dsd.getDataSourceById(CommonUtils.getInnerDataSource(), id).getType();
		String finalSql = null;
		String tmp1, tmp2[];
		Set<String> set = new LinkedHashSet<String>();
		for(int i = 0; i < cols.length; i++) {
			set.add(cols[i]);
		}
		Object tmp3[] = set.toArray();
		
		if("mysql".equals(type) || "oracle".equals(type)) {
			finalSql = "select ";
			tmp1 = sql.substring(6, sql.indexOf("from") - 1);
			tmp2 = tmp1.split(",");
			for(int i = 0; i < tmp3.length; i++) {
				for(int j = 0; j < tmp2.length; j++) {
					if(tmp3[i].equals(tmp2[j].split("\\.")[1].trim())) {
						finalSql += tmp2[j] + ",";
					}
				}
			}
			finalSql = finalSql.substring(0, finalSql.length() - 1);
		} else if("sqlserver".equals(type)) {
			finalSql = "select top 100 ";
			tmp1 = sql.substring(14, sql.indexOf("from") - 1);
			tmp2 = tmp1.split(",");
			for(int i = 0; i < tmp3.length; i++) {
				for(int j = 0; j < tmp2.length; j++) {
					if(tmp3[i].equals(tmp2[j].split("\\.")[1])) {
						finalSql += tmp2[j] + ",";
					}
				}
			}
			finalSql = finalSql.substring(0, finalSql.length() - 1);
		}else if("dameng".equals(type)) {
			finalSql = "select top 100 ";
			tmp1 = sql.substring(14, sql.indexOf("from") - 1);
			System.out.println("tmp1="+tmp1);
			tmp2 = tmp1.split(",");
			
			for(int i = 0; i < tmp3.length; i++) {
				for(int j = 0; j < tmp2.length; j++) {
					if(tmp3[i].equals(tmp2[j].split("\\.")[2])) {
						finalSql += tmp2[j] + ",";
					}
				}
			}
			finalSql = finalSql.substring(0, finalSql.length() - 1);
		}
		
		/*for(int i = 0; i < cols.length; i++) {
			finalSql = finalSql + cols[i];
			if(i + 1 < cols.length) {
				finalSql += ", ";
			}
		}*/
		
		finalSql = finalSql + " " + sql.substring(sql.indexOf("from"));
		ChartViewDao cvd = new ChartViewDao();
		int rs = cvd.add(CommonUtils.getInnerDataSource(), name, finalSql, id);
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
