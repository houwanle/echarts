package com.czy.dao;

import java.util.List;

import com.czy.beans.DataSource;
import com.czy.beans.Property;

public class PropertyDao extends BaseDao {
	public int updatePropertyById(DataSource ds,String fontSize,String fontWeight,String theme,String location,String s_id,String id){
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "UPDATE userproperty SET fontWeight='"+fontWeight+"',location = '"+location+"',fontSize ='"+fontSize+"', theme ='"+theme+"' WHERE id = "+id+" && s_id = "+s_id+";";
		//׼��������ֵ
		int rs;
		//System.out.println("update"+sql);
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	public int addPropertyById(DataSource ds,String fontSize,String fontWeight,String theme,String location,String s_id,String id){
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "INSERT INTO userproperty(id,fontWeight,fontSize, theme,s_id,location) VALUES("+id+",'"+fontWeight+"', '"+fontSize+"','"+theme+"',"+s_id+",'"+location+"');";
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		//System.out.println("insert"+sql);
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	public Property getPropertyById(DataSource ds,String id, String s_id) {
		String sql = "SELECT * FROM userproperty WHERE s_id = "+s_id+" AND id = "+id+"";
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> tempRs;
		Property rs = null;
		//ִ�в�ѯ����
		tempRs = db.execQuery(sql);
		//System.out.println("get "+sql);
		//�ر�����
		db.closeConn();
		for(int i = 1; i < tempRs.size(); i++) {
			rs = new Property();
			rs.setFontSize(tempRs.get(i).get(1));
			rs.setFontWeight(tempRs.get(i).get(2));
			rs.setTheme(tempRs.get(i).get(3));
			rs.setLocation(tempRs.get(i).get(4));
			rs.setS_id(tempRs.get(i).get(5));
		}
		return rs;
	}
	
	public int delete(DataSource ds, String id) {
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��SQL
		String sql = "delete from userproperty where id = " + id;
		//׼��������ֵ
		int rs;
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		db.closeConn();
		return rs;
	}
	
	public Property getPropertyByLocation(DataSource ds,String id,String s_id,String location) {
		String sql = "SELECT * FROM userproperty WHERE s_id = "+s_id+" AND location = '"+location+"' AND id = "+id+"";
		//��������Դ
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> tempRs;
		Property rs = null;
		//ִ�в�ѯ����
		tempRs = db.execQuery(sql);
		System.out.println("location "+sql);
		//�ر�����
		db.closeConn();
		for(int i = 1; i < tempRs.size(); i++) {
			rs = new Property();
			rs.setFontSize(tempRs.get(i).get(1));
			rs.setFontWeight(tempRs.get(i).get(2));
			rs.setTheme(tempRs.get(i).get(3));
			rs.setLocation(tempRs.get(i).get(4));
			rs.setS_id(tempRs.get(i).get(5));
			
		}
		return rs;
	}
	
	
}
