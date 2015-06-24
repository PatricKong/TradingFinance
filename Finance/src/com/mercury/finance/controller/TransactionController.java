package com.mercury.finance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mercury.finance.model.Trader;
import com.mercury.finance.model.Transaction;
import com.mercury.finance.service.TraderDetailsService;
import com.mercury.finance.service.TransactionService;

@Controller
public class TransactionController {
	@Autowired
	TransactionService ts;
	@Autowired
	TraderDetailsService traders;
	@RequestMapping("/transaction")
	public String testTransaction(){
		Transaction trans = new Transaction();
		Trader trader = traders.getTrader(66);
		trans.setPrice(4.4);
		trans.setProcess("pending");
		trans.setStatus("sell");
		trans.setT_date("11-22");
		trans.setQty(20);
		trans.setSname("C");
		trader.setTransaction(trans);
		traders.saveTrader(trader);
		trans.setTrader(trader);
		ts.saveToFile("C:/Users/Zhiyong/NewOne/Finance/WebContent/transactions.csv", trans);
		//adminS.csvToTransactions("C:/Users/Zhiyong/Desktop/transactions.csv");
		return "OK";
	}
	@RequestMapping("/committransactions")
	public void commitTransactions(){
		ts.commitAll("C:/Users/Zhiyong/NewOne/Finance/WebContent/transactions.csv");
	}
}
