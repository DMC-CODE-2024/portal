package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Model.Usertype;
import org.gl.ceir.CeirPannelCode.datatable.model.*;
import org.gl.ceir.CeirPannelCode.features.eirs_response_param.model.EirsResponseParamModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


@Service
@FeignClient(url = "${feignClientPath}", value = "dsj")
public interface FeignCleintImplementation {


    //download file(Error or Uploaded file) feign  controller
    @RequestMapping(value = "/Download/uploadFile", method = RequestMethod.POST)
    public @ResponseBody FileExportResponse downloadFile(@RequestParam("txnId") String txnId, @RequestParam("fileType") String fileType, @RequestParam("fileName") String fileName, @RequestParam(name = "tag", required = false) String tag, @RequestBody AllRequest allrequest);


    //download file(Error or Uploaded file) feign  controller
    @RequestMapping(value = "/Download/SampleFile", method = RequestMethod.POST)
    public @ResponseBody FileExportResponse downloadSampleFile(@RequestParam("featureId") int featureId, @RequestBody AllRequest allrequest);


    /************* DROPDOWN *****************/

    @RequestMapping(value = "/state-mgmt/{featureId}/{userTypeId}", method = RequestMethod.GET)
    public List<Dropdown> consignmentStatusList(@PathVariable("featureId") Integer featureId, @PathVariable("userTypeId") Integer userTypeId);


    @RequestMapping(value = "system-config-list/{tag}", method = RequestMethod.GET)
    public List<Dropdown> taxPaidStatusList(@PathVariable("tag") String tag);

    //***************************************************Admin Registration as Type Dropdown********************************


    @RequestMapping(value = "/system-config-list/by-tag-and-usertype/{tagId}/{userTypeId}", method = RequestMethod.GET)
    public List<Dropdown> asTypeList(@PathVariable("tagId") String tag, @PathVariable("userTypeId") Integer userTypeId);


    @PostMapping("/system/viewTag")
    public Dropdown dataByTag(Tag tag);


    //***************************************************Admin System message Management Feign********************************

    @RequestMapping(value = "/filter/message-configuration", method = RequestMethod.POST)
    public Object adminMessageFeign(@RequestBody FilterRequest filterRequest,
                                    @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                    @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                    @RequestParam(value = "file", defaultValue = "0") Integer file);


    //***************************************************Admin System Config Management Feign********************************

    @RequestMapping(value = "/filter/system-configuration", method = RequestMethod.POST)
    public Object adminConfigFeign(@RequestBody FilterRequest filterRequest,
                                   @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                   @RequestParam(value = "file", defaultValue = "0") Integer file);

    @RequestMapping(value = "/filter/checkIMEIparam", method = RequestMethod.POST)
    public Object checkIMEIparam(@RequestBody FilterRequest filterRequest,
                                 @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                 @RequestParam(value = "file", defaultValue = "0") Integer file);


    @RequestMapping(value = "/filter/checkIMEIContent", method = RequestMethod.POST)
    public Object checkIMEIContent(@RequestBody FilterRequest filterRequest,
                                   @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                   @RequestParam(value = "file", defaultValue = "0") Integer file);

    @RequestMapping(value = "/filter/greyListView", method = RequestMethod.POST)
    public Object greyListView(@RequestBody FilterRequest filterRequest,
                               @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                               @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                               @RequestParam(value = "file", defaultValue = "0") Integer file);

    @RequestMapping(value = "/filter/vipListView", method = RequestMethod.POST)
    public Object vipListView(@RequestBody FilterRequest filterRequest,
                              @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                              @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                              @RequestParam(value = "file", defaultValue = "0") Integer file);

    @RequestMapping(value = "/filter/blackListView", method = RequestMethod.POST)
    public Object blackListView(@RequestBody FilterRequest filterRequest,
                                @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                @RequestParam(value = "file", defaultValue = "0") Integer file);

    @RequestMapping(value = "/filter/BlockedTacView", method = RequestMethod.POST)
    public Object blockedTacView(@RequestBody FilterRequest filterRequest,
                                 @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                 @RequestParam(value = "file", defaultValue = "0") Integer file);

    @RequestMapping(value = "/filter/AllowedTacView", method = RequestMethod.POST)
    public Object allowedTacView(@RequestBody FilterRequest filterRequest,
                                 @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                 @RequestParam(value = "file", defaultValue = "0") Integer file);

//***************************************************Admin System Config Management Feign********************************

