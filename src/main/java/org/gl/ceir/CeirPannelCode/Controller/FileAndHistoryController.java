package org.gl.ceir.CeirPannelCode.Controller;

import org.gl.ceir.CeirPannelCode.Feignclient.DBTablesFeignClient;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.AllRequest;
import org.gl.ceir.CeirPannelCode.Model.DBrowDataModel;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Service.RegistrationService;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.gl.ceir.CeirPannelCode.features.SampeFileRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;

@RequestMapping(value = "/Consignment")
@Controller
public class FileAndHistoryController {
    @Autowired
    PropertyReader propertyReader;


    @Autowired
    AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

    @Autowired

    FeignCleintImplementation feignCleintImplementation;
    @Autowired
    UtilDownload utildownload;
    @Autowired
    DBTablesFeignClient dBTablesFeignClient;
    @Autowired
    DBrowDataModel dBrowDataModel;
    @Autowired
    RegistrationService registerService;

    private final Logger log = LoggerFactory.getLogger(getClass());

    // ************************************************* download file
    // ***************************************************************

    @RequestMapping(value = "/dowloadFiles/{filetype}/{fileName}/{transactionNumber}/{doc_TypeTag}", method = {
            org.springframework.web.bind.annotation.RequestMethod.GET})
    // @RequestMapping(value="/dowloadFiles/{filetype}/{fileName}/{transactionNumber}",method={org.springframework.web.bind.annotation.RequestMethod.GET},
    // headers = {"content-Disposition=attachment"})

    public @ResponseBody FileExportResponse downloadFile(@PathVariable("transactionNumber") String txnid,
                                                         @PathVariable("fileName") String fileName, @PathVariable("filetype") String filetype,
                                                         @PathVariable(name = "doc_TypeTag", required = false) String doc_TypeTag, HttpSession session, HttpServletRequest request) throws IOException {

        FileExportResponse response = new FileExportResponse();
        log.info("inside file download method" + doc_TypeTag);

        addMoreFileModel.setTag("system_upload_filepath");

        urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
        log.info("url to download file==" + urlToUpload.getValue());
        AllRequest allrequest = new AllRequest();
        //UserHeader header=registerService.getUserHeaders(request);
        if (session.getAttribute("usertypeId") == null || session.getAttribute("usertype").equals(null) || session.getAttribute("username").equals(null) || session.getAttribute("userid").equals(null)) {
            allrequest.setUserTypeId(17);
            allrequest.setUserType("End User");
            allrequest.setUserId(0123);
            allrequest.setUsername("End User");
        } else {
            allrequest.setUserTypeId((int) session.getAttribute("usertypeId"));
            allrequest.setUserType(String.valueOf(session.getAttribute("usertype")));
            allrequest.setUserId((int) session.getAttribute("userid"));
            allrequest.setUsername(session.getAttribute("username").toString());
        }
        String txnIDfirstLetter = txnid.substring(0, 1);
        if (txnIDfirstLetter.equalsIgnoreCase("C")) {
            allrequest.setFeatureId(3);
        } else if (txnIDfirstLetter.equalsIgnoreCase("S")) {
            allrequest.setFeatureId(4);
        } else if (txnIDfirstLetter.equalsIgnoreCase("R") || txnIDfirstLetter.equalsIgnoreCase("I") || txnIDfirstLetter.equalsIgnoreCase("A")) {
            allrequest.setFeatureId(12);
        } else if (txnIDfirstLetter.equalsIgnoreCase("B")) {
            allrequest.setFeatureId(7);
        } else if (txnIDfirstLetter.equalsIgnoreCase("L")) {
            allrequest.setFeatureId(5);
        } else if (txnIDfirstLetter.equalsIgnoreCase("T")) {
            allrequest.setFeatureId(21);
        }
        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        allrequest.setPublicIp(session.getAttribute("publicIP").toString());
        allrequest.setBrowser(session.getAttribute("browser").toString());


        if (filetype.equalsIgnoreCase("actual")) {

            if (!doc_TypeTag.equals("DEFAULT")) {
                log.info("doc_TypeTag_______" + doc_TypeTag);
                String rootPath = urlToUpload.getValue() + txnid + "/" + doc_TypeTag + "/";
                File tmpDir = new File(rootPath + fileName);

                boolean exists = tmpDir.exists();
                if (exists) {

                    String extension = fileName.substring(fileName.lastIndexOf("."));
                    log.info("fileExtension===" + extension);

                    if (extension.equalsIgnoreCase(".png") || extension.equalsIgnoreCase(".jpeg")
                            || extension.equalsIgnoreCase(".gif") || extension.equalsIgnoreCase(".jpg")) {
                        response = feignCleintImplementation.downloadFile(txnid, filetype, fileName.replace("%20", " "),
                                doc_TypeTag, allrequest);
                        response.setFilePath("imageType");
                        return response;
                    }
                    log.info("file against document   is exist.");
                } else {
                    log.info(" file against documrnt type   is not exist.");
                    response.setUrl("Not Found");
                    return response;
                }

            } else if (doc_TypeTag.equalsIgnoreCase("DEFAULT")) {
                log.info("doc_TypeTag===" + doc_TypeTag);
                String rootPath = urlToUpload.getValue() + txnid + "/";
                File tmpDir = new File(rootPath + fileName);
                boolean exists = tmpDir.exists();
                if (exists) {

                    log.info("actual file is exist.");
                } else {
                    log.info(" actual file is not exist.");
                    response.setUrl("Not Found");
                    return response;
                }

            }
        } else if (filetype.equalsIgnoreCase("error")) {
            addMoreFileModel.setTag("system_error_filepath");

            urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
            log.info("url to download error  file path ==" + urlToUpload.getValue());
            String rootPath = urlToUpload.getValue() + txnid + "/" + txnid + "_error.csv";
            File tmpDir = new File(rootPath);
            boolean exists = tmpDir.exists();
            if (exists) {
                log.info(" error file is exist.");
            } else {
                log.info(" error file is not exist.");
                response.setUrl("Not Found");
                return response;
            }

        }

        log.info(" everything is fine for hit to api for file downloading");
        log.info("request send to the download file api= txnid(" + txnid + ") fileName (" + fileName + ") fileType ("
                + filetype + ")" + doc_TypeTag + "  ip and browser==" + allrequest);
        response = feignCleintImplementation.downloadFile(txnid, filetype, fileName.replace("%20", " "), doc_TypeTag, allrequest);

        log.info("response of download api=" + response + "------------------" + fileName.replace("%20", " "));
        log.info("redirect:" + response.getUrl());
        // ModelAndView mv= new ModelAndView(("redirect:"+
        // URLEncoder.encode(response.getUrl(), "UTF-8")));

        /*
         * File file = new File(response.getUrl()); if(file.exists()){
         * log.info("file is exist "); return response.getUrl(); } else {
         * log.info("file is Not exist "); return null; }
         */
        return response;
    }

