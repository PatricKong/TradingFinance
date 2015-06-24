package com.mercury.finance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class StockController {
	@RequestMapping("/stockinfo")
	public String loginPage(){
		return "stockinfo";
	}
}
