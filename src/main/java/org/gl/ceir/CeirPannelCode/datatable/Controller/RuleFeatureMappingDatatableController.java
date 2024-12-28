package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.InterRelatedRuleFeatureMapping;
import org.gl.ceir.CeirPannelCode.Model.NewRule;
import org.gl.ceir.CeirPannelCode.Model.RuleEngineMapping;
import org.gl.ceir.CeirPannelCode.Model.RuleNameModel;
import org.gl.ceir.CeirPannelCode.Model.SystemConfigListDb;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.RuleFeatureMappingContent;
import org.gl.ceir.CeirPannelCode.datatable.model.RuleFeatureMappingPagination;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import org.springframework.web.util.HtmlUtils;

@RestController
public class RuleFeatureMappingDatatableController {

    private final Logger log = LoggerFactory.getLogger(getClass());
    String className = "emptyClass";
    @Autowired
    Translator Translator;
    @Autowired
    PageElement pageElement;
    @Autowired
    Button button;
    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    IconsState iconState;
    @Autowired
    DatatableResponseModel datatableResponseModel;
    @Autowired
    RuleFeatureMappingPagination ruleFeatureMappingPagination;
    @Autowired
    GsmaFeignClient gsmaFeignClient;
    @Autowired
    InterRelatedRuleFeatureMapping interRelatedRuleFeatureMapping;

