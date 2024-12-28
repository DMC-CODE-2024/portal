package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.datatable.model.MessageContentModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class SystemAdminController {
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	@RequestMapping(value=
		{"/messageManagement"},method={org.springframework.web.bind.annotation.
				RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
			)
	    public ModelAndView viewMessageManagement(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		 log.info(" view viewMessageManagement entry point."); 
		 mv.setViewName("viewMessageManagement");
		log.info(" view viewMessageManagement exit point."); 
		return mv; 
	}
	
	

	
	
	@PostMapping("/message/viewTag") 
	public @ResponseBody MessageContentModel policyViewTag (@RequestBody FilterRequest filterRequest, HttpSession session)  {
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("request send to the policyViewTag api="+filterRequest);
		MessageContentModel response= feignCleintImplementation.viewMessageFeign(filterRequest);

		log.info("response from currency api "+response);
		return response;

		}
	
	
	
	@PutMapping("/message/update")
	public @ResponseBody MessageContentModel updateMessage (@RequestBody MessageContentModel messageContentModel,HttpSession session) {
		messageContentModel.setPublicIp(session.getAttribute("publicIP").toString());
		messageContentModel.setBrowser(session.getAttribute("browser").toString());
		log.info("request send update Messsage api="+messageContentModel);
		messageContentModel = feignCleintImplementation.updateMessages(messageContentModel);
		log.info("response from update Message api "+messageContentModel);
		return messageContentModel;
		
	}
	
	@PostMapping("exportMessageConfigData")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest,HttpSession session)
	{
		Gson gsonObject=new Gson();
		Object response;
		Integer file = 1;	
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("filterRequest:::::::::"+filterRequest);
		response= feignCleintImplementation.adminMessageFeign(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson= new Gson(); 
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response from Message Management Export  api="+fileExportResponse);

		return fileExportResponse;
	}	
	
	
}
