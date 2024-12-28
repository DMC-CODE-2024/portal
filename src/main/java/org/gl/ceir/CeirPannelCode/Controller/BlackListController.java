package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.datatable.model.ConfigContentModel;
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
public class BlackListController {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	
	@RequestMapping(value=
		{"/blackListView"},method={org.springframework.web.bind.annotation.RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
			)
	    public ModelAndView viewBlackListManagement(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		 log.info(" view Black List ConfigManagement entry point."); 
		 mv.setViewName("viewBlackListManagement");
		log.info(" view Black Lis Management exit point."); 
		return mv; 
	}
	
	
	@PostMapping("/blacklist/viewTag") 
	public @ResponseBody ConfigContentModel SystemConfigViewTag (@RequestBody FilterRequest filterRequest,HttpSession session)  {
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		filterRequest.setFilterPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setFilterBrowser(session.getAttribute("browser").toString());
		log.info("request send to the viplist ViewTag api="+filterRequest);
		ConfigContentModel response= feignCleintImplementation.viewBlackListFeign(filterRequest);
		log.info("viplist response from currency api "+response);
		return response;
	}
	
	
	@PutMapping("/blacklist/update")
	public @ResponseBody GenricResponse updateSystem (@RequestBody ConfigContentModel configContentModel,HttpSession session) {
		log.info("hello/viplist/update request send update Messsage api ##################");
		log.info("1-/viplist/update request send update Messsage api ##################="+configContentModel.toString());
		configContentModel.setPublicIp(session.getAttribute("publicIP").toString());
		configContentModel.setBrowser(session.getAttribute("browser").toString());
		log.info("viplist 2-request send update Messsage api="+configContentModel);
		log.info("3-/system/update request send update Messsage api ##################");
		GenricResponse Response = feignCleintImplementation.updateSystem(configContentModel);
		log.info("4-response from update Message api "+Response);
		return Response;
		
	}
	
	
	
	
	@PostMapping("exportBlackListData")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest,HttpSession session)
	{
		Gson gsonObject=new Gson();
		Object response;
		Integer file = 1;	
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("viplist filterRequest:::::::::"+filterRequest);
		response= feignCleintImplementation.blackListView(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson= new Gson(); 
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response from viplist Export  api="+fileExportResponse);

		return fileExportResponse;
	}		
	
}
