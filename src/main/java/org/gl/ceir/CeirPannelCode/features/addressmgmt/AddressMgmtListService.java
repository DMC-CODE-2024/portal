package org.gl.ceir.CeirPannelCode.features.addressmgmt;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignClientImplementation;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.features.addressmgmt.model.AddressMgmtModel;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.ExceptionListEntity;
import org.gl.ceir.CeirPannelCode.features.trc.ApproveDeviceTACFeignClient;
import org.gl.ceir.CeirPannelCode.features.trc.model.ContentResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Component
public class AddressMgmtListService {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    String className = "emptyClass";

    @Autowired
    private Translator translator;
    private DatatableResponseModel datatableResponseModel;
    private PageElement pageElement;
    private Button button;
    private IconsState iconState;
    private FeignClientImplementation feignClientImplementation;

    @Autowired
    public AddressMgmtListService(FeignClientImplementation feignClientImplementation, DatatableResponseModel datatableResponseModel, PageElement pageElement, Button button, IconsState iconState, ApproveDeviceTACFeignClient approveDeviceTACFeignClient) {
        this.feignClientImplementation = feignClientImplementation;
        this.datatableResponseModel = datatableResponseModel;
        this.pageElement = pageElement;
        this.button = button;
        this.iconState = iconState;
    }

    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        String filter = HtmlUtils.htmlUnescape(request.getParameter("filter"));
        logger.info("filter payload [" + filter + "]");
        Gson gsonObject = new Gson();
        AddressMgmtModel addressMgmtModel = gsonObject.fromJson(filter, AddressMgmtModel.class);
        logger.info("AddressMgmtModel payload [" + addressMgmtModel + "]");
        String userType = (String) session.getAttribute("usertype");
        int userId = (int) session.getAttribute("userid");

        logger.info("session parameters usertype [" + userType + "] and userID [" + userId + "]");

        String search = request.getParameter("search[value]");
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;

        logger.info("search [" + search + "] pageSize  " + pageSize + " and pageNo " + pageNo + "");

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();

        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        String column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        String columnName = Objects.isNull(sortColumnName(column)) ? "Modified On" : sortColumnName(column);

        logger.info("column [" + column + "] and order [" + order + "] columnName[" + columnName + "]");

        addressMgmtModel.getAuditTrailModel().setColumnName(columnName);
        addressMgmtModel.getAuditTrailModel().setSort(order);
        addressMgmtModel.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        addressMgmtModel.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("payload pass to addressMgmtModel [" + addressMgmtModel + "]");

        Integer numberOfElements = null;
        Integer totalElements = null;
        HttpStatus httpStatus;

        /*     try {*/

        Object response = feignClientImplementation.paging(addressMgmtModel, pageNo, pageSize);

        logger.info("response from API [" + response + "]");

        Gson gson = new Gson();
        String gsonJson = gson.toJson(response);

        logger.info("gsonJson [" + gsonJson + "]");
        ContentResponse tacPaging = gson.fromJson(gsonJson, new TypeToken<ContentResponse<AddressMgmtModel>>() {
        }.getType());

        logger.info("pagingResponse [" + tacPaging + "]");

        List<AddressMgmtModel> paginationContentList = tacPaging.getContent();


        logger.info("paginationContentList [" + paginationContentList + "]");

        if (paginationContentList.isEmpty()) {
            datatableResponseModel.setData(Collections.emptyList());
            datatableResponseModel.setRecordsTotal(0);
            datatableResponseModel.setRecordsFiltered(0);
            httpStatus = HttpStatus.OK;
        } else {
            for (AddressMgmtModel dataInsideList : paginationContentList) {
                List<Object> finalDataList = getFinalDataList(addressMgmtModel.getLanguage(), dataInsideList);
                finalList.add(finalDataList);
                datatableResponseModel.setData(finalList);

            }
            numberOfElements = tacPaging.getNumberOfElements();
            totalElements = tacPaging.getTotalElements();
            httpStatus = HttpStatus.OK;
            datatableResponseModel.setRecordsTotal(numberOfElements);
            datatableResponseModel.setRecordsFiltered(totalElements);
        }
        return new ResponseEntity<>(datatableResponseModel, httpStatus);
    }

    private List<Object> getFinalDataList(String lang, AddressMgmtModel addressMgmtModel) {

        String id = String.valueOf(addressMgmtModel.getId());
        String createdOn = addressMgmtModel.getCreatedOn();
        String modifiedOn = addressMgmtModel.getModifiedOn();
        String province = lang.equalsIgnoreCase("en") ? addressMgmtModel.getProvince() : addressMgmtModel.getProvinceKm();
        String district = lang.equalsIgnoreCase("en") ? addressMgmtModel.getDistrict() : addressMgmtModel.getDistrictKm();
        String commune = lang.equalsIgnoreCase("en") ? addressMgmtModel.getCommune() : addressMgmtModel.getCommuneKm();
        String action = iconState.addressManagementIcons(id);
        Object[] finalData;
        List<Object> finalDataList = null;
        finalData = new Object[]{createdOn, modifiedOn, province, district, commune, action};
        finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
        return finalDataList;
    }

    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {

        String userType = String.valueOf(session.getAttribute("usertype"));
        String userStatus = String.valueOf(session.getAttribute("userStatus"));

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle(translator.toLocale("View Address List Management"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        logger.info("USER STATUS:::::::::" + userStatus);
        logger.info("session value user Type==" + session.getAttribute("usertype"));

        String[] dateParam = {"date", translator.toLocale("input.startDate"), "startDate", "", "date", translator.toLocale("input.endDate"), "endDate", "", "select", translator.toLocale("input.province"), "province", "", "select", translator.toLocale("input.district"), "district", "", "select", translator.toLocale("input.commune"), "commune", ""};

        for (int i = 0; i < dateParam.length; i++) {
            dateRelatedFields = new InputFields();
            dateRelatedFields.setType(dateParam[i++]);
            dateRelatedFields.setTitle(dateParam[i++]);
            dateRelatedFields.setId(dateParam[i++]);
            dateRelatedFields.setClassName(dateParam[i]);
            inputTypeDateList.add(dateRelatedFields);
        }

        pageElement.setInputTypeDateList(inputTypeDateList);
        pageElement.setUserStatus(userStatus);
        return new ResponseEntity<>(pageElement, HttpStatus.OK);

    }


    public FileExportResponse export(AddressMgmtModel addressMgmtModel, HttpSession session) {
        //  Gson gsonObject = new Gson();
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        addressMgmtModel.getAuditTrailModel().setUserType(userType);
        addressMgmtModel.getAuditTrailModel().setUserTypeId(Long.valueOf(usertypeId));
        addressMgmtModel.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        addressMgmtModel.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + addressMgmtModel);
        response = feignClientImplementation.addressMgmtExport(addressMgmtModel);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        logger.info("response " + fileExportResponse);
        return fileExportResponse;
    }


    public String sortColumnName(String columnName) {
        Map<String, String> map = new HashMap<>();
        if (Objects.nonNull(columnName) && !columnName.isEmpty()) {
            map.put("0", "Created On");
            map.put("1", "Modified On");
            map.put("2", "Province");
            map.put("3", "District");
            map.put("4", "Commune");
        }
        map.put(null, "Modified On");
        return map.get(columnName);
    }
}