    @PostMapping("ruleFeatureMappingListData")
    public ResponseEntity<?> getData(@RequestParam(name = "type", required = false) String role,
                                     HttpServletRequest request, HttpSession session) {

        // String userType = (String) session.getAttribute("usertype");
        // int userId= (int) session.getAttribute("userid");
        Integer file = 0;
        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        //String filter = request.getParameter("filter");
        String filter =HtmlUtils.htmlUnescape(request.getParameter("filter"));
        Gson gsonObject = new Gson();
        FilterRequest filterRequest = gsonObject.fromJson(filter, FilterRequest.class);
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;

        if (request.getParameter("order[0][column]") == null && request.getParameter("order[0][dir]") == null) {
            filterRequest.setColumnName("modifiedOn");
            filterRequest.setSort("desc");
        } else {
            filterRequest.setColumnName(request.getParameter("order[0][column]"));
            filterRequest.setSort(request.getParameter("order[0][dir]"));
        }
        filterRequest.setSearchString(request.getParameter("search[value]"));
        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);
        try {
            filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
            filterRequest.setBrowser(session.getAttribute("browser").toString());
            log.info("request send to the filter api =" + filterRequest);
            Object response = feignCleintImplementation.ruleFeatureMappingListFeign(filterRequest, pageNo, pageSize,
                    file);
            log.info("response in datatable" + response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            ruleFeatureMappingPagination = gson.fromJson(apiResponse, RuleFeatureMappingPagination.class);
            List<RuleFeatureMappingContent> ruleFeatureMappingContent = ruleFeatureMappingPagination.getContent();
            if (ruleFeatureMappingContent.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (RuleFeatureMappingContent dataInsideList : ruleFeatureMappingContent) {
                    String id = String.valueOf(dataInsideList.getId());
                    String createdOn = dataInsideList.getCreatedOn();
                    String modifiedOn = dataInsideList.getModifiedOn();
                    String name = dataInsideList.getName();
                    String feature = dataInsideList.getFeature();
                    //String user = dataInsideList.getUserType();
                    String ruleOrder = String.valueOf(dataInsideList.getRuleOrder());
                    String gracePeriod = dataInsideList.getGraceAction();
                    String postGracePeriod = dataInsideList.getPostGraceAction();
                    String moveToGrace = dataInsideList.getFailedRuleActionGrace();
                    String moveToPostGrace = dataInsideList.getFailedRuleActionPostGrace();

                    String output = dataInsideList.getOutput() == null ? null : (dataInsideList.getOutput().equals("Y") || dataInsideList.getOutput().equals("Yes")) ? "Yes" : "No";
                    // log.info("Id-->"+Id+"--userStatus--->"+userStatus+"--StatusName---->"+StatusName+"--createdOn---->"+createdOn+"--id--->"+id+"--userName-->"+username);
                    String action = iconState.ruleFeatureMappingIcons(id);
                    Object[] finalData = {createdOn, modifiedOn, name, feature, ruleOrder, gracePeriod,
                            postGracePeriod, moveToGrace, moveToPostGrace, output, action};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);

                }
            }
            // data set on ModelClass
            datatableResponseModel.setRecordsTotal(ruleFeatureMappingPagination.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(ruleFeatureMappingPagination.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);
        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PostMapping("ruleFeatureMapping/pageRendering")
    public ResponseEntity<?> pageRendering(HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle(Translator.toLocale("title.ruleFeatureMapping"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

/*
		String[] names = { "HeaderButton", Translator.toLocale("button.add"), "./add_ruleFeatureMav", "btnLink",
				"FilterButton", Translator.toLocale("button.filter"), "filter(" + ConfigParameters.languageParam + ")",
				"submitFilter" };
		for (int i = 0; i < names.length; i++) {
			button = new Button();
			button.setType(names[i]);
			i++;
			button.setButtonTitle(names[i]);
			i++;
			button.setButtonURL(names[i]);
			i++;
			button.setId(names[i]);
			buttonList.add(button);
		}
		pageElement.setButtonList(buttonList);
*/

        // Dropdown items

        /*
         * String[] selectParam = { "select", Translator.toLocale("table.ruleName"),
         * "Rule Name", "", "select", Translator.toLocale("table.featureName"),
         * "Feature Name", "", "select", Translator.toLocale("table.userType"),
         * "User Type", "" }; for (int i = 0; i < selectParam.length; i++) { inputFields
         * = new InputFields(); inputFields.setType(selectParam[i]); i++;
         * inputFields.setTitle(selectParam[i]); i++; inputFields.setId(selectParam[i]);
         * i++; inputFields.setClassName(selectParam[i]); dropdownList.add(inputFields);
         * } pageElement.setDropdownList(dropdownList);
         */

        String[] dateParam = {"date", Translator.toLocale("input.startDate"), "startDate", "",
                "date", Translator.toLocale("input.endDate"), "endDate", "",
                "select", Translator.toLocale("table.ruleName"), "RuleName", "",
                "select", Translator.toLocale("table.featureName"), "FeatureName", "",
                "text", Translator.toLocale("table.order"), "actionOrder", "5",
                "select", Translator.toLocale("table.gracePeriod"), "actionGracePeriod", "",
                "select", Translator.toLocale("table.postGracePeriod"), "actionPostGracePeriod", "",
                "select", Translator.toLocale("table.moveToGracePeriod"), "actionMoveToGracePeriod", "",
                "select", Translator.toLocale("rule.feature.moveToPostGracePeriod"), "actionMoveToPostGracePeriod", "",
                "select", Translator.toLocale("table.expectedOutput"), "expectedOutput", ""};
        for (int i = 0; i < dateParam.length; i++) {
            dateRelatedFields = new InputFields();
            dateRelatedFields.setType(dateParam[i]);
            i++;
            dateRelatedFields.setTitle(dateParam[i]);
            i++;
            dateRelatedFields.setId(dateParam[i]);
            i++;
            dateRelatedFields.setClassName(dateParam[i]);
            inputTypeDateList.add(dateRelatedFields);
        }


        pageElement.setInputTypeDateList(inputTypeDateList);
        pageElement.setUserStatus(userStatus);
        return new ResponseEntity<>(pageElement, HttpStatus.OK);

    }

    // ************************************************ update consignment record
    // page********************************************************************************/

    @RequestMapping(value = {"/save"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET,
            org.springframework.web.bind.annotation.RequestMethod.POST})
    public GenricResponse saveRecord(@RequestBody NewRule newRule, HttpSession session) {
        newRule.setPublicIp(session.getAttribute("publicIP").toString());
        newRule.setBrowser(session.getAttribute("browser").toString());
        log.info("request::::::" + newRule);
        // RuleListContent ruleList = new RuleListContent();
        GenricResponse response = feignCleintImplementation.save(newRule);

        log.info(" response::::::" + response);
        return response;

    }

    // ************************************************ update Rule Feature Mapping
    // record
    // page********************************************************************************/

    @PostMapping("/updateRuleMapping")
    public @ResponseBody GenricResponse updateRecord(@RequestBody NewRule newRule, HttpSession session) {
        newRule.setPublicIp(session.getAttribute("publicIP").toString());
        newRule.setBrowser(session.getAttribute("browser").toString());
        log.info("request::::::" + newRule);
        GenricResponse response = feignCleintImplementation.updateRuleFeatureMapping(newRule);
        log.info(" response from update Consignment api=" + response);
        return response;

    }

    @GetMapping("ruleName")
    public ResponseEntity<?> getRuleNames() {
        List<RuleNameModel> list = feignCleintImplementation.getList();
        list.sort(Comparator.comparing(x -> x.getName()));
        return new ResponseEntity<>(list, HttpStatus.OK);
    }


    /*
     * @GetMapping("/getBy/{id}") public ResponseEntity<?>
     * getByIDRule(@PathVariable("id") Integer id,HttpServletRequest
     * request,HttpSession session) { String filter =
     * request.getParameter("request"); Gson gson= new Gson();
     * log.info("before casting request in to pojo classs"+filter); FilterRequest
     * filterRequest = gson.fromJson(filter, FilterRequest.class);
     * log.info("after casting request in to pojo classs"+filter);
     * filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
     * filterRequest.setBrowser(session.getAttribute("browser").toString()); NewRule
     * newRule = feignCleintImplementation.getObjectByID(id,filterRequest); return
     * new ResponseEntity<>(newRule, HttpStatus.OK); }
     */

    @GetMapping("/getBy/{id}")
    public ResponseEntity<?> getByIDRule(@PathVariable("id") Integer id) {
        log.info("id is " + id);
        NewRule newRule = feignCleintImplementation.getObjectByID(id);
        return new ResponseEntity<>(newRule, HttpStatus.OK);
    }

    @PostMapping("deleteRuleMapping")
    public @ResponseBody GenricResponse delete(@RequestBody NewRule newRule, HttpSession session) {
        newRule.setPublicIp(session.getAttribute("publicIP").toString());
        newRule.setBrowser(session.getAttribute("browser").toString());
        GenricResponse response = feignCleintImplementation.delete(newRule);
        return response;

    }

    /*
     * @PostMapping("getFeaturedUserType") public @ResponseBody List<NewRule>
     * getFeaturedUserType(@RequestParam(name="featureName") String featureName) {
     * log.info("feature name send to the get userType API"+featureName); //
     * List<Usertype> response =
     * feignCleintImplementation.getUserTypeByFeatureID(featureName); List<NewRule>
     * response = feignCleintImplementation.getUserTypeByFeatureID(featureName);
     * log.info("response from get userType API"+featureName); return response;
     *
     * }
     */

    @PostMapping("getFeaturedUserType")
    public @ResponseBody List<RuleEngineMapping> getFeaturedUserType(@RequestParam(name = "featureName") String featureName,
                                                                     @RequestParam(name = "name") String name) {
        log.info("feature name send to the get userType API" + featureName, name);
        List<RuleEngineMapping> response = feignCleintImplementation.getUserTypeByFeatureID(featureName, name);
        log.info("response from get userType API" + featureName);
        return response;

    }

    @PostMapping("gracePostgraceActionMapping")
    public ResponseEntity<?> actionMapping(@RequestParam(name = "tag", required = false) String tag) {
        log.info("Tag Recieved for Action ::::" + tag);
        List<SystemConfigListDb> list = feignCleintImplementation.gracePostgraceActionMappingFiegn(tag);
        log.info("final::::" + list);
        return new ResponseEntity<>(list, HttpStatus.OK);

    }

}
