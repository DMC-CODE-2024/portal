package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Model.CustomerCareByTxnId;
import org.gl.ceir.CeirPannelCode.Model.CustomerCareRequest;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.GsmaDetail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class CCgsmaController {
	private final Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	GsmaFeignClient gsmaFeignClient;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	

	@PostMapping("getGsmaDetails")
	public @ResponseBody GsmaDetail getDetails(
			@RequestBody FilterRequest filterRequest,HttpSession session) {
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
	    filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("request passed to the getGsmaDetails Api msisdn-->"+filterRequest);
		GsmaDetail response = gsmaFeignClient.viewGsmaFeign(filterRequest);
		log.info("response after getGsmaDetails." + response);
		return response;

	}
	
	
	
	//----------------------------  View Customer details ------------------------------- 
	
	@PostMapping("/customerRecord")
	public @ResponseBody GenricResponse viewCustomerDetails(
			@RequestParam(name = "listType", required = false) String listType,
			@RequestBody CustomerCareRequest customerCareRequest) {
		log.info("request send to the Customer details api=" + customerCareRequest+" listType-->" +listType);
		GenricResponse response = feignCleintImplementation.viewcustomerDetialsfeign(listType, customerCareRequest);
		log.info("response from Customer details api " + response);
		return response;

	}
	
	@PostMapping("/customeCareByTxnId")
	public @ResponseBody GenricResponse customeCareByTxnId(HttpServletRequest request,HttpSession session) {
		
		log.info("request......"+ request);
		String filter = request.getParameter("customerCareRequest");
		Gson gson= new Gson(); 
		CustomerCareByTxnId customerCarebytxnId  = gson.fromJson(filter,CustomerCareByTxnId.class);
		customerCarebytxnId.setPublicIp(session.getAttribute("publicIP").toString());
		customerCarebytxnId.setBrowser(session.getAttribute("browser").toString());
		log.info("request passed to the api=="+customerCarebytxnId);
		GenricResponse response = feignCleintImplementation.customerCareViaTxnId(customerCarebytxnId);
		log.info("response from Customer details api " + response);
		return response;

	}

	//----------------------------  Check imei exist or not  ------------------------------- 
	
	@PostMapping("/checkMsisdnExist")
	public @ResponseBody String checkMsisdnExist(HttpSession session,
			@RequestParam(name = "imei", required = false) String imei,@RequestParam(name = "msisdn", required = false) String msisdn) {
		
		String publicIp=session.getAttribute("publicIP").toString();
	    String browser=session.getAttribute("browser").toString();
		
		log.info("request send to the check msisdn exist or not  details api=" + msisdn+" imei-->" +imei);
		String response  = gsmaFeignClient.checkImeiDetails(imei,msisdn,publicIp,browser);
		log.info("response from check msisdn exist api-----------------++++++++&&&&&&&&& " + response);
		return response;

	}
}
