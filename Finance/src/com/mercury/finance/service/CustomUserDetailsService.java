package com.mercury.finance.service;


import java.util.ArrayList;
import java.util.Collection;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.finance.model.Login;
import com.mercury.finance.model.Trader;


@Service
@Transactional(readOnly = true)
public class CustomUserDetailsService  implements UserDetailsService{
	private Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	@Qualifier("traderDao")
	private HibernateDao<Trader, Integer> traderD;
	@Autowired
	@Qualifier("loginDao")
	private HibernateDao<Login, Integer> loginD;
		
//	public HibernateDao<Trader, Integer> getTraderD() {
//		return traderD;
//	}
//
//	public void setTraderD(HibernateDao<Trader, Integer> traderD) {
//		this.traderD = traderD;
//	}



	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		UserDetails user = null;  
		try {
			Login login = loginD.findBy("username", username);
			int tid = login.getTid();

			Trader trader = traderD.findBy("tid", tid);
			Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			authorities.add(new SimpleGrantedAuthority(trader.getRole()));
			System.out.println(username+trader.getRole()+login.getPassword());
			user = new User(
					login.getUsername(),
					login.getPassword(),
					true,
					true,
					true,
					true,
					authorities 
			);
		} catch (Exception e) {
			logger.error("Error in retrieving user" + e.getMessage());
			throw new UsernameNotFoundException("Error in retrieving user");
		}
		return user;
	}		  
}
