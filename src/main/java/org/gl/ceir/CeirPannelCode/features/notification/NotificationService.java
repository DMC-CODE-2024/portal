package org.gl.ceir.CeirPannelCode.features.notification;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.features.notification.model.NotificationModel;
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
import java.util.stream.Collectors;

@Component
public class NotificationService {

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
    public NotificationService(APIService6Feign apiService6Feign, DatatableResponseModel datatableResponseModel, PageElement pageElement, Button button, IconsState iconState) {
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
        NotificationModel notificationModel = gsonObject.fromJson(filter, NotificationModel.class);
        logger.info("NotificationModel payload [" + notificationModel + "]");
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

        notificationModel.getAuditTrailModel().setColumnName(columnName);
        notificationModel.getAuditTrailModel().setSort(order);
        notificationModel.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        notificationModel.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("payload pass to notificationModel [" + notificationModel + "]");

        Integer numberOfElements = null;
        Integer totalElements = null;
        HttpStatus httpStatus;

        /*     try {*/

        Object response = apiService6Feign.view(notificationModel, pageNo, pageSize);

        logger.info("response from API [" + response + "]");

        Gson gson = new Gson();
        String gsonJson = gson.toJson(response);

        logger.info("gsonJson [" + gsonJson + "]");
        ContentResponse notificationPaging = gson.fromJson(gsonJson, new TypeToken<ContentResponse<NotificationModel>>() {
        }.getType());

        logger.info("pagingResponse [" + notificationPaging + "]");

        List<NotificationModel> paginationContentList = notificationPaging.getContent();


        logger.info("paginationContentList [" + paginationContentList + "]");

        if (paginationContentList.isEmpty()) {
            datatableResponseModel.setData(Collections.emptyList());
            datatableResponseModel.setRecordsTotal(0);
            datatableResponseModel.setRecordsFiltered(0);
            httpStatus = HttpStatus.OK;
        } else {
            for (NotificationModel dataInsideList : paginationContentList) {
                String[] headers = {"nf.creationDate", "nf.channelType", "nf.featureName", "nf.featureTxn", "nf.msgLang", "nf.msg", "nf.status", "nf.notificationSentTime", "nf.msisdn", "nf.email", "nf.subject", "nf.action"};

                String id = String.valueOf(dataInsideList.getId());
                String date = dataInsideList.getCreatedOn();
                String channelType = dataInsideList.getChannelType();
                String featureName = dataInsideList.getFeatureName();
                String featureTxnId = dataInsideList.getFeatureTxnId();
                String msgLang = dataInsideList.getMsgLang();
                //String message = dataInsideList.getMessage();
                String status = dataInsideList.getInterp();
                String notificationSentTime = dataInsideList.getNotificationSentTime();
                String msisdn = dataInsideList.getMsisdn();
                String email = dataInsideList.getEmail();
                String subject = dataInsideList.getSubject();
                String action = iconState.notificationResentFeature(id);
                Object[] finalData;
                List<Object> finalDataList = null;
                finalData = new Object[]{date, channelType, featureName, featureTxnId, msgLang, subject, status, notificationSentTime, msisdn, email, action};
                finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                finalList.add(finalDataList);
                datatableResponseModel.setData(finalList);

            }
            numberOfElements = notificationPaging.getNumberOfElements();
            totalElements = notificationPaging.getTotalElements();
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

        pageElement.setPageTitle(translator.toLocale("View Notification"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        logger.info("USER STATUS:::::::::" + userStatus);
        logger.info("session value user Type==" + session.getAttribute("usertype"));
        // String title = "Notification";

        String[] dateParam = {"date", translator.toLocale("input.startDate"), "startDate", "", "date", translator.toLocale("input.endDate"), "endDate", "", "text", translator.toLocale("nf.featureTxn"), "txn", "", "select", translator.toLocale("nf.channelType"), "channelType", "", "select", translator.toLocale("nf.featureName"), "featureName", "", "text", translator.toLocale("nf.msisdn"), "msisdn", "", "text", translator.toLocale("nf.email"), "email", ""};
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

/*

    public FileExportResponse export(NotificationModel blockListEntity, HttpSession session) {
        //  Gson gsonObject = new Gson();
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        blockListEntity.getAuditTrailModel().setUserType(userType);
        blockListEntity.getAuditTrailModel().setUserTypeId(Long.valueOf(usertypeId));
        blockListEntity.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        blockListEntity.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + blockListEntity);
        response = apiService6Feign.export(blockListEntity);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        logger.info("response " + fileExportResponse);
        return fileExportResponse;
    }
*/


    public String sortColumnName(String columnName) {
        Map<String, String> map = new HashMap<>();
        if (Objects.nonNull(columnName) && !columnName.isEmpty()) {
            map.put("0", "Creation Date");
            map.put("1", "Channel Type");
            map.put("2", "Feature Name");
            map.put("3", "Feature Txn ID");
            map.put("4", "Language");
            map.put("5", "Message");
            map.put("6", "Status");
            map.put("7", "Notification Sent Time");
            map.put("8", "MSISDN");
            map.put("9", "Email");
            map.put("10", "Subject");
        }
        map.put(null, "Modified On");
        return map.get(columnName);
    }

    public FileExportResponse export(NotificationModel notificationModel, HttpSession session) {
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        notificationModel.getAuditTrailModel().setUserType(userType);
        notificationModel.getAuditTrailModel().setUserTypeId(Long.valueOf(usertypeId));
        notificationModel.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        notificationModel.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + notificationModel);
        response = apiService6Feign.export(notificationModel);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        logger.info("response " + fileExportResponse);
        return fileExportResponse;
    }
}
