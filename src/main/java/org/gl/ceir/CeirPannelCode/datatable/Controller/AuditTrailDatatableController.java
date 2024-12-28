package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;

@RestController
public class AuditTrailDatatableController {
    private final Logger log = LoggerFactory.getLogger(getClass());
    @Autowired
    IconsState iconState;
    @Autowired
    PageElement pageElement;
    @Autowired
    Button button;
    @Autowired
    DatatableResponseModel datatableResponseModel;
    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    AuditTrailContentModel auditContentModel;
    @Autowired
    AuditTrailPaginationModel auditPaginationModel;
    @Autowired
    Translator Translator;

    @PostMapping("auditTrailManagementData")
    public ResponseEntity<?> viewAuditManagement(@RequestParam(name = "type", defaultValue = "AuditManagement", required = false) String role, HttpServletRequest request, HttpSession session) {
        //String userType = (String) session.getAttribute("usertype");
        //int userId=	(int) session.getAttribute("userid");
        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter").replace("&#34;", "\"");

        System.out.println("##########################################" + filter);

        Gson gsonObject = new Gson();
        FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);
        Integer file = 0;
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
        if (request.getParameter("order[0][column]") == null && request.getParameter("order[0][dir]") == null) {
            filterrequest.setColumnName("modifiedOn");
            filterrequest.setSort("desc");
        } else {
            filterrequest.setColumnName(request.getParameter("order[0][column]"));
            filterrequest.setSort(request.getParameter("order[0][dir]"));
        }
        filterrequest.setSearchString(request.getParameter("search[value]"));
        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);
        try {
            log.info("request send to the filter api =" + filterrequest);
            Object response = feignCleintImplementation.auditTrailManagementFeign(filterrequest, pageNo, pageSize, file);
            log.info("response in datatable" + response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            auditPaginationModel = gson.fromJson(apiResponse, AuditTrailPaginationModel.class);
            List<AuditTrailContentModel> paginationContentList = auditPaginationModel.getContent();
            log.info("paginationContentList[" + paginationContentList + "]");
            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (AuditTrailContentModel dataInsideList : paginationContentList) {
                    String id = String.valueOf(dataInsideList.getId());
                    String createdOn = dataInsideList.getCreatedOn();
                    String roleType = dataInsideList.getRoleType();
                    String featureName = dataInsideList.getFeatureName();
                    String publicIp = dataInsideList.getPublicIp();
                    String browser = dataInsideList.getBrowser();
                    String executionTime = String.valueOf(dataInsideList.getExecutionTime());
                    String count, count2, failureCount;
                    count = String.valueOf(dataInsideList.getCount());
                    count2 = String.valueOf(dataInsideList.getCount2());
                    failureCount = String.valueOf(dataInsideList.getFailureCount());
                    String status = dataInsideList.getStatus();
                    String moduleName = dataInsideList.getModuleName();
                    String action = dataInsideList.getAction();
                    String info = dataInsideList.getInfo();
                    String actionIcon = iconState.auditTrailIcon(dataInsideList.getId());
                    String modifiedOn = dataInsideList.getModifiedOn();


                    if (Objects.isNull(count) || count.equalsIgnoreCase("")) {
                        count = "0";
                    }
                    if (Objects.isNull(count2) || count2.equalsIgnoreCase("")) {
                        count2 = "0";
                    }
                    if (Objects.isNull(failureCount) || failureCount.equalsIgnoreCase("")) {
                        failureCount = "0";
                    }
                    if (Objects.isNull(status) || status.equalsIgnoreCase("")) {
                        status = "NA";
                    }

                    if (Objects.isNull(info) || info.equalsIgnoreCase("")) {
                        info = "NA";
                    }

                    //String userStatus = (String) session.getAttribute("userStatus");

                    Object[] finalData = {createdOn, modifiedOn, moduleName, featureName, executionTime, count, count2, failureCount, status, info, action, actionIcon};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);
                }
            }
            //data set on ModelClass
            datatableResponseModel.setRecordsTotal(auditPaginationModel.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(auditPaginationModel.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @PostMapping("audit/trail/pageRendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "Config", required = false) String role, HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle("Modules Audit Trail");

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

/*        String[] names = {"HeaderButton", Translator.toLocale("button.addCurrency"), "AddCurrencyAddress()", "btnLink",
                "FilterButton", Translator.toLocale("button.filter"), "auditManagementDatatable(" + ConfigParameters.languageParam + ")", "submitFilter"};
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
        pageElement.setButtonList(buttonList);*/


        //input type date list
        String[] dateParam = {"date", Translator.toLocale("input.startDate"), "startDate", "", "date", Translator.toLocale("input.endDate"), "endDate", "", "select", Translator.toLocale("table.moduleName"), "Module", "","select", Translator.toLocale("table.featureName"), "feature", "", "select", Translator.toLocale("table.status"), "status", "", "select", Translator.toLocale("table.action"), "action", ""};
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

    @GetMapping("/audit-trail/{id}")
    public ResponseEntity<AuditTrailContentModel> viewAuditTrailManagementFeign(@PathVariable("id") Integer id) {
        return feignCleintImplementation.viewById(id);
    }
}
