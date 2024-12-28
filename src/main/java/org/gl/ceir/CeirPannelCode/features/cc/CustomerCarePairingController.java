package org.gl.ceir.CeirPannelCode.features.cc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CustomerCarePairingController {
    private final Logger log = LoggerFactory.getLogger(getClass());

    @RequestMapping(value = {"/customer-care"}, method = {org.springframework.web.bind.annotation.
            RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST}
    )
    public ModelAndView view(@RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("showingPairingCC");
        mv.addObject("featureId", featureId);
        return mv;
    }

}
