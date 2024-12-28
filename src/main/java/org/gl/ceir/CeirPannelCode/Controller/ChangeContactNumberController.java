package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.LostStolenModel;
import org.gl.ceir.CeirPannelCode.Model.TrackLostDeviceFilterRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;


@Controller
public class ChangeContactNumberController {

	private final Logger log = LoggerFactory.getLogger(getClass());
	

	@Autowired
	DeviceRepositoryFeign deviceRepositoryFeign;
	
	

	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	
	GenricResponse response = new GenricResponse();

	@RequestMapping(value=
		{"/cc-change-contact-number"},method={org.springframework.web.bind.annotation.
				RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
			)
	public ModelAndView viewManageTypeAdmin(HttpSession session,
	 @RequestParam(name = "FeatureId", required = false) String featureId) {
		ModelAndView mv = new ModelAndView();
		log.info(" view change contact number entry point.");
		mv.addObject("featureId",featureId);
		mv.setViewName("change-contact-number");
		log.info(" view change contact number exit point..");
		return mv; 
	}

	//------------------------------------- view Approved Device ----------------------------------------							

	@PostMapping("/change-contact-no-view") 
	public @ResponseBody LostStolenModel viewChangeContactNumberDevice(@RequestBody LostStolenModel trackLostDeviceRequest,HttpSession session )  {
		trackLostDeviceRequest.setPublicIp(session.getAttribute("publicIP").toString());
		trackLostDeviceRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("Get Change Contact Number Device Details for Request= "+trackLostDeviceRequest.toString());
		log.info("Get Change Contact Number Device Details for Request ID= "+trackLostDeviceRequest.getRequestId());
		LostStolenModel response= feignCleintImplementation.getLostDeviceByRequestID(trackLostDeviceRequest);
		log.info("response "+response);
		return response;
	}
	
	@PostMapping("/cc-verify-request-number") 
	public @ResponseBody Object verifyRequestNo(@RequestBody TrackLostDeviceFilterRequest userRequest,HttpSession session )  {
		userRequest.setPublicIp(session.getAttribute("publicIP").toString());
		userRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("verifyRequestNo() :: Get Change Contact Number Device Details for Request= "+userRequest.toString());
		log.info("verifyRequestNo() :: Get Change Contact Number Device Details for Request ID= "+userRequest.getRequestNo());
		Object response = deviceRepositoryFeign.verifyRequestNoAndContactNumber(userRequest);
		log.info("response "+response);
		return response;
	}
	@PostMapping("/cc-update-contact-number") 
	public @ResponseBody Object updateRequestNo(@RequestBody TrackLostDeviceFilterRequest userRequest,HttpSession session )  {
		userRequest.setPublicIp(session.getAttribute("publicIP").toString());
		userRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("updateRequestNo() :: Get Change Contact Number Device Details for Request= "+userRequest.toString());
		log.info("updateRequestNo() :: Get Change Contact Number Device Details for Request ID= "+userRequest.getRequestNo());
		Object response = deviceRepositoryFeign.updateContactNumber(userRequest);
		log.info("response "+response);
		return response;
	}


}
