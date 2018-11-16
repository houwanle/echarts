package com.czy.dao;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import com.czy.beans.DataSource;
import com.czy.utils.CommonUtils;

public class System2dataDao extends BaseDao{
	public List<List<String>> obtainData(DataSource ds,String sql){
		
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
	public String getX(String place){
		List<String> hubei = Arrays.asList("黄石市","十堰市","襄阳市","恩施土家族苗族自治州","宜昌市","荆门市","荆州市","潜江市","仙桃市","天门市","随州市","孝感市","黄冈市","鄂州市","咸宁市","神农架林区","武汉市","江岸区","江汉区","硚口区","汉阳区","武昌区","青山区","洪山区","东西湖区","汉南区","蔡甸区","江夏区","黄陂区","新洲区","咸安区","通山县","通城县","嘉鱼县","崇阳县","赤壁市","鄂城区","梁子湖区","华容区","黄州区","麻城市","武穴市","团风县","浠水县","罗田县","英山县","蕲春县","黄梅县","红安县","龙感湖管理区","孝南区","汉川市","应城市","安陆市","云梦县","孝昌县","大悟县","曾都区","随县","广水市","多宝镇","拖市镇","张港镇","渔薪镇","蒋场镇","佛子山镇","黄潭镇","汪场镇","岳口镇","石河镇","九真镇","皂市镇","胡市镇","卢市镇","净潭乡","干驿镇","多祥镇","马湾镇","小板镇","横林镇","麻洋镇","彭市镇","天门开发区","仙桃高新技术产业开发区","干河街道","龙华山街道","沙嘴街道","毛嘴镇","剅河镇","三伏潭镇","胡场镇","长埫口镇","西流河镇","彭场镇","沙湖镇","杨林尾镇","张沟镇","郭河镇","沔城回族镇","通海口镇","陈场镇","仙桃经济开发区","仙桃工业园","熊口镇","竹根滩镇","高石碑镇","老新镇","王场镇","渔洋镇","龙湾镇","浩口镇","积玉口镇","张金镇","荆州区","沙市区","江陵县","松滋市","公安县","石首市","监利县","洪湖市","钟祥市","东宝区","掇刀区","漳河新区","屈家岭管理区","京山县","沙洋县","荆门高新技术产业开发区","远安县","兴山县","秭归县","长阳土家族自治县","五峰土家族自治县","夷陵区","西陵区","伍家岗区","点军区","猇亭区","恩施市","利川市","建始县","巴东县","宣恩县","咸丰县","来凤县","鹤峰县","樊城区","襄州区","枣阳市","南漳县","保康县","谷城县","宣城市","老河口市","茅箭区","张湾区","十堰经济开发区","郧阳区","郧西县","竹山县","竹溪县","房县","丹江口市","黄石港区","下陆区","铁山区","大冶市","阳新县","黄石经济技术开发区","松柏镇","阳日镇","木鱼镇","红坪镇","新华镇","宋洛乡","九湖乡","下谷坪土家族乡");
		for(int i=hubei.size()-1;i>=0;i--){
			if(place.contains(hubei.get(i))){
				place=hubei.get(i);
			}	
			
		}System.out.println("X"+place);
		db.setDs(CommonUtils.getInnerDataSource());
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery("SELECT x FROM coord WHERE name='"+place+"'");
		//�ر�����
		db.closeConn();
		return rs.get(1).get(0);
	}
	public String getY(String place){
		List<String> hubei = Arrays.asList("黄石市","十堰市","襄阳市","恩施土家族苗族自治州","宜昌市","荆门市","荆州市","潜江市","仙桃市","天门市","随州市","孝感市","黄冈市","鄂州市","咸宁市","神农架林区","武汉市","江岸区","江汉区","硚口区","汉阳区","武昌区","青山区","洪山区","东西湖区","汉南区","蔡甸区","江夏区","黄陂区","新洲区","咸安区","通山县","通城县","嘉鱼县","崇阳县","赤壁市","鄂城区","梁子湖区","华容区","黄州区","麻城市","武穴市","团风县","浠水县","罗田县","英山县","蕲春县","黄梅县","红安县","龙感湖管理区","孝南区","汉川市","应城市","安陆市","云梦县","孝昌县","大悟县","曾都区","随县","广水市","多宝镇","拖市镇","张港镇","渔薪镇","蒋场镇","佛子山镇","黄潭镇","汪场镇","岳口镇","石河镇","九真镇","皂市镇","胡市镇","卢市镇","净潭乡","干驿镇","多祥镇","马湾镇","小板镇","横林镇","麻洋镇","彭市镇","天门开发区","仙桃高新技术产业开发区","干河街道","龙华山街道","沙嘴街道","毛嘴镇","剅河镇","三伏潭镇","胡场镇","长埫口镇","西流河镇","彭场镇","沙湖镇","杨林尾镇","张沟镇","郭河镇","沔城回族镇","通海口镇","陈场镇","仙桃经济开发区","仙桃工业园","熊口镇","竹根滩镇","高石碑镇","老新镇","王场镇","渔洋镇","龙湾镇","浩口镇","积玉口镇","张金镇","荆州区","沙市区","江陵县","松滋市","公安县","石首市","监利县","洪湖市","钟祥市","东宝区","掇刀区","漳河新区","屈家岭管理区","京山县","沙洋县","荆门高新技术产业开发区","远安县","兴山县","秭归县","长阳土家族自治县","五峰土家族自治县","夷陵区","西陵区","伍家岗区","点军区","猇亭区","恩施市","利川市","建始县","巴东县","宣恩县","咸丰县","来凤县","鹤峰县","樊城区","襄州区","枣阳市","南漳县","保康县","谷城县","宣城市","老河口市","茅箭区","张湾区","十堰经济开发区","郧阳区","郧西县","竹山县","竹溪县","房县","丹江口市","黄石港区","下陆区","铁山区","大冶市","阳新县","黄石经济技术开发区","松柏镇","阳日镇","木鱼镇","红坪镇","新华镇","宋洛乡","九湖乡","下谷坪土家族乡");
		for(int i=0;i<hubei.size();i++){
			if(place.contains(hubei.get(i))){
				place=hubei.get(i);
			}	
		}//System.out.println("Y"+place);
		db.setDs(CommonUtils.getInnerDataSource());
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery("SELECT y FROM coord WHERE name='"+place+"'");
		//�ر�����
		db.closeConn();
		return rs.get(1).get(0);
	}
	public String getMax(DataSource ds,String name,String table){
		String sql=getSql(CommonUtils.getInnerDataSource(), table);
		List<List<String>> data=obtainData(ds,sql);
		//System.out.println(sql);
		int k=0;
		double max=0;
		for(int i=0;i<data.get(0).size();i++){
			if(data.get(0).get(i).equals(name)){
				k=i;
			}
		}
		for(int i=1;i<data.size();i++){
			if(Double.parseDouble(data.get(i).get(k))>max)max=Double.parseDouble(data.get(i).get(k));
		}
		return String.valueOf(max).split("\\.")[0];//zhuanyi
	}
	public String getName(DataSource ds,String id){
		
		String sql = "SELECT NAME FROM chartview WHERE id = "+ id +"";
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery(sql);
		String name = rs.get(1).get(0);
		//�ر�����
		db.closeConn();
		return name;
	}
	public List<List<String>> getName(DataSource ds){
	
		String sql = "SELECT NAME FROM chartview";
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
	public String getProperties(DataSource ds,String id,String chartType,String property){
		
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		
		//ִ�в�ѯ����
		
		rs = db.execQuery("SELECT "+property+" FROM "+chartType+" WHERE id = "+id+"");
		
		String value=rs.get(1).get(0);
		//�ر�����
		db.closeConn();
	
		
		return value;
	}
	public String getSql(DataSource ds,String tableName){//�ṩtablenameֵ����chartview����sql���
		//System.out.println(tableName);
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery("SELECT stmt FROM chartview WHERE NAME='"+ tableName+"'");
		//System.out.println("SELECT"+tableName);
		String sql=rs.get(1).get(0);
		//�ر�����
		db.closeConn();
		return sql;
	}
	public List<String> getId(DataSource ds){
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		List<String>id=new ArrayList<String>();
		//ִ�в�ѯ����
		rs = db.execQuery("SELECT id FROM view_type");
		for(int i = 1;i<rs.size();i++){
			id.add(rs.get(i).get(0));
		}		
		//System.out.println("daoid"+id);
		//�ر�����
		db.closeConn();
		return id;
	}
	public String getcvId(DataSource ds,String tableName){//�ṩtablenameֵ����chartview����id
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery("SELECT id FROM chartview WHERE NAME='"+ tableName+"'");
		String id=rs.get(1).get(0);
		
		//�ر�����
		db.closeConn();
		return id;
	}
	public String getidVid(DataSource ds,String id){//ͨ��id����view_type����vid
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		List<List<String>> rs;
		//ִ�в�ѯ����
		rs = db.execQuery("SELECT v_id FROM view_type WHERE id="+ id+"");
		String vid=rs.get(1).get(0);
		
		//�ر�����
		db.closeConn();
		return vid;
	}
	public int removeType(DataSource ds,String type,String id){
		String sql = "DELETE FROM "+type+" WHERE id = "+id+";";
		
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
	public int removeall(DataSource ds){
		String []type=new String[]{"bar","line","scatter","pie","treemap","candlestick","funnel","map","heatmap","radar","heatbaidu"};
		for(int i=0;i<type.length;i++)
		{
			clearType(ds, type[i]);			
		}
		int rs=clearView(ds)+clearUser(ds);
		return rs;
		
	}
	public int clearType(DataSource ds,String type){
		String sql = "DELETE FROM "+type+";";
		//System.out.println("sql="+sql);
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
	public int clearView(DataSource ds)
	{		
			String sql = "DELETE FROM view_type;";
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
	public int clearUser(DataSource ds)
	{		
			String sql = "DELETE FROM userproperty;";
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
	public int removeUser(DataSource ds,String id){
		String sql = "DELETE FROM userproperty WHERE vt_id = "+id+";";
		
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
	public int removeView(DataSource ds,String id){
		String sql = "DELETE FROM view_type WHERE id = "+id+";";
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
	public int updatatype(DataSource ds,String id,String type,List<String> properies){
		String sql ="";
		if(type.equals("bar")){
			sql = "UPDATE bar SET barGap = '"+properies.get(0)+"', yUnit = '"+properies.get(1)+"' , typeaxis = '"+properies.get(2)+"' WHERE id = "+id+";";
		}
		else if(type.equals("line")){
			sql = "UPDATE line SET yUnit = '"+properies.get(0)+"', typeaxis = '"+properies.get(1)+"' WHERE id = "+id+";";

		}
		else if(type.equals("pie")){
			sql = "UPDATE pie SET innerRadius = '"+properies.get(0)+"', externalRadius = '"+properies.get(1)+"' , piePositionRadio = '"+properies.get(2)+"' , legendPositionRadio = '"+properies.get(3)+"' WHERE id = "+id+";";

		}
		else if(type.equals("scatter")){
			sql = "UPDATE scatter SET xmin = '"+properies.get(0)+"', xmax = '"+properies.get(1)+"' , ymin = '"+properies.get(2)+"' , ymax = '"+properies.get(3)+"', xUnit = '"+properies.get(4)+"', yUnit = '"+properies.get(5)+"' WHERE id = "+id+";";

		}
		else if(type.equals("treemap")){
			sql = "UPDATE treemap SET mapDesc = '"+properies.get(0)+"', borderWidth = '"+properies.get(1)+"' , borderColor = '"+properies.get(2)+"' , mapHeight = '"+properies.get(3)+"' WHERE id = "+id+";";

		}
		else if(type.equals("funnel")){
			sql = "UPDATE funnel SET sort = '"+properies.get(0)+"', minSize = '"+properies.get(1)+"' , maxSize = '"+properies.get(2)+"' , gap = '"+properies.get(3)+"' WHERE id = "+id+";";

		}
		else if(type.equals("candlestick")){
			sql = "UPDATE candlestick SET color1 = '"+properies.get(0)+"', color2 = '"+properies.get(1)+"' WHERE id = "+id+";";

		}
		else if(type.equals("map")){
			sql = "UPDATE map SET mapmax = '"+properies.get(0)+"', mapmin = '"+properies.get(1)+"' WHERE id = "+id+";";

		}
		else if(type.equals("heatmap")){
			sql = "UPDATE heatmap SET min = '"+properies.get(0)+"', max = '"+properies.get(1)+"' WHERE id = "+id+";";

		}
		else if(type.equals("radar")){
			sql = "UPDATE radar SET max = '"+properies.get(0)+"' WHERE id = "+id+";";

		}
		else if(type.equals("baidu")){
			sql = "UPDATE heatbaidu SET radius = '"+properies.get(0)+"', maxNum = '"+properies.get(1)+"' WHERE id = "+id+";";

		}
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
	public int addViewtype(DataSource ds,String v_id,String chartType,String id){
		String sql = "INSERT INTO view_type(v_id,type_name,id) VALUES(" + v_id + ", '" + chartType + "'," + id + ");";
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
	public int updataview(DataSource ds,String v_id,String chartType,String id){		
		String sql = "UPDATE view_type SET v_id = '"+v_id+"', type_name = '"+chartType+"' WHERE id = "+id+";";		
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
	public int addMap(DataSource ds,String id,String mapmin,String mapmax){
		
		String sql = "INSERT INTO map(id, mapmax, mapmin) VALUES(" + id + ", '" + mapmax + "', '" + mapmin + "');";
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
	public int addBaidu(DataSource ds,String id,String radius,String maxNum){
		
		String sql = "INSERT INTO heatbaidu(id, radius, maxNum) VALUES(" + id + ", '" + radius + "', '" + maxNum + "');";
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
	public int addradar(DataSource ds,String id,String max){
		
		String sql = "INSERT INTO radar(id, max) VALUES(" + id + ", '" + max + "');";
		db.setDs(ds);
		//��ȡ����
		db.getConnection();
		//׼��������ֵ
		int rs;
		System.out.println(sql);
		//ִ�и��²���
		rs = db.execOther(sql);
		//�ر�����
		
		db.closeConn();
		return rs;
		
	}
	public int addheatmap(DataSource ds,String id,String min,String max){
		
		String sql = "INSERT INTO heatmap(id, min, max) VALUES(" + id + ", '" + min + "', '" + max + "');";
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
	public int addBar(DataSource ds,String id,String barGap,String yUnit,String typeaxis){
		
		String sql = "INSERT INTO bar(id, barGap, yUnit,typeaxis) VALUES(" + id + ", '" + barGap + "', '" + yUnit + "', '" + typeaxis + "');";
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
public int addLine(DataSource ds,String id,String yUnit,String typeaxis){
		
		String sql = "INSERT INTO line(id, yUnit,typeaxis) VALUES(" + id + ", '" + yUnit + "', '" + typeaxis + "');";
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
public int addPie(DataSource ds,String id,String innerRadius,String externalRadius,String piePositionRadio,String legendPositionRadio){
	
	String sql = "INSERT INTO pie(id, innerRadius,externalRadius,piePositionRadio,legendPositionRadio) VALUES(" + id + ", '" + innerRadius + "', '" + externalRadius + "', '" + piePositionRadio + "', '" + legendPositionRadio+ "');";
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
public int addScatter(DataSource ds,String id,String xmin,String xmax,String ymin,String ymax,String xUnit,String yUnit){
	
	String sql = "INSERT INTO scatter(id, xmin,xmax,ymin,ymax,xUnit,yUnit) VALUES(" + id + ", '" + xmin + "', '" + xmax + "', '" + ymin + "', '" + ymax + "', '" + xUnit + "', '" + yUnit+ "');";
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
public int addTreemap(DataSource ds,String id,String mapDesc,String borderWidth,String borderColor,String mapHeight){
	
	String sql = "INSERT INTO treemap(id, mapDesc,borderWidth,borderColor,mapHeight) VALUES(" + id + ", '" + mapDesc + "', '" + borderWidth + "', '" + borderColor + "', '" + mapHeight + "');";
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
public int addFunnel(DataSource ds,String id,String sort,String minSize,String maxSize,String gap){
	
	String sql = "INSERT INTO funnel(id, sort,minSize,maxSize,gap) VALUES(" + id + ", '" + sort + "', '" + minSize + "', '" + maxSize + "', '" + gap + "');";
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
public int addCandlestick(DataSource ds,String id,String color1,String color2){
	
	String sql = "INSERT INTO candlestick(id, color1,color2) VALUES(" + id + ", '" + color1 + "', '" + color2 + "');";
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
public String getAxis(DataSource ds,String id){
	
	String sql = "SELECT type_name FROM view_type WHERE id = "+id+"";
	db.setDs(ds);
	//��ȡ����
	db.getConnection();
	//׼��������ֵ
	List<List<String>> rs;
	//ִ�в�ѯ����
	rs = db.execQuery(sql);
	String sql1= "SELECT typeaxis FROM "+rs.get(1).get(0)+" WHERE id = "+id+"";
	
	//ִ�в�ѯ����
	rs = db.execQuery(sql1);
	//�ر�����
	db.closeConn();
	return rs.get(1).get(0);
}
	
}
