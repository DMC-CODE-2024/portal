package org.gl.ceir.CeirPannelCode.Controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.CheckImeiRequest;
import org.gl.ceir.CeirPannelCode.Model.ImeiResponse;
import org.gl.ceir.CeirPannelCode.Model.PeriodValidate;
import org.gl.ceir.CeirPannelCode.Model.UserHeader;
import org.gl.ceir.CeirPannelCode.Service.RegistrationService;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CheckDeviceController {
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	FeignCleintImplementation feignCleintImplementation;

	@Autowired
    APIService4Feign userRegistrationFeignImpl;

	@Autowired
	RegistrationService registerService;
	
	@Autowired
	GsmaFeignClient gsmaFeignClient;
	
	
	
	@RequestMapping(value=
		{"/services/checkIMEIPortal"},method={org.springframework.web.bind.annotation.RequestMethod.GET})
	    public ModelAndView viewConsignment(HttpSession session,@RequestParam(name="utm_source",required = false,defaultValue = "eirs_web") String utm_source,
	    		@RequestParam(name="IMEI",required = false,defaultValue = "000000000000000") String imei,
	    		@RequestParam(name="rightPanel",required = false,defaultValue = "no") String rightPanel) {
		
	
		
		log.info("utm_source value="+utm_source);
		HttpResponse httpResponse=userRegistrationFeignImpl.periodValidate(new PeriodValidate(17L, 44L));
		ModelAndView mv = new ModelAndView();
		
		if(httpResponse.getStatusCode() == 200) {
			log.info("view Check Device entry point."); 
			if(rightPanel.equalsIgnoreCase("yes")) {
				mv.setViewName("checkIMEIiFrame");	
			}
			else if(rightPanel.equalsIgnoreCase("iframe")) {
				 System.out.println("iframe page");
				mv.setViewName("iframe");
			}
			else {
				mv.setViewName("checkIMEI");	
			}
			
			mv.addObject("utm_source", utm_source);
			mv.addObject("rightPanel", rightPanel);
			if(imei.equals("000000000000000")) {
				mv.addObject("IMEIStatus", "default");
				mv.addObject("IMEI", imei);
			}
			else {
				mv.addObject("IMEIStatus", "invalidIMEI");
				mv.addObject("IMEI", imei);
			}
		
			log.info(" view Check Device  exit point."); 
		}
		else {
			mv.setViewName("registrationPopup");
		}
		return mv; 
	}


	@CrossOrigin(origins = "*", allowedHeaders = "*")
	@PostMapping("/checkDevice") 
	public @ResponseBody ImeiResponse checkImei(@RequestBody CheckImeiRequest checkImeiRequest, HttpServletRequest request)  {
		//String validCaptcha=(String)session.getAttribute("captcha_security");
		   System.out.println("request send to the checkImei api=" +checkImeiRequest);
		    UserHeader header=registerService.getUserHeaders(request);
		    checkImeiRequest.setPublicIp(header.getPublicIp());
		    checkImeiRequest.setBrowser(header.getBrowser());
			log.info("request send to the checkImei api=" +checkImeiRequest);
			ImeiResponse response= gsmaFeignClient.viewDetails(checkImeiRequest);
			log.info("response from checkImei api " +response);
			return response;
	}
	
	
	
	@PostMapping("/report")
    public void report(HttpServletRequest request) throws IOException {
        if (log.isInfoEnabled()) {
            log.info("Report: {}", IOUtils.toString(request.getInputStream()));
        }
    }


}
