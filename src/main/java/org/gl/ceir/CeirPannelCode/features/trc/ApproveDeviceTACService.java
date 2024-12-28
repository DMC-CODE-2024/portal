package org.gl.ceir.CeirPannelCode.features.trc;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.gl.ceir.CeirPannelCode.features.GlobalMap;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableHeaderModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.features.trc.model.ContentResponse;
import org.gl.ceir.CeirPannelCode.features.trc.model.MDR;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Component
public class ApproveDeviceTACService {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    String className = "emptyClass";

    private final Translator translator;
    private final DatatableResponseModel datatableResponseModel;
    private final PageElement pageElement;
    private Button button;
    private final IconsState iconState;
    private final ApproveDeviceTACFeignClient approveDeviceTACFeignClient;

    @Autowired
    public ApproveDeviceTACService(Translator translator, DatatableResponseModel datatableResponseModel, PageElement pageElement, Button button, IconsState iconState, ApproveDeviceTACFeignClient approveDeviceTACFeignClient) {
        this.translator = translator;
        this.datatableResponseModel = datatableResponseModel;
        this.pageElement = pageElement;
        this.button = button;
        this.iconState = iconState;
        this.approveDeviceTACFeignClient = approveDeviceTACFeignClient;
    }

    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        String filter = HtmlUtils.htmlUnescape(request.getParameter("filter"));
        logger.info("filter payload [" + filter + "]");
        Gson gsonObject = new Gson();
        MDR mobileDeviceRepository = gsonObject.fromJson(filter, MDR.class);
        logger.info("MobileDeviceRepository payload [" + mobileDeviceRepository + "]");
        String userType = (String) session.getAttribute("usertype");
        int userId = (int) session.getAttribute("userid");

        logger.info("session parameters usertype [" + userType + "] and userID [" + userId + "]");

        String search = request.getParameter("search[value]");
        int pageSize = Integer.parseInt(request.getParameter("length"));
        Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;

        logger.info("search [" + search + "] pageSize  " + pageSize + " and pageNo " + pageNo + "");

        // Data set on this List
        List<List<Object>> finalList = new ArrayList<List<Object>>();

        String order = Objects.isNull(request.getParameter("order[0][dir]")) ? "desc" : request.getParameter("order[0][dir]");
        String column = Objects.isNull(request.getParameter("order[0][column]")) ? "-1" : request.getParameter("order[0][column]");
        String columnName = Objects.isNull(sortColumnName(column)) ? "Modified On" : sortColumnName(column);

        logger.info("column [" + column + "] and order [" + order + "] columnName[" + columnName + "]");

        mobileDeviceRepository.getAuditTrailModel().setColumnName(columnName);
        mobileDeviceRepository.getAuditTrailModel().setSort(order);
        mobileDeviceRepository.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        mobileDeviceRepository.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("payload pass to mobileDeviceRepository [" + mobileDeviceRepository + "]");

        Integer numberOfElements = null;
        Integer totalElements = null;
        HttpStatus httpStatus;

        /*     try {*/

        Object response = approveDeviceTACFeignClient.paging(mobileDeviceRepository, pageNo, pageSize);

        logger.info("response from API [" + response + "]");

        Gson gson = new Gson();
        String gsonJson = gson.toJson(response);

        logger.info("gsonJson [" + gsonJson + "]");
        ContentResponse tacPaging = gson.fromJson(gsonJson, new TypeToken<ContentResponse<MDR>>() {
        }.getType());

        logger.info("pagingResponse [" + tacPaging + "]");

        List<MDR> paginationContentList = tacPaging.getContent();

        logger.info("paginationContentList [" + paginationContentList + "]");

