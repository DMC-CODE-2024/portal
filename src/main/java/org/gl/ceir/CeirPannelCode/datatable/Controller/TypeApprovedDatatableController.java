package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.TypeApprovedRequest;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.TAContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.TrcPaginationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

@RestController
public class TypeApprovedDatatableController {
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
    APIService6Feign apiService6Feign;
    @Autowired
    TAContentModel tacontentModel;
    @Autowired
    TrcPaginationModel TypeApprovePaginationModel;
    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

    @PostMapping("trcData")
    public ResponseEntity<?> viewAdminMessage(
            @RequestParam(name = "type", defaultValue = "Type Approved", required = false) String role,
            @RequestParam(name = "source", defaultValue = "menu", required = false) String source,
            HttpServletRequest request, HttpSession session) {

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter").replace("&#34;", "\"");
        Gson gsonObject = new Gson();
        TypeApprovedRequest typeApprovedRequest = gsonObject.fromJson(filter, TypeApprovedRequest.class);

        String column = null;
        column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Updated Date"
                : "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "File Name"
                : "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Status"
                : "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Transaction ID"
                : "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Uploaded By" :
                "Updated Date";
        String order;

        if ("Updated Date".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
            order = "desc";
        } else if ("Updated Date".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
            order = "asc";
        } else {
            order = request.getParameter("order[0][dir]");
        }


        // -------------------Set Audit Parameters----------------------------//
        typeApprovedRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        typeApprovedRequest.getAuditTrailModel().setColumnName(column);
        typeApprovedRequest.getAuditTrailModel().setSort(order);

        Integer file = 0;
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
        //typeApprovedRequest.setSearchString(request.getParameter("search[value]"));
        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);

        try {
            log.info("request send to the filter api =" + typeApprovedRequest);
            Object response = apiService6Feign.typeApprovedFeign(typeApprovedRequest, pageNo, pageSize,
                    file, source);
            log.info("response in datatable" + response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            TypeApprovePaginationModel = gson.fromJson(apiResponse, TrcPaginationModel.class);
            List<TAContentModel> paginationContentList = TypeApprovePaginationModel.getContent();
            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (TAContentModel dataInsideList : paginationContentList) {
                    String createdOn = (String) dataInsideList.getCreatedOn();
                    String modifiedOn = (String) dataInsideList.getModifiedOn();
                    String fileName = dataInsideList.getFileName();
                    String status = dataInsideList.getStatus();
                    String txnID = (String) dataInsideList.getTransactionId();
                    String uploadedBy = null;
                    if (Objects.nonNull(dataInsideList.getUser())) {
                        uploadedBy = dataInsideList.getUser().getUsername();
                    }


                    String rootPath = null;

                    addMoreFileModel.setTag("system_upload_filepath");
                    urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
                    rootPath = (urlToUpload.getValue() + txnID + "/" + fileName).split("webapps")[1];
                    log.info("urlToUpload value " + urlToUpload.getValue());
                    log.info("filepath [" + rootPath + "]");

                    String action = iconState.TypeApproveIcons(rootPath, fileName);
                    Object[] finalData = {modifiedOn, fileName, status, txnID, uploadedBy, action};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);

                }

            }
            // data set on ModelClass
            datatableResponseModel.setRecordsTotal(TypeApprovePaginationModel.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(TypeApprovePaginationModel.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    @PostMapping("typeApproved/pageRendering")
    public ResponseEntity<?> pageRendering(HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle("Type Approved");

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"FilterButton", "Apply Filter", "TrcDataTable(" + ConfigParameters.languageParam + ")",
                "submitFilter"};
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

        // input type date list
        String[] dateParam = {"date", "Start Date", "startDate", "", "date", "End Date", "endDate", "", "text",
                "File Name", "fileName", "50", "select", "Status", "status", "", "text", "Transaction ID", "transactionID", "", "text", "Uploaded By", "uploadedBy", ""};
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

        pageElement.setDropdownList(dropdownList);
        pageElement.setInputTypeDateList(inputTypeDateList);
        pageElement.setUserStatus(userStatus);
        return new ResponseEntity<>(pageElement, HttpStatus.OK);

    }
}
