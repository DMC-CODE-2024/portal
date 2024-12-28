package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class QualifiedAgentController {
private final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	AddMoreFileModel addMoreFileModel,urlToUpload,urlToMove;
	
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	
	@Autowired
	UtilDownload utildownload;
	
	@Autowired
    PropertyReader propertyReader;

	@Autowired
	GsmaFeignClient gsmaFeignClient;
	
	GenricResponse response = new GenricResponse();
	
	
	@RequestMapping(value = { "/qualifiedAgent" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET,
			org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView viewManageTypeAdmin(@RequestParam(name = "FeatureId", required = false) String featureId, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		log.info(" view qualifiedAgent entry point.");
		mv.setViewName("QualifiedAgents");
		mv.addObject("featureId", featureId);
		log.info(" view qualifiedAgent exit point..");
		return mv;
	}
	@RequestMapping(value = { "/viewQualifiedAgent" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET,
			org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView viewQualifiedAgent(@RequestParam(name = "FeatureId", required = false) String featureId,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ViewQualifiedAgents");
		mv.addObject("featureId", featureId);
		return mv;
	}
}
