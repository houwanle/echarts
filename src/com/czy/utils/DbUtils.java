package com.czy.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.czy.beans.DataSource;

public class DbUtils {
	
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private DataSource ds = null;
    
    public boolean getConnection(){ 
        try {
        	String url = null;
        	String driver = null;
        	//System.out.println(ds.getIp());
        	if("mysql".equals(ds.getType())) {
    			//mysql:3306
    			url = "jdbc:mysql://" + ds.getIp() + ":" + ds.getPort() + "/" + ds.getDatabaseName() + "?useUnicode=true&characterEncoding=UTF-8";
    			driver = "com.mysql.jdbc.Driver";
    		} else if("sqlserver".equals(ds.getType())) {
    			//sqlserver:1433
    			url = "jdbc:sqlserver://" + ds.getIp() + ":" + ds.getPort() + ";DatabaseName=" + ds.getDatabaseName();
    			driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    		} else if("oracle".equals(ds.getType())) {
    			//oracle:1521
    			url = "jdbc:oracle:thin:@" + ds.getIp() + ":" + ds.getPort() + ":" + ds.getDatabaseName();
    			driver = "oracle.jdbc.driver.OracleDriver";
    		} else if("dameng".equals(ds.getType())) {
    			//达梦
    			url = "jdbc:dm://" + ds.getIp() + ":" + ds.getPort() + "/" + ds.getDatabaseName();
    			driver = "dm.jdbc.driver.DmDriver";
    		}
            Class.forName(driver);
            conn = DriverManager.getConnection(url,ds.getUser(),ds.getPassword());
        } catch (Exception e) {
        	System.out.println(e.getMessage());
        }
        return true;
    }
    
    public void closeConn(){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(pstmt!=null){
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public int execOther(String sql){
        try {
        	Statement stmt = conn.createStatement();
        	int affectedRows = stmt.executeUpdate(sql);
            return affectedRows;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    public List<List<String>> execQuery(String sql){
        try {
        	List<List<String>> list = new ArrayList<List<String>>();
            Statement stmt = conn.createStatement();
        	rs = stmt.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            List<String> l = new ArrayList<String>();
            for(int i = 0; i < columnCount; i++) {
            	l.add(rsmd.getColumnName(i+1));
            }
            list.add(l);
            while(rs.next()) { 
            	l = new ArrayList<String>();
            	for(int i = 0; i < columnCount; i++) {
                	l.add(rs.getString(i + 1));
                	
                }
            	list.add(l);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
	public DataSource getDs() {
		return ds;
	}
	public void setDs(DataSource ds) {
		this.ds = ds;
	}
	public Connection getConn() {
		return conn;
	}
	
}
