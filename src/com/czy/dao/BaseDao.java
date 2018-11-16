package com.czy.dao;

import java.util.List;

import com.czy.beans.DataSource;
import com.czy.utils.DbUtils;

/**
 * 
 * @author tom
 *	参照这个DAO，编写自己的DAO，成员方法自定义，基本流程不变
 */
public class BaseDao {
	protected DbUtils db = new DbUtils();
	public List<List<String>> get(DataSource ds, String sql) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> rs;
		//执行查询操作
		rs = db.execQuery(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public int update(DataSource ds, String sql) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public List<List<String>> getColumnName(DataSource ds, String table) {
		String sql = null;
		if("mysql".equals(ds.getType())) {
			sql = "select * from " + table + " limit 0";
		} else if("oracle".equals(ds.getType())) {
			sql = "select * from " + table + " where rownum < 1";
		} else if("sqlserver".equals(ds.getType())) {
			sql = "select top 0 * from " + table;
		}
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> rs;
		//执行查询操作
		rs = db.execQuery(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
}
