package org.gl.ceir.CeirPannelCode.features.eirs_response_param;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.features.eirs_response_param.model.EirsResponseParamModel;
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
public class EirsResponseParamService {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private Translator translator;
    private DatatableResponseModel datatableResponseModel;
    private PageElement pageElement;
    private Button button;
    private IconsState iconState;
    private FeignCleintImplementation feignCleintImplementation;


    @Autowired
    public EirsResponseParamService(FeignCleintImplementation feignCleintImplementation, DatatableResponseModel datatableResponseModel, PageElement pageElement, Button button, IconsState iconState) {
        this.feignCleintImplementation = feignCleintImplementation;
        this.datatableResponseModel = datatableResponseModel;
        this.pageElement = pageElement;
        this.button = button;
        this.iconState = iconState;
    }

    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        String filter = HtmlUtils.htmlUnescape(request.getParameter("filter"));
        logger.info("filter payload [" + filter + "]");
        Gson gsonObject = new Gson();
        EirsResponseParamModel eirsResponseParamModel = gsonObject.fromJson(filter, EirsResponseParamModel.class);
        logger.info("EirsResponseParamModel payload [" + eirsResponseParamModel + "]");
        String userType = (String) session.getAttribute("usertype");
        int userId = (int) session.getAttribute("userid");

        logger.info("session parameters usertype [" + userType + "] and userID [" + userId + "]");

        String search = request.getParameter("search[value]");
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;

        logger.info("search [" + search + "] pageSize  " + pageSize + " and pageNo " + pageNo + "");

        List<List<Object>> finalList = new ArrayList<>();

        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        String column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        String columnName = Objects.isNull(sortColumnName(column)) ? "Modified On" : sortColumnName(column);

        logger.info("column [" + column + "] and order [" + order + "] columnName[" + columnName + "]");

        eirsResponseParamModel.getAuditTrailModel().setColumnName(columnName);
        eirsResponseParamModel.getAuditTrailModel().setSort(order);
        eirsResponseParamModel.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        eirsResponseParamModel.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("payload pass to eirsResponseParamModel [" + eirsResponseParamModel + "]");

        Integer numberOfElements = null;
        Integer totalElements = null;
        HttpStatus httpStatus;

        Object response = feignCleintImplementation.paging(eirsResponseParamModel, pageNo, pageSize);

        logger.info("response from API [" + response + "]");

        Gson gson = new Gson();
        String gsonJson = gson.toJson(response);

        logger.info("gsonJson [" + gsonJson + "]");
        ContentResponse<EirsResponseParamModel> pagingResponse = gson.fromJson(gsonJson, new TypeToken<ContentResponse<EirsResponseParamModel>>() {
        }.getType());

        logger.info("pagingResponse [" + pagingResponse + "]");

        List<EirsResponseParamModel> paginationContentList = pagingResponse.getContent();

        logger.info("paginationContentList [" + paginationContentList + "]");

        if (paginationContentList.isEmpty()) {
            datatableResponseModel.setData(Collections.emptyList());
            datatableResponseModel.setRecordsTotal(0);
            datatableResponseModel.setRecordsFiltered(0);
            httpStatus = HttpStatus.OK;
        } else {
            for (EirsResponseParamModel dataInsideList : paginationContentList) {
                List<Object> finalDataList = getFinalDataList(eirsResponseParamModel.getLanguage(), dataInsideList);
                finalList.add(finalDataList);
                datatableResponseModel.setData(finalList);
            }
            numberOfElements = pagingResponse.getNumberOfElements();
            totalElements = pagingResponse.getTotalElements();
            httpStatus = HttpStatus.OK;
            datatableResponseModel.setRecordsTotal(numberOfElements);
            datatableResponseModel.setRecordsFiltered(totalElements);
        }
        return new ResponseEntity<>(datatableResponseModel, httpStatus);
    }

    private List<Object> getFinalDataList(String lang, EirsResponseParamModel eirsResponseParamModel) {
        String id = String.valueOf(eirsResponseParamModel.getId());
        //  String createdOn = eirsResponseParamModel.getCreatedOn();
        String modifiedOn = eirsResponseParamModel.getModifiedOn();
        String description = eirsResponseParamModel.getDescription();
        //   String tag = eirsResponseParamModel.getTag();
        //  String type = String.valueOf(eirsResponseParamModel.getType());
        String value = HtmlUtils.htmlEscape(eirsResponseParamModel.getValue());
        //  String active = String.valueOf(eirsResponseParamModel.getActive());
        String featureName = eirsResponseParamModel.getFeatureName();
        // String remarks = eirsResponseParamModel.getRemarks();
        //  String userType = eirsResponseParamModel.getUserType();
        //  String modifiedBy = eirsResponseParamModel.getModifiedBy();
        String language = eirsResponseParamModel.getLanguage();
        String action = iconState.eirsResponseParamIcons(id);
        Object[] finalData = {modifiedOn, description, value, featureName, language, action};
        return new ArrayList<>(Arrays.asList(finalData));
    }

    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        String userType = String.valueOf(session.getAttribute("usertype"));
        String userStatus = String.valueOf(session.getAttribute("userStatus"));

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle(translator.toLocale("View Notification Management"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        logger.info("USER STATUS:::::::::" + userStatus);
        logger.info("session value user Type==" + session.getAttribute("usertype"));

        String[] dateParam = {"date", translator.toLocale("input.startDate"), "startDate", "", "date", translator.toLocale("input.endDate"), "endDate", ""};//"select", translator.toLocale("input.description"), "description", "", "select", "Tag", "tag", "", "select", translator.toLocale("input.type"), "type", "", "select", translator.toLocale("input.value"), "value", ""};

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

    public FileExportResponse export(EirsResponseParamModel eirsResponseParamModel, HttpSession session) {
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        eirsResponseParamModel.getAuditTrailModel().setUserType(userType);
        eirsResponseParamModel.getAuditTrailModel().setUserTypeId(Long.valueOf(usertypeId));
        eirsResponseParamModel.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        eirsResponseParamModel.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + eirsResponseParamModel);
        response = feignCleintImplementation.eirsResponseParamExport(eirsResponseParamModel);
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
            map.put("2", "Description");
            map.put("3", "Tag");
            map.put("4", "Type");
            map.put("5", "Value");
            map.put("6", "Active");
            map.put("7", "Feature Name");
            map.put("8", "Remarks");
            map.put("9", "User Type");
            map.put("10", "Modified By");
            map.put("11", "Language");
        }
        map.put(null, "Modified On");
        return map.get(columnName);
    }
}