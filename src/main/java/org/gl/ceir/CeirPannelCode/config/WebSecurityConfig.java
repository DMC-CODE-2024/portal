package org.gl.ceir.CeirPannelCode.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;
import org.springframework.security.web.csrf.InvalidCsrfTokenException;
import org.springframework.security.web.csrf.MissingCsrfTokenException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private CustomLogoutHandler logoutHandler;
	
	@Override
	protected void configure(HttpSecurity http){
		try {
			http
			.authorizeRequests()
					.antMatchers("/pair-device","/repair-device","/check-pair-status","/customer-cares").permitAll()
			.and()
			.sessionManagement()
			.sessionCreationPolicy(SessionCreationPolicy.NEVER).invalidSessionUrl("/login").and()
			.formLogin().disable()
			.logout().logoutUrl("/manualLogout").permitAll().addLogoutHandler(logoutHandler).invalidateHttpSession(true).deleteCookies("JSESSIONID").and().
			/*headers().frameOptions().sameOrigin().cacheControl().disable().and()*/
			headers().xssProtection().and()
					.contentTypeOptions().disable().frameOptions().disable().cacheControl().disable().and()
			.exceptionHandling().accessDeniedHandler(accessDeniedHandler());
		}catch( Exception ex) {
			ex.printStackTrace();
		}
	}
	
	
	static class CustomAccessDeniedHandler extends AccessDeniedHandlerImpl{
		private final Logger log = LoggerFactory.getLogger(getClass());
		@Override
		public void handle(HttpServletRequest request, 
				HttpServletResponse response, AccessDeniedException accessDeniedException) 
						throws IOException, ServletException {
			log.info("Inside CustomAccessDeniedHandler method. Request:["+request.getRequestURI()+"]");
			if (accessDeniedException instanceof MissingCsrfTokenException
					|| accessDeniedException instanceof InvalidCsrfTokenException) {
				response.sendRedirect(request.getContextPath()+"/login");
			}
	
			super.handle(request, response, accessDeniedException);
	
		}
	}


	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		return new CustomAccessDeniedHandler();
	}
}