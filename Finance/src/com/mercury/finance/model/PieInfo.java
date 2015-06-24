package com.mercury.finance.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class PieInfo {
	@XmlElement
	public String sname;
	@XmlElement
	public double value;
	public PieInfo(){}
	public PieInfo(String sname, double value){
		this.sname = sname;
		this.value = value;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public double getValue() {
		return value;
	}
	public void setValue(double value) {
		this.value = value;
	};
	
}
