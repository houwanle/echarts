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

@WebServlet("/GetViewComponentServlet")
public class GetViewComponentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BaseDao bd = new BaseDao();
		
		response.setContentType("text/html;charset=utf-8");
		List<List<String>> pie = null;
		List<List<String>> bar = null;
		List<List<String>> line = null;
		List<List<String>> scatter = null;
		List<List<String>> funnel = null;
		List<List<String>> treemap = null;
		List<List<String>> candlestick = null;
		List<List<String>> map = null;
		List<List<String>> heatmap = null;
		List<List<String>> radar = null;
		List<List<String>> heatbaidu = null;
		//获取饼图可视化组件
		pie = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'pie'");
		//获取柱形图可视化组件
		bar = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'bar'");
		//获取折线图可视化组件
		line = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'line'");
		//获取散点图可视化组件
		scatter = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'scatter'");
		//获取漏斗图可视化组件
		funnel = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'funnel'");
		//获取树图可视化组件
		treemap = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'treemap'");
		//获取k线图可视化组件
		candlestick = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'candlestick'");
		//获取地图可视化组件
		map = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'map'");
		//获取热力图可视化组件
		heatmap = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'heatmap'");
		//获取雷达图可视化组件
		radar = bd.get(CommonUtils.getInnerDataSource(), "SELECT t2.id, t1.name FROM chartview t1, view_type t2 WHERE t1.id = t2.v_id AND t2.type_name = 'radar'");
		//获取百度地图可视化组件
		heatbaidu = bd.get(CommonUtils.getInnerDataSource(), "SELECT * FROM heatbaidu t1 , view_type t2, chartview t3 WHERE t1.id = t2.id AND t2.v_id = t3.id");
		
		StringBuilder sb = new StringBuilder();
		
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"pielink\" href=\"javascript:changeview('pieContent','pielink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">饼图</a>"+
				"<div id=\"pieContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < pie.size(); i++) {
			sb.append("<div id=\""+pie.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+pie.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"barlink\" href=\"javascript:changeview('barContent','barlink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">柱图</a>"+
				"<div id=\"barContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < bar.size(); i++) {
			sb.append("<div id=\""+bar.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+bar.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"linelink\" href=\"javascript:changeview('lineContent','linelink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">折线图</a>"+
				"<div id=\"lineContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < line.size(); i++) {
			sb.append("<div id=\""+line.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+line.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"scatterlink\" href=\"javascript:changeview('scatterContent','scatterlink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">散点图</a>"+
				"<div id=\"scatterContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < scatter.size(); i++) {
			sb.append("<div id=\""+scatter.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+scatter.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"funnellink\" href=\"javascript:changeview('funnelContent','funnellink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">漏斗图</a>"+
				"<div id=\"funnelContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < funnel.size(); i++) {
			sb.append("<div id=\""+funnel.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+funnel.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		
		
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"treemaplink\" href=\"javascript:changeview('treemapContent','treemaplink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">树图</a>"+
				"<div id=\"treemapContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < treemap.size(); i++) {
			sb.append("<div id=\""+treemap.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+treemap.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"candlelink\" href=\"javascript:changeview('candlestickContent','candlelink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">K线图</a>"+
				"<div id=\"candlestickContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < candlestick.size(); i++) {
			sb.append("<div id=\""+candlestick.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+candlestick.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"maplink\" href=\"javascript:changeview('mapContent','maplink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">地图</a>"+
				"<div id=\"mapContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < map.size(); i++) {
			sb.append("<div id=\""+map.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+map.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"heatmaplink\" href=\"javascript:changeview('heatmapContent','heatmaplink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">热力图</a>"+
				"<div id=\"heatmapContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < heatmap.size(); i++) {
			sb.append("<div id=\""+heatmap.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+heatmap.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"radarlink\" href=\"javascript:changeview('radarContent','radarlink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">雷达图</a>"+
				"<div id=\"radarContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < radar.size(); i++) {
			sb.append("<div id=\""+radar.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+radar.get(i).get(1)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		sb.append("<div style=\"color:red;font-size:18px;margin-bottom:3px;\">"+
				"<a id=\"heatbaidulink\" href=\"javascript:changeview('heatbaiduContent','heatbaidulink')\" style=\"color:#a2a2a2;font-weight:650;font-Size:18px;\">百度地图</a>"+
				"<div id=\"heatbaiduContent\" style=\"color:#0000ff;font-size:18px;display:none\">");
		for(int i = 1; i < heatbaidu.size(); i++) {
			sb.append("<div id=\""+heatbaidu.get(i).get(0)+"\" style=\"padding:2px;\" draggable=\"true\" ondragstart=\"drag(event)\">"+heatbaidu.get(i).get(7)+"</div>");
		}
		sb.append("</div>"+
					"</div>");
		
		PrintWriter out = response.getWriter();
		out.println(sb.toString());
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
