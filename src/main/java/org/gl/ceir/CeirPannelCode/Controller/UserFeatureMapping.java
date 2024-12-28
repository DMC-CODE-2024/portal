package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Service.ProfileService;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.gl.ceir.CeirPannelCode.datatable.model.UserManagementContent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class UserFeatureMapping {

    @Autowired
    ProfileService profileService;

    @Autowired
    APIService4Feign apiService4Feign;

    private final Logger log = LoggerFactory.getLogger(getClass());

    @RequestMapping(value =
            {"/usertypeFeatureMapping"}, method = {org.springframework.web.bind.annotation.
            RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST}
    )
    public ModelAndView viewMessageManagement(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info(" view usertypeFeatureMapping entry point.");
        mv.setViewName("userFeatureMapping");
        log.info(" view usertypeFeatureMapping exit point.");
        return mv;
    }


    @RequestMapping(value = "/updateSystemUserPeriod", method = RequestMethod.POST)
    @ResponseBody
    public HttpResponse changeUserPeriodStatus(@RequestBody UserManagementContent userManagementContent, HttpSession session) {
        return profileService.changeSystemUserPeriodService(userManagementContent, session);

    }

    //------------------------------------ Export Field controller ------------------------------------

    @PostMapping("exportUserFeatureData")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest, HttpSession session) {
        Gson gsonObject = new Gson();
        Object response;
        Integer file = 1;
        String userType = (String) session.getAttribute("usertype");
        Integer usertypeId = (int) session.getAttribute("usertypeId");
        filterRequest.setUserType(userType);
        filterRequest.setUserTypeId(usertypeId);
        filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
        filterRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("filterRequest:::::::::" + filterRequest);
        response = apiService4Feign.viewUserFeatureMappingRequest(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response  from  Export usertypeFeatureMapping api=" + fileExportResponse);

        return fileExportResponse;
    }

    //------------------------------------- view userType ----------------------------------------

    @PostMapping("userTypeFeatureViewByID")
    public @ResponseBody GenricResponse viewUserPeriod(@RequestBody FilterRequest filterRequest, HttpSession session) {
        filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
        filterRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("request send to the View UserPeriod api=" + filterRequest);
        GenricResponse response = apiService4Feign.viewUserTypeFeatureFeign(filterRequest);
        log.info("response from UserPeriod api " + response);
        return response;
    }
}
