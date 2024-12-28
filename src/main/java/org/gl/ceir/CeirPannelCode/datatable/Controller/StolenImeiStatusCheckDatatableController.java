package org.gl.ceir.CeirPannelCode.datatable.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.StolenImeiStatusCheckRequest;
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
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@RestController
public class StolenImeiStatusCheckDatatableController {
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
    DeviceRepositoryFeign deviceRepositoryFeign;
    @Autowired
    StolenImeiStatusContentModel stolenStatusContentModel;
    @Autowired
    StolenImeiStatusPaginitionModel stolenStatusPaginitionModel;

    @PostMapping("/getStolenImeiStatusCheckDetails")
    public ResponseEntity<?> viewDatatable(
            @RequestParam(name = "type", defaultValue = "Duplicate Data", required = false) String role,
            @RequestParam(name = "source", defaultValue = "menu", required = false) String source,
            HttpServletRequest request, HttpSession session) {

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = HtmlUtils.htmlUnescape(request.getParameter("filter"));
        Gson gsonObject = new Gson();
        StolenImeiStatusCheckRequest stolenRequest = gsonObject.fromJson(filter, StolenImeiStatusCheckRequest.class);

        String column = null;
        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        String columnName = Objects.isNull(sortColumnName(column)) ? "Updated Date" : sortColumnName(column);

        // -------------------Set Audit Parameters----------------------------//
        stolenRequest.setOrderColumnName(columnName);
        stolenRequest.setSort(order);

        Integer file = 0;
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;


        try {
            log.info("request send to the filter api ={}", stolenRequest);
            Object response = deviceRepositoryFeign.getStolenDeviceFeign(stolenRequest, pageNo, pageSize, file);
            log.info("response in datatable{}", response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            stolenStatusPaginitionModel = gson.fromJson(apiResponse, StolenImeiStatusPaginitionModel.class);
            List<StolenImeiStatusContentModel> paginationContentList = stolenStatusPaginitionModel.getContent();
            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (StolenImeiStatusContentModel dataInsideList : paginationContentList) {
                    Integer id = dataInsideList.getId();
                    String createdOn = (String) dataInsideList.getCreatedOn();
                    String modifiedOn = dataInsideList.getModifiedOn();
                    String transactionId = dataInsideList.getTransactionId();
                    String requestMode = dataInsideList.getRequestMode();
                    String imei = dataInsideList.getImei1();
                    String fileName = dataInsideList.getFileName();
                    String fileRecordCount = Objects.isNull(dataInsideList.getFileRecordCount()) ? null : String.valueOf(dataInsideList.getFileRecordCount());
                    String countFoundInLost = Objects.isNull(dataInsideList.getCountFoundInLost()) ? null : String.valueOf(dataInsideList.getCountFoundInLost());
                    String status = dataInsideList.getStatus();
                    //String remark = dataInsideList.getRemark();
                    String action = iconState.StolenImeiStatusCheckIconsList(id, transactionId,countFoundInLost);
                    Object[] finalData = {createdOn, modifiedOn, transactionId, requestMode, imei, fileName, fileRecordCount, countFoundInLost, status, action};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);
                }

            }
            // data set on ModelClass
            datatableResponseModel.setRecordsTotal(stolenStatusPaginitionModel.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(stolenStatusPaginitionModel.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    @PostMapping("stolenImeiStatusCheck/pageRendering")
    public ResponseEntity<?> pageRendering(HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle("Stolen IMEI Status Check");

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::{}", userStatus);
        log.info("session value user Type=={}", session.getAttribute("usertype"));

        String[] names = {"FilterButton", "Apply Filter", "Datatable(" + ConfigParameters.languageParam + ")", "submitFilter"};
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
        String[] dateParam = {"date", "Creation Date", "filterCreatedDate", "",
                "date", "Updated Date", "filterUpdatedDate", "20",
                "text", "Transaction ID", "filterTransactionID", "20",
                "select", "Request Mode", "filterRequestMode", "",
                "text", "IMEI", "filterImei", "16",
                "text", "File Name", "filterFileName", "20",
                "select", "Status", "filterStatus", ""};
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

    public String sortColumnName(String columnName) {
        Map<String, String> map = new HashMap<>();
        if (Objects.nonNull(columnName) && !columnName.isEmpty()) {
            map.put("0", "Creation Date");
            map.put("1", "Updated Date");
            map.put("2", "Transaction ID");
            map.put("3", "Request Mode");
            map.put("4", "IMEI");
            map.put("5", "File Name");
            map.put("6", "Record Count");
            map.put("7", "IMEI Found Count");
            map.put("8", "Status");
            map.put("9", "Remark");
        }
        map.put(null, "Updated Date");
        return map.get(columnName);
    }

    //-------------------Export Stolen IMEI Controller-------------------//

    @PostMapping("export-stolenimeistatus-details")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpSession session, HttpServletRequest request) {
        Object response;
        Integer file = 1;

        String column = null;
        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        String columnName = Objects.isNull(sortColumnName(column)) ? "Updated Date" : sortColumnName(column);
        stolenRequest.setOrderColumnName(columnName);
        stolenRequest.setSort(order);

        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        stolenRequest.setBrowser(session.getAttribute("browser").toString());
        stolenRequest.setPublicIp(session.getAttribute("publicIP").toString());
        log.info("Request to Export:::::::::" + stolenRequest);
        response = deviceRepositoryFeign.getStolenDeviceExportFeign(stolenRequest);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response Export  api=" + fileExportResponse);
        return fileExportResponse;
    }

}
