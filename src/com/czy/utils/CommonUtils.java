package com.czy.utils;

import java.util.List;
import com.czy.beans.DataSource;

public class CommonUtils {
	
	public static Integer[] getMaxMin(List<Double> list){
		Integer[] a = new Integer[2];
		Double max = list.get(0),min = list.get(0);
		Double temp;
		for(int i = 0; i < list.size(); i++) {
			temp = list.get(i);
			if(max < temp) {
				max = temp;
			}
			if(min > temp) {
				min = temp;
			}
		}
		double t = max;
		a[0] = (int) t;
		t = min;
		a[1] = (int) t;
		return a;
	}
	
	public static DataSource getInnerDataSource() {
		DataSource ds = new DataSource();
		ds.setId("0");
		ds.setIp("localhost");
		ds.setPort("3306");
		ds.setDatabaseName("echart");
		ds.setUser("root");
		ds.setPassword("root");
		ds.setType("mysql");
		return ds;
	}
	
}
