package org.gl.ceir.CeirPannelCode.Controller;

import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.TicketAuthenticationFeign;
import org.gl.ceir.CeirPannelCode.Model.Dropdown;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.SearchIMEIRequest;
import org.gl.ceir.CeirPannelCode.Model.SearchIMEITableResponse;
import org.gl.ceir.CeirPannelCode.Response.SearchIMEIResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CCSearchIMEIController {
    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    DeviceRepositoryFeign deviceRepositoryFeign;

    @Autowired
    TicketAuthenticationFeign ticketAuthenticationFeign;

    GenricResponse response = new GenricResponse();

    @GetMapping("search")
    public ModelAndView viewCCSearchIMEI(@RequestParam(name = "via", required = false) String via,
                                         @RequestParam(name = "msisdn", required = false) String msisdn,
                                         @RequestParam(name = "imei", required = false) String imei,
                                         @RequestParam(name = "FeatureId", required = false) String featureId,
                                         HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info("imei " + imei + " msisdn" + msisdn + "via " + via);
        if ("other".equals(via)) {
            mv.addObject("msisdn", msisdn);
            mv.addObject("imei", imei);
            mv.addObject("featureId", featureId);
            mv.setViewName("searchIMEIContent");
        } else {
            mv.addObject("featureId", featureId);
            mv.setViewName("searchIMEI");
        }
        return mv;
    }

    //------------------------------------- get IMEI/MSISDN/IMSI on basis of IMEI  ----------------------------------------

    @PostMapping("searchimei-msisdn")
    public @ResponseBody GenricResponse getMsisdnImsi(@RequestBody SearchIMEIRequest searchIMEIRequest, HttpSession session) {
        searchIMEIRequest.setPublicIp(session.getAttribute("publicIP").toString());
        searchIMEIRequest.setBrowser(session.getAttribute("browser").toString());
        GenricResponse response = deviceRepositoryFeign.getImsiMsisdnFeign(searchIMEIRequest);
        log.info("response " + response);
        return response;
    }

    //------------------------------------- get Device Details on basis of TAC  ---------------------------------------------

    @PostMapping("get-device-details")
    public @ResponseBody GenricResponse getDeviceDetails(@RequestBody SearchIMEIRequest searchIMEIRequest, HttpSession session) {
        searchIMEIRequest.setPublicIp(session.getAttribute("publicIP").toString());
        searchIMEIRequest.setBrowser(session.getAttribute("browser").toString());
        GenricResponse response = deviceRepositoryFeign.getIMEIDetailDeviceFeign(searchIMEIRequest);
        log.info("response " + response);
        return response;
    }

    //------------------------------------- get Device state on basis of IMEI/MSISDN  ----------------------------------------

    @PostMapping("get-device-state")
    public @ResponseBody SearchIMEIResponse getDeviceState(@RequestBody SearchIMEIRequest searchIMEIRequest, HttpSession session) {
        searchIMEIRequest.setPublicIp(session.getAttribute("publicIP").toString());
        searchIMEIRequest.setBrowser(session.getAttribute("browser").toString());
        SearchIMEIResponse response = deviceRepositoryFeign.getDeviceStateFeign(searchIMEIRequest);
        log.info("response {}", response);
        return response;
    }

    //------------------------------------- view table details ---------------------------------------------------------------

    @PostMapping("view-table-record")
    public @ResponseBody SearchIMEITableResponse viewTableDetail(@RequestBody SearchIMEIRequest searchIMEIRequest, HttpSession session) {
        searchIMEIRequest.setPublicIp(session.getAttribute("publicIP").toString());
        searchIMEIRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("table name = " + searchIMEIRequest.getTableName() + " with imei = " + searchIMEIRequest.getImei());
        SearchIMEITableResponse response = deviceRepositoryFeign.getTableDetailFeign(searchIMEIRequest);
        log.info("response " + response);
        return response;
    }

    //------------------------------------- Ticket authentication ---------------------------------------------------------------

    @GetMapping("verify-ticket/{ticketId}")
    public @ResponseBody GenricResponse verifyTicketId(
            @PathVariable("ticketId") String ticketId,
            @RequestHeader("X-Client-Type") String clientType,
            @RequestHeader("X-Client-Id") String clientId,
            @RequestHeader("loggedInUser") String loggedInUser) {
        GenricResponse genricResponse = new GenricResponse();
        try {
            log.info("Received Ticket Id {}", ticketId);
            Object response = ticketAuthenticationFeign.verifyTicketFeign(ticketId, clientType, clientId, loggedInUser);
            log.info("Response from Ticket Authentication API {}", response);
            genricResponse.setData(response);
        } catch (Exception e) {
            log.info("in Catch Block {}", e.getMessage());
            e.printStackTrace();

        }
        return genricResponse;
    }
}
