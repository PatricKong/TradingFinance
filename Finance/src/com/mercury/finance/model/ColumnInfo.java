package com.mercury.finance.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class ColumnInfo {
	@XmlElement
	public String sname;
	@XmlElement
	public int sell;
	@XmlElement
	public int buy;
	public ColumnInfo(){}
	public ColumnInfo(String sname, int sell, int buy){
		this.sname = sname;
		this.sell = sell;
		this.buy = buy;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getSell() {
		return sell;
	}
	public void setSell(int sell) {
		this.sell = sell;
	}
	public int getBuy() {
		return buy;
	}
	public void setBuy(int buy) {
		this.buy = buy;
	}
	
	
}
