package org.gl.ceir.CeirPannelCode.features.trc;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.features.healthEndpoint.HealthEndpointRestController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/approveTac")
public class ApproveDeviceTACController {
    private HealthEndpointRestController healthEndpointRestController;

    public ApproveDeviceTACController(HealthEndpointRestController healthEndpointRestController) {
        this.healthEndpointRestController = healthEndpointRestController;
    }

    @GetMapping
    public ModelAndView view(@RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingUnApprovedDeviceTACDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

    @GetMapping("/approved")
    public ModelAndView viewApprovedTAC(@RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingApprovedDeviceTACDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }
}
