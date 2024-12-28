package org.gl.ceir.CeirPannelCode.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DBTablesFeignClient;
import org.gl.ceir.CeirPannelCode.Model.DBrowDataModel;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.ReportResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class ReportController {
		

	private final Logger log = LoggerFactory.getLogger(getClass());

	
	
	@Autowired
	DBTablesFeignClient dBTablesFeignClient;
	
	@GetMapping("/report")
	public ModelAndView pageView(@RequestParam(name="via", required = false) String via,
								@RequestParam(name="tableName", required = false) String tableName, HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		if("other".equals(via)) {
			modelAndView.setViewName("viewReport");
			modelAndView.addObject("tableName",tableName);
		}
		else {
			modelAndView.setViewName("selectReport");
		}
		return modelAndView;
	}

	
	/*---------------------------------------- Select Report Dropdown ----------------------------------------*/
	
	@RequestMapping(value="/getallreports", method = {org.springframework.web.bind.annotation.RequestMethod.POST})
	public @ResponseBody List<ReportResponse> dbReportList(@RequestParam(name="reportCategory", required = false) Integer reportCategory,
			@RequestParam(name="featureId", required = false) Integer featureId,
			@RequestParam(name="userId", required = false) Integer userId,
			@RequestParam(name="userType", required = false) String userType,HttpSession session){
		String publicIp=session.getAttribute("publicIP").toString();
	    String browser=session.getAttribute("browser").toString();
		List<ReportResponse> dbTableList = dBTablesFeignClient.getAllReports(reportCategory,featureId,userId,userType,publicIp,browser);
		return  dbTableList;
	}
	
	
	//***************************************** Export Report  controller *********************************
	
	
	@PostMapping("exportReportData")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody DBrowDataModel filterRequest,HttpSession session)
	{
		Gson gsonObject=new Gson();
		Object response;
		Integer file = 1;	
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("DBrowDataModel:::::::::"+filterRequest);
		response= dBTablesFeignClient.ReportDetailsFeign(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson= new Gson(); 
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
	   log.info("response  from  Report Export  api="+fileExportResponse);
		
		return fileExportResponse;
	}
}

	

