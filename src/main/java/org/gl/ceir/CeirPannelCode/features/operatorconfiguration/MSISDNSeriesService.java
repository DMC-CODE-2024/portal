package org.gl.ceir.CeirPannelCode.features.operatorconfiguration;

import com.google.gson.Gson;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.MSISDNSeriesModel;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.features.trc.model.MDR;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Service
public class MSISDNSeriesService {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    String className = "emptyClass";

    private final Translator translator;
    private final DatatableResponseModel datatableResponseModel;
    private final PageElement pageElement;
    private Button button;
    private final IconsState iconState;
    private final MSISDNSeriesFeignClient msisdnSeriesFeignClient;

    @Autowired
    public MSISDNSeriesService(Translator translator, DatatableResponseModel datatableResponseModel, PageElement pageElement, Button button, IconsState iconState, MSISDNSeriesFeignClient msisdnSeriesFeignClient) {
        this.translator = translator;
        this.datatableResponseModel = datatableResponseModel;
        this.pageElement = pageElement;
        this.button = button;
        this.iconState = iconState;
        this.msisdnSeriesFeignClient = msisdnSeriesFeignClient;
    }

    public ResponseEntity<GenricResponse> save(MSISDNSeriesModel msisdnSeriesModel) {
        logger.info("POST payload [" + msisdnSeriesModel + "]");
        ResponseEntity<GenricResponse> save = msisdnSeriesFeignClient.save(msisdnSeriesModel);
        return save;
    }

    public ResponseEntity<GenricResponse> update(MSISDNSeriesModel msisdnSeriesModel) {
        logger.info("PUT payload [" + msisdnSeriesModel + "]");
        ResponseEntity<GenricResponse> update = msisdnSeriesFeignClient.update(msisdnSeriesModel);
        return update;
    }

    public ResponseEntity<GenricResponse> delete(MSISDNSeriesModel msisdnSeriesModel) {
        logger.info("DELETE payload [" + msisdnSeriesModel + "]");
        ResponseEntity<GenricResponse> delete = msisdnSeriesFeignClient.delete(msisdnSeriesModel);
        return delete;
    }


