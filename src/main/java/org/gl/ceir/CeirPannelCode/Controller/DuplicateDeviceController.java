package org.gl.ceir.CeirPannelCode.Controller;


import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
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

@Controller
public class DuplicateDeviceController {

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
    private FileCopierFeignClient fileCopierFeignClient;

    @Autowired
    DeviceRepositoryFeign deviceRepositoryFeign;

    GenricResponse response = new GenricResponse();

    @RequestMapping(value = {"/duplicateDevice"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST})
    public ModelAndView viewManageTypeAdmin(@RequestParam(name = "FeatureId", required = false) String featureId,HttpSession session) {
        ModelAndView mv = new ModelAndView();
        log.info(" view Duplicate Device entry point.");
        mv.addObject("featureId", featureId);
        mv.setViewName("viewDuplicateDevice");
        log.info(" view Duplicate Device exit point..");
        return mv;
    }


    //------------------------------------- view Approved Device ----------------------------------------

    @PostMapping("view")
    public @ResponseBody GenricResponse viewApprovedDevice(@RequestBody DuplicateDeviceRequest duplicateDeviceRequest, HttpSession session) {
        duplicateDeviceRequest.setPublicIp(session.getAttribute("publicIP").toString());
        duplicateDeviceRequest.setBrowser(session.getAttribute("browser").toString());
        log.info("Get Device Details for ID= " + duplicateDeviceRequest.getId());
        log.info("duplicateDeviceRequest = " + duplicateDeviceRequest);
        GenricResponse response = deviceRepositoryFeign.viewApprovedDeviceFeign(duplicateDeviceRequest);
        log.info("response " + response);
        return response;
    }

    //-------------------Export Duplicate Device Controller-------------------//

    @PostMapping("export-duplicate-details")
    @ResponseBody
    public FileExportResponse exportToExcel(@RequestBody DuplicateDeviceRequest duplicateDeviceRequest, HttpSession session, HttpServletRequest request) {
        Object response;
        Integer file = 1;
        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        duplicateDeviceRequest.setBrowser(session.getAttribute("browser").toString());
        duplicateDeviceRequest.setPublicIp(session.getAttribute("publicIP").toString());
        log.info("Request to Export:::::::::" + duplicateDeviceRequest);
        response = deviceRepositoryFeign.exportDuplicateData(duplicateDeviceRequest, duplicateDeviceRequest.getPageNo(), duplicateDeviceRequest.getPageSize(), file);
        FileExportResponse fileExportResponse;
        Gson gson = new Gson();
        String apiResponse = gson.toJson(response);
        fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
        log.info("response Export  api=" + fileExportResponse);
        return fileExportResponse;
    }

    //-------------------Approve Duplicate Device Controller-------------------//

    @RequestMapping(value = {"/approveDevice"}, method = RequestMethod.POST, consumes = "multipart/form-data")
    public @ResponseBody GenricResponse approveDevice(@RequestParam(name = "file1", required = false) MultipartFile fileUpload1, @RequestParam(name = "file2", required = false) MultipartFile fileUpload2, @RequestParam(name = "file3", required = false) MultipartFile fileUpload3, @RequestParam(name = "file4", required = false) MultipartFile fileUpload4, @RequestParam(name = "id", required = false) Integer id, HttpServletRequest request, HttpSession session) {

        log.info("fileUpload1=" + fileUpload1);
        log.info("fileUpload2=" + fileUpload2);
        log.info("fileUpload3=" + fileUpload3);
        log.info("fileUpload4=" + fileUpload4);

        Gson gson = new Gson();
        String deviceDetails = request.getParameter("multirequest").replace("&#34;", "\"");
        log.info("upload request------" + deviceDetails);
        addMoreFileModel.setTag("system_upload_filepath");
        String txnNumber = "T" + utildownload.getTxnId();
        log.info("Random transaction id number=" + txnNumber);

        addMoreFileModel.setTag("system_upload_filepath");
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);

        DuplicateDeviceRequest approveRequest = gson.fromJson(deviceDetails, DuplicateDeviceRequest.class);

        try {
            for (int i = 1; i <= 4; i++) {
                MultipartFile currentFile = null;
                String currentDocumentType = null;


                switch (i) {
                    case 1:
                        currentFile = fileUpload1;
                        currentDocumentType = approveRequest.getDocumentType1();
                        log.info("case 1 " + i + " fileUpload1 " + fileUpload1);
                        break;
                    case 2:
                        currentFile = fileUpload2;
                        currentDocumentType = approveRequest.getDocumentType2();
                        log.info("case 2 " + i + " fileUpload2 " + fileUpload2);
                        break;
                    case 3:
                        currentFile = fileUpload3;
                        currentDocumentType = approveRequest.getDocumentType3();
                        log.info("case 3 " + i + " fileUpload3 " + fileUpload3);
                        break;
                    case 4:
                        currentFile = fileUpload4;
                        currentDocumentType = approveRequest.getDocumentType4();
                        log.info("case 4 " + i + " fileUpload4 " + fileUpload4);
                        break;
                    default:
                        break;
                }

                if (currentFile != null && !currentFile.isEmpty()) {
                    log.info("File " + i + " processed successfully.");
                    byte[] bytes = currentFile.getBytes();
                    String rootPath = urlToUpload.getValue() + txnNumber + "/" + currentDocumentType + "/";
                    File dir = new File(rootPath + File.separator);

                    if (!dir.exists()) {
                        dir.mkdirs();
                        dir.setExecutable(true, false);
                        dir.setReadable(true, false);
                        dir.setWritable(true, false);
                    }
                    // Create the file on server
                    File serverFile = new File(rootPath + currentFile.getOriginalFilename());
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
                    fileCopyRequest.setSourceFileName(currentFile.getOriginalFilename());
                    fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
                    fileCopyRequest.setAppName("Duplicate Files Upload");
                    fileCopyRequest.setRemarks("File Copy mango one server to mango2");
                    log.info("request passed to for uploaded_file_to_sync DB==" + fileCopyRequest);
                    GenricResponse fileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
                    log.info("file move api response===" + fileUploadResponse);
                } else {
                    log.info("File " + i + " not processed.");
                }
            }

        } catch (Exception e) {
            // Handle exception
            e.printStackTrace();
        }

        approveRequest.setBrowser(session.getAttribute("browser").toString());
        approveRequest.setPublicIp(session.getAttribute("publicIP").toString());
        approveRequest.setStatus("ORIGINAL");
        approveRequest.setApproveTransactionId(txnNumber);
        log.info("approve request file Details " + approveRequest);
        response = deviceRepositoryFeign.approveDuplicateDevice(approveRequest);
        log.info("response from approve api" + response);
        return response;

    }


}
