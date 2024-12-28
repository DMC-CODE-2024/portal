package org.gl.ceir.CeirPannelCode.features.eirs_response_param;

import org.gl.ceir.CeirPannelCode.datatable.model.EirsResponseParamContentModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EirsResponseParamController {
    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    EirsResponseParamContentModel eirsResponseParamModel;

    @RequestMapping(value={"/eirsResponseParam"},method={org.springframework.web.bind.annotation.
            RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
    )

    //@RequestMapping(value={"/eirs-response-param"}, method={org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST})
    public ModelAndView view() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("viewEirsResponseParam");
        return mv;
    }
}

