package com.czy.dao;

import com.czy.beans.DataSource;

public class ChartViewDao extends BaseDao {
	public int add(DataSource ds, String name, String stmt, String ds_id) {
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "insert into chartview(name, stmt, ds_id) values('" + name + "', '" + stmt + "', " + ds_id + ")";
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	
	public int update(DataSource ds, String name, String stmt, String id) {
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "UPDATE chartview SET NAME='" + name + "', stmt='" + stmt + "' WHERE id=" + id;
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	
	public int delete(DataSource ds, String id) {
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "delete from chartview where id = " + id;
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
}