    @RequestMapping(value = "/filter/policy-configuration", method = RequestMethod.POST)
    public Object policyManagementFeign(@RequestBody FilterRequest filterRequest,
                                        @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                        @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                        @RequestParam(value = "file", defaultValue = "0") Integer file);


//************************************************ view icon Message Management Feign *****************************************

    @PostMapping("/message/viewTag")
    public @ResponseBody MessageContentModel viewMessageFeign(FilterRequest filterRequest);


    @PostMapping("/system/viewTag")
    public @ResponseBody ConfigContentModel viewAdminFeign(FilterRequest filterRequest);

    @PostMapping("/greylist/viewById")
    public @ResponseBody ConfigContentModel viewGreylistFeign(FilterRequest filterRequest);

    @PostMapping("/viplist/viewById")
    public @ResponseBody ConfigContentModel viewVIPListFeign(FilterRequest filterRequest);

    @PostMapping("/blacklist/viewid")
    public @ResponseBody ConfigContentModel viewBlackListFeign(FilterRequest filterRequest);


    @PostMapping("/blockedTac/viewTac")
    public @ResponseBody ConfigContentModel viewBlockedTacFeign(FilterRequest filterRequest);

    @PostMapping("/allowedTac/viewTac")
    public @ResponseBody ConfigContentModel viewAllowedTacFeign(FilterRequest filterRequest);


    @PostMapping("/checkIMEIParam/viewTag")
    public @ResponseBody ConfigContentModel checkIMEIParam(FilterRequest filterRequest);

    @PostMapping("/checkIMEIContent/viewTag")
    public @ResponseBody ConfigContentModel checkIMEIContent(FilterRequest filterRequest);

    @RequestMapping(value = "/system-config-list/by-tag-and-featureid/{tagId}/{featureId}", method = RequestMethod.GET)
    public List<Dropdown> modeType(@PathVariable("tagId") String tagId, @PathVariable("featureId") Integer featureId);


    //************************************ Message update Feign  *************************************************

    @PutMapping(value = "/message/update")
    public @ResponseBody MessageContentModel updateMessages(MessageContentModel messageContentModel);

    //************************************ System update Feign  *************************************************

    @PutMapping(value = "/system/update")

    public @ResponseBody GenricResponse updateSystem(@RequestBody ConfigContentModel configContentModel);

    @PutMapping(value = "/checkIMEIParam/update")
    public @ResponseBody GenricResponse checkIMEIParam(@RequestBody ConfigContentModel configContentModel);

    @PutMapping(value = "/checkIMEIContent/update")
    public @ResponseBody GenricResponse checkIMEIContent(@RequestBody ConfigContentModel configContentModel);

    //***************************************************Audit Management Feign********************************

    @RequestMapping(value = "/filter/audit-trail", method = RequestMethod.POST)
    public Object auditManagementFeign(@RequestBody FilterRequest filterRequest,
                                       @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                       @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                       @RequestParam(value = "file", defaultValue = "0") Integer file);

    //************************************************ view Audit Management Feign *************************************

    @RequestMapping(value = "/audit-trail/{id}", method = RequestMethod.GET)
    public AuditContentModel viewAuditManagementFeign(@PathVariable("id") Integer id);


    //***************************************************Audit Trail Management Feign********************************

    @RequestMapping(value = "/filter/moduleAuditViewAll", method = RequestMethod.POST)
    public Object auditTrailManagementFeign(@RequestBody FilterRequest filterRequest,
                                            @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                            @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                            @RequestParam(value = "file", defaultValue = "0") Integer file);

    //************************************************ view Audit trail Management Feign *************************************


    @RequestMapping(value = "/audit-trail/{id}", method = RequestMethod.GET)
    public AuditContentModel viewAuditTrailManagementFeign(@PathVariable("id") Integer id);

//************************************ Message update Feign  *************************************************

    @PostMapping(value = "/checkDevice")
    public @ResponseBody GenricResponse viewDetails(FilterRequest filterRequest);


    //download file(Error or Uploaded file) feign  controller
    @RequestMapping(value = "/Download/manuals", method = RequestMethod.POST)
    public @ResponseBody FileExportResponse manualDownloadSampleFile(@RequestBody AllRequest auditRequest);

//******************************* Tag Updated DropDown in Field ****************************************

    @PostMapping("/projection/tags/system-config-list")
    public @ResponseBody GenricResponse getAllTagsDropdowntFeign(FilterRequest filterRequest);


