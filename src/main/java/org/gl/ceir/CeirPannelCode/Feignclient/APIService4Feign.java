package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Response.LoginResponse;
import org.gl.ceir.CeirPannelCode.Response.UpdateProfileResponse;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.gl.ceir.CeirPannelCode.datatable.model.AlertContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.UserManagementContent;
import org.gl.ceir.CeirPannelCode.datatable.model.UserfeatureContent;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Service
@FeignClient(url = "${apiUrl1}", value = "registrationUrls")
public interface APIService4Feign {

    @PostMapping("/userRegistration/getUsertypes")
    public List<Usertype> userypeList();

    @PostMapping("/userRegistration/usertypeIdByName/{usertype}")
    public Usertype userypeDataByName(@PathVariable("usertype") String usertype);

    @PostMapping("/userRegistration/getSecurityQuestion/{username}")
    public GenricResponse securityQuestionList(@PathVariable("username") String username);

    @PostMapping("/userRegistration/getAllSecurityQuestion")
    public List<SecurityQuestion> getAllSecurityQuestion();


    @PostMapping("/userRegistration/registration")
    public OtpResponse registration(@RequestBody Registration registration);

    @PostMapping("/userRegistration/validate")
    public HttpResponse otpValidate(@RequestBody Otp otp);

    @PostMapping("/userRegistration/resendOtp")
    public HttpResponse otpResend(@RequestBody ResendOtp otp);

    @PostMapping("/userRegistration/profileResendOtp")
    public HttpResponse profileResendOtp(@RequestBody ResendOtp otp);


    @PostMapping("/userRegistration/getUsertypes")
    public List<Usertype> userRegistrationDropdown(@RequestParam(name = "type", required = false) Integer type);


    @PostMapping("/userRegistration/checkAvailability/{usertypeId}")
    public HttpResponse checkRegistration(@PathVariable("usertypeId") Integer usertypeId);

    @GetMapping("/getDistinctAlertFeatureName")
    public List<String> getDistinctAlertFeatureName();


    @PostMapping("/getAuditAllfeatures")
    public List<FeatureDropdown> getAuditAllfeatures();


    @PostMapping("/getAllFeatures")
    public List<FeatureDropdown> userAllFeatureDropdown();



    @PostMapping("/subFeature/view")
    public List<FeatureDropdown> userAllSubFeatureDropdown();

    @PostMapping("/userProfile/getAddDeleteRoles")
    public @ResponseBody GenricResponse getAddDeleteRoleFeign(FilterRequest filterRequest);

    @PostMapping("/periodValidate")
    public HttpResponse periodValidate(@RequestBody PeriodValidate periodValidate);

    @PostMapping("/userTypeDropdownForGrievance")
    public List<Usertype> userRegistrationDropdownGrievance();

    @PostMapping("/featureList/{userid}")
    public List<Feature> featureList(@PathVariable("userid") Integer userid);


    @PostMapping("/userProfile/changePassword")
    public HttpResponse changePassword(Password password);

    @PostMapping("/userProfile/updateExpirePassword")
    public HttpResponse updateExpirePassword(Password password);


    @PostMapping("/userProfile/updateUserStatus")
    public HttpResponse updateUserStatus(UserStatus userStatus);


    @PostMapping("/userProfile/editProfile/{userid}")
    public Registration editUserProfile(@PathVariable("userid") Integer userid, @RequestBody UserHeader userHeader);

    @PostMapping("/userProfile/updateProfile")
    public UpdateProfileResponse updateUserProfile(Registration registration);

    //****************************************************************Admin Registration api starts from here ***************************************************************************************************
    //View admin registration feign controller
    @RequestMapping(value = "/userProfile/record", method = RequestMethod.POST)
    public Object registrationRequest(@RequestBody FilterRequest filterRequest,
                                      @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                      @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                      @RequestParam(value = "file", defaultValue = "0") Integer file,
                                      @RequestParam(name = "source", defaultValue = "menu", required = false) String source
    );


