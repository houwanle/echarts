package com.czy.dao;

import com.czy.beans.DataSource;

public class ChartViewDao extends BaseDao {
	public int add(DataSource ds, String name, String stmt, String ds_id) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "insert into chartview(name, stmt, ds_id) values('" + name + "', '" + stmt + "', " + ds_id + ")";
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public int update(DataSource ds, String name, String stmt, String id) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "UPDATE chartview SET NAME='" + name + "', stmt='" + stmt + "' WHERE id=" + id;
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public int delete(DataSource ds, String id) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "delete from chartview where id = " + id;
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
}
