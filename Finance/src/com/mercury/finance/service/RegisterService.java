package com.mercury.finance.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.finance.mail.MailAppBean;
import com.mercury.finance.model.Login;
import com.mercury.finance.model.Trader;

@Service
@Transactional
public class RegisterService {
	@Autowired
	@Qualifier("traderDao")
	private HibernateDao<Trader, Integer> traderD;
	@Autowired
	@Qualifier("loginDao")
	private HibernateDao<Login, Integer> loginD;
	@Autowired
	private MailAppBean mb;

	public void createAccount(String fName, String lName, String email, String userName, String pw){
		Trader trader = new Trader(fName, lName, email, "PENDING");
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashedPassword = passwordEncoder.encode(pw);
		Login login = new Login(userName, hashedPassword);
		login.setTrader(trader);
		trader.setLogin(login);
		traderD.save(trader);
		sendEmail(email);
	}
	
	public boolean userExist(String userName){
		//loginD.findBy(property, value)
		return loginD.findAllBy("username", userName).size() == 0 ? false : true;
	}
	
	public boolean emailExist(String email){
		return traderD.findAllBy("email", email).size() == 0 ? false : true;
	}
	
	public void sendEmail(String email){
		Trader trader = traderD.findBy("email", email);
		Login login = trader.getLogin();
		String username = login.getUsername();
		String pw = login.getPassword();
		System.out.println(username + pw);
		String link = "http://localhost:8080/Finance/rest/register/verify?username=" + username + "&pw=" + pw;
		mb.sendMail(email, link, username);
	}
	
	public boolean verifyUser(String user, String pw){
		Login login = loginD.findBy("username", user);
		
		if(login == null){
			System.out.println(user);
			return false;
		}
		else if(login.getPassword().equals(pw)){
			login.getTrader().setRole("ROLE_USER");

			return true;
		}
		else
			return false;
	}
}
