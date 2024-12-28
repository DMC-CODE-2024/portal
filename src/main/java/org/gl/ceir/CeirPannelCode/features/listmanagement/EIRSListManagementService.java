package org.gl.ceir.CeirPannelCode.features.listmanagement;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.EIRSListManagementEntity;
import org.gl.ceir.CeirPannelCode.features.trc.ApproveDeviceTACFeignClient;
import org.gl.ceir.CeirPannelCode.features.trc.model.ContentResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Component
public class EIRSListManagementService {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    String className = "emptyClass";

    @Autowired
    private Translator translator;
    private DatatableResponseModel datatableResponseModel;
    private PageElement pageElement;
    private Button button;
    private IconsState iconState;
    private APIService6Feign apiService6Feign;

    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

    @Autowired
    public EIRSListManagementService(APIService6Feign apiService6Feign, DatatableResponseModel datatableResponseModel, PageElement pageElement, Button button, IconsState iconState, ApproveDeviceTACFeignClient approveDeviceTACFeignClient) {
        this.apiService6Feign = apiService6Feign;
        this.datatableResponseModel = datatableResponseModel;
        this.pageElement = pageElement;
        this.button = button;
        this.iconState = iconState;
    }

    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        String filter = HtmlUtils.htmlUnescape(request.getParameter("filter"));
        logger.info("filter payload [" + filter + "]");
        Gson gsonObject = new Gson();
        EIRSListManagementEntity eirsListManagementEntity = gsonObject.fromJson(filter, EIRSListManagementEntity.class);
        logger.info("MobileDeviceRepository payload [" + eirsListManagementEntity + "]");
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

        eirsListManagementEntity.getAuditTrailModel().setColumnName(columnName);
        eirsListManagementEntity.getAuditTrailModel().setSort(order);
        eirsListManagementEntity.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        eirsListManagementEntity.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("payload pass to eirsListManagementEntity [" + eirsListManagementEntity + "]");

        Integer numberOfElements = null;
        Integer totalElements = null;
        HttpStatus httpStatus;

        /*     try {*/

        Object response = apiService6Feign.paging(eirsListManagementEntity, pageNo, pageSize);

        logger.info("response from API [" + response + "]");

        Gson gson = new Gson();
        String gsonJson = gson.toJson(response);

        logger.info("gsonJson [" + gsonJson + "]");
        ContentResponse tacPaging = gson.fromJson(gsonJson, new TypeToken<ContentResponse<EIRSListManagementEntity>>() {
        }.getType());

        logger.info("pagingResponse [" + tacPaging + "]");

        List<EIRSListManagementEntity> paginationContentList = tacPaging.getContent();


        logger.info("paginationContentList [" + paginationContentList + "]");

        if (paginationContentList.isEmpty()) {
            datatableResponseModel.setData(Collections.emptyList());
            datatableResponseModel.setRecordsTotal(0);
            datatableResponseModel.setRecordsFiltered(0);
            httpStatus = HttpStatus.OK;
        } else {
            for (EIRSListManagementEntity dataInsideList : paginationContentList) {
                String id = String.valueOf(dataInsideList.getId());
                String createdOn = (String) dataInsideList.getCreatedOn();
                String txnId = dataInsideList.getTransactionId();
                String mode = dataInsideList.getRequestMode();
                String status = dataInsideList.getStatus();
                String requestType = dataInsideList.getAction();
                String file = dataInsideList.getFileName();
                String category = dataInsideList.getCategory();
                String uploadedBy = null;
                if (Objects.nonNull(dataInsideList.getUser())) {
                    uploadedBy = dataInsideList.getUser().getUsername();
                }
                Object[] finalData;
                List<Object> finalDataList = null;
                String fileAction = dataInsideList.getRequestMode().equalsIgnoreCase("BULK") ? file : txnId;


                String action = iconState.eirsListMgmtIcon(mode, status, id, txnId, file);
                finalData = new Object[]{createdOn, txnId, mode, status, requestType, category, uploadedBy, action};
                finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
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

    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {

        String userType = String.valueOf(session.getAttribute("usertype"));
        String userStatus = String.valueOf(session.getAttribute("userStatus"));

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;
        String headerTitle = role.equalsIgnoreCase("blocked-imei") ? "Blocked List" : role.equalsIgnoreCase("EXCEPTION_LIST") ? "Exception List" : "Blocked TAC";
        pageElement.setPageTitle(translator.toLocale(headerTitle));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        logger.info("USER STATUS:::::::::" + userStatus);
        logger.info("session value user Type==" + session.getAttribute("usertype"));
        String title = "View List";
        String[] names = {"HeaderButton", title, "", "btnLink", "FilterButton", translator.toLocale("button.filter"), "table()", "submitFilter"};
        for (int i = 0; i < names.length; i++) {
            button = new Button();
            button.setType(names[i++]);
            button.setButtonTitle(names[i++]);
            button.setButtonURL(names[i++]);
            button.setId(names[i]);
            buttonList.add(button);
        }
        pageElement.setButtonList(buttonList);

        String[] dateParam = {"date", translator.toLocale("input.startDate"), "startDate", "", "date", translator.toLocale("input.endDate"), "endDate", "", "text", translator.toLocale("el.txn"), "transactionID", "", "select", translator.toLocale("filter.mode"), "mode", "", "select", translator.toLocale("filter.status"), "status", "", "select", translator.toLocale("table.requestType"), "request", "", "select", translator.toLocale("el.category"), "category", "", "text", translator.toLocale("el.uploadedby"), "uploadedby", ""};
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


    public FileExportResponse export(EIRSListManagementEntity eirsListManagementEntity, HttpSession session) {
        //  Gson gsonObject = new Gson();
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        eirsListManagementEntity.getAuditTrailModel().setUserType(userType);
        eirsListManagementEntity.getAuditTrailModel().setUserTypeId(Long.valueOf(usertypeId));
        eirsListManagementEntity.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        eirsListManagementEntity.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + eirsListManagementEntity);
        response = apiService6Feign.export(eirsListManagementEntity);
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
            map.put("0", "Date");
            map.put("1", "Transaction ID");
            map.put("2", "Mode");
            map.put("3", "Status");
            map.put("4", "Request");
            map.put("5", "Category");
            map.put("6", "Uploaded By");
        }
        map.put(null, "Modified On");
        return map.get(columnName);
    }

}
