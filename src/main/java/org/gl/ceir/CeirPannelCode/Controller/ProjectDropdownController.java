package org.gl.ceir.CeirPannelCode.Controller;

import org.gl.ceir.CeirPannelCode.Feignclient.*;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.datatable.model.RuleFeatureMappingContent;
import org.gl.ceir.CeirPannelCode.datatable.model.UserfeatureContent;
import org.gl.ceir.CeirPannelCode.features.trc.ApproveDeviceTACFeignClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

@RestController
public class ProjectDropdownController {
    @Autowired
    FeignCleintImplementation feignCleintImplementation;

    @Autowired
    GsmaFeignClient gsmaFeignClient;

    @Autowired
    APIService4Feign apiService4Feign;


    @Autowired
    ApproveDeviceTACFeignClient approveDeviceTACFeignClient;

    @Autowired
    APIService6Feign apiService6Feign;

    @Autowired
    DeviceRepositoryFeign deviceRepositoryFeign;
    private final Logger log = LoggerFactory.getLogger(getClass());

    @ResponseBody
    @GetMapping("getDropdownList/{featureId}/{userTypeId}")
    public List<Dropdown> getConsignmentStatus(@PathVariable("featureId") Integer featureId, @PathVariable("userTypeId") Integer userTypeId) {
        List<Dropdown> dropdown = feignCleintImplementation.consignmentStatusList(featureId, userTypeId);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDropdownList/{tag}")
    public List<Dropdown> getTaxPaidStatus(@PathVariable("tag") String tag) {
        List<Dropdown> dropdown = feignCleintImplementation.taxPaidStatusList(tag);
        dropdown.sort(Comparator.comparing(x -> x.getListOrder()));
        return dropdown;
    }


    @ResponseBody
    @GetMapping("getTypeDropdownList/{tagId}/{userTypeId}")
    public List<Dropdown> asTypeDropdown(@PathVariable("tagId") String tag, @PathVariable("userTypeId") Integer userTypeId) {
        List<Dropdown> dropdown = feignCleintImplementation.asTypeList(tag, userTypeId);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("dataByTag/{tag}/")
    public Dropdown dataByTag(@PathVariable("tag") String tag) {
        Tag tagData = new Tag(tag);
        Dropdown dropdown = feignCleintImplementation.dataByTag(tagData);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getSourceTypeDropdown/{tagId}/{featureId}")
    public List<Dropdown> asRequestType(@PathVariable("tagId") String tagId, @PathVariable("featureId") Integer featureId) {
        List<Dropdown> dropdown = feignCleintImplementation.modeType(tagId, featureId);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("productList")
    public List<Dropdown> productList() {
        List<Dropdown> dropdown = deviceRepositoryFeign.viewAllProductList();
        return dropdown;
    }

    @RequestMapping(value = "/productModelList", method = {org.springframework.web.bind.annotation.RequestMethod.GET})
    public @ResponseBody List<Dropdown> productModelList(@RequestParam(name = "brand_id") Integer brand_id) {
        List<Dropdown> productModelList = gsmaFeignClient.viewAllmodel(brand_id);

        return productModelList;

    }


    @PostMapping("/getSystemTags")
    public @ResponseBody GenricResponse getAllTagsDropdown(@RequestBody FilterRequest filterRequest, HttpSession session) {
        filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
        filterRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("request send to the getAllTagsDropdown api=" + filterRequest);
        GenricResponse response = feignCleintImplementation.getAllTagsDropdowntFeign(filterRequest);
        log.info("response from getAllTagsDropdown api " + response);
        return response;

    }


    @GetMapping("/addMoreFile/{tag}")
    public @ResponseBody AddMoreFileModel addMoreFileControler(@PathVariable("tag") String tag) {
        log.info("request send to the addMore Count api=" + tag);
        AddMoreFileModel addmore = new AddMoreFileModel();
        addmore.setTag(tag);
        AddMoreFileModel response = feignCleintImplementation.addMoreBuutonCount(addmore);
        log.info("response from addMore Count api " + response);
        return response;

    }

    /*
     * @PostMapping("getFeatureName") public ResponseEntity<?>
     * getFeatureName(@RequestParam(name = "ruleName", required = false) String
     * ruleName) { List<String> list = gsmaFeignClient.getFeatureName(ruleName);
     * return new ResponseEntity<>(list, HttpStatus.OK); }
     */

    @PostMapping("getFeatureName")
    public ResponseEntity<?> getFeatureName(@RequestParam(name = "ruleName", required = false) String ruleName) {
        List<RuleFeatureMappingContent> list = feignCleintImplementation.getFeatureName(ruleName);
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @PostMapping("ruleFeatureActionMapping")
    public ResponseEntity<?> ruleFeatureActionMapping(@RequestParam(name = "featureName", required = false) String featureName,
                                                      @RequestParam(name = "ruleName", required = false) String ruleName) {
        List<InterRelatedRuleFeatureMapping> list = gsmaFeignClient.interRelateMapping(featureName, ruleName);
        log.info("final::::" + list);
        return new ResponseEntity<>(list, HttpStatus.OK);

    }

    @ResponseBody
    @GetMapping("getDistinctTypeName")
    public List<String> getDistinctTypeName() {
        List<String> dropdown = feignCleintImplementation.getDistinctTypeName();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctIMEIFeatureName")
    public List<String> getDistinctIMEIFeatureName() {
        List<String> dropdown = feignCleintImplementation.getDistinctIMEIFeatureName();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctIMEIContentFeatureName")
    public List<String> getDistinctIMEIContentFeatureName() {
        List<String> dropdown = feignCleintImplementation.getDistinctIMEIContentFeatureName();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);

        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }


    @ResponseBody
    @GetMapping("getDistinctFeatureList")
    public List<String> getDistinctFeatureList() {
        List<String> dropdown = feignCleintImplementation.getDistinctFeature();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctUserTypeList")
    public List<String> getDistinctUserTypeList() {
        List<String> dropdown = feignCleintImplementation.getDistinctUserType();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctSystemParamFeatureName")
    public List<String> getDistinctSystemFeatureName() {
        List<String> dropdown = feignCleintImplementation.getDistinctSystemFeatureName();
        log.info("[dropdown] list is " + dropdown);
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
/*
        Comparator.nullsFirst(Comparator.naturalOrder())
        */
        return dropdown;
    }


    @ResponseBody
    @GetMapping("getusertypefeature/{featureId}/{usertypeId}")
    public List<UserfeatureContent> userToFeatureDropdown(@PathVariable("featureId") Integer featureId, @PathVariable("usertypeId") Integer usertypeId) {
        List<UserfeatureContent> response = apiService4Feign.userToFeatureDropdownFeign(featureId, usertypeId);
        return response;
    }


    @ResponseBody
    @GetMapping("/getList/dropdown")
    public List<GetDumpFileList> getList(@RequestParam("tag") String tag) {
        List<GetDumpFileList> dropdown = apiService4Feign.getListDropDown(tag);
        log.info("response from getList api " + dropdown);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctFeatureNameList")
    public List<String> getDistinctFeatureNameList() {
        List<String> dropdown = feignCleintImplementation.getDistinctFeatureName();
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctModuleFeatureName")
    public List<String> getDistinctModuleFeatureName() {
        List<String> dropdown = feignCleintImplementation.getDistinctModuleFeatureName();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctModulesName")
    public List<String> getDistinctModulesName() {
        List<String> dropdown = feignCleintImplementation.getDistinctModulesName();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctModuleStatus")
    public List<String> getDistinctModuleStatus() {
        List<String> dropdown = feignCleintImplementation.getDistinctModuleStatus();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    @ResponseBody
    @GetMapping("getDistinctActionName")
    public List<String> getDistinctActionName() {
        List<String> dropdown = feignCleintImplementation.getDistinctAction();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }


    @PostMapping("/adt")
    @ResponseBody
    public Map<String, List<?>> adt(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = approveDeviceTACFeignClient.distinctApproveDeviceTACDropdown(param);
        return stringListMap;
    }


    @PostMapping("/list-management-const")
    @ResponseBody
    public Map<String, List<?>> lm(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = apiService6Feign.distinctEirsListMgmt(param);
        return stringListMap;
    }

    @PostMapping("/exception-list-const")
    @ResponseBody
    public Map<String, List<?>> el(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = apiService6Feign.distinctExceptionList(param);
        return stringListMap;
    }

    @PostMapping("/block-list-const")
    @ResponseBody
    public Map<String, List<?>> bl(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = apiService6Feign.distinctBlockList(param);
        return stringListMap;
    }

    @PostMapping("/gray-list-const")
    @ResponseBody
    public Map<String, List<?>> gl(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = apiService6Feign.distinctGrayList(param);
        return stringListMap;
    }

    @PostMapping("/block-tac-const")
    @ResponseBody
    public Map<String, List<?>> bt(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = apiService6Feign.distinctBlockTAC(param);
        return stringListMap;
    }

    @ResponseBody
    @GetMapping("/getRunningAlertfeatures")
    public List<String> getRunningAlertfeatures() {
        List<String> dropdown = feignCleintImplementation.getRunningAlertfeatures();
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

//------------Initiate Recovery Dropdown Start ---------------------

    @ResponseBody
    @GetMapping("/brandName")
    public List<Dropdown> brandName() {
        List<Dropdown> dropdown = deviceRepositoryFeign.viewAllProductList();
        return dropdown;
    }

    @ResponseBody
    @PostMapping("/getAllProvince")
    public List<AddressResp> getAllProvince(@RequestBody AddressModel addressModel) {
        return feignCleintImplementation.getAllProvinceFeign(addressModel.getLang());
    }

    @ResponseBody
    @PostMapping("/getDistrict")
    public List<AddressResp> getDistrict(@RequestBody AddressModel addressModel) {
        return feignCleintImplementation.getDistrict(addressModel.getId(), addressModel.getLang());
    }

    @ResponseBody
    @PostMapping("/getCommune")
    public ResponseEntity<?> getCommune(@RequestBody AddressModel addressModel) {
        return feignCleintImplementation.getCommune(addressModel.getId(), addressModel.getLang());
    }

    @ResponseBody
    @PostMapping("/getPolice")
    public ResponseEntity<?> getPolice(@RequestBody AddressModel addressModel) {
        return feignCleintImplementation.getPolice(addressModel.getId(),addressModel.getLang());
    }

    @ResponseBody
    @GetMapping("/getCountryCode")
    public List<CountryCodeModel> getCountryCode() {
        List<CountryCodeModel> dropdown = feignCleintImplementation.getCountryCode();
        System.out.println(dropdown);
        return dropdown;
    }


    @PostMapping("/policeStation/distinctCommune")
    public Map<String, List<?>> distinctCommune(@RequestBody List<String> list) {
        return feignCleintImplementation.distinctCommune(list);

    }

    @PostMapping("/policeStation/distinctDistrict")
    public Map<String, List<?>> distinctDistrict(@RequestBody List<String> list) {
        return feignCleintImplementation.distinctDistrict(list);
    }

    @PostMapping("/policeStation/distinctProvince")
    public Map<String, List<?>> distinctProvince(@RequestBody List<String> list) {
        return feignCleintImplementation.distinctProvince(list);
    }

    @PostMapping("/policeStation/distinctPoliceStation")
    public Map<String, List<?>> distinctPoliceStation(@RequestBody List<String> list) {
        return feignCleintImplementation.distinctPoliceStation(list);
    }

    //------------Initiate Recovery Dropdown End---------------------
}		
