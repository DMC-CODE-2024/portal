package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.datatable.model.AuditContentModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class AuditTrailManageController {
	
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value=
		{"/auditTrailHistory"},method={org.springframework.web.bind.annotation.
				RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
			)
	    public ModelAndView viewMessageManagement(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		 log.info(" view audit Trail Management entry point."); 
		 mv.setViewName("auditTrailManagement");
		log.info(" view audit Trail Management exit point."); 
		return mv; 
	}


	
	
	@ResponseBody
	@GetMapping("/audittrail/view/{id}")
	public AuditContentModel AuditManagementView(@PathVariable("id") Integer id, HttpSession session) {
		String publicIP = session.getAttribute("publicIP").toString();
		String browser = session.getAttribute("browser").toString();
		AuditContentModel auditContentModel  = feignCleintImplementation.viewAuditTrailManagementFeign(id);
		log.info("AuditContentModel response::::::::"+auditContentModel);
		return auditContentModel;
	}

	

	//***************************************** Export Audit controller *********************************
	
	
	
	@PostMapping("exportAuditTrailData")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest,HttpSession session)
	{
		Gson gsonObject=new Gson();
		Object response;
		Integer file = 1;	
		
		log.info("filterRequest:::::::::"+filterRequest);
		response= feignCleintImplementation.auditTrailManagementFeign(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson= new Gson(); 
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response  from  Alert Export  api="+fileExportResponse);
		return fileExportResponse;
	}	
}
