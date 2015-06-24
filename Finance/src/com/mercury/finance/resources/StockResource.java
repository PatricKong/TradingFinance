package com.mercury.finance.resources;


import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.finance.model.Stock;
import com.mercury.finance.model.StockInfo;
import com.mercury.finance.service.AdminService;
import com.mercury.finance.service.YahooFinance;
@Component
@Path("/finance")
public class StockResource {
	private StockInfo stockInfo;
	@Autowired
	private AdminService as;

	@GET
	@Path("/getstocks")
	@Produces({MediaType.APPLICATION_JSON})
	public StockInfo execute() {
		int size = 0;
		if (stockInfo==null) {
			stockInfo = new StockInfo();
			stockInfo.setStocks(new ArrayList<Stock>());
			size = as.getStocks().size();
			List<Stock> stocks = as.getStocks();
			String[] snames = new String[size];
			for(int i = 0; i < size; i++){
				snames[i] = stocks.get(i).getSname();
			}
			for (String sname:snames) {
				Stock stock = new Stock();
				stock.setSname(sname);
				stockInfo.addStock(stock);
			}
		}
		System.out.println("I have size of " + stockInfo.getStocks().size());
		YahooFinance.marketData(stockInfo.getStocks());
		return stockInfo;
	}
	@POST
	@Path("/addstock")
	@Produces({MediaType.APPLICATION_JSON})
	public void addStock(@QueryParam("sname") String sname){
		System.out.println(sname + "sname");
		if(!(sname==null)){
			System.out.println(sname + "sname");
			Stock stock = new Stock();
			stock.setSname(sname);
			stockInfo.addStock(stock);
			as.addStock(stock);
		}

	}
	@POST
	@Path("/deletestock")
	@Produces({MediaType.APPLICATION_JSON})
	public void deleteStock(@QueryParam("sname") String sname){
		Stock stock = new Stock();
		stock.setSname(sname);
		as.deleteStock(stock);
		stockInfo = null;
	}
}