        if (paginationContentList.isEmpty()) {
            datatableResponseModel.setData(Collections.emptyList());
            datatableResponseModel.setRecordsTotal(0);
            datatableResponseModel.setRecordsFiltered(0);
            httpStatus = HttpStatus.OK;
        } else {
            for (MDR dataInsideList : paginationContentList) {
                String id = String.valueOf(dataInsideList.getId());
                String modelName = dataInsideList.getModelName();
                String manufacturer = dataInsideList.getManufacturer();
                String manufacturingLocation = dataInsideList.getManufacturingLocation();
                String os = dataInsideList.getOs();
                String launchDate = null;
                if (Objects.nonNull(dataInsideList.getLaunchDate())) {
                    launchDate = String.valueOf(dataInsideList.getLaunchDate());
                }
                String deviceType = dataInsideList.getDeviceType();
                String simSlot = String.valueOf(dataInsideList.getSimSlot());
                String tac = dataInsideList.getDeviceId();
                Object[] finalData;
                List<Object> finalDataList = null;
                //String userStatus = (String) session.getAttribute("userStatus");
                if (Objects.nonNull(mobileDeviceRepository.getTrcApprovedStatus()) && mobileDeviceRepository.getTrcApprovedStatus().equals("approved")) {
                    finalData = new Object[]{modelName, manufacturer, manufacturingLocation, os, launchDate, deviceType, simSlot, tac};
                    finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                } else {
                    Long featureId = mobileDeviceRepository.getAuditTrailModel().getFeatureId();
                    String action = iconState.actionIconsList(id, featureId);
                    finalData = new Object[]{modelName, manufacturer, manufacturingLocation, os, launchDate, deviceType, simSlot, tac, action};
                    finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
                }
                finalList.add(finalDataList);
                datatableResponseModel.setData(finalList);

            }
            numberOfElements = tacPaging.getNumberOfElements();
            totalElements = tacPaging.getTotalElements();
            httpStatus = HttpStatus.OK;
            datatableResponseModel.setRecordsTotal(numberOfElements);
            datatableResponseModel.setRecordsFiltered(totalElements);
        }
        /*} catch (Exception e) {
            datatableResponseModel.setRecordsTotal(null);
            datatableResponseModel.setRecordsFiltered(null);
            datatableResponseModel.setData(Collections.emptyList());
            httpStatus = HttpStatus.EXPECTATION_FAILED;
            logger.error("error occured during datatable [" + e.getMessage() + "]", e);
        }*/
        return new ResponseEntity<>(datatableResponseModel, httpStatus);
    }
    public ResponseEntity<?> pageRendering(String role, HttpSession session, int featureId) {
        String userType = String.valueOf(session.getAttribute("usertype"));
        String userStatus = String.valueOf(session.getAttribute("userStatus"));

        InputFields inputFields = new InputFields();
        InputFields dateRelatedFields;

        pageElement.setPageTitle(translator.toLocale("Approve Device TAC"));

        List<Button> buttonList = new ArrayList<>();
        List<InputFields> dropdownList = new ArrayList<>();
        List<InputFields> inputTypeDateList = new ArrayList<>();

        logger.info("USER STATUS:::::::::" + userStatus);
        logger.info("session value user Type==" + session.getAttribute("usertype"));
        String title = role.equals("approved") ? "Back" : "View TAC List";
        String countryTitle = role.equals("approved") ? "Manufacturing Country" : "Manufacturing Country";

        String[] names = {"HeaderButton", title, "", "btnLink"};
        for (int i = 0; i < names.length; i++) {
            button = new Button();
            button.setType(names[i++]);
            button.setButtonTitle(names[i++]);
            button.setButtonURL(names[i++]);
            button.setId(names[i]);
            buttonList.add(button);
        }
        pageElement.setButtonList(buttonList);

        String[] dateParam = {"text", "Model Name", "modelName", "", "text", "Manufacturer", "manufacturer", "", "text", countryTitle, "manufacturingLocation", "", "select", "OS", "os", "", "date", "Launch Date", "launchDate", "", "select", "Device Type", "deviceType", "", "select", "Sim Slot", "simSlot", "", "text", "TAC", "tac", ""};
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


    public FileExportResponse export(MDR mdr, HttpSession session) {
        Gson gsonObject = new Gson();
        Object response;
        String userType = (String) session.getAttribute("usertype");
        int usertypeId = (int) session.getAttribute("usertypeId");
        mdr.getAuditTrailModel().setUserType(userType);
        mdr.getAuditTrailModel().setUserTypeId(Long.valueOf(usertypeId));
        mdr.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        mdr.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        logger.info("filterRequest:::::::::" + mdr);
        response = approveDeviceTACFeignClient.export(mdr);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        logger.info("response  from  Export Rule api=" + fileExportResponse);
        return fileExportResponse;
    }


    public String sortColumnName(String columnName) {
        Map<String, String> map = new HashMap<>();
        if (Objects.nonNull(columnName) && !columnName.isEmpty()) {
            map.put("0", "Model Name");
            map.put("1", "Manufacturer");
            map.put("2", "Manufacturing Country");
            map.put("3", "OS");
            map.put("4", "Launch Date");
            map.put("5", "Device Type");
            map.put("6", "Sim Slot");
            map.put("7", "TAC");
            map.put("-1", "Modified On");

        }
        return map.get(columnName);
    }
}
