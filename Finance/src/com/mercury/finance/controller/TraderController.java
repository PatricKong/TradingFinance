package com.mercury.finance.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.finance.model.Login;
import com.mercury.finance.model.Stock;
import com.mercury.finance.model.Trader;
import com.mercury.finance.model.Transaction;
import com.mercury.finance.service.TraderDetailsService;

@Controller
public class TraderController {
	@Autowired
	TraderDetailsService traders;
	@RequestMapping(value="/user")
	public ModelAndView traderPage(HttpServletRequest request){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user");
		Trader trader = traders.getTrader(name);
		mav.addObject("trader", trader);
		System.out.println(name);
		return mav;
	}
	@RequestMapping("/test")
	public ModelAndView insertTrader(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		Trader trader = new Trader();
		Login login = new Login();
		Stock stock = new Stock();
		Transaction transaction = new Transaction();
		transaction.setQty(10);
		transaction.setPrice(3.11);
		transaction.setProcess("sell");
		transaction.setStatus("pending");
		trader.setBalance(3000);
		trader.setEmail("alice@gmail.com");
		trader.setFname("Alice");
		trader.setLname("Chen");
		trader.setRole("Admin");
		stock.setSname("ABC");
		login.setUsername("Alice");

		//One to One mapping for trader and login
		login.setTrader(trader);
		trader.setLogin(login);
		
		//One to Many mapping for trader and transaction
		trader.setTransaction(transaction);
		
		//many to many mapping for trader and stock
		trader.setStock(stock);
//		
		traders.saveTrader(trader);
		//trader.addTrans(transaction);
		
		
		mav.setViewName("front");//default forward
		mav.addObject("msg", "Hello Welcom to Spring MVC!");
		return mav;
	}
}