    //***************************************************Field Management Feign**********************************

    @RequestMapping(value = "/filter/system-config-list", method = RequestMethod.POST)
    public Object fieldManagementFeign(@RequestBody FilterRequest filterRequest,
                                       @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                       @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                       @RequestParam(value = "file", defaultValue = "0") Integer file);


    //***************************************************Add Field Management Feign********************************

    @RequestMapping(value = "/save/system-config-list", method = RequestMethod.POST)
    public GenricResponse AddfieldManagementFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************View Field Management Feign********************************

    @RequestMapping(value = "/get/system-config-list", method = RequestMethod.POST)
    public GenricResponse viewfieldManagementFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************update Field Management Feign********************************

    @RequestMapping(value = "/system-config-list", method = RequestMethod.PUT)
    public GenricResponse updatefieldManagementFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************Delete Field Management Feign********************************

    @RequestMapping(value = "/tags/system-config-list", method = RequestMethod.DELETE)
    public @ResponseBody GenricResponse deleteFieldFeign(@RequestBody FilterRequest filterRequest);

    @PostMapping("/system/viewTag")
    public @ResponseBody AddMoreFileModel addMoreBuutonCount(AddMoreFileModel addMoreCount);


    //************************************************ view customer Care Feign *****************************************

    @PostMapping("/customer-care/record")
    public @ResponseBody GenricResponse viewcustomerDetialsfeign(
            @RequestParam(name = "listType", required = false) String listType,
            @RequestBody CustomerCareRequest customerCareRequest);

    @PostMapping("/customer-care/by-txn-id")
    public @ResponseBody GenricResponse customerCareViaTxnId(@RequestBody CustomerCareByTxnId customerCareDeviceState);

    /* Rule List Feign */
    @RequestMapping(value = "/filter/rule-engine", method = RequestMethod.POST)
    public Object ruleListFeign(@RequestBody FilterRequest filterRequest,
                                @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                @RequestParam(name = "file", defaultValue = "0", required = false) Integer file);


    @RequestMapping(value = "rule-engine/{id}", method = RequestMethod.GET)
    public RuleListContent fetchData(@PathVariable("id") Integer id);

    @RequestMapping(value = "rule-engine", method = RequestMethod.PUT)
    public GenricResponse update(@RequestBody RuleListContent ruleListContent);

    /* Rule Feature Mapping  Feign */
    @RequestMapping(value = "/filter/rule-engine-mapping", method = RequestMethod.POST)
    public Object ruleFeatureMappingListFeign(@RequestBody FilterRequest filterRequest,
                                              @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                              @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                              @RequestParam(name = "file", defaultValue = "0", required = false) Integer file);

    @PostMapping("/rule-engine-mapping")
    public GenricResponse save(@RequestBody NewRule newRule);

    @RequestMapping(value = "/rule-engine-mapping", method = RequestMethod.PUT)
    public GenricResponse updateRuleFeatureMapping(@RequestBody NewRule newRule);

    @GetMapping("/all/rule-engine")
    public List<RuleNameModel> getList();


    @GetMapping(value = "/rule-engine-mapping/{id}")
    public NewRule getObjectByID(@PathVariable("id") Integer id);

    @DeleteMapping(value = "rule-engine-mapping")
    public @ResponseBody GenricResponse delete(NewRule newRule);

    /*
     * @DeleteMapping(value="rule-engine-mapping-userType") public @ResponseBody
     * List<NewRule> getUserTypeByFeatureID(@RequestParam(name="featureName") String
     * featureName) ;
     */

    @PostMapping(value = "rule-engine-mapping-userType")
    public @ResponseBody List<RuleEngineMapping> getUserTypeByFeatureID(@RequestParam(name = "featureName") String featureName, @RequestParam(name = "name") String name);


    //***************************************************Admin Pending TAC List Feign********************************

    @RequestMapping(value = "/filter/pending-tac-approveddb", method = RequestMethod.POST)
    public Object pendingTACFeign(@RequestBody FilterRequest filterRequest,
                                  @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                  @RequestParam(value = "file", defaultValue = "0") Integer file,
                                  @RequestParam(value = "source", defaultValue = "menu") String source);


    //****************************************Pending TAC List Delete Feign********************************

    @RequestMapping(value = "/pending-tac-approved", method = RequestMethod.DELETE)
    public @ResponseBody GenricResponse deletePendingTac(@RequestBody FilterRequest filterRequest);

