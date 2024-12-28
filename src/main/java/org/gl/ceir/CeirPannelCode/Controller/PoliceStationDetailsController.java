package org.gl.ceir.CeirPannelCode.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class PoliceStationDetailsController {
    @RequestMapping(value = {"/eirsPoliceStationDetail"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST})
    public ModelAndView viewPoliceBulkViewDetails(HttpSession session, HttpServletRequest request,
    @RequestParam(name = "featureId", required = false) String featureId) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("policeStationDetails");
        mv.addObject("featureId",featureId);
        return mv;
    }

}
