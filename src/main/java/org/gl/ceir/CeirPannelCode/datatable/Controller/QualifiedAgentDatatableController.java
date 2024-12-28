package org.gl.ceir.CeirPannelCode.datatable.Controller;

import com.google.gson.Gson;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.TypeApprovedRequest;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@RestController
public class QualifiedAgentDatatableController {
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
    TAContentModel localManufactureContent;
    @Autowired
    TrcPaginationModel TypeApprovePaginationModel;

    @PostMapping("viewQualifiedAgentData")
    public ResponseEntity<?> viewQualifiedAgent(
            @RequestParam(name = "type", defaultValue = "Qualified Agent", required = false) String role,
            @RequestParam(name = "source", defaultValue = "menu", required = false) String source,
            HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();

        String filter =   HtmlUtils.htmlUnescape(request.getParameter("filter"));
        Gson gsonObject = new Gson();
        TypeApprovedRequest typeApprovedRequest = gsonObject.fromJson(filter, TypeApprovedRequest.class);

        String column = null;
        column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "S.No"
                : "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Company Name"
                : "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Company ID"
                : "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Phone Number"
                : "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Email"
                : "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Expiry" : "S.No";
        String order;

        if ("S.No".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
            order = "desc";
        } else if ("S.No".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
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
            Object response = apiService6Feign.qualifiedAgentViewFeign(typeApprovedRequest, pageNo, pageSize,
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
                    String SNo = String.valueOf(dataInsideList.getNo());
                    //String modifiedOn = (String) dataInsideList.getModifiedOn();
                    String companyName = dataInsideList.getCompanyName();
                    String companyId = dataInsideList.getCompanyId();
                    String phoneNumber = dataInsideList.getPhoneNumber();
                    String email = dataInsideList.getEmail();
                    String expiry = dataInsideList.getExpiryDate();
                    Object[] finalData = {SNo, companyName, companyId, phoneNumber, email, expiry};
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

    @PostMapping("viewQualifiedAgents/pageRendering")
    public ResponseEntity<?> pageRendering(HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle("Qualified Agent");

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"FilterButton", "Apply Filter", "viewQADatatable(" + ConfigParameters.languageParam + ")",
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
        String[] dateParam = {"text", "Company Name", "viewCompanyName", "",
                "text", "Company ID", "companyId", "",
                "text", "Phone Number", "viewPhoneNumber", "50",
                "text", "Email", "viewEmail", "50",
                "date", "Expiry", "expiry", "50"
        };
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

    //-------------------Export QA Management Controller-------------------//

    @PostMapping("exportViewQADetails")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody TypeApprovedRequest typeApprovedRequest, HttpSession session, HttpServletRequest request) {
        Object response;
        Integer file = 1;
        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        log.info("Request to Export:::::::::" + typeApprovedRequest);
        response = apiService6Feign.QAViewExportFeign(typeApprovedRequest, typeApprovedRequest.getPageNo(), typeApprovedRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response Export  api=" + fileExportResponse);
        return fileExportResponse;
    }
}
