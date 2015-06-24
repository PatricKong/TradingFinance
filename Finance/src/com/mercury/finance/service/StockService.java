package com.mercury.finance.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.finance.model.Stock;


@Service
@Transactional
public class StockService {
	@Autowired
	@Qualifier("stockDao")
	private HibernateDao<Stock, Integer> stockD;
	
	public Stock findStock(String sname){
		return stockD.findBy("sname", sname);
	}
}
