package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DBTablesFeignClient;
import org.gl.ceir.CeirPannelCode.Model.DBReportDataModel;
import org.gl.ceir.CeirPannelCode.Model.DBrowDataModel;
import org.gl.ceir.CeirPannelCode.Model.MapDatatableResponse;
import org.gl.ceir.CeirPannelCode.Model.ReportResponse;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableHeaderModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.ReportPaginationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

@RestController
public class ReportDatatableController {
    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    Translator Translator;
    @Autowired
    PageElement pageElement;
    @Autowired
    Button button;
    @Autowired
    DBTablesFeignClient dBTablesFeignClient;
    @Autowired
    DBReportDataModel dBReportDataModel;
    @Autowired
    ReportPaginationModel reportPaginationModel;
    @Autowired
    DatatableResponseModel datatableResponseModel;

    @PostMapping("dbReportData")
    public ResponseEntity<?> viewReportTable(HttpServletRequest request, HttpSession session) {
        List<List<Object>> finalList = new ArrayList<List<Object>>();
        String filter = request.getParameter("filter");
        MapDatatableResponse map = new MapDatatableResponse();
        Gson gsonObject = new Gson();
        DBrowDataModel filterrequest = gsonObject.fromJson(filter, DBrowDataModel.class);
        Integer file = 0;
        Integer pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNumber = Integer.parseInt(request.getParameter("start")) / pageSize;

        log.info("pageSize" + pageSize + "-----------pageNumber---" + pageNumber);
        filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
        filterrequest.setBrowser(session.getAttribute("browser").toString());
        log.info("request passed to API:::::::::" + filterrequest);
        Object response = dBTablesFeignClient.ReportDetailsFeign(filterrequest, pageNumber, pageSize, file);
        log.info("request passed filterrequest::::::::" + filterrequest);
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        log.info("apiResponse ::::::::::::::" + apiResponse);

        reportPaginationModel = gson.fromJson(apiResponse, ReportPaginationModel.class);
        log.info("response::::::" + reportPaginationModel);

        DBReportDataModel paginationContentList = reportPaginationModel.getContent();
        log.info("paginationContentList----------->" + paginationContentList);
        try {
            if (paginationContentList.getRowData().isEmpty()) {
                datatableResponseModel.setData(Collections.emptyList());
            } else {
                for (Map<String, String> dataModel : paginationContentList.getRowData()) {
                    List<Object> datatableList = new ArrayList<Object>();
                    for (String key : dataModel.keySet()) {
                        datatableList.add(dataModel.get(key));
                    }
                    finalList.add(datatableList);
                    datatableResponseModel.setData(finalList);
                }
            }
            datatableResponseModel.setRecordsTotal(reportPaginationModel.getNumberOfElements());
            datatableResponseModel.setRecordsFiltered(reportPaginationModel.getTotalElements());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

        } catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    private Object row(Map<String, String> column) {
        // TODO Auto-generated method stub
        return null;
    }


    @PostMapping("tableHeaders")
    public ResponseEntity<?> headers(@RequestParam("reportnameId") Integer reportnameId, @RequestParam("typeFlag") int typeFlag) {
        List<DatatableHeaderModel> dataTableInputs = new ArrayList<>();
        try {
            DBrowDataModel filterrequest = dBTablesFeignClient.tableHeaders(reportnameId, typeFlag);
            for (String header : filterrequest.getColumns()) {
                dataTableInputs.add(new DatatableHeaderModel(header));
            }
            return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(Collections.emptyList(), HttpStatus.UNAVAILABLE_FOR_LEGAL_REASONS);
        }

    }

    @PostMapping("dbReportTable/pageRendering")
    public ResponseEntity<?> pageRendering(String displayName, HttpSession session, @RequestParam("reportName") String reportName) {

        String userType = (String) session.getAttribute("usertype");
        String userStatus = (String) session.getAttribute("userStatus");

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();
        log.info("USER STATUS:::::::::" + userStatus);
        log.info("session value user Type==" + session.getAttribute("usertype"));

        String[] names = {"HeaderButton", Translator.toLocale("button.addTag"), "AddField()", "btnLink",
                "FilterButton", Translator.toLocale("button.filter"),
                "Datatable(" + ConfigParameters.languageParam + ")", "submitFilter"};
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
        String[] selectParam = {"select", Translator.toLocale("table.ReportType"), "reportType", ""};
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
        // input type date list
        String[] dateParam = {"date", Translator.toLocale("input.startDate"), "startDate", "", "date",
                Translator.toLocale("input.endDate"), "endDate", ""};
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


        pageElement.setPageTitle(Translator.toLocale("sidebar.Report") + " - " + reportName);
        pageElement.setInputTypeDateList(inputTypeDateList);
        pageElement.setUserStatus(userStatus);
        return new ResponseEntity<>(pageElement, HttpStatus.OK);
    }


    @ResponseBody
    @PostMapping("fetchReportType")
    public ReportResponse fetchReportType(@RequestParam("reportnameId") Integer reportnameId) {

        try {
            log.info("reportnameId==" + reportnameId);
            ReportResponse filterrequest = dBTablesFeignClient.fetchReportType(reportnameId);
            log.info("filterrequest response==" + filterrequest);
            return filterrequest;
        } catch (Exception e) {
            e.printStackTrace();

        }
        return null;

    }
}