    public Map<String, List<?>> val(@RequestBody List<String> param) {
        Map<String, List<?>> stringListMap = msisdnSeriesFeignClient.val(param);
        return stringListMap;
    }

    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session, @RequestParam(value = "source", defaultValue = "menu", required = false) String source) {
        String filter = HtmlUtils.htmlUnescape(request.getParameter("filter"));
        Gson gsonObject = new Gson();
        MSISDNSeriesModel msisdnSeriesModelFilterRequest = gsonObject.fromJson(filter, MSISDNSeriesModel.class);
        logger.info("msisdnSeriesModelFilterRequest : " + msisdnSeriesModelFilterRequest);
        String userType = (String) session.getAttribute("usertype");
        int userId = (int) session.getAttribute("userid");

        logger.info("session parameters usertype [" + userType + "] and userID [" + userId + "]");
        String search = request.getParameter("search[value]");
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;

        logger.info("search [" + search + "] pageSize  " + pageSize + " and pageNo " + pageNo + "");

        int file = 0;
        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        String column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        String columnName = Objects.isNull(sortColumnName(column)) ? "Modified On" : sortColumnName(column);

        logger.info("column [" + column + "] and order [" + order + "] columnName[" + columnName + "]");
        msisdnSeriesModelFilterRequest.getAuditTraildDTO().getFilterDTO().setColumnName(columnName);
        msisdnSeriesModelFilterRequest.getAuditTraildDTO().getFilterDTO().setSort(order);
        msisdnSeriesModelFilterRequest.getAuditTraildDTO().setPublicIp(session.getAttribute("publicIP").toString());
        msisdnSeriesModelFilterRequest.getAuditTraildDTO().setBrowser(session.getAttribute("browser").toString());

        logger.info("payload pass to MSISDNSeries [" + msisdnSeriesModelFilterRequest + "]");

        Integer numberOfElements = null;
        Integer totalElements = null;
        HttpStatus httpStatus;

        try {

            Object response = msisdnSeriesFeignClient.paging(msisdnSeriesModelFilterRequest, pageNo, pageSize, file);

            logger.info("response from API [" + response + "]");

            Gson gson = new Gson();
            String gsonJson = gson.toJson(response);

            logger.info("gsonJson [" + gsonJson + "]");

            PagingResponse pagingResponse = gson.fromJson(gsonJson, PagingResponse.class);

            logger.info("pagingResponse [" + pagingResponse + "]");

            List<MSISDNSeriesModel> paginationContentList = pagingResponse.getContent();

            logger.info("pagingResponse [" + paginationContentList + "]");

            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
                datatableResponseModel.setRecordsTotal(0);
                datatableResponseModel.setRecordsFiltered(0);
                httpStatus = HttpStatus.OK;
            } else {
                for (MSISDNSeriesModel dataInsideList : paginationContentList) {
                    String id = String.valueOf(dataInsideList.getId());
                    String createdOn = dataInsideList.getCreatedOn();
                    String modifiedOn = dataInsideList.getModifiedOn();
                    String operatorName = dataInsideList.getOperatorName();
                   String userID = dataInsideList.getUser().getUsername();
                    String seriesType = dataInsideList.getSeriesType();
                    String seriesStart = String.valueOf(dataInsideList.getSeriesStart());
                    String seriesEnd = String.valueOf(dataInsideList.getSeriesEnd());
                    String userStatus = (String) session.getAttribute("userStatus");
                    String action = iconState.actionIcons(id);
                    Object[] finalData = {createdOn, modifiedOn, operatorName, userID, seriesType, seriesStart, seriesEnd, action};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);
                }
                numberOfElements = pagingResponse.getNumberOfElements();
                totalElements = pagingResponse.getTotalElements();
                httpStatus = HttpStatus.OK;
                datatableResponseModel.setRecordsTotal(numberOfElements);
                datatableResponseModel.setRecordsFiltered(totalElements);
            }
        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(0);
            datatableResponseModel.setRecordsFiltered(0);
            datatableResponseModel.setData(Collections.emptyList());
            httpStatus = HttpStatus.EXPECTATION_FAILED;
            logger.error("error occured during datatable [" + e.getMessage() + "]", e);
        }
        return new ResponseEntity<>(datatableResponseModel, httpStatus);
    }

    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {

        String userType = String.valueOf(session.getAttribute("usertype"));
        String userStatus = String.valueOf(session.getAttribute("userStatus"));

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle(translator.toLocale("Operator Series Configuration"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        logger.info("USER STATUS:::::::::" + userStatus);
        logger.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"HeaderButton", "Add Series", "AddSeries()", "btnLink"};
        for (int i = 0; i < names.length; i++) {
            button = new Button();
            button.setType(names[i++]);
            button.setButtonTitle(names[i++]);
            button.setButtonURL(names[i++]);
            button.setId(names[i]);
            buttonList.add(button);
        }
        pageElement.setButtonList(buttonList);

        String[] dateParam = {"date", translator.toLocale("input.startDate"), "startDate", "", "date", translator.toLocale("input.endDate"), "endDate", "", "select", "Operator Name", "operatorName", "", "text", "User ID", "userid", "", "select", "Series Type", "seriesType", ""};
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


    public FileExportResponse export(MSISDNSeriesModel msisdnSeriesModel, HttpSession session) {
        Gson gsonObject = new Gson();
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        msisdnSeriesModel.getAuditTraildDTO().setUserType(userType);
        msisdnSeriesModel.getAuditTraildDTO().setUserTypeId(Long.valueOf(usertypeId));
        msisdnSeriesModel.getAuditTraildDTO().setPublicIp(session.getAttribute("publicIP").toString());
        msisdnSeriesModel.getAuditTraildDTO().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + msisdnSeriesModel);
        response = msisdnSeriesFeignClient.export(msisdnSeriesModel);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        logger.info("response  from  Export API=" + fileExportResponse);
        return fileExportResponse;
    }

    public MSISDNSeriesModel find(Long id) {
        logger.info("response {}", msisdnSeriesFeignClient.findByID(id));
        return msisdnSeriesFeignClient.findByID(id);
    }

    public String sortColumnName(String columnName) {
        Map<String, String> map = new HashMap<>();
        if (Objects.nonNull(columnName) && !columnName.isEmpty()) {
            map.put("0", "Created On");
            map.put("1", "Modified On");
            map.put("2", "Operator Name");
            map.put("3", "User ID");
            map.put("4", "Series Type");
            map.put("5", "Series Start");
            map.put("6", "Series End");
        }
        map.put(null, "Modified On");
        return map.get(columnName);
    }

}
