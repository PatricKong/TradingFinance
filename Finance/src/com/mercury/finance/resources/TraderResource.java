package com.mercury.finance.resources;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.mercury.finance.model.ColumnInfo;
import com.mercury.finance.model.PieInfo;
import com.mercury.finance.model.Stock;
import com.mercury.finance.model.StockInfo;
import com.mercury.finance.model.Trader;
import com.mercury.finance.model.Transaction;
import com.mercury.finance.service.StockService;
import com.mercury.finance.service.TraderDetailsService;
import com.mercury.finance.service.TransactionService;
import com.mercury.finance.service.YahooFinance;

@Component
@Path("/user")
public class TraderResource {
	private StockInfo stockInfo;
	private Trader trader;
	
	@Autowired
	private TraderDetailsService ts;
	@Autowired
	private StockService ss;
	@Autowired
	private TransactionService transService;
	@GET
	@Path("/gethistory")
	@Produces({MediaType.APPLICATION_JSON})
	public Set<Transaction> getPortfolio(){
		//get user data from transactions
		if(trader == null){
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String username = auth.getName();
			trader = ts.getTrader(username);
		}
		return trader.getTransactions();
	}
	
	@GET
	@Path("/getinterestedstock")
	@Produces({MediaType.APPLICATION_JSON})
	public StockInfo getInterestedStock(){
		//get user data from transactions
		if(trader == null){
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String username = auth.getName();
			trader = ts.getTrader(username);
		}
		int size = 0;
		if (stockInfo==null) {
			stockInfo = new StockInfo();
			stockInfo.setStocks(new ArrayList<Stock>());
			Set<Stock> stocks = trader.getStocks();
			size = stocks.size();
			String[] snames = new String[size];
			int temp = 0;
			for(Stock stock:stocks){
				snames[temp] = stock.getSname();
				temp++;
			}
			for (String sname:snames) {
				Stock stock = new Stock();
				stock.setSname(sname);
				stockInfo.addStock(stock);
			}
		}
		
		YahooFinance.marketData(stockInfo.getStocks());
		return stockInfo;
	}
	
	@POST
	@Path("/deletestock")
	@Produces({MediaType.APPLICATION_JSON})
	public void deleteStock(@QueryParam("sname") String sname){
		Stock stock = ss.findStock(sname);
		trader.deleteStock(stock);
		ts.saveTrader(trader);
		System.out.println(sname);
	}
	
	@POST
	@Path("/purchasestock")
	@Produces({MediaType.APPLICATION_JSON})
	public String purchaseStock(@QueryParam("type") String type,
			@QueryParam("sname") String sname,@QueryParam("qty") String qty){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		trader = ts.getTrader(username);
		Transaction trans = new Transaction();
		Stock stock = new Stock();
		stock.setSname(sname);
		YahooFinance.getPrice(stock);
		if(type.equals("buy")){
			if(stock.getPrice() * Integer.parseInt(qty) > trader.getBalance())
				return "false";
			trader.setBalance(trader.getBalance() - stock.getPrice() * Integer.parseInt(qty) - 5);
		}
		else{
			trader.setBalance(trader.getBalance() + stock.getPrice() * Integer.parseInt(qty) - 5);
		}
		trans.setPrice(stock.getPrice());
		trans.setProcess("pending");
		trans.setStatus(type);
		trans.setT_date("02-06-2015");
		trans.setQty(Integer.parseInt(qty));
		trans.setSname(sname);
		trader.setTransaction(trans);
		ts.saveTrader(trader);
		trans.setTrader(trader);
		transService.saveToFile("C:/Users/Zhiyong/NewOne/Finance/WebContent/transactions.csv", trans);
		return "true";
	}
	
	@POST
	@Path("/addstock")
	@Produces({MediaType.APPLICATION_JSON})
	public void addStock(@FormParam("sname") String sname){
		
		if(!sname.equals("")){
			System.out.println(sname + "sname");
			Stock stock = ss.findStock(sname);
			trader.setStock(stock);
			ts.saveTrader(trader);
			stockInfo.addStock(stock);
		}
	}
	
	@GET
	@Path("/getpie")
	@Produces({MediaType.APPLICATION_JSON})
	public Set<PieInfo> getPie(){
		//get user data from transactions
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		trader = ts.getTrader(username);
		Set<Transaction> transactions = trader.getTransactions();
		Map<String, Double> map = new HashMap<String, Double>();
		Set<PieInfo> pieChart = new HashSet<PieInfo>();
		
		
		for (Transaction transaction : transactions){
			String sname = transaction.getSname();
			Stock stock = new Stock();
			stock.setSname(sname);
			YahooFinance.getPrice(stock);
			String status = transaction.getStatus();
			int qty = transaction.getQty();
			String process = transaction.getProcess();
			Double currentValue = stock.getPrice();
			if(process.equals("complete")){
				if (map.containsKey(sname)){
					if(status.equals("sell"))
						map.put(sname, map.get(sname) - (qty * currentValue));
					else
						map.put(sname, map.get(sname) + (qty * currentValue));
				}else{
					if(status.equals("sell"))
						map.put(sname, 0 - (qty * currentValue));
					else
						map.put(sname, 0 + (qty * currentValue));
				}
			}
		}
		Set<String> keys = map.keySet();
		for (String key: keys){
			PieInfo pie = new PieInfo(key, map.get(key));
			pieChart.add(pie);
		}
		System.out.println("size is " + map.size() + "value is " + map.get("C"));
		return pieChart;
	}
	
	@GET
	@Path("/getcolumn")
	@Produces({MediaType.APPLICATION_JSON})
	public Set<ColumnInfo> getColumn(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		trader = ts.getTrader(username);
		Set<Transaction> transactions = trader.getTransactions();
		Set<ColumnInfo> column = new HashSet<ColumnInfo>();
		Map<String, int[]> mystocks = new HashMap<String, int[]>();
		for (Transaction transaction : transactions){
			String sname = transaction.getSname();
			String status = transaction.getStatus();
			String process = transaction.getProcess();
			int qty = transaction.getQty();
			if(process.equals("complete")){
				if(mystocks.containsKey(sname)){
					int[] value = new int[2];
					int[] pastValue = mystocks.get(sname);
					if(status.equals("sell")){
						value[0] = qty + pastValue[0];
						value[1] = pastValue[1];
						mystocks.put(sname, value);
					}				
					else{
						value[1] = qty + pastValue[1];
						value[0] = pastValue[0];
						mystocks.put(sname, value);
					}
				}
				else{
					int[] value = new int[2];
					if(status.equals("sell")){
						value[0] = qty;
						value[1] = 0;
						mystocks.put(sname, value);
					}
						
					else{
						value[1] = qty;
						value[0] = 0;
						mystocks.put(sname, value);
					}
				}
			}
			
		}
		Set<String> keys = mystocks.keySet();
		for (String key : keys){
			int[] values = mystocks.get(key);
			ColumnInfo columnInfo = new ColumnInfo(key, values[0], values[1]);
			column.add(columnInfo);
		}
		System.out.println("columnInfo size is " + column.size());
		return column;
	}
	
	@POST
	@Path("/addmoney")
	@Produces({MediaType.APPLICATION_JSON})
	public void addMoney(@QueryParam("amount") int amount){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		trader = ts.getTrader(username);
		trader.setBalance(amount + trader.getBalance());
		ts.saveTrader(trader);
		System.out.println("amount " + amount);
	}
	
	@GET
	@Path("/getmoney")
	@Produces({MediaType.APPLICATION_JSON})
	public String getMoney(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		trader = ts.getTrader(username);
		return Double.toString(trader.getBalance());
	}
}
  