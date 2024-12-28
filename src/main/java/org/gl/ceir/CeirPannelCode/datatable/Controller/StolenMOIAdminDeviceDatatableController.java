package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.FileCopierFeignClient;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.LostStolenModel;
import org.gl.ceir.CeirPannelCode.Model.TrackLostDeviceFilterRequest;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.StolenPolicePaginationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.google.gson.Gson;

@RestController
public class StolenMOIAdminDeviceDatatableController {
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
    PropertyReader propertyReader;
	@Autowired
	StolenPolicePaginationModel stolenPaginationModel;
	@Autowired
    UtilDownload utildownload;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	@Autowired
	AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;
	@Autowired
    private FileCopierFeignClient fileCopierFeignClient;
	@Autowired
	Translator Translator;

//	 private Map<String, String> Province = new HashMap<>();
//	 private Map<String, String> District = new HashMap<>();
//	 private Map<String, String> Commune = new HashMap<>();
	

	@PostMapping("moiAdmintTrackLostDeviceData")
	public ResponseEntity<?> viewAdminMessage(
			@RequestParam(name = "type", defaultValue = "Police Verification Track Lost Device Data", required = false) String role,
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
						: "2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "IMEI"
								: "3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Uploaded By" 
										: "4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Request Mode" 
												: "5".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Request Type" 
														: "6".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Province" 
																: "7".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "District" 
																		: "8".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Commune" 
																				: "9".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Device Type" 
																						: "10".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Status" :
																							"modifiedOn";
		String order;

		if ("modifiedOn".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == null) {
			order = "desc";
		} else if ("modifiedOn".equalsIgnoreCase(column) && request.getParameter("order[0][dir]") == "asc") {
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
			Object response = deviceRepositoryFeign.getPoliceTrackLostDevicesDetails(trackLostDeviceFilterRequest, pageNo, pageSize, file);
			log.info("response in datatable" + response);
			Gson gson = new Gson();
			String apiResponse = gson.toJson(response);
			stolenPaginationModel = gson.fromJson(apiResponse, StolenPolicePaginationModel.class);

			List<LostStolenModel> paginationContentList = stolenPaginationModel.getContent();
			if (paginationContentList.isEmpty()) {
				datatableResponseModel.setData(Collections.emptyList());
			} else {
				for (LostStolenModel dataInsideList : paginationContentList) {
					
						Integer id = dataInsideList.getId();
						String detectionDate=(String) dataInsideList.getCreatedOn();
						String requestId=dataInsideList.getRequestId();
						String imei=dataInsideList.getImei1();
						
						String status = "NA";
						String trimmedStatus = dataInsideList.getStatus() != null ? dataInsideList.getStatus().trim() : "";

						if (trimmedStatus.equalsIgnoreCase("INIT")) {
						    status = "Pending Police";
						} else if (trimmedStatus.equalsIgnoreCase("VERIFY_MOI")) {
						    status = "Pending";
						} else if (trimmedStatus.equalsIgnoreCase("REJECT")) {
						    status = "Reject";
						} else if (trimmedStatus.equalsIgnoreCase("START")) {
						    status = "Pending EIRS";
						} else if (trimmedStatus.equalsIgnoreCase("DONE")) {
						    status = "Done";
						}
						else if (trimmedStatus.equalsIgnoreCase("FAIL")) {
							status = "Fail";
						}

						//String status = dataInsideList.getUserStatus();
						String remarks=dataInsideList.getRemarks();
						String uploadedby=dataInsideList.getCreatedBy()+"";
						String req_mode=dataInsideList.getRequestMode();
						String req_type=dataInsideList.getRequestType();
						String province=dataInsideList.getProvince();
						String district=dataInsideList.getDistrict();
						String commune=dataInsideList.getCommune();
						String deviceType=dataInsideList.getDeviceType();
						if(deviceType==null) {
							deviceType="NA";
						}
						if(remarks==null) {
							remarks="";
						}
						//String action = iconState.policTracklLostActionIconsList(requestId,status);
						String action = iconState.traclLostActionIconsList(requestId,status,trackLostDeviceFilterRequest.getLang());
						Object[] finalData = {detectionDate, requestId, imei, uploadedby,req_mode,req_type,province,district,commune,deviceType,status,action};
						List<Object> finalDataList = new ArrayList<Object>(Arrays.asList(finalData));
						finalList.add(finalDataList);
						datatableResponseModel.setData(finalList);
					}
			}
			// data set on ModelClass
			datatableResponseModel.setRecordsTotal(stolenPaginationModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(stolenPaginationModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

		} catch (Exception e) {
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			log.error(e.getMessage(), e);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

		}
	}

	@PostMapping("moiAdminTrackLostDevice/pageRendering")
	public ResponseEntity<?> pageRendering(HttpSession session) {

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");

		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;

		pageElement.setPageTitle(Translator.toLocale("stolen.moi.admin.title"));

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
		String[] dateParam = {"date",Translator.toLocale("input.startDate"), "startDate", "",
				"date", Translator.toLocale("input.endDate"), "endDate", "",
				"text",Translator.toLocale("stolen.table.req-number"), "filterRequestNo", "20",
				"text",Translator.toLocale("stolen.table.IMEI"), "filterImei", "20",
				"select",Translator.toLocale("stolen.table.UploadedBy"), "filterUploadedBy", "",
				"select", Translator.toLocale("stolen.table.RequestMode"), "filterRequestMode", "" ,
				"select",Translator.toLocale("stolen.table.request-type"), "filterRequestType", "",
				"select", Translator.toLocale("stolen.table.Province"), "filterProvince", "" ,
				"select", Translator.toLocale("stolen.table.District"), "filterDistrict", "" ,
				"select", Translator.toLocale("stolen.table.Commune"), "filterCommune", "" ,
				"select", Translator.toLocale("stolen.table.DeviceType"), "filterDeviceType", "" ,
				"select", Translator.toLocale("stolen.table.status"), "filterMOIStatus", "" };
		
//		String[] dateParam = {"date", "Start Date", "filterStartDate", "",
//				"date", "End Date", "filterEndDate", "",
//				"text","Request Number", "filterRequestNo", "20",
//				"text","IMEI", "filterImei", "20",
//				"text","MSISDN", "filterMsisdn", "20", 
//				"text", "Email ID", "filterEmailID", "", 
//				"select", "Status", "filterStatus", "" };
		
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
	 
	 @RequestMapping(value = {"/approvedRejectMOIAdmin"}, method = RequestMethod.POST)
	    public Object approvedRejectMOIAdmin(@RequestParam(name = "remarks", required = false) String remarks, @RequestParam(name = "requestType", required = true) String requestType, @RequestParam(name = "id", required = false) Integer id, HttpServletRequest request, HttpSession session) {
	        Gson gson = new Gson();
	        String deviceDetails = request.getParameter("multirequest").replace("&#34;", "\"");
	        log.info("approvedRejectMOIAdmin() :: FIR upload request------" + deviceDetails);

	        TrackLostDeviceFilterRequest uploadFIRRequest = gson.fromJson(deviceDetails, TrackLostDeviceFilterRequest.class);
	        
	        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
	       
	        uploadFIRRequest.auditTrailModel.setPublicIp(session.getAttribute("publicIP").toString());
	        uploadFIRRequest.auditTrailModel.setBrowser(session.getAttribute("browser").toString());
	        uploadFIRRequest.setRemarks(remarks);
	        log.info("approvedRejectMOIAdmin() ::  form parameters passed to save file Details " + uploadFIRRequest);
	        
	        Object response = deviceRepositoryFeign.setMOIAdminStatus(uploadFIRRequest);
	        log.info("response from upload approvedRejectMOIAdmin api" + response);
	        return response;
	    }
	 
	 @GetMapping("/getMOIProvince")
		public ResponseEntity<?> getProvince() {
			List<Object>  list = deviceRepositoryFeign.getProvince();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		@GetMapping("/getMOICommune")
		public ResponseEntity<?> getCommune() {
			List<Object>  list = deviceRepositoryFeign.getCommune();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		@GetMapping("/getMOIDistrict")
		public ResponseEntity<?> getDistrict() {
			List<Object>  list = deviceRepositoryFeign.getDistrict();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		@GetMapping("/getMOIPoliceStation")
		public ResponseEntity<?> getPoliceStation() {
			List<Object>  list = deviceRepositoryFeign.getPoliceStation();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		@GetMapping("/getDistinctRequestMode")
		public ResponseEntity<?> getDistinctRequestMode() {
			List<String>  list = deviceRepositoryFeign.getDistinctRequestMode();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		@GetMapping("/getDistinctRequestType")
		public ResponseEntity<?> getDistinctRequestType() {
			List<String>  list = deviceRepositoryFeign.getDistinctRequestType();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		@GetMapping("/getDistinctCreatedBy")
		public ResponseEntity<?> getDistinctCreatedBy() {
			List<String>  list = deviceRepositoryFeign.getDistinctCreatedBy();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		
		@GetMapping("/getPolistStatus")
		public ResponseEntity<?> getPolistStatus() {
			List<Object>  list = deviceRepositoryFeign.getPolistStatus();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		@GetMapping("/getMOIAdminStatus")
		public ResponseEntity<?> getMOIAdminStatus() {
			List<Object>  list = deviceRepositoryFeign.getMOIAdminStatus();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		
		@GetMapping("/getDistinctMOIDeviceType")
		public ResponseEntity<?> getDistinctMOIDeviceType() {
			List<String>  list = deviceRepositoryFeign.getDistinctMOIDeviceType();
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
		

}