    // *********************************************** Download Sampmle file
    // *************************************************
    @RequestMapping(value = "/sampleFileDownload/{featureId}", method = {
            org.springframework.web.bind.annotation.RequestMethod.GET})
    public String downloadSampleFile(@PathVariable("featureId") String featureId, @RequestParam(name = "hostname", required = false) String hostname, HttpSession session, HttpServletRequest request) throws IOException, URISyntaxException {

        int featureIdForFile = Integer.parseInt(featureId);
        AllRequest allrequest = new AllRequest();
        // UserHeader header=registerService.getUserHeaders(request);

        /*
         * int userTypeid=(int) session.getAttribute("usertypeId"); String
         * roleType=String.valueOf(session.getAttribute("usertype")); String
         * userName=session.getAttribute("username").toString(); int userId= (int)
         * session.getAttribute("userid");
         */
        if (session.getAttribute("usertypeId") == null || session.getAttribute("usertype").equals(null) || session.getAttribute("username").equals(null) || session.getAttribute("userid").equals(null)) {
            allrequest.setUserTypeId(17);
            allrequest.setUserType("End User");
            allrequest.setUserId(0123);
            allrequest.setUsername("End User");
        } else {
            allrequest.setUserTypeId((int) session.getAttribute("usertypeId"));
            allrequest.setUserType(String.valueOf(session.getAttribute("usertype")));
            allrequest.setUserId((int) session.getAttribute("userid"));
            allrequest.setUsername(session.getAttribute("username").toString());
        }

        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        allrequest.setPublicIp(session.getAttribute("publicIP").toString());
        allrequest.setBrowser(session.getAttribute("browser").toString());

        log.info(" featureIdForFile==" + featureIdForFile + "  request send to the sample file download api=" + allrequest);
        FileExportResponse response = feignCleintImplementation.downloadSampleFile(featureIdForFile, allrequest);
        return "redirect:" + response.getUrl();

    }


