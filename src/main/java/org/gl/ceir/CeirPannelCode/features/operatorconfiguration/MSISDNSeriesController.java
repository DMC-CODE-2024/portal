package org.gl.ceir.CeirPannelCode.features.operatorconfiguration;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MSISDNSeriesController {

    @GetMapping("/msisdn-series-view")
    public ModelAndView view(@RequestParam(name = "featureId", required = false) String featureId){
        ModelAndView mv = new ModelAndView("showingMSISDNSeriesDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }
    @GetMapping("/msisdn-series-add-series")
    public ModelAndView addSeriesView(@RequestParam(name = "featureId", required = false) String featureId){
        ModelAndView mv = new ModelAndView("MSISDNSeriesAddDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

}
