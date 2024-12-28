package org.gl.ceir.CeirPannelCode.Feignclient;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Response.SearchIMEIResponse;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.EIRSListManagementEntity;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

@Service
@FeignClient(url = "${deviceRepositoryfeignClientPath}", value = "deviceRepository" )

public interface DeviceRepositoryFeign {

    //-------------------get all Device details feign Controller-------------------//

    @RequestMapping(value = "/getDevicesDetails", method = RequestMethod.POST)
    public Object deviceManagementFeign(@RequestBody DeviceFilterRequest deviceManagementRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "0") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


    //-------------------Export Device details feign Controller-------------------//

    @RequestMapping(value = "/exportData", method = RequestMethod.POST)
    public Object deviceManagementExportFeign(@RequestBody DeviceFilterRequest deviceManagementRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


    //-------------------Update Device Management feign Controller-------------------//

    @RequestMapping(value = "/addDevice", method = RequestMethod.POST)
    public GenricResponse addDeviceInfo(@RequestBody DeviceManagementRequest deviceManagementRequest);


    //-------------------Add Device Management feign Controller-------------------//

    @RequestMapping(value = "/updateDevices", method = RequestMethod.POST)
    public GenricResponse updateDeviceInfo(@RequestBody List<DeviceManagementRequest> updateRequest);

    //-------------------Delete Device feign Controller-------------------//

    @RequestMapping(value = "/deleteDevice", method = RequestMethod.POST)
    public @ResponseBody GenricResponse deleteDeviceFeign(@RequestParam(name = "deviceId", required = true) String deviceId, @RequestParam(name = "featureId", required = false) String featureId, @RequestParam(name = "publicIp", required = false) String publicIp, @RequestParam(name = "browser", required = false) String browser, @RequestParam(name = "userId", required = true) String userId, @RequestParam(name = "userType", required = false) String userType);

    //-------------------Get Device History feign Controller-------------------//

    @RequestMapping(value = "/getDeviceHistory", method = RequestMethod.POST)
    public Object getDeviceHistoryFeign(@RequestBody DeviceFilterRequest deviceManagementRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "0") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


			//-------------------Get Duplicate Device feign Controller-------------------//

			@RequestMapping(value="/getDuplicateDeviceDetails" ,method=RequestMethod.POST)
			public Object getDuplicateDeviceFeign(@RequestBody DuplicateDeviceRequest duplicateDeviceRequest,
			@RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			@RequestParam(value = "file", defaultValue = "0") Integer file);

			//-------------------Get Duplicate Device Export Controller-------------------//

			@RequestMapping(value = "/exportDuplicateData", method = RequestMethod.POST)
		    public Object exportDuplicateData(@RequestBody DuplicateDeviceRequest duplicateDeviceRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);

			//-------------------Get Approved Device Detail Controller-------------------//

			@RequestMapping(value="/getApprovedDeviceData" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse viewApprovedDeviceFeign(@RequestBody DuplicateDeviceRequest duplicateDeviceRequest);

			//-------------------Approve Duplicate feign Controller-------------------//

			@RequestMapping(value="/approveDuplicateDevice" ,method=RequestMethod.POST)
			public GenricResponse approveDuplicateDevice(@RequestBody DuplicateDeviceRequest duplicateDeviceRequest) ;


			//-------------------Customer Care search IMEI/MSISDN/IMSI Detail Controller-------------------//

			@RequestMapping(value="/get-msisdn-imsi" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse getImsiMsisdnFeign(@RequestBody SearchIMEIRequest searchIMEIRequest);

			//-------------------Customer Care search IMEI Device Detail Controller-------------------//

			@RequestMapping(value="/get-device-details-by-tac" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse getIMEIDetailDeviceFeign(@RequestBody SearchIMEIRequest searchIMEIRequest);

			//-------------------Customer Care search IMEI Device state Controller-------------------//

			@RequestMapping(value="/get-device-states" ,method=RequestMethod.POST)
			public @ResponseBody SearchIMEIResponse getDeviceStateFeign(@RequestBody SearchIMEIRequest searchIMEIRequest);

			//-------------------Customer Care search IMEI get table details Controller-------------------//

			@RequestMapping(value="/get-table-record-by-imei" ,method=RequestMethod.POST)
			public @ResponseBody SearchIMEITableResponse getTableDetailFeign(@RequestBody SearchIMEIRequest searchIMEIRequest);

			//-------------------Customer Care search IMEI get table details Controller-------------------//

			@RequestMapping(value="/get-table-history-record-by-imei" ,method=RequestMethod.POST)
			public @ResponseBody List<Object> getHistoryTableHistoryDetailFeign(@RequestBody SearchIMEIRequest searchIMEIRequest);

			//-------------------Get Stolen Device feign Controller-------------------//

			@RequestMapping(value="/getStolenDeviceDetails" ,method=RequestMethod.POST)
			public Object getStolenDeviceFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest,
										  @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
										  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
										  @RequestParam(value = "file", defaultValue = "0") Integer file);

			//-------------------Get Stolen Device Export feign Controller-------------------//

			@RequestMapping(value="/exportStolenData" ,method=RequestMethod.POST)
			public Object getStolenDeviceExportFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get Stolen Device view feign Controller-------------------//

			@RequestMapping(value="/viewStolenImeiData" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse viewStolenDeviceFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get Recovered Device view feign Controller-------------------//

			@RequestMapping(value="/viewRecoveredImeiData" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse viewRecoveredDeviceFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get new recovery feign Controller-------------------//
			@PostMapping("/upload")
			public GenricResponse single(StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get Stolen Device Export feign Controller-------------------//

			@RequestMapping(value="/initiateRecovery-single" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse InitiateRecoverySingleFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get Stolen Device Export feign Controller-------------------//

			@RequestMapping(value="/initiateRecovery-bulk" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse InitiateRecoveryBulkFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get Stolen Initiate Recovery Verify OTP Feign Controller-------------------//

			@RequestMapping(value="/initiate-recovery/verify/otp" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse InitiateRecoveryVerifyOTPFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get Stolen Initiate Recovery Resend OTP feign Controller-------------------//

			@RequestMapping(value="/initiate-recovery/resendOTP" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse InitiateRecoveryResendOTPFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);

			//-------------------Get initiate recovery form feign Controller-------------------//
			@PostMapping("/initiateRecovery")
			public GenricResponse initiateRecoveryFormFeign(StolenImeiStatusCheckRequest stolenRequest);

	

			//------------------Send Recovery feign Controller-------------------//

			@RequestMapping(value="/initiateRecovery-sendNotification" ,method=RequestMethod.POST)
			public @ResponseBody GenricResponse sendRecoveryFeign(@RequestBody StolenImeiStatusCheckRequest stolenRequest);


			
			//-------------------Get Track Lost Device feign Controller-------------------//
			
			@RequestMapping(value="/getTrackLostDevicesDetails" ,method=RequestMethod.POST) 
			public Object getTrackLostDevicesDetails(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceFilterRequest,
			@RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			@RequestParam(value = "file", defaultValue = "0") Integer file);
			
			//-------------------Get Track Lost Device Export Controller-------------------//
			
			@RequestMapping(value = "/exportTrackLostData", method = RequestMethod.POST)
		    public Object exportTrackLostData(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceFilterRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);
			
			//-------------------Get Track Lost Device Detail Controller-------------------//
			
			@RequestMapping(value="/getTrackLostData" ,method=RequestMethod.POST) 
			public @ResponseBody GenricResponse getTrackLostData(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceFilterRequest);
			
			@RequestMapping(value="getDistinctOperator" ,method=RequestMethod.GET) 
			public List<Object> getDistinctOperator();
			
			@RequestMapping(value="getDistinctStatus" ,method=RequestMethod.GET) 
			public List<String> getDistinctStatus();


			
			
			
			@RequestMapping(value="getTrackLostRequestType" ,method=RequestMethod.GET) 
			public List<Object> getTrackLostRequestType();
			
			//----------------------Police Verification Stolen Device...........................//
			
			@RequestMapping(value="/getVerificationDevicesDetails" ,method=RequestMethod.POST) 
			public Object getPoliceTrackLostDevicesDetails(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceFilterRequest,
			@RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
			@RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize,
			@RequestParam(value = "file", defaultValue = "0") Integer file);
			
			//-------------------Get Police Track Lost Device Export Controller-------------------//
			
			@RequestMapping(value = "/exportVerificationData", method = RequestMethod.POST)
		    public Object exportPoliceTrackLostData(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceFilterRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);
			
			//-------------------Get Police Track Lost Device Detail Controller-------------------//
			
			@RequestMapping(value="/getPoliceVerificationData" ,method=RequestMethod.POST) 
			public @ResponseBody GenricResponse getPoliceTrackLostData(@RequestBody TrackLostDeviceFilterRequest trackLostDeviceFilterRequest);
			
			
			@RequestMapping(value="getProvince" ,method=RequestMethod.GET) 
			public List<Object> getProvince();
			
			
			@RequestMapping(value="getCommune" ,method=RequestMethod.GET) 
			public List<Object> getCommune();
			
			@RequestMapping(value="getDistrict" ,method=RequestMethod.GET) 
			public List<Object> getDistrict();
			
			@RequestMapping(value="getPoliceStation" ,method=RequestMethod.GET) 
			public List<Object> getPoliceStation();
			
			@RequestMapping(value="getDistinctRequestMode" ,method=RequestMethod.GET) 
			public List<String> getDistinctRequestMode();
			
			@RequestMapping(value="getDistinctRequestType" ,method=RequestMethod.GET) 
			public List<String> getDistinctRequestType();
			
			@RequestMapping(value="getDistinctCreatedBy" ,method=RequestMethod.GET) 
			public List<String> getDistinctCreatedBy();
			
			@RequestMapping(value="getPolistStatus" ,method=RequestMethod.GET) 
			public List<Object> getPolistStatus();
			
			@RequestMapping(value="getMOIAdminStatus" ,method=RequestMethod.GET) 
			public List<Object> getMOIAdminStatus();
			
			@RequestMapping(value = "/policeVerificationStatus", method = RequestMethod.POST)
			public Object setpoliceVerificationStatus(TrackLostDeviceFilterRequest uploadFIRRequest);

			@RequestMapping(value = "/MOIAdminVerifyStatus", method = RequestMethod.POST)
			public Object setMOIAdminStatus(TrackLostDeviceFilterRequest uploadFIRRequest);
			
			//Start Customer care Change Contact Number for lost/stolen contact
			@RequestMapping(value = "/contact-number/verification", method = RequestMethod.POST)
			public Object verifyRequestNoAndContactNumber(TrackLostDeviceFilterRequest userRequest);
			
			@RequestMapping(value = "/contact-number/update", method = RequestMethod.POST)
			public Object updateContactNumber(TrackLostDeviceFilterRequest userRequest);

			@RequestMapping(value="initiateRecoveryDistinctStatus" ,method=RequestMethod.GET)
			public List<String> initiateRecoveryDistinctStatus();

    @RequestMapping(value = "getDistinctMOIDeviceType", method = RequestMethod.GET)
    public List<String> getDistinctMOIDeviceType();

    @RequestMapping(value = "getDistinctDeviceType", method = RequestMethod.GET)
    public List<Object> getDeviceTypetListFeign();


    @RequestMapping(value = "getManufacturerCountry", method = RequestMethod.GET)
    public List<Object> getManufacturerCountryListFeign();


    //-------------------get single device detail feign Controller-------------------//

    @RequestMapping(value = "/getDeviceInfo", method = RequestMethod.POST)
    public @ResponseBody Object getDeviceinfoFeign(@RequestParam(name = "deviceId", required = true) String deviceId, @RequestParam(name = "featureId", required = false) Integer featureId, @RequestParam(name = "publicIp", required = false) String publicIp, @RequestParam(name = "browser", required = false) String browser, @RequestParam(name = "userId", required = true) Integer userId, @RequestParam(name = "userType", required = false) String userType, @RequestParam(name = "userTypeId", required = false) Integer userTypeId);

    //-------------------Delete Device feign Controller-------------------//

    @RequestMapping(value = "/getDeviceHistoryInfo", method = RequestMethod.POST)
    public @ResponseBody Object getDeviceHistoryFeign(@RequestParam(name = "deviceId", required = true) String deviceId, @RequestParam(name = "featureId", required = false) Integer featureId, @RequestParam(name = "userId", required = true) Integer userId, @RequestParam(name = "userType", required = false) String userType, @RequestParam(name = "userTypeId", required = false) Integer userTypeId, @RequestParam(name = "rowId", required = false) Integer rowId, @RequestParam(name = "publicIp", required = false) String publicIp, @RequestParam(name = "browser", required = false) String browser);

    //-------------------Get User Agent Drop down feign Controller-------------------//

    @RequestMapping(value = "getDistinctUserName", method = RequestMethod.GET)
    public List<Dropdown> getUserAgentListFeign();


    @RequestMapping(value = "/gsma/brandName", method = RequestMethod.GET)
    public List<Dropdown> viewAllProductList();

    //-------------------get dash board count feign Controller-------------------//
    @RequestMapping(value = "/getMDRDashboardData", method = RequestMethod.GET)
    public Object getDashboardCountFeign(@RequestParam(name = "userId", required = true) String userId);
}
