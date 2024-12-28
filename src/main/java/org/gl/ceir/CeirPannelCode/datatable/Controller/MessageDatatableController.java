package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.MessageContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.MessagePaginationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

@RestController
public class MessageDatatableController {
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
    MessageContentModel messageContentModel;
    @Autowired
    MessagePaginationModel messagePaginationModel;


    @PostMapping("adminMessageData")
    public ResponseEntity<?> viewAdminMessage(@RequestParam(name = "type", defaultValue = "message", required = false) String role, HttpServletRequest request, HttpSession session) {
        //String userType = (String) session.getAttribute("usertype");
        //int userId=	(int) session.getAttribute("userid");
        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter").replace("&#34;", "\"");
        Gson gsonObject = new Gson();
        FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);

        String column = null;
        column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Created On" :
                "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Modified On" :
                        "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Feature" :
                                "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Subject" :
                                        "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Description" :
                                                "5".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Value" :
                                                        "6".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Channel" :
                                                                "Modified On";
        String order;
        /*
         * if("Modified On".equalsIgnoreCase(column)) { order="desc"; } else {
         * order=request.getParameter("order[0][dir]"); }
         *
         *
         */

        if ("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
            order = "desc";
        } else if ("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
            order = "asc";
        } else {
            order = request.getParameter("order[0][dir]");
        }
        filterrequest.setColumnName(column);
        filterrequest.setSort(order);


        Integer file = 0;
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
        filterrequest.setSearchString(request.getParameter("search[value]"));
        log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo);

        try {
            filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
            filterrequest.setBrowser(session.getAttribute("browser").toString());
            log.info("request send to the filter api =" + filterrequest);
            Object response = feignCleintImplementation.adminMessageFeign(filterrequest, pageNo, pageSize, file);
            log.info("response in datatable" + response);
            Gson gson = new Gson();
            String apiResponse = gson.toJson(response);
            messagePaginationModel = gson.fromJson(apiResponse, MessagePaginationModel.class);
            List<MessageContentModel> paginationContentList = messagePaginationModel.getContent();
            if (paginationContentList.isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (MessageContentModel dataInsideList : paginationContentList) {
                    String createdOn = (String) dataInsideList.getCreatedOn();
                    String modifiedOn = (String) dataInsideList.getModifiedOn();
                    String tag = dataInsideList.getTag();
                    String description = dataInsideList.getDescription();
                    String value = "NA";
                    if (Objects.nonNull(dataInsideList.getValue())) {
                        value = dataInsideList.getValue().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                    }
                    String channel = dataInsideList.getChannelInterp();
                    String userStatus = (String) session.getAttribute("userStatus");
                    String subject = dataInsideList.getSubject() == null ? "NA" : dataInsideList.getSubject().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
                    String feature = dataInsideList.getFeatureName() == null ? "NA" : dataInsideList.getFeatureName();
                    ;
                    //log.info("----Id------"+Id+"-------id----------------"+id+"---userName-----"+username);
                    String action = iconState.adminMessageIcons(userStatus, tag);
                    Object[] finalData = {createdOn, modifiedOn, feature, subject, description, value, channel, action};
                    List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                    finalList.add(finalDataList);
                    datatableResponseModel.setData(finalList);

                }

            }
            //data set on ModelClass
            datatableResponseModel.setRecordsTotal(messagePaginationModel.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(messagePaginationModel.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);


        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            log.error(e.getMessage(), e);
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);


        }
    }


    @PostMapping("messageManagement/pageRendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "messageManagement", required = false) String role, HttpSession session) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle("Message Management");

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"FilterButton", "Apply Filter", "messageManagementDatatable(" + ConfigParameters.languageParam + ")", "submitFilter"};
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

        //input type date list
        String[] dateParam = {"date", "Creation Start Date", "startDate", "", "date", "Creation End Date", "endDate", "", "select", "Feature", "feature", "", "text", "Subject", "subjectID", "50", "text", "Description", "descriptionID", "50", "text", "Value", "valueID", "50", "select", "Channel", "channel", ""};
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
        //Dropdown items

        /*
         * String[] selectParam=
         * {"select","Channel","channel","","select","Feature","feature",""}; for(int
         * i=0; i< selectParam.length; i++) { inputFields= new InputFields();
         * inputFields.setType(selectParam[i]); i++;
         * inputFields.setTitle(selectParam[i]); i++; inputFields.setId(selectParam[i]);
         * i++; inputFields.setClassName(selectParam[i]); dropdownList.add(inputFields);
         * }
         */
        pageElement.setDropdownList(dropdownList);

        pageElement.setInputTypeDateList(inputTypeDateList);
        pageElement.setUserStatus(userStatus);
        return new ResponseEntity<>(pageElement, HttpStatus.OK);


    }


}
