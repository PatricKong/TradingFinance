package com.mercury.finance.service;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.mercury.common.db.HibernateDao;
import com.mercury.finance.model.Login;
import com.mercury.finance.model.Trader;
import com.mercury.finance.model.Transaction;

@Service
@Transactional
public class TraderDetailsService{
	@Autowired
	@Qualifier("traderDao")
	private HibernateDao<Trader, Integer> td;
	@Autowired
	@Qualifier("loginDao")
	private HibernateDao<Login, Integer> loginD;
	
	public void setTd(HibernateDao<Trader, Integer> td) {
		this.td = td;
	}
	
	public HibernateDao<Trader, Integer> getTd(){
		return td;
	}

	
	public void saveTrader(Trader trader){
		td.save(trader);
	}
	
	public Trader getTrader(int tid){
		return td.findById(tid);
	}
	
	public Trader getTrader(String username){
		int tid = loginD.findBy("username", username).tid;
		return td.findById(tid);
	}
	
	public Set<Transaction> getTransactions(String username){
		Login login = loginD.findBy("username", username);
		Trader trader = td.findById(login.getTid());
		return trader.getTransactions();
	}
}
