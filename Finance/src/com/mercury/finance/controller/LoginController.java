package com.mercury.finance.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.finance.service.RegisterService;

@Controller
public class LoginController {
	@Autowired
	private RegisterService rs;
	@RequestMapping("/login")
	public String loginPage(){
		return "login";
	}
	@RequestMapping("/admin")
	public String adminPage(){
		return "admin";
	}
	@RequestMapping("/main")
	public ModelAndView mainPage(HttpServletRequest request){
		String username = request.getParameter("username");
		String pw = request.getParameter("password");
		ModelAndView mav=new ModelAndView();
		if(rs.verifyUser(username, pw))
		mav.setViewName(username + pw);
		return mav;
	}
}

