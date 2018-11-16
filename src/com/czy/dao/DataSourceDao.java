package com.czy.dao;

import java.util.ArrayList;
import java.util.List;
import com.czy.beans.DataSource;

public class DataSourceDao extends BaseDao {
	
	public int add(DataSource ds, String ip, String port, String databaseName, String user, String password, String type, String conn_name) {
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "INSERT INTO datasource(ip, PORT, databaseName, USER, PASSWORD, TYPE, conn_name) VALUES('" + ip + "', '" + port + "', '" + databaseName + "', '" + user + "', '" + password + "', '" + type + "', '" + conn_name + "');";
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public List<DataSource> getDataSourceByType(DataSource ds, String type) {
		String sql = "SELECT * FROM datasource WHERE TYPE = '" + type + "'";
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> tempRs;
		List<DataSource> rs = new ArrayList<DataSource>();
		DataSource tempDs;
		//执行查询操作
		tempRs = db.execQuery(sql);
		//关闭连接
		db.closeConn();
		for(int i = 0; i < tempRs.size(); i++) {
			tempDs = new DataSource();
			tempDs.setId(tempRs.get(i).get(0));
			tempDs.setIp(tempRs.get(i).get(1));
			tempDs.setPort(tempRs.get(i).get(2));
			tempDs.setDatabaseName(tempRs.get(i).get(3));
			tempDs.setUser(tempRs.get(i).get(4));
			tempDs.setPassword(tempRs.get(i).get(5));
			tempDs.setType(tempRs.get(i).get(6));
			tempDs.setConn_name(tempRs.get(i).get(7));
			rs.add(tempDs);
		}
		return rs;
	}
	
	public DataSource getDataSourceById(DataSource ds, String id) {
		String sql = "SELECT * FROM datasource WHERE id = " + id;
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> tempRs;
		DataSource rs = null;
		//执行查询操作
		tempRs = db.execQuery(sql);
		//关闭连接
		db.closeConn();
		for(int i = 0; i < tempRs.size(); i++) {
			rs = new DataSource();
			rs.setId(tempRs.get(i).get(0));
			rs.setIp(tempRs.get(i).get(1));
			rs.setPort(tempRs.get(i).get(2));
			rs.setDatabaseName(tempRs.get(i).get(3));
			rs.setUser(tempRs.get(i).get(4));
			rs.setPassword(tempRs.get(i).get(5));
			rs.setType(tempRs.get(i).get(6));
			rs.setConn_name(tempRs.get(i).get(7));
		}
		return rs;
	}
}
