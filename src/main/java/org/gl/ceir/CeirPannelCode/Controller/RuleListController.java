package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class RuleListController {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	
@GetMapping("ruleListMav")
public ModelAndView view() {
	return new ModelAndView("ruleList");
	
}


//------------------------------------ Export Address controller ------------------------------------

@PostMapping("exportRuleList")
@ResponseBody
public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest,HttpSession session)
{
	Gson gsonObject=new Gson();
	Object response;
	Integer file = 1;	
	String userType=(String) session.getAttribute("usertype");
	Integer usertypeId=(int) session.getAttribute("usertypeId");
	filterRequest.setUserType(userType);
	filterRequest.setUserTypeId(usertypeId);
	filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
	filterRequest.setBrowser(session.getAttribute("browser").toString());
	log.info("filterRequest:::::::::"+filterRequest);
	response= feignCleintImplementation.ruleListFeign(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
	FileExportResponse fileExportResponse;
	Gson gson= new Gson(); 
	String apiResponse = gson.toJson(response);
	fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
	log.info("response  from  Export Rule api="+fileExportResponse);

	return fileExportResponse;
}	
}