    @PostMapping("/sampleFileDownloads")
    public ResponseEntity<?> downloadSampleFile(@RequestBody SampeFileRequest sampeFileRequest, HttpSession session, HttpServletRequest request) throws IOException, URISyntaxException {
        String domainName = sampeFileRequest.getCurrentContextPath();
        int featureIdForFile = sampeFileRequest.getFeatureId();
        AllRequest allrequest = new AllRequest();
        allrequest.setType(sampeFileRequest.getType());
        if (session.getAttribute("usertypeId") == null || session.getAttribute("usertype").equals(null) || session.getAttribute("username").equals(null) || session.getAttribute("userid").equals(null)) {
            allrequest.setUserTypeId(17);
            allrequest.setUserType("End User");
            allrequest.setUserId(0123);
            allrequest.setUsername("End User");
        } else {
            allrequest.setUserTypeId((int) session.getAttribute("usertypeId"));
            allrequest.setUserType(String.valueOf(session.getAttribute("usertype")));
            allrequest.setUserId((int) session.getAttribute("userid"));
            allrequest.setUsername(session.getAttribute("username").toString());
        }

        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        allrequest.setPublicIp(session.getAttribute("publicIP").toString());
        allrequest.setBrowser(session.getAttribute("browser").toString());

        log.info(" featureIdForFile==" + featureIdForFile + "  request send to the sample file download api=" + allrequest);
        FileExportResponse response = feignCleintImplementation.downloadSampleFile(featureIdForFile, allrequest);
        log.info("response from sample file download file " + response);
        URI uri = new URI(response.getUrl().replaceAll(" ", "%20"));
        String path = uri.getPath();
        String finalPath = domainName + "" + path;
        log.info("file download location [" + finalPath + "]");
        SampeFileRequest finalUrl = new SampeFileRequest();
        finalUrl.setUrl(finalPath);
        return new ResponseEntity<>(finalUrl, HttpStatus.OK);

    }
    @PostMapping("/downloadSampleFileBulk")
    public ResponseEntity<?> downloadSampleFileBulk(@RequestBody SampeFileRequest sampeFileRequest, HttpSession session, HttpServletRequest request) throws IOException, URISyntaxException {
        String domainName = sampeFileRequest.getCurrentContextPath();
        int featureIdForFile = sampeFileRequest.getFeatureId();
        AllRequest allrequest = new AllRequest();
        allrequest.setType(sampeFileRequest.getType());
        if (session.getAttribute("usertypeId") == null || session.getAttribute("usertype").equals(null) || session.getAttribute("username").equals(null) || session.getAttribute("userid").equals(null)) {
            allrequest.setUserTypeId(17);
            allrequest.setUserType("End User");
            allrequest.setUserId(0123);
            allrequest.setUsername("End User");
        } else {
            allrequest.setUserTypeId((int) session.getAttribute("usertypeId"));
            allrequest.setUserType(String.valueOf(session.getAttribute("usertype")));
            allrequest.setUserId((int) session.getAttribute("userid"));
            allrequest.setUsername(session.getAttribute("username").toString());
        }

        log.info("publicIP " + session.getAttribute("publicIP").toString() + " And Browser " + session.getAttribute("browser").toString());
        allrequest.setPublicIp(session.getAttribute("publicIP").toString());
        allrequest.setBrowser(session.getAttribute("browser").toString());

        log.info(" featureIdForFile==" + featureIdForFile + "  request send to the sample file download api=" + allrequest);
        FileExportResponse response = feignCleintImplementation.downloadSampleFile(featureIdForFile, allrequest);
        log.info("response from sample file download file " + response);
        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    // consignment History

    @RequestMapping(value = "/ManualFileDownload", method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    public ResponseEntity<?> ManualSampleFile(@RequestBody SampeFileRequest sampleFileRequest, HttpSession session) throws URISyntaxException {
        String domainName = sampleFileRequest.getCurrentContextPath();
        String userTypeId = session.getAttribute("usertypeId").toString();
        AllRequest allrequest = new AllRequest();
       // allrequest.setType(sampleFileRequest.getType());
        String roleType = String.valueOf(session.getAttribute("usertype"));
        String userName = session.getAttribute("username").toString();
        int userId = (int) session.getAttribute("userid");
        allrequest.setUserTypeId(Long.parseLong(userTypeId));
        allrequest.setUserType(roleType);
        allrequest.setUserId(userId);
        allrequest.setUsername(userName);
        allrequest.setPublicIp(session.getAttribute("publicIP").toString());
        allrequest.setBrowser(session.getAttribute("browser").toString());
        log.info("request send to the manual sample file download api==" + allrequest);
        SampeFileRequest finalUrl = new SampeFileRequest();
        try {
            FileExportResponse fileExportResponse = feignCleintImplementation.manualDownloadSampleFile(allrequest);
            log.info("response from manual file download file " + fileExportResponse);

            // log.info("manual file download file url" + url);
            URI uri = new URI(fileExportResponse.getUrl().replaceAll(" ", "%20"));
            log.info("manual file download file uri" + uri);
            String path = uri.getPath();
            String finalPath = domainName + "" + path;
            log.info("file download location [" + finalPath + "]");
            finalUrl.setUrl(finalPath);
            return new ResponseEntity<>(finalUrl, HttpStatus.OK);
        } catch (Exception e) {
            log.info("No file found {}", e.getMessage());
            return new ResponseEntity<>(finalUrl.setUrl(null), HttpStatus.OK);

        }



  /*      try {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

            String file = fileLocation + "" + fileName;
            InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

            FileCopyUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
        } catch (Exception e) {
            log.info("" + e.toString());
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"File_not_exist\"");
        }*/
    }
}
