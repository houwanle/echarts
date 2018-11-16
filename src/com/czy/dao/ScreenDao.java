package com.czy.dao;

import java.util.ArrayList;
import java.util.List;

import com.czy.beans.DataSource;
import com.czy.beans.Screen;

public class ScreenDao extends BaseDao {
	public List<Screen> query(DataSource ds) {
		String sql = "";
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> tempRs;
		List<Screen> rs = new ArrayList<Screen>();
		Screen tempS;
		//执行查询操作
		tempRs = db.execQuery(sql);
		//关闭连接
		db.closeConn();
		for(int i = 1; i < tempRs.size(); i++) {
			tempS = new Screen();
			tempS.setId(tempRs.get(i).get(0));
			tempS.setX(tempRs.get(i).get(1));
			tempS.setY(tempRs.get(i).get(2));
			tempS.setName(tempRs.get(i).get(3));
			rs.add(tempS);
		}
		return rs;
	}
	
	public int add(DataSource ds, String x, String y,String name) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "INSERT INTO screen(x, y,name) VALUES('" + x + "', '" + y + "','"+name+"');";
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public Screen getScreenById(DataSource ds, String id) {
		String sql = "SELECT * FROM screen WHERE id = " + id;
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> tempRs;
		Screen rs = null;
		//执行查询操作
		tempRs = db.execQuery(sql);
		//关闭连接
		db.closeConn();
		for(int i = 1; i < tempRs.size(); i++) {
			rs = new Screen();
			rs.setId(tempRs.get(i).get(0));
			rs.setX(tempRs.get(i).get(1));
			rs.setY(tempRs.get(i).get(2));
			rs.setName(tempRs.get(i).get(3));
		}
		return rs;
	}
}
