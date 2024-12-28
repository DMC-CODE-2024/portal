package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EIRSSupportController {
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value=
		{"/eirs-support-dashboard"},method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public ModelAndView viewDashBoard(HttpSession session) {

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("token", session.getAttribute("token"));
		mv.setViewName("eirs-support-dashboard");	
		return mv; 
	}
	@RequestMapping(value=
		{"/eirs-support-register-ticket"},method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public ModelAndView viewRegisterTicket(HttpSession session) {

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("token", session.getAttribute("token"));
		mv.setViewName("eirs-support-register-ticket");	
		return mv; 
	}
	@RequestMapping(value=
		{"/eirs-support-check-ticket-status"},method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public ModelAndView viewCTicketStatus(HttpSession session) {

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("token", session.getAttribute("token"));
		mv.setViewName("eirs-support-check-ticket-status");	
		return mv; 
	}
	@RequestMapping(value=
		{"/eirs-support-ticket"},method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public ModelAndView viewTicket(HttpSession session) {

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("token", session.getAttribute("token"));
		mv.setViewName("eirs-support-ticket");	
		return mv; 
	}

}
