package org.gl.ceir.CeirPannelCode.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.FileCopierFeignClient;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.*;

@Controller
public class StolenImeiStatusCheckController {

    private final Logger log = LoggerFactory.getLogger(getClass());
    @Autowired
    UtilDownload utildownload;

    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

    @Autowired
    DeviceRepositoryFeign deviceRepositoryFeign;

    @Autowired
    FeignCleintImplementation feignCleintImplementation;

    @Autowired
    PropertyReader propertyReader;

    @Autowired
    FileCopierFeignClient fileCopierFeignClient;


    @GetMapping("/imeiStatusCheck")
    public ModelAndView viewStolenImeiStatus(@RequestParam(name = "via", required = false) String via,
                                             @RequestParam(name = "transactionId", required = false) String transactionId,
                                             @RequestParam(name = "FeatureId", required = false) String featureId,
                                             HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info("transactionId {}", transactionId);
        log.info("featureId {}", featureId);
        if ("other".equals(via)) {
            mv.addObject("transactionId", transactionId);
            mv.addObject("featureId", featureId);
            mv.setViewName("viewStolenIMEIStatus");
        } else {
            mv.addObject("featureId", featureId);
            mv.setViewName("stolenIMEIStatusCheck");
        }
        return mv;
    }


    //------------------------------------- view Stolen Device ----------------------------------------

    @PostMapping("viewStolenImeiDetail")
    public @ResponseBody GenricResponse viewApprovedDevice(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpSession session) {
        stolenRequest.setPublicIp(session.getAttribute("publicIP").toString());
        stolenRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("Get Device Details for transaction Id = {}", stolenRequest.getTransactionId());
        GenricResponse response = deviceRepositoryFeign.viewStolenDeviceFeign(stolenRequest);
        log.info("view response {}", response);
        return response;
    }

    //------------------------------------- view Stolen Device ----------------------------------------

    @PostMapping("viewRecoveredDeviceImeiDetail")
    public @ResponseBody GenricResponse viewRecoveredDeviceImeiDetail(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpSession session) {
        stolenRequest.setPublicIp(session.getAttribute("publicIP").toString());
        stolenRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("Get Device Details for request Id = {}", stolenRequest.getRequestId());
        GenricResponse response = deviceRepositoryFeign.viewRecoveredDeviceFeign(stolenRequest);
        log.info("view recovered response {}", response);
        return response;
    }

    //------------------------------------- New Stolen Device Recovery [Single]----------------------------------------

