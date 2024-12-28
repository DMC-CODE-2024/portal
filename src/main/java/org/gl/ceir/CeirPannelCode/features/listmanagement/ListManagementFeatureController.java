package org.gl.ceir.CeirPannelCode.features.listmanagement;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ListManagementFeatureController {

    @GetMapping("/eirs-list-management")
    public ModelAndView view(@RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingEIRSListManagementDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

    @GetMapping("/exception-list")
    public ModelAndView exceptionListView( @RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingExceptionListDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

    @GetMapping("/block-imei")
    public ModelAndView blockIMEIView( @RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingBlockedIMEIDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

    @GetMapping("/view-block-imei")
    public ModelAndView blockIMEIDataView( @RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingBlockIMEIListDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

    @GetMapping("/grey-list")
    public ModelAndView grayListView( @RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingGrayListDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }
    @GetMapping("/blocked-tac-list")
    public ModelAndView blockedTacListView( @RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingBlockedTacListDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }

    @GetMapping("/blockedtac-list")
    public ModelAndView blockedTacView( @RequestParam(name = "FeatureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView("showingBlockTACDetails");
        mv.addObject("featureId", featureId);
        return mv;
    }
}