    @PostMapping("/userProfile/adminApproval")
    public HttpResponse adminUserApproval(UserStatus userStatus);

    @PostMapping("/userProfile/viewProfile/{id}/{userId}")
    public Registration ViewAdminUser(@PathVariable("id") long id, @PathVariable("userId") Integer userId,
                                      @RequestParam(name = "publicIp", required = false) String publicIp,
                                      @RequestParam(name = "browser", required = false) String browser,
                                      @RequestParam(name = "username", required = false) String username);


    @RequestMapping(value = "/userProfile/searchAssignee", method = RequestMethod.POST)
    public Object asigneeDetailsFeign(@RequestBody FilterRequest filterRequest,
                                      @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                      @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                      @RequestParam(value = "file", defaultValue = "0") Integer file
    );

    @PostMapping("/userProfile/changeUserStatus")
    public HttpResponse changeUserStatusFeign(UserStatus userStatus);


    /*-------------------------- view Port Feign ------------------------------*/

    @RequestMapping(value = "/portAddress/view", method = RequestMethod.POST)
    public Object viewPortRequest(@RequestBody FilterRequest filterRequest,
                                  @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                  @RequestParam(value = "file", defaultValue = "0") Integer file);


    //***************************************************Add Port Address Feign********************************

    @RequestMapping(value = "/portAddress/save", method = RequestMethod.POST)
    public GenricResponse AddPortAddressFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************View Port Management Feign********************************

    @RequestMapping(value = "/portAddress/viewDataById", method = RequestMethod.POST)
    public @ResponseBody GenricResponse viewPortFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************Update Port Address Feign********************************

    @RequestMapping(value = "/portAddress/update", method = RequestMethod.POST)
    public GenricResponse updatePortAddressFeign(@RequestBody FilterRequest filterRequest);

    //***************************************************Delete Port Management Feign********************************

    @RequestMapping(value = "/portAddress/delete", method = RequestMethod.POST)
    public @ResponseBody GenricResponse deletePortFeign(@RequestBody FilterRequest filterRequest);


    /*-------------------------- view all Currency Feign ------------------------------*/

