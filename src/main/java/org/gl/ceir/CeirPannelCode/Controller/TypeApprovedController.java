package org.gl.ceir.CeirPannelCode.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.FileCopierFeignClient;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class TypeApprovedController {
    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

    @Autowired
    FeignCleintImplementation feignCleintImplementation;

    @Autowired
    UtilDownload utildownload;

    @Autowired
    PropertyReader propertyReader;


    @Autowired
    GsmaFeignClient gsmaFeignClient;

    @Autowired
    APIService6Feign apiService6Feign;

    @Autowired
    private FileCopierFeignClient fileCopierFeignClient;
    GenricResponse response = new GenricResponse();

    @RequestMapping(value = {"/typeApprove"}, method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView viewManageTypeAdmin(@RequestParam(name = "FeatureId", required = false) String featureId,HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info(" view Device Management entry point.");
        mv.setViewName("TypeApproved");
        mv.addObject("featureId", featureId);
        log.info(" view Device Management entry point..");
        return mv;
    }

    @RequestMapping(value = {"/view-typeApprove"}, method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView viewTypeApprove(@RequestParam(name = "FeatureId", required = false) String featureId,HttpSession session) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("ViewTypeApproved");
        mv.addObject("featureId", featureId);
        return mv;
    }


    //-------------------Upload TA file Controller-------------------//

    @RequestMapping(value = {"/uploadfile"}, method = RequestMethod.POST, consumes = "multipart/form-data")
    public @ResponseBody GenricResponse uploadTAFile(@RequestParam(name = "file", required = false) MultipartFile file, @RequestParam(name = "remarks", required = false) String remarks, @RequestParam(name = "requestType", required = true) String requestType, @RequestParam(name = "id", required = false) Integer id, HttpServletRequest request, HttpSession session) {
        Gson gson = new Gson();
        String deviceDetails = request.getParameter("multirequest").replace("&#34;", "\"");
        log.info("upload request------" + deviceDetails);
        log.info("fileUpload------" + file.getOriginalFilename());

        String txnNumber = "T" + utildownload.getTxnId();
        log.info("Random transaction id number=" + txnNumber);
        //String filter = request.getParameter("request");
        //log.info("*********"+filter);

        addMoreFileModel.setTag("system_upload_filepath");
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);

        TypeApprovedRequest uploadTARequest = gson.fromJson(deviceDetails, TypeApprovedRequest.class);

        //GrievanceModel grievanceRequest  = gson.fromJson(grievanceDetails, GrievanceModel.class);
        //DeviceManagementRequest deviceManagementRequest  = gson.fromJson(deviceDetails, DeviceManagementRequest.class);
        //TypeApprovedRequest uploadTARequest  = gson.fromJson(deviceDetails, TypeApprovedRequest.class);

        //uploadTARequest.setTxnId(txnNumber);

        //log.info("upload Request for TA " +uploadTARequest.getId());
        //TypeApprovedRequest uploadTARequest = new TypeApprovedRequest();


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
            log.info("uploaded file path on server" + serverFile);
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
            fileCopyRequest.setAppName("TRC Bulk Upload");
            fileCopyRequest.setRemarks("File Copy mango one server to mango2");
            log.info("request passed to for uploaded_file_to_sync DB==" + fileCopyRequest);
            GenricResponse fileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
            log.info("file move api response===" + fileUploadResponse);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }


        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        uploadTARequest.setFileName(file.getOriginalFilename());
        uploadTARequest.setRemarks(remarks);
        uploadTARequest.setRequestType(requestType);
        uploadTARequest.setTransactionId(txnNumber);

        //uploadTARequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        //uploadTARequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        log.info("TA form parameters passed to save file Details " + uploadTARequest);
        response = apiService6Feign.uploadTAFile(uploadTARequest);
        response.setRequestID(txnNumber);
        log.info("response from upload TA api" + response);
        log.info("upload TA exit point.");
        return response;
    }

    //-------------------Get TA Drop down Management Controller-------------------//

    @ResponseBody
    @PostMapping("TRCDropdownList")
    public Map<String, List<?>> TRCDropdown(@RequestBody List<String> list) {
        return apiService6Feign.typeApprovedDropdownFeign(list);

    }


    //-------------------Get Type Equipment Drop down Management Controller-------------------//

    @ResponseBody
    @PostMapping("trc-type-equipment")
    public Map<String, List<?>> TypeEquipmentDropdown(@RequestBody List<String> list) {
        return apiService6Feign.typeOfEquipmentDropdownFeign(list);
    }

    //-------------------Export TA Management Controller-------------------//

    @PostMapping("export-table-details")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody TypeApprovedRequest typeApprovedRequest, HttpSession session, HttpServletRequest request) {
        Object response;
        Integer file = 1;
        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        typeApprovedRequest.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        log.info("Request to Export:::::::::" + typeApprovedRequest);
        response = apiService6Feign.TAExportFeign(typeApprovedRequest, typeApprovedRequest.getPageNo(), typeApprovedRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response Export  api=" + fileExportResponse);
        return fileExportResponse;
    }

    //-------------------Download TA file-------------------//

    @GetMapping("Download-File")
    @ResponseBody
    public FileExportResponse downloadFile(@RequestParam(name = "transactionID", required = true) String transactionID, @RequestParam(name = "fileName", required = true) String fileName, HttpSession session, HttpServletRequest request) {

        FileExportResponse response = new FileExportResponse();
        log.info("inside file download method");
        log.info("fileName---" + fileName + " transactionID " + transactionID);
        addMoreFileModel.setTag("system_upload_filepath");

        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
        log.info("url to download file==" + urlToUpload.getValue());


        String rootPath = urlToUpload.getValue() + "/" + transactionID + "/" + fileName;
        log.info("fileName---" + fileName + " transactionID " + transactionID + "rootPath----" + rootPath);
        response.setFilePath(rootPath);
        response.setFileName(fileName);
        response.setUrl(urlToUpload.getValue());

        return response;
    }
}
