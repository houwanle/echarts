package com.czy.dao;

import java.util.ArrayList;
import java.util.List;

import com.czy.beans.DataSource;
import com.czy.beans.Screen;

public class ScreenDao extends BaseDao {
	public List<Screen> query(DataSource ds) {
		String sql = "";
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> tempRs;
		List<Screen> rs = new ArrayList<Screen>();
		Screen tempS;
		//ִ�в�ѯ����
		tempRs = db.execQuery(sql);
		//�ر�����
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
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "INSERT INTO screen(x, y,name) VALUES('" + x + "', '" + y + "','"+name+"');";
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	
	public Screen getScreenById(DataSource ds, String id) {
		String sql = "SELECT * FROM screen WHERE id = " + id;
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> tempRs;
		Screen rs = null;
		//ִ�в�ѯ����
		tempRs = db.execQuery(sql);
		//�ر�����
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
