package com.mercury.finance.model;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@Entity
@Table(name = "stock")
public class Stock {
	@XmlElement(name="sid")
	public int sid;
	@XmlElement(name="sname")
	public String sname;
	@XmlElement(name="price")
	public double price;
	@XmlElement(name="change")
	public double change;
	
	public Stock(){}

	@Id
	@GeneratedValue(generator="stock_seq")
	@SequenceGenerator(name="stock_seq",sequenceName="seq_stock", allocationSize=1)
	@Column(name = "sid", unique = true, nullable = false)
	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}
	@Column(name = "sname", unique = true, nullable = false)
	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}
	@Column(name = "price")
	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	@Column(name = "change")
	public double getChange() {
		return change;
	}

	public void setChange(double change) {
		this.change = change;
	}
	
	
}
