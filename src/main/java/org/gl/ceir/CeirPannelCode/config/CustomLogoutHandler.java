package org.gl.ceir.CeirPannelCode.config;

import org.gl.ceir.CeirPannelCode.Service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
public class CustomLogoutHandler implements LogoutHandler {

	private final Logger log = LoggerFactory.getLogger(getClass());	
	@Autowired
	LoginService loginService;
	
	
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		log.info("coming in custom log out handler");
		loginService.logout( request.getSession(), request );	
		log.info("coming out from  custom log out handler");
	}
}
