package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.TrackLostDeviceFilterRequest;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.TrackLostDeviceContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.TrackLostDevicePaginitionModel;
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
public class TrackLostDeviceDatatableController {
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	Translator Translator;
	@Autowired
	IconsState iconState;
	@Autowired
	PageElement pageElement;
	@Autowired
	Button button;
	@Autowired
	DatatableResponseModel datatableResponseModel;
	@Autowired
	DeviceRepositoryFeign deviceRepositoryFeign;
	
	@Autowired
	TrackLostDevicePaginitionModel trackLostDevicePaginitionModel;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	@Autowired
	AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

	@PostMapping("trackLostDeviceData")
	public ResponseEntity<?> viewAdminMessage(
			@RequestParam(name = "type", defaultValue = "Track Lost Device Data", required = false) String role,
			@RequestParam(name = "source", defaultValue = "menu", required = false) String source,
			HttpServletRequest request, HttpSession session) {

		// Data set on this List
		List<List<Object>> finalList = new ArrayList<List<Object>>();
		String filter = request.getParameter("filter").replace("&#34;", "\"");
		Gson gsonObject = new Gson();
		TrackLostDeviceFilterRequest trackLostDeviceFilterRequest = gsonObject.fromJson(filter, TrackLostDeviceFilterRequest.class);

		String column = null;
		column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Date & Time"
				    : "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Request Number"
						: "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "IMSI"
								: "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "IMEI"
										: "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "MSISDN" 
												: "5".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Operator" 
														: "6".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Request Type" 
																: "7".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Status" :
																	"Date & Time";
		String order;

		if ("Date & Time".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
			order = "desc";
		} else if ("Date & Time".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
			order = "asc";
		} else {
			order = request.getParameter("order[0][dir]");
		}

		// -------------------Set Audit Parameters----------------------------//
		trackLostDeviceFilterRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
		trackLostDeviceFilterRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
		trackLostDeviceFilterRequest.getAuditTrailModel().setColumnName(column);
		trackLostDeviceFilterRequest.setOrderColumnName(column);
		trackLostDeviceFilterRequest.setSort(order);

		Integer file = 0;
		Integer pageSize = Integer.parseInt(request.getParameter("length"));
		Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
		log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo+ " sort-----"+trackLostDeviceFilterRequest.getSort());

		try {
			log.info("request send to the filter api =" + trackLostDeviceFilterRequest);
			Object response = deviceRepositoryFeign.getTrackLostDevicesDetails(trackLostDeviceFilterRequest, pageNo, pageSize, file);
			log.info("response in datatable" + response);
			Gson gson = new Gson();
			String apiResponse = gson.toJson(response);
			trackLostDevicePaginitionModel = gson.fromJson(apiResponse, TrackLostDevicePaginitionModel.class);
			List<TrackLostDeviceContentModel> paginationContentList = trackLostDevicePaginitionModel.getContent();
			if (paginationContentList.isEmpty()) {
				datatableResponseModel.setData(Collections.emptyList());
			} else {
				for (TrackLostDeviceContentModel dataInsideList : paginationContentList) {
					Integer id = dataInsideList.getId();
					String detectionDate=(String) dataInsideList.getCreatedOn();
					String requestId=dataInsideList.getRequest_id();
					String imsi=dataInsideList.getImsi();
					String imei=dataInsideList.getImei();
					String phoneNumber=dataInsideList.getMsisdn();
					String operator=dataInsideList.getOperator();
					String type=dataInsideList.getRequestType();
					String status = String.valueOf(dataInsideList.getInterpretation());
					String action = iconState.traclLostActionIconsList(requestId,status, trackLostDeviceFilterRequest.getLang());
					Object[] finalData = {detectionDate, requestId,imsi,imei, phoneNumber, operator,type, status,action};
					List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
					finalList.add(finalDataList);
					datatableResponseModel.setData(finalList);
				}
			}
			// data set on ModelClass
			datatableResponseModel.setRecordsTotal(trackLostDevicePaginitionModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(trackLostDevicePaginitionModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

		} catch (Exception e) {
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			log.error(e.getMessage(), e);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

		}
	}

	@PostMapping("trackLostDevice/pageRendering")
	public ResponseEntity<?> pageRendering(HttpSession session) {

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");

		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;

		pageElement.setPageTitle(Translator.toLocale("stolen.moi.tracklost.title"));

		List<Button> buttonList = new ArrayList<>();
		List<InputFields> dropdownList = new ArrayList<>();
		List<InputFields> inputTypeDateList = new ArrayList<>();

		log.info("USER STATUS:::::::::" + userStatus);
		log.info("session value user Type==" + session.getAttribute("usertype"));

		String[] names = {"FilterButton", "Apply Filter", "Datatable(" + ConfigParameters.languageParam + ")",
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
//		String[] dateParam = {"date", "Start Date", "startDate", "",
//				"date", "End Date", "endDate", "",
//				"text","Request Number", "filterRequestNo", "20",
//				"text","IMSI", "filterImsi", "20",
//				"text","IMEI", "filterImei", "20",
//				"text","MSISDN", "filterMsisdn", "20",
//				"select", "Operator", "filterOperator", "",
//				"select","Request Type", "filterRequestType", "",
//				"select", "Status", "filterStatus", "" };

		String[] dateParam = {"date",Translator.toLocale("input.startDate"), "startDate", "",
				"date", Translator.toLocale("input.endDate"), "endDate", "",
				"text", Translator.toLocale("stolen.table.req-number"), "filterRequestNo", "20",
				"text", Translator.toLocale("stolen.table.IMSI"), "filterImsi", "20",
				"text", Translator.toLocale("stolen.table.IMEI"), "filterImei", "20",
				"text", Translator.toLocale("stolen.table.MSISDN"), "filterMsisdn", "20",
				"select", Translator.toLocale("stolen.table.operator"), "filterOperator", "",
				"select", Translator.toLocale("stolen.table.request-type"), "filterRequestType", "",
				"select",  Translator.toLocale("stolen.table.status"), "filterStatus", "" };
		
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
}
