package org.gl.ceir.CeirPannelCode.features.addressmgmt;

import org.gl.ceir.CeirPannelCode.datatable.model.AddressContentModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AddressManagementController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    AddressContentModel addressContentModel;

    @RequestMapping(value = {"/address-management"}, method = {org.springframework.web.bind.annotation.
            RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST}
    )
    public ModelAndView view(@RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("viewAddressManagement");
        mv.addObject("featureId", featureId);
        return mv;
    }
}
