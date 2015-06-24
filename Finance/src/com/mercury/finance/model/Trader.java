package com.mercury.finance.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


@Entity
@Table(name="trader")
public class Trader {
	public int tid;
	public String fname;
	public String lname;
	public String email;
	public String role;
	public double balance;
	public Login login;
	public Set<Transaction> transactions = new HashSet<Transaction>();
    private Set<Stock> stocks = new HashSet<Stock>();
	
	public Trader(){}
	
	public Trader(String fname, String lname, String email, String role){
		this.fname = fname;
		this.lname = lname;
		this.role = role;
		this.email = email;
		this.balance = 0;
	}

	@GeneratedValue(generator="trader_seq")
	@SequenceGenerator(name="trader_seq",sequenceName="seq_trader", allocationSize=1)
	@Id
	@Column(name = "tid", unique = true, nullable = false)
	public int getTid() {
		return tid;
	}
	
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	@Column(name = "fname",  length = 30)
	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}
	
	@Column(name = "lname",length = 30)
	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}
	@Column(name = "email", length = 30)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "role", length = 20)
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Column(name = "balance")
	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name="tid")
	public Set<Transaction> getTransactions() {
		return transactions;
	}

	public void setTransactions(Set<Transaction> transactions) {
		this.transactions = transactions;
	}
	
	public void setTransaction(Transaction transaction){
		transactions.add(transaction);
	}
	///for one to one login annotation

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "trader", cascade = CascadeType.ALL)
	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}

	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "trader_stock", joinColumns = { @JoinColumn(name = "tid") }, 
	inverseJoinColumns = { @JoinColumn(name = "sid") })
	public Set<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(Set<Stock> stocks) {
		this.stocks = stocks;
	}
	
	public void setStock(Stock stock){
		stocks.add(stock);
	}
	public void deleteStock(Stock stock){
		stocks.remove(stock);
	}
}
