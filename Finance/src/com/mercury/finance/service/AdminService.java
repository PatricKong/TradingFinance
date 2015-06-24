package com.mercury.finance.service;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.finance.model.Stock;
import com.mercury.finance.model.Trader;
import com.mercury.finance.model.Transaction;

@Service
@Transactional
public class AdminService {
	@Autowired
	@Qualifier("stockDao")
	private HibernateDao<Stock, Integer> stockD;
	@Autowired
	@Qualifier("traderDao")
	private HibernateDao<Trader, Integer> traderD;
	@Autowired
	@Qualifier("transactionDao")
	private HibernateDao<Transaction, Integer> transD;

	public void addStock(Stock stock){
		stockD.save(stock);
	}
	public void deleteStock(Stock stock){
		Stock mystock = stockD.findBy("sname", stock.getSname());
		stockD.delete(mystock);
	}
	public List<Stock> getStocks(){
		return stockD.findAll();
	}
	public void csvToTransactions(String path){   
		String csvFile = path;
		BufferedReader br = null;
		String line = "";
		String cvsSplitBy = ",";
		try {
			br = new BufferedReader(new FileReader(csvFile));
			br.readLine();
			while ((line = br.readLine()) != null) {
			        // use comma as separator
				String[] csvString = line.split(cvsSplitBy);
				int tid = Integer.parseInt(csvString[0]);
				int qty = Integer.parseInt(csvString[1]);
				String status = csvString[2];
				String t_date = csvString[3];
				String process = csvString[4];
				double price = Double.parseDouble(csvString[5]);
				
				Transaction transaction = new Transaction();
				Trader trader = traderD.findById(tid);
				transaction.setPrice(price);
				transaction.setProcess(process);
				transaction.setQty(qty);
				transaction.setStatus(status);
				transaction.setT_date(t_date);
				transaction.setTrader(trader);
				commitTransaction(transaction);
			}
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	public void commitTransaction(Transaction trans){
		String process = trans.getProcess();
		Trader trader = trans.getTrader();
		int qty = trans.getQty();
		double price = trans.getPrice();
		double balance = trader.getBalance();
		if (process.equals("sell"))
			balance = balance - qty * price - 5;
		else
			balance = balance + qty * price - 5;
		trans.setStatus("success");
		trader.setBalance(balance);
		trader.setTransaction(trans);
		traderD.save(trader);
	}
	
	public void failTransaction(int trans_id){
		Transaction trans= transD.findBy("trans_id", trans_id);
		trans.setStatus("reject");
		transD.save(trans);
	}
	
}