    @RequestMapping(value = "/currency/view", method = RequestMethod.POST)
    public Object viewCurrencyRequest(@RequestBody FilterRequest filterRequest,
                                      @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                      @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                      @RequestParam(value = "file", defaultValue = "0") Integer file,
                                      @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


    //***************************************************Add Currency Feign********************************

    @RequestMapping(value = "/currency/save", method = RequestMethod.POST)
    public GenricResponse AddCurrencyFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************View Currency Feign********************************

    @RequestMapping(value = "/currency/viewById", method = RequestMethod.POST)
    public @ResponseBody GenricResponse viewCurrencyFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************Update Currency Feign********************************

    @RequestMapping(value = "/currency/update", method = RequestMethod.POST)
    public GenricResponse updateCurrencyFeign(@RequestBody FilterRequest filterRequest);

    /*-------------------------- view userManagement Feign ------------------------------*/

    @RequestMapping(value = "/usertypeData", method = RequestMethod.POST)
    public Object viewUserTypeRequest(@RequestBody FilterRequest filterRequest,
                                      @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                      @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                      @RequestParam(value = "file", defaultValue = "0") Integer file);


    /*-------------------------- Update System user Type Management Feign ------------------------------*/

    @PostMapping("/updateUserTypeStatus")
    public HttpResponse changeSystemUserStatusFeign(UserManagementContent userManagementContent);



    /*-------------------------- view userManagement Feign ------------------------------*/

    @RequestMapping(value = "/userTypeFeatureData", method = RequestMethod.POST)
    public Object viewUserFeatureMappingRequest(@RequestBody FilterRequest filterRequest,
                                                @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                @RequestParam(value = "file", defaultValue = "0") Integer file);

    /*-------------------------- Update System user Period Feign ------------------------------*/

    @PostMapping("/updatePeriod")
    public HttpResponse changeSystemUserPeriodFeign(UserManagementContent userManagementContent);



    /*-------------------------- view IP LOG Management Feign ------------------------------*/

    @RequestMapping(value = "/viewAll", method = RequestMethod.POST)
    public Object viewIPLogRequest(@RequestBody FilterRequest filterRequest,
                                   @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                   @RequestParam(value = "file", defaultValue = "0") Integer file,
                                   @RequestParam(name = "source", defaultValue = "menu", required = false) String source);



    /*-------------------------- view user Management Feign ------------------------------*/

    @RequestMapping(value = "/userMgmt/view", method = RequestMethod.POST)
    public Object viewSystemUserManagementRequest(@RequestBody FilterRequest filterRequest,
                                                  @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                                  @RequestParam(value = "file", defaultValue = "0") Integer file);


    /*----------------------- Add System user feign ---------------------------*/

    @PostMapping("/userMgmt/save")
    public GenricResponse saveSystemUser(@RequestBody NewSystemUser newSystemUser);

    //***************************************************View user Feign********************************

    @RequestMapping(value = "/userMgmt/getById", method = RequestMethod.POST)
    public @ResponseBody GenricResponse viewUserFeign(@RequestBody NewSystemUser newSystemUser);

    //***************************************************Update user Feign********************************

    @RequestMapping(value = "/userMgmt/update", method = RequestMethod.POST)
    public GenricResponse updateUserFeign(@RequestBody NewSystemUser newSystemUser);

    //***************************************************Delete user Feign********************************

    @RequestMapping(value = "/userMgmt/delete", method = RequestMethod.POST)
    public @ResponseBody GenricResponse deleteUserFeign(@RequestBody NewSystemUser newSystemUser);

    //***************************************************userToFeatureDropdown user Feign********************************

    @GetMapping("/userToFeatureDropdown/{featureId}/{usertypeId}")
    public List<UserfeatureContent> userToFeatureDropdownFeign(@PathVariable("featureId") Integer featureId, @PathVariable("usertypeId") Integer usertypeId);

    //***************************************************View userType Feign********************************

    @RequestMapping(value = "/usertype/viewById", method = RequestMethod.POST)
    public @ResponseBody GenricResponse viewUserTypeFeign(@RequestBody FilterRequest filterRequest);

    //***************************************************View userType Feature Feign********************************

    @RequestMapping(value = "/viewPeriodById", method = RequestMethod.POST)
    public @ResponseBody GenricResponse viewUserTypeFeatureFeign(@RequestBody FilterRequest filterRequest);

    @PostMapping("/Login/checkUser")
    public LoginResponse checkUser(User user);

    @PostMapping("/Login/ipLog")
    public LoginResponse ipLog(User user);


    @PostMapping("/Login/changeLanguage")
    public HttpResponse changeUserLanguage(ChangeLanguage language, @RequestParam("publicIP") String publicIP, @RequestParam("browser") String browser);

    @PostMapping("/Login/sessionTracking/{userid}")
    public HttpResponse sessionTracking(@PathVariable("userid") Integer userid, @RequestParam(name = "publicIP") String publicIP, @RequestParam(name = "browser") String browser);

    @PostMapping("/Login/forgotPassword")
    public UpdateProfileResponse ForgotPassword(ForgotPassword forgotPassword, @RequestParam(name = "publicIP") String publicIP, @RequestParam(name = "browser") String browser);

    @PostMapping("/Login/updateNewPassword")
    public HttpResponse updateNewPassword(Password forgotPassword, @RequestParam(name = "publicIP") String publicIP, @RequestParam(name = "browser") String browser);

    @PostMapping("/Login/testLogin")
    public LoginResponse searchUserDetailFeign(UserStatus userStatus);


    @GetMapping("/OperatorFileDump/dropdown")
    public List<GetDumpFileList> getListDropDown(@RequestParam("tag") String tag);




}
