package com.czy.dao;

import java.util.List;

import com.czy.beans.DataSource;
import com.czy.utils.DbUtils;

/**
 * 
 * @author tom
 *	�������DAO����д�Լ���DAO����Ա�����Զ��壬�������̲���
 */
public class BaseDao {
	protected DbUtils db = new DbUtils();
	public List<List<String>> get(DataSource ds, String sql) {
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	
	public int update(DataSource ds, String sql) {
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
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
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
}
