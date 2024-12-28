package org.gl.ceir.CeirPannelCode.Controller;

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

import javax.servlet.http.HttpSession;

@Controller
public class LocalManufactureController {

    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

    @Autowired
    FeignCleintImplementation feignCleintImplementation;

    @Autowired
    UtilDownload utildownload;

    @Autowired
    PropertyReader propertyReader;

    @Autowired
    GsmaFeignClient gsmaFeignClient;

    GenricResponse response = new GenricResponse();

    @RequestMapping(value = {"/localManufacturerIMEI"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET,
            org.springframework.web.bind.annotation.RequestMethod.POST})
    public ModelAndView viewManageTypeAdmin(@RequestParam(name = "FeatureId", required = false) String featureId, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info(" view LocalManufacture entry point.");
        mv.setViewName("LocalManufacture");
        mv.addObject("featureId", featureId);
        log.info(" view LocalManufacture entry point..");
        return mv;
    }

    @RequestMapping(value = {"/viewlocalManufacturerIMEI"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET,
            org.springframework.web.bind.annotation.RequestMethod.POST})
    public ModelAndView viewlocalManufacturerIMEI(@RequestParam(name = "FeatureId", required = false) String featureId,HttpSession session) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("ViewLocalManufacture");
        mv.addObject("featureId", featureId);
        return mv;
    }

}
