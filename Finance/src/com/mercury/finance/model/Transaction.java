package com.mercury.finance.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
@Entity
@Table(name = "Transaction")
public class Transaction {
	@XmlElement(name="trans_id")
	public int trans_id;
	@XmlElement(name="qty")
	public int qty;
	@XmlElement(name="status")
	public String status;
	@XmlElement(name="t_date")
	public String t_date;
	@XmlElement(name="process")
	public String process;
	@XmlTransient
	public Trader trader;
	@XmlElement(name="price")
	public double price;
	@XmlElement(name="sname")
	public String sname;
	@Id
	@GeneratedValue(generator="trans_seq")
	@SequenceGenerator(name="trans_seq",sequenceName="seq_trans", allocationSize=1)
	@Column(name = "trans_id", unique = true, nullable = false)
	public int getTrans_id() {
		return trans_id;
	}
	public void setTrans_id(int trans_id) {
		this.trans_id = trans_id;
	}

	@Column(name = "qty")
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	@Column(name = "status")
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Column(name = "t_date")
	public String getT_date() {
		return t_date;
	}
	public void setT_date(String t_date) {
		this.t_date = t_date;
	}
	@Column(name = "process")
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	@ManyToOne
    @JoinColumn(name="tid", insertable=false, updatable=false, nullable=false)
	public Trader getTrader() {
		return trader;
	}
	public void setTrader(Trader trader) {
		this.trader = trader;
	}
	@Column(name = "price")
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	@Column(name = "sname")
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}

	
	
//	@JoinColumn(name = "tid")
//	public int getTid() {
//		return tid;
//	}
//	public void setTid(int tid) {
//		this.tid = tid;
//	}

}