    @PostMapping("recoverStolenImeiDetail-single")
    public ResponseEntity<GenricResponse> singleRequest(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpServletRequest request, HttpSession session) {
        GenricResponse response = new GenricResponse();

        try {
            String txnNumber = "M" + utildownload.getTxnId();
            log.info("Random transaction id number={}", txnNumber);
            log.info("publicIP {} And Browser {}", session.getAttribute("publicIP"), session.getAttribute("browser"));

            stolenRequest.setTransactionId(txnNumber);
            stolenRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
            stolenRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());

            log.info("payload : {}", stolenRequest);
            response = deviceRepositoryFeign.single(stolenRequest);
            response.setRequestID(txnNumber);
            log.info("singleRequestResponse {}", response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.info("Error processing request", e);
            response.setMessage("Error processing request: " + e.getMessage());
            response.setStatusCode("500");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    //------------------------------------- New Stolen Device Recovery [Bulk]----------------------------------------

    @ResponseBody
    @RequestMapping(value = {"/recoverStolenImeiDetail-bulk"}, method = RequestMethod.POST, consumes = "multipart/form-data")
    public ResponseEntity<GenricResponse> uploadBulkFile(@RequestParam(name = "file", required = false) MultipartFile file, HttpServletRequest request, HttpSession session) {
/*        String filter = request.getParameter("model").replace("&#34;", "\"");
        logger.info("filter payload [" + filter + "]");*/
        Gson gsonObject = new Gson();
        //GenricResponse bulkResponse;
        GenricResponse bulkResponse = new GenricResponse();
        String model = HtmlUtils.htmlUnescape(request.getParameter("model"));
        log.info("model{}", model);
        StolenImeiStatusCheckRequest stolenRequest = gsonObject.fromJson(model, StolenImeiStatusCheckRequest.class);
        log.info("stolenRequest------{}", stolenRequest);
        String deviceDetails = request.getParameter("multirequest");
        log.info("upload request------{}", deviceDetails);
        log.info("fileUpload------{}", file.getOriginalFilename());

        String txnNumber = "M" + utildownload.getTxnId();
        log.info("Random transaction id number for bulk recovery={}", txnNumber);

        addMoreFileModel.setTag("system_upload_filepath");
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
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
            log.info("uploaded file path on server{}", serverFile);
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
            dest.setDestFilePath(propertyReader.destFilePath + txnNumber);
            destination.add(dest);
            fileCopyRequest.setDestination(destination);
            fileCopyRequest.setSourceFilePath(rootPath);
            fileCopyRequest.setTxnId(txnNumber);
            fileCopyRequest.setSourceFileName(file.getOriginalFilename());
            fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
            fileCopyRequest.setAppName("Stolen Check IMEI Bulk Upload");
            fileCopyRequest.setRemarks("File Copy mango one server to mango2");
            log.info("request passed to for uploaded_file_to_sync DB=={}", fileCopyRequest);
            GenricResponse fileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
            log.info("file move api response==={}", fileUploadResponse);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        stolenRequest.setFileName(file.getOriginalFilename());
        stolenRequest.setTransactionId(txnNumber);
        stolenRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        stolenRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        log.info("bulk form parameters passed to save file Details {}", stolenRequest);
        bulkResponse = deviceRepositoryFeign.single(stolenRequest);
        bulkResponse.setRequestID(txnNumber);
        log.info("bulk request response {}", stolenRequest);
        return ResponseEntity.ok(bulkResponse);
    }

    //------------------------------------- Initiate Recovery [Single] ----------------------------------------

    @PostMapping("initialRecovery-single")
    public @ResponseBody GenricResponse initialRecoverySingle(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpSession session) {
        stolenRequest.setPublicIp(session.getAttribute("publicIP").toString());
        stolenRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("Single Initiate Recovery for single request Id = {}", stolenRequest.getRequestId());
        GenricResponse response = deviceRepositoryFeign.InitiateRecoverySingleFeign(stolenRequest);
        log.info("Initiate Recovery response {}", response);
        return response;
    }

    //------------------------------------- Initiate Recovery [Bulk] ----------------------------------------

    @PostMapping("initialRecovery-bulk")
    public @ResponseBody GenricResponse initialRecoveryBulk(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpSession session) {
        stolenRequest.setPublicIp(session.getAttribute("publicIP").toString());
        stolenRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("Single Initiate Recovery for Bulk request Id = {}", stolenRequest.getRequestId());
        GenricResponse response = deviceRepositoryFeign.InitiateRecoveryBulkFeign(stolenRequest);
        log.info("Initiate Recovery Bulk response {}", response);
        return response;
    }


    @RequestMapping(value= {"/initialVerifyOTPRequest"},method= RequestMethod.POST,consumes = "multipart/form-data")
    public @ResponseBody GenricResponse OTPRequest(
            HttpServletRequest request,HttpSession session) {
        log.info("inside OTP verify request---------{}", request.getParameter("request"));
        Gson gson= new Gson();
        String filter = request.getParameter("request").replace("&#34;", "\"");
        log.info("filter {}", filter);
        org.gl.ceir.CeirPannelCode.Model.OTPRequest OTPrequest  = gson.fromJson(filter, org.gl.ceir.CeirPannelCode.Model.OTPRequest.class);
        OTPrequest.setOtp(OTPrequest.getOtpBox1()+OTPrequest.getOtpBox2()+OTPrequest.getOtpBox3()+OTPrequest.getOtpBox4() +OTPrequest.getOtpBox5()+OTPrequest.getOtpBox6());
        log.info("otp ={}", OTPrequest.getOtp());
        GenricResponse response = new GenricResponse();
        StolenImeiStatusCheckRequest stolenRequest=new StolenImeiStatusCheckRequest();
        stolenRequest.setRequestId(OTPrequest.getRequestID());
        stolenRequest.setOtp(OTPrequest.getOtp());
        stolenRequest.setLang(OTPrequest.getLang());

        String userAgent = request.getHeader("User-Agent");
        String ip = request.getRemoteAddr();
        log.info("publicIP " + request.getRemoteAddr()+ " And Browser " + userAgent.toString());

        //AuditTrailModel autitrail=new AuditTrailModel();
        //autitrail.setPublicIp(ip);
        //autitrail.setBrowser(userAgent);
        //stolenRequest.setAuditTrailModel(autitrail);
       /* bulkRequest.getAuditTrailModel().setBrowser(userAgent);
        bulkRequest.getAuditTrailModel().setPublicIp(ip);*/

        response=deviceRepositoryFeign.InitiateRecoveryVerifyOTPFeign(stolenRequest);
        log.info("response from verify OTP "+response);
        return response;
    }


    @RequestMapping(value= {"/initialResendOTPRequest"},method= RequestMethod.POST,consumes = "multipart/form-data")
    public @ResponseBody GenricResponse resendOTPRequest(
            HttpServletRequest request,HttpSession session) {
        log.info("inside  resend OTP  request---------{}", request.getParameter("request"));
        Gson gson= new Gson();
        String filter = request.getParameter("request").replace("&#34;", "\"");
        log.info(" initialResendOTPRequest filter  {}", filter);
        org.gl.ceir.CeirPannelCode.Model.OTPRequest oTPrequest  = gson.fromJson(filter, org.gl.ceir.CeirPannelCode.Model.OTPRequest.class);
        GenricResponse response = new GenricResponse();

        StolenImeiStatusCheckRequest stolenRequest=new StolenImeiStatusCheckRequest();
        stolenRequest.setTransactionId(oTPrequest.getRequestID());
        stolenRequest.setOtp(oTPrequest.getOtp());
        stolenRequest.setLang(oTPrequest.getLang());
        String userAgent = request.getHeader("User-Agent");
        String ip = request.getRemoteAddr();
        log.info("publicIP " + request.getRemoteAddr()+ " And Browser " + userAgent.toString());

        /*AuditTrailModel autitrail=new AuditTrailModel();
        autitrail.setPublicIp(ip);
        autitrail.setBrowser(userAgent);
        stolenRequest.setAuditTrailModel(autitrail);*/
        response=deviceRepositoryFeign.InitiateRecoveryResendOTPFeign(stolenRequest);
        log.info("response from resend OTP "+response);
        return response;
    }

    //------------------------------------- New Stolen Device Recovery [Single]----------------------------------------

    @PostMapping("initiateRecoveryForm-single")
    public ResponseEntity<GenricResponse> initiateRecoveryFormSingle(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpServletRequest request, HttpSession session) {
        GenricResponse response = new GenricResponse();

        try {
            stolenRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
            stolenRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
            log.info("initiateRecoveryForm-single payload : {}", stolenRequest);
            response = deviceRepositoryFeign.initiateRecoveryFormFeign(stolenRequest);
            log.info("initiateRecoveryForm-single Response {}", response);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.info("Error processing request", e);
            response.setMessage("Error processing request: " + e.getMessage());
            response.setStatusCode("500");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }


    //------------------------------------- Get Status Dropdown distinct values----------------------------------------
    @ResponseBody
    @GetMapping("getDistinctStatus")
    public List<String> getDistinctStatus() {
        List<String> dropdown = deviceRepositoryFeign.initiateRecoveryDistinctStatus();
        log.info("getDistinctStatus response {}", dropdown);
        dropdown.removeIf(Objects::isNull);
        dropdown.removeIf(String::isEmpty);
        dropdown.sort(Comparator.comparing(x -> x, Comparator.nullsFirst(Comparator.naturalOrder())));
        Collections.sort(dropdown, String.CASE_INSENSITIVE_ORDER);
        return dropdown;
    }

    //------------------------------------- Send Notification Controller----------------------------------------

    @PostMapping("sendNotification")
    public @ResponseBody GenricResponse sendNotification(@RequestBody StolenImeiStatusCheckRequest stolenRequest, HttpSession session) {
        stolenRequest.setPublicIp(session.getAttribute("publicIP").toString());
        stolenRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("Send Notification on contact number = {}", stolenRequest.getContactNumber());
        GenricResponse response = deviceRepositoryFeign.sendRecoveryFeign(stolenRequest);
        log.info("Send Notification {}", response);
        return response;
    }

}
