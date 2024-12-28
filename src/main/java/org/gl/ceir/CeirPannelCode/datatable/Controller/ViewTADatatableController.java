package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;


@RestController
public class ViewTADatatableController {
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

    @PostMapping("viewApprovedDeviceData")
    public ResponseEntity<?> viewAdminMessage(
            @RequestParam(name = "type", defaultValue = "Type Approved", required = false) String role,
            @RequestParam(name = "source", defaultValue = "menu", required = false) String source,
            HttpServletRequest request, HttpSession session) {

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter =   HtmlUtils.htmlUnescape(request.getParameter("filter"));
        Gson gsonObject = new Gson();
        TypeApprovedRequest typeApprovedRequest = gsonObject.fromJson(filter, TypeApprovedRequest.class);

        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        String column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        System.out.println(">>>column>>>"+request.getParameter("order[0][column]"));
        String columnName = Objects.isNull(sortColumnName(column)) ? "Approved Date" : sortColumnName(column);
        System.out.println(">>columnName>>>>"+columnName);

        // -------------------Set Audit Parameters----------------------------//
        typeApprovedRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        typeApprovedRequest.getAuditTrailModel().setColumnName(columnName);
        typeApprovedRequest.getAuditTrailModel().setSort(order);

        Integer file = 0;
        int pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
        //typeApprovedRequest.setSearchString(request.getParameter("search[value]"));
        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);

        try {
            log.info("request send to the filter api =" + typeApprovedRequest);
            Object response = apiService6Feign.typeApprovedViewFeign(typeApprovedRequest, pageNo, pageSize,
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
                    String createdOn = (String) dataInsideList.getApprovalDate();
                    //String modifiedOn = (String) dataInsideList.getModifiedOn();
                    String company = dataInsideList.getCompany();
                    String companyId = dataInsideList.getCompanyId();
                    String trademark = dataInsideList.getTrademark();
                    String productName = dataInsideList.getProductName();
                    String commercialName = dataInsideList.getCommercialName();
                    String model = dataInsideList.getModel();
                    String country = dataInsideList.getCountry();
                    String trcIdentifier = dataInsideList.getTrcIdentifier();
                    Object[] finalData = {createdOn, company, companyId, trademark, productName, commercialName, model, country, trcIdentifier};
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

    @PostMapping("viewTypeApproved/pageRendering")
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

        String[] names = {"FilterButton", "Apply Filter", "viewTADatatable(" + ConfigParameters.languageParam + ")",
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
        String[] dateParam = {"date", "Approved Start Date", "viewstartDate", "",
                "date", "Approved End Date", "viewEndDate", "",
                "text", "Company", "company", "50",
                "text", "Company ID", "companyId", "50",
                "text", "Trademark", "viewTrademark", "50",
                "text", "Product Name", "viewProductName", "50",
                "text", "Commercial Name", "commercialName", "50",
                "text", "Model", "viewModelNumber", "50",
                "text", "Country Of Manufacture", "com", "",
                "text", "TRC Identifier", "viewTRCIdentifier", "50"};
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

    //-------------------Export TA Management Controller-------------------//

    @PostMapping("exportViewTADetails")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody TypeApprovedRequest typeApprovedRequest, HttpSession session, HttpServletRequest request) {
        Object response;
        Integer file = 1;
        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        log.info("Request to Export:::::::::" + typeApprovedRequest);
        response = apiService6Feign.TAViewExportFeign(typeApprovedRequest, typeApprovedRequest.getPageNo(), typeApprovedRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response Export  api=" + fileExportResponse);
        return fileExportResponse;
    }


    public String sortColumnName(String columnName) {
        Map<String, String> map = new HashMap<>();
        if (Objects.nonNull(columnName) && !columnName.isEmpty()) {
            map.put("0", "Approved Date");
            map.put("1", "Company");
            map.put("2", "Company ID");
            map.put("3", "Trademark");
            map.put("4", "Product Name");
            map.put("5", "Commercial Name");
            map.put("6", "Model");
            map.put("7", "Country Of Manufacture");
            map.put("8", "TRC Identifier");
            map.put("-1", "Approved Date");

        }
        return map.get(columnName);
    }
}
