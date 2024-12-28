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
import org.gl.ceir.CeirPannelCode.Model.DuplicateDeviceRequest;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.DuplicateContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.DuplicatePaginitionModel;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
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
public class DuplicateDeviceDatatableController {
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
	DeviceRepositoryFeign deviceRepositoryFeign;
	@Autowired
	DuplicateContentModel duplicateContentModel;
	@Autowired
	DuplicatePaginitionModel duplicatePaginitionModel;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	@Autowired
	AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

	@PostMapping("getDuplicateDeviceDetails")
	public ResponseEntity<?> viewAdminMessage(
			@RequestParam(name = "type", defaultValue = "Duplicate Data", required = false) String role,
			@RequestParam(name = "source", defaultValue = "menu", required = false) String source,
			HttpServletRequest request, HttpSession session) {

		// Data set on this List
		List<List<Object>> finalList = new ArrayList<List<Object>>();
		String filter = request.getParameter("filter").replace("&#34;", "\"");
		Gson gsonObject = new Gson();
		DuplicateDeviceRequest duplicateDeviceRequest = gsonObject.fromJson(filter, DuplicateDeviceRequest.class);

		String column = null;
		column = "0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Detection Date"
				: "1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "IMEI"
						: "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Phone Number"
						: "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Ticket ID"
								: "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Updated By"
										: "5".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Status" :
											"Detection Date";
		String order;

		if ("Detection Date".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
			order = "desc";
		} else if ("Detection Date".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
			order = "asc";
		} else {
			order = request.getParameter("order[0][dir]");
		}


		// -------------------Set Audit Parameters----------------------------//
		duplicateDeviceRequest.setOrderColumnName(column);
		duplicateDeviceRequest.setSort(order);

		Integer file = 0;
		Integer pageSize = Integer.parseInt(request.getParameter("length"));
		Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize;
		log.info("pageSize" + pageSize + "-----------pageNo---" + pageNo+ " sort-----"+duplicateDeviceRequest.getSort());

		try {
			log.info("request send to the filter api =" + duplicateDeviceRequest);
			Object response = deviceRepositoryFeign.getDuplicateDeviceFeign(duplicateDeviceRequest, pageNo, pageSize, file);
			log.info("response in datatable" + response);
			Gson gson = new Gson();
			String apiResponse = gson.toJson(response);
			duplicatePaginitionModel = gson.fromJson(apiResponse, DuplicatePaginitionModel.class);
			List<DuplicateContentModel> paginationContentList = duplicatePaginitionModel.getContent();
			if (paginationContentList.isEmpty()) {
				datatableResponseModel.setData(Collections.emptyList());
			} else {
				for (DuplicateContentModel dataInsideList : paginationContentList) {
					Integer id = dataInsideList.getId();
					String detectionDate=(String) dataInsideList.getEdrTime();
					String imei=dataInsideList.getImei();
					String phoneNumber=dataInsideList.getMsisdn();
					String redmineTktId = dataInsideList.getRedmineTktId();
					String updatedBy=dataInsideList.getUpdatedBy();
					String status=dataInsideList.getStatus();
					Integer userStatus=dataInsideList.getUserStatus(); 
					String stateInterpretation = dataInsideList.getInterpretation();
					//String txnID = (String) dataInsideList.getTransactionId();
					String action = iconState.duplicateActionIconsList(id,status,redmineTktId);
					Object[] finalData = {detectionDate, imei, phoneNumber, redmineTktId,updatedBy, status,action};
					List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
					finalList.add(finalDataList);
					datatableResponseModel.setData(finalList);
				}

			}
			// data set on ModelClass
			datatableResponseModel.setRecordsTotal(duplicatePaginitionModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(duplicatePaginitionModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

		} catch (Exception e) {
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			log.error(e.getMessage(), e);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

		}
	}

	@PostMapping("duplicateDevice/pageRendering")
	public ResponseEntity<?> pageRendering(HttpSession session) {

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");

		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;

		pageElement.setPageTitle("Duplicate Device");

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
		String[] dateParam = {"date", "Detection Date", "filterDetectionDate", "", 
				"text","IMEI", "filterImei", "20",
				"text","Phone Number", "filterMsisdn", "20", 
				"text","Ticket ID", "redmineTktId", "20",
				"text", "Updated By", "filterupldatedBy", "",
				"select", "Status", "filterStatus", "" };
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
