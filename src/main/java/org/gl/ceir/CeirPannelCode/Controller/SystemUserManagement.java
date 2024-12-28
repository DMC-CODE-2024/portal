package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Service.ProfileService;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.gl.ceir.CeirPannelCode.datatable.model.UserManagementContent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class SystemUserManagement {
	
	@Autowired
	ProfileService profileService;
	
	@Autowired
	APIService4Feign apiService4Feign;
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value=
		{"/usertypeManagment"},method={org.springframework.web.bind.annotation.
				RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
			)
	    public ModelAndView viewMessageManagement(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		 log.info(" view viewUserManagement entry point."); 
		 mv.setViewName("viewUserManagement");
		log.info(" view viewUserManagement exit point."); 
		return mv; 
	}
	
	

	@RequestMapping(value ="/updateSystemUserTypeStatus",method = RequestMethod.POST)
	@ResponseBody
	public  HttpResponse changeSystemUserTypeStatus(@RequestBody UserManagementContent userManagementContent,HttpSession session) {
		return profileService.changeSystemUserStatusService(userManagementContent,session);

	}
	
	
	//------------------------------------ Export Field controller ------------------------------------

		@PostMapping("exportUserTypeData")
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
			response= apiService4Feign.viewUserTypeRequest(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
			FileExportResponse fileExportResponse;
			Gson gson= new Gson(); 
			String apiResponse = gson.toJson(response);
			fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
			log.info("response  from  Export User Management api="+fileExportResponse);

			return fileExportResponse;
		}
		
		//------------------------------------- view userType ----------------------------------------							
		
			@PostMapping("userTypeViewByID") 
			public @ResponseBody GenricResponse viewCurrency (@RequestBody FilterRequest filterRequest,HttpSession session )  {
				filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
				filterRequest.setBrowser(session.getAttribute("browser").toString());
				log.info("request send to the View userType api="+filterRequest);
				GenricResponse response= apiService4Feign.viewUserTypeFeign(filterRequest);
				log.info("response from userType api "+response);
				return response;
		}
}
