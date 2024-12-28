package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import org.gl.ceir.CeirPannelCode.Model.CopyFileRequest;
import org.gl.ceir.CeirPannelCode.Model.Destination;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

@RestController
public class StolenPoliceVerificationDeviceDatatableController {
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

	@PostMapping("policeTrackLostDeviceData")
	public ResponseEntity<?> viewAdminMessage(
			@RequestParam(name = "type", defaultValue = "Police Verification Track Lost Device Data", required = false) String role,
			@RequestParam(name = "source", defaultValue = "menu", required = false) String source,
			@RequestParam(name = "featureId", required = false) String featureId,
			HttpServletRequest request, HttpSession session) {

		log.info("featureId==" + featureId);
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
//					String status;
//					if(dataInsideList.getUserStatus()==null){
//						status="NA";
//					}
//					else{
//						status=dataInsideList.getUserStatus();
//					}

					String remarks=dataInsideList.getRemarks();
					String uploadedby=dataInsideList.getCreatedBy();
					if(uploadedby==null){uploadedby="NA";}
					String req_mode=dataInsideList.getRequestMode();
					if(req_mode==null){req_mode="NA";}
					String req_type=dataInsideList.getRequestType();
					if(req_type==null){req_type="NA";}
					String province=dataInsideList.getProvince();
					if(province==null){province="NA";}
					String district=dataInsideList.getDistrict();
					if(district==null){district="NA";}
					String commune=dataInsideList.getCommune();
					if(commune==null){commune="NA";}
					
					if(remarks==null) {
						remarks="";
					}
					String status = "NA";
					String trimmedStatus = dataInsideList.getStatus() != null ? dataInsideList.getStatus().trim() : "";

					if (trimmedStatus.equalsIgnoreCase("INIT")) {
					    status = "Pending";
					} else if (trimmedStatus.equalsIgnoreCase("VERIFY_MOI")) {
					    status = "Pending MOI";
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
					String action ="";
					String deviceType=dataInsideList.getDeviceType();
					if(deviceType==null) {
						deviceType="NA";
					}
					
					//stolenData.firCopyUrl+stolenData.requestId+"/"+stolenData.fileName
					//String url=dataInsideList.getFileUrl()+requestId+"/"+dataInsideList.getFileName();
					String url="";
					try {
						String fileName = dataInsideList.getFileName();
						if (fileName != null) {
							fileName = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");
						} else {
							// Handle the null case, e.g., log a warning or set a default value
							fileName = "defaultFileName.csv"; // Or handle it in a way that suits your logic
						}

						 url = dataInsideList.getFileUrl() + requestId + "/" + fileName;
						System.out.println("Generated URL: " + url);
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}

					String url2=dataInsideList.getFileUrl()+requestId+"/"+requestId+".csv";
					//String url="#";
					if(req_mode.equalsIgnoreCase("Bulk")) {
						log.info("Bulk File Upload response in datatable" + dataInsideList.toString());
						 action = iconState.policeBulkViewIconsList(requestId,status,req_mode, url,url2,trackLostDeviceFilterRequest.getLang(),featureId);
					}else {
						action = iconState.policeViewIconsList(requestId,status,req_mode,trackLostDeviceFilterRequest.getLang(),featureId);
						
					}
					
					
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

	@PostMapping("policeTrackLostDevice/pageRendering")
	public ResponseEntity<?> pageRendering(HttpSession session) {

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");

		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;

		pageElement.setPageTitle(Translator.toLocale("stolen.moi.police.title"));

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
//		String[] dateParam = {"date", "Start Date", "filterStartDate", "",
//				"date", "End Date", "filterEndDate", "",
//				"text","Request Number", "filterRequestNo", "20",
//				"text","IMEI", "filterImei", "20",
//				"text","MSISDN", "filterMsisdn", "20", 
//				"text", "Email ID", "filterEmailID", "", 
//				"select", "Status", "filterStatus", "" };
		
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
	
	 @RequestMapping(value = {"/firUploadFile"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	    public Object uploadStolenFIRFile(@RequestParam(name = "file", required = false) MultipartFile file, @RequestParam(name = "remarks", required = false) String remarks, @RequestParam(name = "requestType", required = true) String requestType, @RequestParam(name = "id", required = false) Integer id, HttpServletRequest request, HttpSession session) {
	        Gson gson = new Gson();
	        String deviceDetails = request.getParameter("multirequest").replace("&#34;", "\"");
	        log.info("uploadStolenFIRFile() :: FIR upload request------" + deviceDetails);
	        log.info("fir fileUpload------" + file.getOriginalFilename());

	        String txnNumber = "S" + utildownload.getTxnId();
	        log.info("uploadStolenFIRFile() ::  Random transaction id number=" + txnNumber);

	        addMoreFileModel.setTag("system_upload_filepath");
	        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);

	        TrackLostDeviceFilterRequest uploadFIRRequest = gson.fromJson(deviceDetails, TrackLostDeviceFilterRequest.class);
	        
	        try {

	            byte[] bytes = file.getBytes();
	            String rootPath = urlToUpload.getValue() + txnNumber + "/";
	            File dir = new File(rootPath + File.separator);

	            if (!dir.exists()) {
	                dir.mkdirs();
	                dir.setExecutable(true, false);
	                dir.setReadable(true, false);
	                dir.setWritable(true, false);
	            }
	            // Create the file on server
	            File serverFile = new File(rootPath + file.getOriginalFilename());
	            log.info("uploadStolenFIRFile() :: uploaded file path on server" + serverFile);
	            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
	            serverFile.setExecutable(true, false);
	            serverFile.setReadable(true, false);
	            serverFile.setWritable(true, false);
	            stream.write(bytes);
	            stream.close();

	            CopyFileRequest fileCopyRequest = new CopyFileRequest();
	            ArrayList<Destination> destination = new ArrayList<Destination>();
	            Destination dest = new Destination();
	            dest.setDestFilePath(rootPath);
	            dest.setDestServerName(propertyReader.destServerName);
	            dest.setDestFilePath(propertyReader.destFilePath+ txnNumber);
	            destination.add(dest);
	            fileCopyRequest.setDestination(destination);
	            fileCopyRequest.setSourceFilePath(rootPath);
	            fileCopyRequest.setTxnId(txnNumber);
	            fileCopyRequest.setSourceFileName(file.getOriginalFilename());
	            fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
	            fileCopyRequest.setAppName("Police FIR Upload");
	            fileCopyRequest.setRemarks("File Copy mango one server to mango2");
	            log.info("uploadStolenFIRFile() :: request passed to for uploaded_file_to_sync DB==" + fileCopyRequest);
	            GenricResponse fileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
	            log.info("file move api response===" + fileUploadResponse);

	        } catch (Exception e) {
	            // TODO: handle exception
	            e.printStackTrace();
	        }
	        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
	        uploadFIRRequest.auditTrailModel.setPublicIp(session.getAttribute("publicIP").toString());
	        uploadFIRRequest.auditTrailModel.setBrowser(session.getAttribute("browser").toString());
	        uploadFIRRequest.setFileName(file.getOriginalFilename());
	        uploadFIRRequest.setRemarks(remarks);

	        log.info("uploadStolenFIRFile() ::  form parameters passed to save file Details " + uploadFIRRequest);
	        
	        Object response = deviceRepositoryFeign.setpoliceVerificationStatus(uploadFIRRequest);
	       // response = trcModuleFeignImplementation.uploadTAFile(uploadTARequest);
	        log.info("response from upload TA api" + response);
	        log.info("upload TA exit point.");
	        return response;
	    }
	 
//	 @RequestMapping(value = {"/approvedRejectMOIAdmin"}, method = RequestMethod.POST)
//	    public Object approvedRejectMOIAdmin(@RequestParam(name = "remarks", required = false) String remarks, @RequestParam(name = "requestType", required = true) String requestType, @RequestParam(name = "id", required = false) Integer id, HttpServletRequest request, HttpSession session) {
//	        Gson gson = new Gson();
//	        String deviceDetails = request.getParameter("multirequest").replace("&#34;", "\"");
//	        log.info("approvedRejectMOIAdmin() :: FIR upload request------" + deviceDetails);
//
//	        TrackLostDeviceFilterRequest uploadFIRRequest = gson.fromJson(deviceDetails, TrackLostDeviceFilterRequest.class);
//	        
//	        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
//	        uploadFIRRequest.auditTrailModel.setPublicIp(session.getAttribute("publicIP").toString());
//	        uploadFIRRequest.auditTrailModel.setBrowser(session.getAttribute("browser").toString());
//	        uploadFIRRequest.setRemarks(remarks);
//	        log.info("approvedRejectMOIAdmin() ::  form parameters passed to save file Details " + uploadFIRRequest);
//	        
//	        Object response = deviceRepositoryFeign.setMOIAdminStatus(uploadFIRRequest);
//	        log.info("response from upload approvedRejectMOIAdmin api" + response);
//	        return response;
//	    }

}