    @RequestMapping(value = "/visa/view", method = RequestMethod.POST)
    public Object viewVisaRequest(@RequestBody FilterRequest filterRequest,
                                  @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                  @RequestParam(value = "file", defaultValue = "0") Integer file,
                                  @RequestParam(value = "source", defaultValue = "menu") String source);


    //Rule feature Dropdwon
    @RequestMapping(value = "GetfeaturebyRuleName", method = RequestMethod.POST)
    public List<RuleFeatureMappingContent> getFeatureName(@RequestParam(name = "ruleName", required = false) String ruleName);

//Grace/ PostGrace Action Mapping

    @PostMapping(path = "gracePostgraceActionMapping")
    public @ResponseBody List<SystemConfigListDb> gracePostgraceActionMappingFiegn(@RequestParam(name = "tag", required = false) String tag);

    @GetMapping("/getDistinctIMEIFeatureName")
    public List<String> getDistinctIMEIFeatureName();


    @GetMapping("/getDistinctIMEIContentFeatureName")
    public List<String> getDistinctIMEIContentFeatureName();

    @GetMapping("/getDistinctTypeName")
    public List<String> getDistinctTypeName();

    @GetMapping("/getDistinctModuleFeatureName")
    public List<String> getDistinctModuleFeatureName();

    @GetMapping("/getDistinctModulesName")
    public List<String> getDistinctModulesName();

    @GetMapping("/getDistinctModuleStatus")
    public List<String> getDistinctModuleStatus();

    @GetMapping("/modules-audit-trails/{id}")
    public ResponseEntity<AuditTrailContentModel> viewById(@PathVariable("id") long id);

    @GetMapping("/getDistinctAction")
    public List<String> getDistinctAction();

    @PostMapping(value = "/lostStolen/save")
    public GenricResponse saveStolenDevice(@RequestBody LostStolenModel lostStolenModel);


    @PostMapping(value = "/recoveryFound/save")
    public GenricResponse saveRecoveryFound(@RequestBody LostStolenModel lostStolenModel);


