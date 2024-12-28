package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.Registration;
import org.gl.ceir.CeirPannelCode.Model.UserStatus;
import org.gl.ceir.CeirPannelCode.Service.ProfileService;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class AdminRegistrationRequest {
    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    APIService4Feign apiService4Feign;

    @Autowired
    ProfileService profileService;

    @RequestMapping(value =
            {"/registrationRequest"}, method = {org.springframework.web.bind.annotation.
            RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST}
    )
    public ModelAndView viewConsignment(HttpSession session, @RequestParam(name = "txnID", required = false) String txnID,
                                        @RequestParam(name = "source", defaultValue = "menu", required = false) String source) {
        ModelAndView mv = new ModelAndView();
        log.info(" view Admin Registration entry point.");
        mv.setViewName("AdminRegistrationRequest");
        log.info(" view Admin Registration  exit point.");
        return mv;
    }


    @RequestMapping(value =
            {"/trcInformation"}, method = {org.springframework.web.bind.annotation.
            RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST}
    )
    public ModelAndView viewAdminUser(HttpSession session, @RequestParam(name = "id") int id, @RequestParam(name = "roles") String roles, @RequestParam(name = "type") String asType,
                                      @RequestParam(name = "username") String username) {
        int userId = (int) session.getAttribute("userid");
        ModelAndView mv = new ModelAndView();

        log.info("ID----->" + id + "----- Roles----->" + roles + "----type------>" + asType + "----userId---->" + userId);

        roles = roles.replace("=", " ");
        String publicIp = session.getAttribute("publicIP").toString();
        String browser = session.getAttribute("browser").toString();
        Registration registration = apiService4Feign.ViewAdminUser(id, userId, publicIp, browser, username);
        log.info("View registration API Response--------------->" + registration);
        mv.addObject("registration", registration);


        if ("TRC".equals(roles)) {
            log.info("-------------------->1");
            mv.setViewName("trcInformation");

        } else if ("Operator".equals(roles)) {
            log.info("-------------------->2");
            mv.setViewName("viewOperator");

        } else if ("Custom".equals(roles)) {
            log.info("-------------------->3");
            mv.setViewName("viewCustom");

        } else if (roles.equals("Lawful Agency")) {
            log.info("-------------------->7");
            mv.setViewName("viewLawful");

        } else if (("Importer".equals(roles) || "Distributor".equals(roles) || "Retailer".equals(roles)) && "Company".equals(asType) || "Organization".equals(asType)) {
            log.info("-------------------->4");
            mv.setViewName("viewCompany");

        } else if (("Importer".equals(roles) || "Distributor".equals(roles) || "Retailer".equals(roles)) && "Individual".equals(asType)) {
            log.info("-------------------->5");
            mv.setViewName("viewIndividual");

        } else if (("Manufacturer".equals(roles)) && "Company".equals(asType)) {
            log.info("-------------------->6");
            mv.setViewName("viewManufacturer");

        }

        log.info(" view trcInformation  exit point.");
        return mv;
    }


    //***************************************** Export Registration controller *********************************

    @RequestMapping(value = "/exportAdminRegistration", method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public String exportToExcel(@RequestParam(name = "RegistrationStartDate", required = false) String RegistrationStartDate,
                                @RequestParam(name = "RegistrationEndDate", required = false) String RegistrationEndDate,
                                @RequestParam(name = "asType", required = false) Integer asType,
                                @RequestParam(name = "userRoleTypeId", required = false) Integer userRoleTypeId,
                                @RequestParam(name = "featureId", required = false) Integer featureId,
                                @RequestParam(name = "usertypeId", required = false) Integer usertypeId,
                                @RequestParam(name = "userTypeId") Integer userTypeId,
                                @RequestParam(name = "status", required = false) Integer status,
                                @RequestParam(name = "userId", required = false) Integer userId,
                                @RequestParam(name = "email", required = false) String email,
                                @RequestParam(name = "phoneNo", required = false) String phoneNo,
                                @RequestParam(name = "username", required = false) String username,
                                @RequestParam(name = "filteredUsername", required = false) String filteredUsername,
                                @RequestParam(name = "source", defaultValue = "menu", required = false) String source,

                                @RequestParam(name = "pageSize") Integer pageSize,
                                @RequestParam(name = "pageNo") Integer pageNo,
                                HttpServletRequest request,
                                HttpSession session) {

        log.info("usertypeId::::" + usertypeId + "-----userTypeId:" + userTypeId + "email-->" + email + " phoneNo--->" + phoneNo + "username-->" + username + " source-->" + source);

        log.info("RegistrationStartDate==" + RegistrationStartDate + " RegistrationEndDate =" + RegistrationEndDate + " asType=" + asType + "userRoleTypeId=" + userRoleTypeId);
        //int userId= (int) session.getAttribute("userid");
        int file = 1;
        String userType = (String) session.getAttribute("usertype");
        FileExportResponse fileExportResponse;
        FilterRequest filterRequest = new FilterRequest();
        filterRequest.setStartDate(RegistrationStartDate);
        filterRequest.setEndDate(RegistrationEndDate);
        filterRequest.setAsType(asType);
        filterRequest.setUserRoleTypeId(userRoleTypeId);
        filterRequest.setStatus(status);
        filterRequest.setUserId(userId);
        filterRequest.setUserType(userType);
        filterRequest.setFeatureId(featureId);
        filterRequest.setUsertypeId(userTypeId);
        filterRequest.setUserTypeId(userTypeId);
        filterRequest.setEmail(email);
        filterRequest.setPhoneNo(phoneNo);
        filterRequest.setUsername(username);
        filterRequest.setFilteredUsername(filteredUsername);

        log.info(" request passed to the exportTo Excel Api ==" + filterRequest + " *********** pageSize" + pageSize + "  pageNo  " + pageNo);
        filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
        filterRequest.setBrowser(session.getAttribute("browser").toString());
        Object response = apiService4Feign.registrationRequest(filterRequest, pageNo, pageSize, file, source);
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response  from   export grievance  api=" + fileExportResponse);
        return "redirect:" + fileExportResponse.getUrl();

    }

    @RequestMapping(value = "/adminChangeRequest", method = RequestMethod.POST)
    @ResponseBody
    public HttpResponse changeUserStatus(@RequestBody UserStatus userStatus, HttpSession session) {
        return profileService.changeUserStatusService(userStatus, session);

    }

}
