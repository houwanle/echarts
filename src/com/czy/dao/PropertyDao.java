package com.czy.dao;

import java.util.List;

import com.czy.beans.DataSource;
import com.czy.beans.Property;

public class PropertyDao extends BaseDao {
	public int updatePropertyById(DataSource ds,String fontSize,String fontWeight,String theme,String location,String s_id,String id){
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "UPDATE userproperty SET fontWeight='"+fontWeight+"',location = '"+location+"',fontSize ='"+fontSize+"', theme ='"+theme+"' WHERE id = "+id+" && s_id = "+s_id+";";
		//准备变量接值
		int rs;
		//System.out.println("update"+sql);
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	public int addPropertyById(DataSource ds,String fontSize,String fontWeight,String theme,String location,String s_id,String id){
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "INSERT INTO userproperty(id,fontWeight,fontSize, theme,s_id,location) VALUES("+id+",'"+fontWeight+"', '"+fontSize+"','"+theme+"',"+s_id+",'"+location+"');";
		//准备变量接值
		int rs;
		//执行更新操作
		//System.out.println("insert"+sql);
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	public Property getPropertyById(DataSource ds,String id, String s_id) {
		String sql = "SELECT * FROM userproperty WHERE s_id = "+s_id+" AND id = "+id+"";
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> tempRs;
		Property rs = null;
		//执行查询操作
		tempRs = db.execQuery(sql);
		//System.out.println("get "+sql);
		//关闭连接
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
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备SQL
		String sql = "delete from userproperty where id = " + id;
		//准备变量接值
		int rs;
		//执行更新操作
		rs = db.execOther(sql);
		//关闭连接
		db.closeConn();
		return rs;
	}
	
	public Property getPropertyByLocation(DataSource ds,String id,String s_id,String location) {
		String sql = "SELECT * FROM userproperty WHERE s_id = "+s_id+" AND location = '"+location+"' AND id = "+id+"";
		//设置数据源
		db.setDs(ds);
		//获取连接
		db.getConnection();
		//准备变量接值
		List<List<String>> tempRs;
		Property rs = null;
		//执行查询操作
		tempRs = db.execQuery(sql);
		System.out.println("location "+sql);
		//关闭连接
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