    @PostMapping(value = "/checkRequestStatus")
    public GenricResponse checkRequestStatus(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/getOTP")
    public GenricResponse getOTP(@RequestBody LostStolenModel lostStolenModel);

    //------------Initiate Recovery dropdown feign Start ---------------------

    @PostMapping("/v1/address-mgmt/address/getDistricts")
    public List<AddressResp> getDistrict(@RequestParam int id, @RequestParam String lang);

    @PostMapping("/v1/address-mgmt/address/getCommunes")
    public ResponseEntity<?> getCommune(@RequestParam int id, @RequestParam String lang);

    @PostMapping("/v1/address-mgmt/address/getPolices")
    public ResponseEntity<?> getPolice(@RequestParam int id, @RequestParam String lang);

    @PostMapping("/v1/address-mgmt/address/getProvinces")
    public @ResponseBody List<AddressResp> getAllProvinceFeign(@RequestParam String lang);


    @PostMapping(value = "/resendOTP")
    public GenricResponse resendOTP(@RequestBody OTPRequest otpRequest);

    @PostMapping(value = "/verifyOTP")
    public GenricResponse verifyOTP(@RequestBody OTPRequest otpRequest);

    @PostMapping(value = "/getByRequestID")
    public LostStolenModel getByRequestID(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/getLostDeviceByRequestID")
    public LostStolenModel getLostDeviceByRequestID(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/police/lostStolen/bulkSave")
    public GenricResponse bulkSave(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/police/verifyDevice")
    public GenricResponse verifyDevice(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/police/approvePoliceRequest")
    public GenricResponse approveRequest(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/getBulkDeviceByRequestID")
    public LostStolenModel getBulkDeviceByRequestID(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/police/lostStolen/create")
    public GenricResponse saveStolenDevicePolice(@RequestBody LostStolenModel lostStolenModel);

    @PostMapping(value = "/police/verifyOTP")
    public GenricResponse verifyOTPPolice(@RequestBody OTPRequest otpRequest);

    @PostMapping(value = "/police/resendOTP")
    public GenricResponse resendOTPPolice(@RequestBody OTPRequest otpRequest);

    @PostMapping(value = "/countryCodeList")
    public List<CountryCodeModel> getCountryCode();

    //------------Initiate Recovery dropdown feign End ---------------------

    @RequestMapping(value = "/policeStation/filterPoliceDetails", method = RequestMethod.POST)
    public Object policeDetailsFeign(@RequestBody FilterRequest filterRequest,
                                     @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                     @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "file", defaultValue = "0") Integer file);


    @RequestMapping(value = "/policeStation/distinctProvince", method = RequestMethod.POST)
    public Map<String, List<?>> distinctProvince(@RequestBody List<String> list);


    @RequestMapping(value = "/policeStation/distinctDistrict", method = RequestMethod.POST)
    public Map<String, List<?>> distinctDistrict(@RequestBody List<String> list);


    @RequestMapping(value = "/policeStation/distinctCommune", method = RequestMethod.POST)
    public Map<String, List<?>> distinctCommune(@RequestBody List<String> list);

    @RequestMapping(value = "/policeStation/distinctPoliceStation", method = RequestMethod.POST)
    public Map<String, List<?>> distinctPoliceStation(@RequestBody List<String> list);


    /*-------------------------- view  all Alert Management Feign ------------------------------*/

    @RequestMapping(value = "/alertDb/viewAll", method = RequestMethod.POST)
    public Object viewAlertRequest(@RequestBody AlertRequest filterRequest,
                                   @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                   @RequestParam(value = "file", defaultValue = "0") Integer file,
                                   @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


    /*-------------------------- view Alert Management Feign ------------------------------*/
    @PostMapping("/alertDb/view")
    public List<String> userAllAlertDropdown();


    //***************************************************View Alert by Id Management Feign********************************

    @RequestMapping(value = "/alertDb/viewById", method = RequestMethod.POST)
    public @ResponseBody GenricResponse viewAlertFeign(@RequestBody FilterRequest filterRequest);


    //***************************************************Update Alert Management  Feign******************************


    @RequestMapping(value = "/alertDb/update", method = RequestMethod.POST)
    public GenricResponse updateAlertFeign(@RequestBody FilterRequest filterRequest);


    /*-------------------------- view Running Alert Management Feign ------------------------------*/


    @RequestMapping(value = "/runningAlert/viewAll", method = RequestMethod.POST)
    public Object viewRunningAlertRequest(@RequestBody FilterRequest filterRequest,
                                          @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                                          @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
                                          @RequestParam(value = "file", defaultValue = "0") Integer file,
                                          @RequestParam(name = "source", defaultValue = "menu", required = false) String source);

    @GetMapping("/runningAlert/alertFeatures")
    public List<String> getRunningAlertfeatures();

    @GetMapping("/getDistinctFeature")
    public @ResponseBody List<String> getDistinctFeature();

    @GetMapping("/getDistinctUserType")
    public @ResponseBody List<String> getDistinctUserType();


    @GetMapping("/getDistinctSystemFeatureName")
    public @ResponseBody List<String> getDistinctSystemFeatureName();

    @GetMapping("/getDistinctFeatureName")
    public @ResponseBody List<String> getDistinctFeatureName();

    @GetMapping("/getDistinctAlertFeatureName")
    public List<String> getDistinctAlertFeatureName();


    @PostMapping("/getAuditAllfeatures")
    public List<FeatureDropdown> getAuditAllfeatures();


    @PostMapping("/getAllFeatures")
    public List<FeatureDropdown> userAllFeatureDropdown();

    @PostMapping("/userRegistration/getUsertypes")
    public List<String> userRegistrationDropdown(@RequestParam(name = "type", required = false) Integer type);


    // Eirs_Response_Param
    @PostMapping("/v1/eirs-response-param/paging")
    public Object paging(@RequestBody EirsResponseParamModel eirsResponseParamModel,
                         @RequestParam(value = "pageNo", defaultValue = "0") int pageNo,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize);

    @PostMapping("/v1/eirs-response-param")
    public Object findByID(@RequestBody EirsResponseParamModel eirsResponseParamModel);

    @PostMapping("/v1/eirs-response-param/export")
    public FileExportResponse eirsResponseParamExport(@RequestBody EirsResponseParamModel eirsResponseParamModel);

    @PutMapping("/v1/eirs-response-param")
    public GenricResponse update(@RequestBody EirsResponseParamModel eirsResponseParamModel);


    @RequestMapping(value = "/v1/eirs-response-param/distinctParam", method = RequestMethod.POST)
    public Map<String, List<?>> distinct(@RequestBody List<String> list);

}







