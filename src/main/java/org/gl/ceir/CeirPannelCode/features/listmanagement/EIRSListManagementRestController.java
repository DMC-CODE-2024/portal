package org.gl.ceir.CeirPannelCode.features.listmanagement;

import com.google.gson.Gson;
import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.FileCopierFeignClient;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.EIRSListManagementEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;

@RestController
@RequestMapping("/eirs-list-management")
public class EIRSListManagementRestController {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    UtilDownload utildownload;
    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;
    @Autowired
    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    PropertyReader propertyReader;

    @Autowired
    GsmaFeignClient gsmaFeignClient;
    GenricResponse response = new GenricResponse();
    private EIRSListManagementService eirsListManagementService;
    private APIService6Feign apiService6Feign;
    private FileCopierFeignClient fileCopierFeignClient;

    public EIRSListManagementRestController(EIRSListManagementService eirsListManagementService, FileCopierFeignClient fileCopierFeignClient, APIService6Feign apiService6Feign) {
        this.eirsListManagementService = eirsListManagementService;
        this.apiService6Feign = apiService6Feign;
        this.fileCopierFeignClient = fileCopierFeignClient;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return eirsListManagementService.paging(request, session);
    }

    @PostMapping
    public Object findByID(@RequestBody EIRSListManagementEntity eirsListManagementEntity) {
        return apiService6Feign.findByID(eirsListManagementEntity);
    }


    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return eirsListManagementService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody EIRSListManagementEntity eirsListManagementEntity, HttpSession session) {
        return eirsListManagementService.export(eirsListManagementEntity, session);
    }

    @RequestMapping(value = {"/single"})
    public GenricResponse singleRequest(@RequestBody EIRSListManagementEntity eirsListManagementEntity, HttpServletRequest request, HttpSession session) {

        String txnNumber = "T" + utildownload.getTxnId();
        logger.info("Random transaction id number=" + txnNumber);
        logger.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        eirsListManagementEntity.setTransactionId(txnNumber);
        eirsListManagementEntity.setUserId(String.valueOf(eirsListManagementEntity.getAuditTrailModel().getUserId()));
        eirsListManagementEntity.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        eirsListManagementEntity.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        logger.info("payload : " + eirsListManagementEntity);
        GenricResponse singleRequestResponse = apiService6Feign.single(eirsListManagementEntity);
        singleRequestResponse.setRequestID(txnNumber);
        logger.info("singleRequestResponse " + singleRequestResponse);
        return singleRequestResponse;
    }


    @RequestMapping(value = {"/bulk"}, method = RequestMethod.POST, consumes = "multipart/form-data")
    public GenricResponse uploadTAFile(@RequestParam(name = "file", required = false) MultipartFile file, HttpServletRequest request, HttpSession session) {
/*        String filter = request.getParameter("model").replace("&#34;", "\"");
        logger.info("filter payload [" + filter + "]");*/
        Gson gsonObject = new Gson();
        String model = HtmlUtils.htmlUnescape(request.getParameter("model"));
        logger.info("model" + model);
        EIRSListManagementEntity eirsListManagementEntity = gsonObject.fromJson(model, EIRSListManagementEntity.class);
        logger.info("exceptionListEntity request------" + eirsListManagementEntity);
        String deviceDetails = request.getParameter("multirequest");
        logger.info("upload request------" + deviceDetails);
        logger.info("fileUpload------" + file.getOriginalFilename());

        String txnNumber = "T" + utildownload.getTxnId();
        logger.info("Random transaction id number=" + txnNumber);
        //String filter = request.getParameter("request");
        //  FileCopyToOtherServer fileCopyRequest = new FileCopyToOtherServer();

        addMoreFileModel.setTag("system_upload_filepath");
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
        // EIRSListManagementEntity payload = new EIRSListManagementEntity();

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
            logger.info("uploaded file path on server" + serverFile);
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
            fileCopyRequest.setAppName("List Management Bulk Upload");
            fileCopyRequest.setRemarks("File Copy mango one server to mango2");
            logger.info("request passed to for uploaded_file_to_sync DB==" + fileCopyRequest);
            GenricResponse fileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
            logger.info("file move api response===" + fileUploadResponse);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }


        logger.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        eirsListManagementEntity.setFileName(file.getOriginalFilename());
        eirsListManagementEntity.setTransactionId(txnNumber);
        eirsListManagementEntity.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        eirsListManagementEntity.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        logger.info("bulk form parameters passed to save file Details " + eirsListManagementEntity);
        GenricResponse bulkResponse = apiService6Feign.single(eirsListManagementEntity);
        bulkResponse.setRequestID(txnNumber);
        logger.info("bulk request response " + eirsListManagementEntity);
        return bulkResponse;
    }


    @GetMapping("/download")
    public FileExportResponse downloadFile(@RequestParam(name = "transactionID", required = true) String transactionID, @RequestParam(name = "fileName", required = true) String fileName, @RequestParam(name = "type", required = true) String type, HttpSession session, HttpServletRequest request) {
        String rootPath = null;
        FileExportResponse response = new FileExportResponse();
        logger.info("inside file download method");
        logger.info("fileName---" + fileName + " transactionID " + transactionID);
        if (type.equalsIgnoreCase("processed")) {
            addMoreFileModel.setTag("upload_file_link");
        } else {
            addMoreFileModel.setTag("system_upload_filepath");
        }
        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
        logger.info("url to download file==" + urlToUpload.getValue());
        rootPath = urlToUpload.getValue() + "/" + transactionID + "/" + fileName;
        logger.info("fileName---" + fileName + " transactionID " + transactionID + "rootPath----" + rootPath);
        response.setFilePath(rootPath);
        response.setFileName(fileName);
        response.setUrl(urlToUpload.getValue());
        return response;
    }
}
