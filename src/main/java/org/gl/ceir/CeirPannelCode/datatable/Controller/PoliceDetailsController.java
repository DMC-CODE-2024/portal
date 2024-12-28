package org.gl.ceir.CeirPannelCode.datatable.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
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
import java.util.*;

@RestController
public class PoliceDetailsController {

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
    PoliceDetailPaginationModel auditPaginationModel;
    @Autowired
    org.gl.ceir.CeirPannelCode.configuration.Translator Translator;

    @PostMapping("policeStationDetail")
    public ResponseEntity<?> policeStationDetail(@RequestParam(name = "type", defaultValue = "AuditManagement", required = false) String role, HttpServletRequest request, HttpSession session) {
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter").replace("&#34;", "\"");
        Gson gsonObject = new Gson();
        FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);
        Integer file = 0;
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
        if (request.getParameter("order[0][column]") == null && request.getParameter("order[0][dir]") == null) {
            filterrequest.setColumnName("province");
            filterrequest.setSort("desc");
        } else {
            filterrequest.setColumnName(request.getParameter("order[0][column]"));
            filterrequest.setSort(request.getParameter("order[0][dir]"));
        }
        filterrequest.setSearchString(request.getParameter("search[value]"));
        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);
        try {
            log.info("request send to the filter api =" + filterrequest);
            Object response = feignCleintImplementation.policeDetailsFeign(filterrequest, pageNo, pageSize, file);
            log.info("response in datatable" + response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            auditPaginationModel = gson.fromJson(apiResponse, PoliceDetailPaginationModel.class);
            List<PoliceStationDetailsModel> paginationContentList = auditPaginationModel.getContent();
            log.info("paginationContentList[" + paginationContentList + "]");
            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (PoliceStationDetailsModel dataInsideList : paginationContentList) {
                    String id = String.valueOf(dataInsideList.getId());
                    String createdOn = dataInsideList.getCreatedOn();
                    String province = dataInsideList.getProvinceDb().getProvince();
                    String commune = dataInsideList.getPoliceStationDb().getCommuneDb().getCommune();
                    String district = dataInsideList.getDistrictDb().getDistrict();
                    String police = dataInsideList.getPoliceStationDb().getPolice();
                    String phoneNo = String.valueOf(dataInsideList.getPhoneNo());
                    String firstName = String.valueOf(dataInsideList.getFirstName());
                    Object[] finalData = {province, district,commune, police, firstName,phoneNo};
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

    @PostMapping("policeDetails/pageRendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "Config", required = false) String role, HttpSession session) {
        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");
        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;
        pageElement.setPageTitle("View Police Station Contact Details");
        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();
        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));
         //input type date list
        String[] dateParam = {"select", "Province", "province", "", "select", "District", "district", "","select", "Commune", "commune","","select", "Police Station", "police", "","text","Name","name","25","text","Contact Number","contact","14"};
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

    @PostMapping("exportPoliceDetails")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest, HttpSession session)
    {
        Gson gsonObject=new Gson();
        Object response;
        Integer file = 1;

        log.info("filterRequest:::::::::"+filterRequest);
        response= feignCleintImplementation.policeDetailsFeign(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson= new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response  Police station details Export  api="+fileExportResponse);
        return fileExportResponse;
    }
}
