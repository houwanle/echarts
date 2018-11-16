package com.czy.utils;

import java.util.List;

import com.czy.beans.DataSource;
import com.czy.dao.BaseDao;


public class Test {

	public static void main(String[] args) {
		DataSource ds = new DataSource();
		ds.setIp("localhost");
		ds.setPort("5236");
		ds.setDatabaseName("dameng");
		ds.setUser("sysdba");
		ds.setPassword("sysdba");
		ds.setType("dameng");
		DbUtils db = new DbUtils();
		db.setDs(ds);
		db.getConnection();
		BaseDao bd = new BaseDao();
		List<List<String>> list =  bd.get(ds, "select * from aaa.table_1");
		//System.out.println(list.size() + "aaa");
		System.out.println(list.size());
		for(int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i).get(0));
		}
		
	}

}
