package org.gl.ceir.CeirPannelCode.datatable.Controller;

import com.google.gson.Gson;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@RestController
public class LocalManufactureDatatableController {
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

    @PostMapping("viewLocalManufactureData")
    public ResponseEntity<?> viewLocalManufacture(@RequestParam(name = "type", defaultValue = "Local Manufacture", required = false) String role, @RequestParam(name = "source", defaultValue = "menu", required = false) String source, HttpServletRequest request, HttpSession session) {

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter").replace("&#34;", "\"");
        Gson gsonObject = new Gson();
        TypeApprovedRequest typeApprovedRequest = gsonObject.fromJson(filter, TypeApprovedRequest.class);

        String column = null;
        column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Uploaded Date" : "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Serial Number" : "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "IMEI" : "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Manufacture ID" : "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Manufacture Name" : "Uploaded Date";
        String order;

        if ("Uploaded Date".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
            order = "desc";
        } else if ("Uploaded Date".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
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
            Object response = apiService6Feign.localManufactureViewFeign(typeApprovedRequest, pageNo, pageSize, file, source);
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
                    //String modifiedOn = (String) dataInsideList.getModifiedOn();
                    String serialNumber = dataInsideList.getSerialNumber();
                    String imei = dataInsideList.getActualImei();
                    String manufactureID = dataInsideList.getManufacturerId();
                    String manufactureName = dataInsideList.getManufacturerName();
                    Object[] finalData = {createdOn, serialNumber, imei, manufactureID, manufactureName};
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

    @PostMapping("viewLocalManufacture/pageRendering")
    public ResponseEntity<?> pageRendering(HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle("Local Manufacturer IMEI");

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"FilterButton", "Apply Filter", "viewLMDatatable(" + ConfigParameters.languageParam + ")", "submitFilter"};
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
        String[] dateParam = {"date", "Uploaded Date", "viewstartDate", "", "text", "Serial Number", "viewSerialNumber", "50", "text", "IMEI", "imei", "50", "text", "Manufacture ID", "viewManufactureID", "50", "text", "Manufacture Name", "viewManufactureNamer", "50",};
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

    //-------------------Export LM Management Controller-------------------//

    @PostMapping("exportViewLMDetails")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody TypeApprovedRequest typeApprovedRequest, HttpSession session, HttpServletRequest request) {
        Object response;
        Integer file = 1;
        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        log.info("Request to Export:::::::::" + typeApprovedRequest);
        response = apiService6Feign.LMViewExportFeign(typeApprovedRequest, typeApprovedRequest.getPageNo(), typeApprovedRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response Export  api=" + fileExportResponse);
        return fileExportResponse;
    }
}
