package org.gl.ceir.CeirPannelCode.datatable.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@RestController
public class SytemUserDatatableController {
    private final Logger log = LoggerFactory.getLogger(getClass());
    String className = "emptyClass";
    @Autowired
    Translator Translator;
    @Autowired
    DatatableResponseModel datatableResponseModel;
    @Autowired
    PageElement pageElement;
    @Autowired
    Button button;
    @Autowired
    IconsState iconState;
    @Autowired
    APIService4Feign apiService4Feign;
    @Autowired
    Usertype usertype;
    @Autowired
    SystemUserContent systemUserContent;
    @Autowired
    SystemUserPagination systemUserPagination;
    @Autowired
    RegistrationContentModel registrationcontentmodel;


    @PostMapping("UserManagementData")
    public ResponseEntity<?> viewUserManagementRecord(HttpServletRequest request, HttpSession session) {
        //String userType = (String) session.getAttribute("usertype");
        //int userId=	(int) session.getAttribute("userid");
        int file = 0;
        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter");
        Gson gsonObject = new Gson();
        FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
        filterrequest.setSearchString(request.getParameter("search[value]"));
        log.info("---->" + request.getParameter("order[0][column]") + "============>" + request.getParameter("order[0][dir]"));
        String column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Created On" :
                "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Modified On" :
                        "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "User ID" :
                                "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Email" :
                                        "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Phone No." :
                                                "5".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "User Type"
                                                        : "Modified On";
        log.info("---->" + request.getParameter("order[0][column]") + "============>" + request.getParameter("order[0][dir]"));
        String order;
        if ("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
            order = "desc";
        } else if ("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
            order = "asc";
        } else {
            order = request.getParameter("order[0][dir]");
        }
        filterrequest.setOrderColumnName(column);
        filterrequest.setOrder(order);

        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);
        try {
            filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
            filterrequest.setBrowser(session.getAttribute("browser").toString());
            log.info("request send to the filter api =" + filterrequest);
            Object response = apiService4Feign.viewSystemUserManagementRequest(filterrequest, pageNo, pageSize, file);
            log.info("response in datatable" + response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            systemUserPagination = gson.fromJson(apiResponse, SystemUserPagination.class);
            List<SystemUserContent> paginationContentList = systemUserPagination.getContent();
            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (SystemUserContent dataInsideList : paginationContentList) {
                    String id = String.valueOf(dataInsideList.getId());
                    String createdOn = dataInsideList.getCreatedOn();
                    String modifiedOn = dataInsideList.getModifiedOn();
                    String userName = dataInsideList.getUsername();
                    String userTypeName = dataInsideList.getUsertype().getUsertypeName();
                    String email = dataInsideList.getUserProfile().getEmail();
                    String phoneNo = dataInsideList.getUserProfile().getPhoneNo();
                    String action = iconState.userSystemManagementIcons(id);
                    Object[] finalData = {createdOn, modifiedOn, userName, email, phoneNo, userTypeName, action};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);
                }
            }
            //data set on ModelClass
            datatableResponseModel.setRecordsTotal(systemUserPagination.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(systemUserPagination.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);
        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);
        }
    }


    @PostMapping("systemUser/pageRendering")
    public ResponseEntity<?> pageRendering(HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle(Translator.toLocale("sidebar.User_Management"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"HeaderButton", Translator.toLocale("table.registerUser"), "./register-user-form", "btnLink",
                "FilterButton", Translator.toLocale("button.filter"), "DataTable(" + ConfigParameters.languageParam + ")", "submitFilter"};
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


        //Dropdown items
        String[] selectParam = {"select", Translator.toLocale("table.userType"), "userType", ""};
        for (int i = 0; i < selectParam.length; i++) {
            inputFields = new InputFields();
            inputFields.setType(selectParam[i]);
            i++;
            inputFields.setTitle(selectParam[i]);
            i++;
            inputFields.setId(selectParam[i]);
            i++;
            inputFields.setClassName(selectParam[i]);
            dropdownList.add(inputFields);
        }
        pageElement.setDropdownList(dropdownList);


        //input type date list
        String[] dateParam = {"date", Translator.toLocale("input.startDate"), "startDate", "", "date", Translator.toLocale("input.endDate"), "endDate", "", "text", "User ID",
                "userName", "", "text", Translator.toLocale("table.email"), "emailID", "", "text",
                Translator.toLocale("table.phone"), "phone", ""};
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

}
