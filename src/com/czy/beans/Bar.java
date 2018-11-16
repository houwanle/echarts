package com.czy.beans;

public class Bar {
	private String id;
	private String varGap;
	private String yUnit;
	private String typeaxis;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "Bar [id=" + id + ", varGap=" + varGap + ", yUnit=" + yUnit
				+ ", typeaxis=" + typeaxis + "]";
	}
	public String getVarGap() {
		return varGap;
	}
	public void setVarGap(String varGap) {
		this.varGap = varGap;
	}
	public String getyUnit() {
		return yUnit;
	}
	public void setyUnit(String yUnit) {
		this.yUnit = yUnit;
	}
	public String getTypeaxis() {
		return typeaxis;
	}
	public void setTypeaxis(String typeaxis) {
		this.typeaxis = typeaxis;
	}
}
