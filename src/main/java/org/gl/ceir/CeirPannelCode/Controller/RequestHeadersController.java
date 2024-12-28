package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class RequestHeadersController {
    @Autowired
    APIService4Feign apiService4Feign;

    private final Logger log = LoggerFactory.getLogger(getClass());

    @RequestMapping(value =
            {"/requestHeaders"}, method = {org.springframework.web.bind.annotation.
            RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST}
    )
    public ModelAndView viewMessageManagement(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info(" view Request Headers entry point.");
        mv.setViewName("ipLogManagement");
        log.info(" view Request Headers exit point.");
        return mv;

    }

    //***************************************** Export IP LOG  controller *********************************
    @PostMapping("exportLogData")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest, HttpSession session, @RequestParam(name = "source", defaultValue = "menu", required = false) String source) {
        Gson gsonObject = new Gson();
        Object response;
        Integer file = 1;
        log.info("filterRequest:::::::::" + filterRequest);
        filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
        filterRequest.setBrowser(session.getAttribute("browser").toString());
        response = apiService4Feign.viewIPLogRequest(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file, source);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response  from  Alert Export  api=" + fileExportResponse);

        return fileExportResponse;
    }


}