package org.gl.ceir.CeirPannelCode.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.LostStolenModel;
import org.gl.ceir.CeirPannelCode.Model.TrackLostDeviceFilterRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class TrackLostDeviceController {

	private final Logger log = LoggerFactory.getLogger(getClass());
	

	@Autowired
	DeviceRepositoryFeign deviceRepositoryFeign;

	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	
	GenricResponse response = new GenricResponse();

	@RequestMapping(value=
		{"/trackLostDevice"},method={org.springframework.web.bind.annotation.
				RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
			)
	public ModelAndView viewManageTypeAdmin(HttpSession session,
	@RequestParam(name = "FeatureId", required = false) String featureId) {
		ModelAndView mv = new ModelAndView();
		log.info(" view Track Lost Device entry point."); 
		mv.setViewName("viewTrackLostDevice");
		mv.addObject("featureId",featureId);
		log.info(" view Track Lost Device exit point.."); 
		return mv; 
	}

	//------------------------------------- view Approved Device ----------------------------------------							

	@PostMapping("tracklostbyid/view") 
	public @ResponseBody LostStolenModel viewTrackLostDevice (@RequestBody LostStolenModel trackLostDeviceRequest,HttpSession session )  {
		trackLostDeviceRequest.setPublicIp(session.getAttribute("publicIP").toString());
		trackLostDeviceRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("Get Track Lost Device Details for Request= "+trackLostDeviceRequest.toString());
		log.info("Get Track Lost Device Details for Request ID= "+trackLostDeviceRequest.getRequestId());
		LostStolenModel response= feignCleintImplementation.getLostDeviceByRequestID(trackLostDeviceRequest);
		log.info("response "+response);
		return response;
	}

	//-------------------Export Track Lost Device Controller-------------------//

	@PostMapping("export-trackLost-details")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceRequest, HttpSession session, HttpServletRequest request) {
		Object response;
		Integer file = 1;
		log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
		trackLostDeviceRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
		trackLostDeviceRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
		log.info("Request Track Lost to Export:::::::::" + trackLostDeviceRequest);
		response = deviceRepositoryFeign.exportTrackLostData(trackLostDeviceRequest, trackLostDeviceRequest.getPageNo(), trackLostDeviceRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson = new Gson();
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response Track Lost Export  api=" + fileExportResponse);
		return fileExportResponse;
	}
	
	@ResponseBody
	@GetMapping("getDistinctOperator")
	public List<Object> getDistinctDeviceType() {
		List<Object> dropdown = deviceRepositoryFeign.getDistinctOperator();
		return dropdown;
	}
	
//	@ResponseBody
//	@GetMapping("getDistinctStatus")
//	public List<String> getDistinctStatus() {
//		List<String> dropdown = deviceRepositoryFeign.getDistinctStatus();
//		return dropdown;
//	}

	@ResponseBody
	@GetMapping("getTrackLostRequestType")
	public List<Object> getTrackLostRequestType() {
		List<Object> dropdown = deviceRepositoryFeign.getTrackLostRequestType();
		return dropdown;
	}


}
