package org.gl.ceir.CeirPannelCode.Controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.gl.ceir.CeirPannelCode.features.pairdevice.model.LocResponse;
import org.apache.commons.lang3.StringEscapeUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.FileCopierFeignClient;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class PoliceStolenController {


	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	UtilDownload utildownload;

	@Autowired
	PropertyReader propertyReader;

	@Autowired
	AddMoreFileModel addMoreFileModel, urlToUpload, urlToMove;

	@Autowired

	FeignCleintImplementation feignCleintImplementation;

	@Autowired
	FileCopierFeignClient fileCopierFeignClient;

	@RequestMapping(value = {"/requestStolenRecovery"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST})
	public ModelAndView viewLostStolenRecovery(HttpSession session, HttpServletRequest request,
											   @RequestParam(name = "type", required = false, defaultValue = "0") Integer type, @RequestParam(name = "lang", required = false, defaultValue = "en") String lang) {
		ModelAndView mv = new ModelAndView();
		String locUrl = propertyReader.locationFeignClientPath;
		String testing = propertyReader.testing;
		mv.addObject("lang", lang);
		String ipAddress = request.getRemoteAddr();
		log.info("request send to the get location api=" + locUrl + " and IP Is [" + ipAddress + "] and test status [" + testing + "]");
		try {
			if (testing.equalsIgnoreCase("true")) {
				if (!checkLocation(ipAddress, locUrl)) {
					log.info("Non cambodian user ,returing to error page");
					mv.setViewName("NonCambodianUser");
					return mv;
				}
			}

		} catch (IOException e1) {
			// TODO Auto-generated catch block
			log.info("ip locaton error." + e1);
		}
		try {

			if (type == 0) {
				mv.setViewName("LostStolen");
			} else if (type == 1) {
				mv.setViewName("FoundRecovery");
			} else if (type == 2) {
				mv.setViewName("CheckRequestID");
			}

		} catch (Exception e) {
			// TODO: handle exception
			log.info("this is catch block session is blank or something went wrong." + e);
		}

		return mv;
	}

	@RequestMapping(value = {"/viewPoliceBulkViewDetails"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST})
	public ModelAndView viewPoliceBulkViewDetails(HttpSession session, HttpServletRequest request,
		@RequestParam(name = "featureId", required = false) String featureId,
		@RequestParam(name = "requestId", required = true) String requestId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("requestId", requestId);
		mv.addObject("featureId", featureId);
		mv.setViewName("viewBulkStolenDeviceDetail");
		return mv;
	}


	@RequestMapping(value = {"/viewPoliceSingleViewDetails"}, method = {org.springframework.web.bind.annotation.RequestMethod.GET, org.springframework.web.bind.annotation.RequestMethod.POST})
	public ModelAndView viewPoliceSingleViewDetails(HttpSession session, HttpServletRequest request,
	@RequestParam(name = "requestId", required = true) String requestId,
    @RequestParam(name = "featureId", required = false) String featureId) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("requestId", requestId);
		mv.addObject("featureId", featureId);
		mv.setViewName("policeSingleViewDetails");
		return mv;
	}
	@RequestMapping(value=
			{"/policeStolenLostDevice"},method={org.springframework.web.bind.annotation.
			RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
	)
	public ModelAndView viewManageTypeAdmin(HttpSession session,
        @RequestParam(name = "featureId", required = false) String featureId) {
		ModelAndView mv = new ModelAndView();
		log.info(" open Police single Device entry point.");
		//mv.setViewName("viewStolenPoliceVerificationDevice");
		mv.setViewName("policeStolenRequest");
		mv.addObject("featureId", featureId);
		//mv.setViewName("policeBulkStolenRequest");
		log.info(" open  Police Verification Device exit point..");
		return mv;
	}

	@RequestMapping(value=
			{"/policeBulkStolenLostDevice"},method={org.springframework.web.bind.annotation.
			RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
	)
	public ModelAndView policeBulkStolenLostDevice(HttpSession session,
	@RequestParam(name = "featureId", required = false) String featureId) {
		ModelAndView mv = new ModelAndView();
		log.info(" open  Police buk Stolen Verification Device entry point.");
		//mv.setViewName("viewStolenPoliceVerificationDevice");
		//mv.setViewName("policeStolenRequest");
		mv.setViewName("policeBulkStolenRequest");
		mv.addObject("featureId", featureId);
		log.info(" open  Police buk Stolen Verification Device exit point..");
		return mv;
	}

	public boolean checkLocation(String ip, String url) throws IOException {
		String ipType = "ipv4";
		if (ip.contains(":")) {
			ipType = "ipv6";
		}
		String json = "{\"ip\":\"" + ip + "\",\"ipType\":\"" + ipType + "\"}";
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("POST");
		con.setRequestProperty("Content-Type", "application/json");
		con.setDoOutput(true);

		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(json);
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();
		System.out.println("Response Code: " + responseCode);
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		log.info("location response from api " + response.toString());
		Gson gson = new Gson();
		LocResponse resp = gson.fromJson(response.toString(), LocResponse.class);
		log.info("Gson location response from api " + resp.toString());
		if (resp.getStatusCode() == 202 || resp.getStatusCode() == 200) {
			return true;
		} else {
			return false;
		}
		//return response.toString();
	}


	@RequestMapping(value = {"/lostStolenSave"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	public @ResponseBody GenricResponse register(@RequestParam(name = "file", required = false) MultipartFile file,
												 @RequestParam(name = "nidFileName", required = false) MultipartFile nidFileName,
												 @RequestParam(name = "firCopy", required = false) MultipartFile firCopy,
												 @RequestParam(name = "otherDocument", required = false) MultipartFile otherDocument,
												 HttpServletRequest request, HttpSession session) {
		log.info("inside controller lost Stolen-------request---------" + request.getParameter("request"));
		String txnNumber = "L" + utildownload.getTxnId();
		log.info("Random transaction id number=" + txnNumber);
		CopyFileRequest fileCopyRequest = new CopyFileRequest();
		ArrayList<Destination> destination = new ArrayList<Destination>();
		Destination dest = new Destination();
		CopyFileRequest fileCopyRequest1 = new CopyFileRequest();
		ArrayList<Destination> destination1 = new ArrayList<Destination>();
		Destination dest1 = new Destination();
		//String filter = request.getParameter("request").replace("&#34;", "\"").replace("&#64;", "@");
		String filter = StringEscapeUtils.unescapeHtml4(request.getParameter("request"));
		addMoreFileModel.setTag("system_upload_filepath");
		urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
		try {

			byte[] bytes = file.getBytes();
			String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
			File dir = new File(rootPath + File.separator);
			File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
			if (!dir.exists()) {
				dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
				dir.setReadable(true, false);
				dir.setWritable(true, false);
				dir.setExecutable(true, false);
				dir1.setReadable(true, false);
				dir1.setWritable(true, false);
				dir1.setExecutable(true, false);
			}
			File serverFile = new File(rootPath + file.getOriginalFilename());
			log.info("uploaded file path on server" + serverFile);
			BufferedOutputStream
					stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			serverFile.setExecutable(true, false);
			serverFile.setReadable(true, false);
			serverFile.setWritable(true, false);
			stream.write(bytes);
			stream.close();
			//dest.setDestFilePath(rootPath);
			dest.setDestFilePath(propertyReader.destFilePath + txnNumber);
			dest.setDestServerName(propertyReader.destServerName);
			destination.add(dest);
			fileCopyRequest.setDestination(destination);
			fileCopyRequest.setSourceFilePath(rootPath);
			fileCopyRequest.setTxnId(txnNumber);
			fileCopyRequest.setSourceFileName(file.getOriginalFilename());
			fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
			fileCopyRequest.setAppName("Bulk File Upload");
			fileCopyRequest.setRemarks("File Copy from primary  server to secondary server");
			log.info("request passed to for uploaded_file_to_sync DB Mobile invoice==" + fileCopyRequest);
			GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
			log.info("file move api response Mobile invoice===" + FileUploadResponse);
			//  grievanceRequest.setFileName(file.getOriginalFilename());

		} catch (Exception e) { //
			// TODO: handle exception e.printStackTrace(); }

			// set reaquest parameters into model class

		}

		try {

			byte[] bytes = nidFileName.getBytes();
			String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
			File dir = new File(rootPath + File.separator);
			File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
			if (!dir.exists()) {
				dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
				dir.setReadable(true, false);
				dir.setWritable(true, false);
				dir.setExecutable(true, false);
				dir1.setReadable(true, false);
				dir1.setWritable(true, false);
				dir1.setExecutable(true, false);
			}
			File serverFile = new File(rootPath + nidFileName.getOriginalFilename());
			log.info("uploaded nid file  on server" + serverFile);
			BufferedOutputStream
					stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			serverFile.setExecutable(true, false);
			serverFile.setReadable(true, false);
			serverFile.setWritable(true, false);
			stream.write(bytes);
			stream.close();
			//	dest1.setDestFilePath(rootPath);
			dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
			dest1.setDestServerName(propertyReader.destServerName);
			destination1.add(dest1);
			fileCopyRequest1.setDestination(destination1);
			fileCopyRequest1.setSourceFilePath(rootPath);
			fileCopyRequest1.setTxnId(txnNumber);
			fileCopyRequest1.setSourceFileName(nidFileName.getOriginalFilename());
			fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
			fileCopyRequest1.setAppName("Bulk File Upload");
			fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
			log.info("request passed to for uploaded_file_to_sync DB in fir copy file  upload==" + fileCopyRequest1);
			GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
			log.info("file move api response NID file  upload===" + FileUploadResponse);
			//  grievanceRequest.setFileName(file.getOriginalFilename());

		} catch (Exception e) { //
			// TODO: handle exception e.printStackTrace(); }

			// set reaquest parameters into model class

		}
		try {

			byte[] bytes = firCopy.getBytes();
			String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
			File dir = new File(rootPath + File.separator);
			File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
			if (!dir.exists()) {
				dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
				dir.setReadable(true, false);
				dir.setWritable(true, false);
				dir.setExecutable(true, false);
				dir1.setReadable(true, false);
				dir1.setWritable(true, false);
				dir1.setExecutable(true, false);
			}
			File serverFile = new File(rootPath + firCopy.getOriginalFilename());
			log.info("uploaded fir file  on server" + serverFile);
			BufferedOutputStream
					stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			serverFile.setExecutable(true, false);
			serverFile.setReadable(true, false);
			serverFile.setWritable(true, false);
			stream.write(bytes);
			stream.close();
			//	dest1.setDestFilePath(rootPath);
			dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
			dest1.setDestServerName(propertyReader.destServerName);
			destination1.add(dest1);
			fileCopyRequest1.setDestination(destination1);
			fileCopyRequest1.setSourceFilePath(rootPath);
			fileCopyRequest1.setTxnId(txnNumber);
			fileCopyRequest1.setSourceFileName(firCopy.getOriginalFilename());
			fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
			fileCopyRequest1.setAppName("Bulk File Upload");
			fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
			log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
			GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
			log.info("file move api response NID file  upload===" + FileUploadResponse);


		} catch (Exception e) { //
			// TODO: handle exception e.printStackTrace(); }

			// set reaquest parameters into model class

		}
		if(otherDocument!=null) {
			try {

				byte[] bytes = otherDocument.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + otherDocument.getOriginalFilename());
				log.info("uploaded other document file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(txnNumber);
				fileCopyRequest1.setSourceFileName(otherDocument.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);


			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}

		Gson gson = new Gson();
		LostStolenModel lawfulIndividualStolen = gson.fromJson(filter, LostStolenModel.class);
		lawfulIndividualStolen.setRequestId(txnNumber);
		lawfulIndividualStolen.setRequestType("Stolen");
		lawfulIndividualStolen.setMobileInvoiceBill(file.getOriginalFilename());
		String userAgent = request.getHeader("User-Agent");
		String ip = request.getRemoteAddr();
		lawfulIndividualStolen.setPublicIp(ip);
		lawfulIndividualStolen.setUserAgent(userAgent);
		lawfulIndividualStolen.setBrowser(getBrowser(userAgent));
		lawfulIndividualStolen.setCreatedBy(lawfulIndividualStolen.getUsername());
		lawfulIndividualStolen.setRequestMode("Single");
		lawfulIndividualStolen.setFirCopyUrl(firCopy.getOriginalFilename());
		lawfulIndividualStolen.setDeviceOwnerNationalIdUrl(nidFileName.getOriginalFilename());

		if(otherDocument!=null) {
			lawfulIndividualStolen.setOtherDocument(otherDocument.getOriginalFilename());
		}
		log.info("request passed to the police save stolen device api" + lawfulIndividualStolen);
		GenricResponse response = new GenricResponse();
		try {
			response = feignCleintImplementation.saveStolenDevicePolice(lawfulIndividualStolen);
			log.info("response from police save stolen device api" + response);
		} catch (Exception e) {
			// TODO: handle exception
			log.info("exception in stolen lost" + e);
			e.printStackTrace();
		}
		return response;
	}



	@RequestMapping(value = {"/lostStolenSaveBulk"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	public @ResponseBody GenricResponse saveBulkStolenFile(@RequestParam(name = "file", required = false) MultipartFile file,
	@RequestParam(name = "nidFileName", required = false) MultipartFile nidFileName,
	@RequestParam(name = "firCopy", required = false) MultipartFile firCopy,
	@RequestParam(name = "otherDocument", required = false) MultipartFile otherDocument,
	@RequestParam(name = "bulkFile", required = false) MultipartFile bulkFile,
	HttpServletRequest request, HttpSession session) {

		String txnNumber = "L" + utildownload.getTxnId();
		CopyFileRequest fileCopyRequest = new CopyFileRequest();
		ArrayList<Destination> destination = new ArrayList<Destination>();
		Destination dest = new Destination();
		CopyFileRequest fileCopyRequest1 = new CopyFileRequest();
		ArrayList<Destination> destination1 = new ArrayList<Destination>();
		Destination dest1 = new Destination();
		//String filter = request.getParameter("request").replace("&#34;", "\"").replace("&#64;", "@");
		String filter = StringEscapeUtils.unescapeHtml4(request.getParameter("request"));
		addMoreFileModel.setTag("system_upload_filepath");
		urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
		try {

			byte[] bytes = file.getBytes();
			String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
			File dir = new File(rootPath + File.separator);
			File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
			if (!dir.exists()) {
				dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
				dir.setReadable(true, false);
				dir.setWritable(true, false);
				dir.setExecutable(true, false);
				dir1.setReadable(true, false);
				dir1.setWritable(true, false);
				dir1.setExecutable(true, false);
			}
			File serverFile = new File(rootPath + file.getOriginalFilename());
			log.info("uploaded file path on server" + serverFile);
			BufferedOutputStream
					stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			serverFile.setExecutable(true, false);
			serverFile.setReadable(true, false);
			serverFile.setWritable(true, false);
			stream.write(bytes);
			stream.close();
			//dest.setDestFilePath(rootPath);
			dest.setDestFilePath(propertyReader.destFilePath + txnNumber);
			dest.setDestServerName(propertyReader.destServerName);
			destination.add(dest);
			fileCopyRequest.setDestination(destination);
			fileCopyRequest.setSourceFilePath(rootPath);
			fileCopyRequest.setTxnId(txnNumber);
			fileCopyRequest.setSourceFileName(file.getOriginalFilename());
			fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
			fileCopyRequest.setAppName("Bulk File Upload");
			fileCopyRequest.setRemarks("File Copy from primary  server to secondary server");
			log.info("request passed to for uploaded_file_to_sync DB Mobile invoice==" + fileCopyRequest);
			GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
			log.info("file move api response Mobile invoice===" + FileUploadResponse);
			//  grievanceRequest.setFileName(file.getOriginalFilename());

		} catch (Exception e) { //
			// TODO: handle exception e.printStackTrace(); }

			// set reaquest parameters into model class

		}

		try {

			byte[] bytes = nidFileName.getBytes();
			String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
			File dir = new File(rootPath + File.separator);
			File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
			if (!dir.exists()) {
				dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
				dir.setReadable(true, false);
				dir.setWritable(true, false);
				dir.setExecutable(true, false);
				dir1.setReadable(true, false);
				dir1.setWritable(true, false);
				dir1.setExecutable(true, false);
			}
			File serverFile = new File(rootPath + nidFileName.getOriginalFilename());
			log.info("uploaded nid file  on server" + serverFile);
			BufferedOutputStream
					stream = new BufferedOutputStream(new FileOutputStream(serverFile));
			serverFile.setExecutable(true, false);
			serverFile.setReadable(true, false);
			serverFile.setWritable(true, false);
			stream.write(bytes);
			stream.close();
			//	dest1.setDestFilePath(rootPath);
			dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
			dest1.setDestServerName(propertyReader.destServerName);
			destination1.add(dest1);
			fileCopyRequest1.setDestination(destination1);
			fileCopyRequest1.setSourceFilePath(rootPath);
			fileCopyRequest1.setTxnId(txnNumber);
			fileCopyRequest1.setSourceFileName(nidFileName.getOriginalFilename());
			fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
			fileCopyRequest1.setAppName("Bulk File Upload");
			fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
			log.info("request passed to for uploaded_file_to_sync DB in fir copy file  upload==" + fileCopyRequest1);
			GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
			log.info("file move api response NID file  upload===" + FileUploadResponse);
			//  grievanceRequest.setFileName(file.getOriginalFilename());

		} catch (Exception e) { //
			// TODO: handle exception e.printStackTrace(); }

			// set reaquest parameters into model class

		}
		if(firCopy!=null) {
			try {

				byte[] bytes = firCopy.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + firCopy.getOriginalFilename());
				log.info("uploaded fir file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(txnNumber);
				fileCopyRequest1.setSourceFileName(firCopy.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);


			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}
		if(otherDocument!=null) {
			try {

				byte[] bytes = otherDocument.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + otherDocument.getOriginalFilename());
				log.info("uploaded other document file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(txnNumber);
				fileCopyRequest1.setSourceFileName(otherDocument.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);


			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}

		if(bulkFile!=null) {
			try {

				byte[] bytes = bulkFile.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + txnNumber + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + txnNumber + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + bulkFile.getOriginalFilename());
				log.info("uploaded other document file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + txnNumber);
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(txnNumber);
				fileCopyRequest1.setSourceFileName(bulkFile.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);
			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}

		Gson gson = new Gson();
		LostStolenModel lawfulIndividualStolen = gson.fromJson(filter, LostStolenModel.class);
		lawfulIndividualStolen.setRequestId(txnNumber);
		lawfulIndividualStolen.setRequestType("Stolen");
		lawfulIndividualStolen.setMobileInvoiceBill(file.getOriginalFilename());
		String userAgent = request.getHeader("User-Agent");
		String ip = request.getRemoteAddr();
		lawfulIndividualStolen.setPublicIp(ip);
		lawfulIndividualStolen.setUserAgent(userAgent);
		lawfulIndividualStolen.setBrowser(getBrowser(userAgent));
		lawfulIndividualStolen.setCreatedBy(lawfulIndividualStolen.getUsername());
		lawfulIndividualStolen.setRequestMode("Bulk");
		lawfulIndividualStolen.setFirCopyUrl(firCopy.getOriginalFilename());
		lawfulIndividualStolen.setDeviceOwnerNationalIdUrl(nidFileName.getOriginalFilename());
		lawfulIndividualStolen.setFileName(bulkFile.getOriginalFilename());
		if(otherDocument!=null) {
			lawfulIndividualStolen.setOtherDocument(otherDocument.getOriginalFilename());
		}
		if(firCopy!=null) {
			lawfulIndividualStolen.setFirCopyUrl(firCopy.getOriginalFilename());
		}
		log.info("request passed to the police save stolen device api" + lawfulIndividualStolen);
		GenricResponse response = new GenricResponse();
		try {
			response = feignCleintImplementation.bulkSave(lawfulIndividualStolen);
			log.info("response from police save stolen device api" + response);
		} catch (Exception e) {
			// TODO: handle exception
			log.info("exception in stolen lost" + e);
			e.printStackTrace();
		}
		return response;
	}


	@RequestMapping(value = {"/verifyOTPRequest"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	public @ResponseBody GenricResponse OTPRequest(
			HttpServletRequest request, HttpSession session) {
		log.info("inside OTP verify request---------" + request.getParameter("request"));

		Gson gson = new Gson();
		String filter = request.getParameter("request").replace("&#34;", "\"");
		OTPRequest OTPrequest = gson.fromJson(filter, OTPRequest.class);
		OTPrequest.setOtp(OTPrequest.getOtpBox1() + OTPrequest.getOtpBox2() + OTPrequest.getOtpBox3() + OTPrequest.getOtpBox4() + OTPrequest.getOtpBox5() + OTPrequest.getOtpBox6());
		String userAgent = request.getHeader("User-Agent");
		String ip = request.getRemoteAddr();
		OTPrequest.setPublicIp(ip);
		OTPrequest.setUserAgent(userAgent);
		OTPrequest.setBrowser(getBrowser(userAgent));
		log.info(" get otp request =" + OTPrequest);
		GenricResponse response = new GenricResponse();
		response = feignCleintImplementation.verifyOTPPolice(OTPrequest);
		log.info("response from verify OTP " + response);
		return response;
	}

	@RequestMapping(value = {"/resendOTPRequest"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	public @ResponseBody GenricResponse resendOTPRequest(
			HttpServletRequest request, HttpSession session) {
		log.info("inside  resend OTP  request---------" + request.getParameter("request"));

		Gson gson = new Gson();
		String filter = request.getParameter("request").replace("&#34;", "\"");
		log.info("*********" + filter);
		OTPRequest OTPrequest = gson.fromJson(filter, OTPRequest.class);
		String userAgent = request.getHeader("User-Agent");
		String ip = request.getRemoteAddr();
		OTPrequest.setPublicIp(ip);
		OTPrequest.setUserAgent(userAgent);
		OTPrequest.setBrowser(getBrowser(userAgent));
		GenricResponse response = new GenricResponse();
		response = feignCleintImplementation.resendOTPPolice(OTPrequest);
		log.info("response from resend OTP " + response);

		return response;
	}


	@RequestMapping(value = {"/verifyDevice"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	public @ResponseBody GenricResponse verifyDevice(
			HttpServletRequest request, HttpSession session) {
		Gson gson = new Gson();
		String filter = request.getParameter("request").replace("&#34;", "\"");
		LostStolenModel individualStolen = gson.fromJson(filter, LostStolenModel.class);
		String userAgent = request.getHeader("User-Agent");
		String ip = request.getRemoteAddr();
		individualStolen.setPublicIp(ip);
		individualStolen.setUserAgent(userAgent);
		individualStolen.setBrowser(getBrowser(userAgent));
		GenricResponse response = new GenricResponse();
		response = feignCleintImplementation.verifyDevice(individualStolen);
		log.info("response from verify Device " + response);

		return response;
	}

	@PostMapping("bulkStolen/view")
	public @ResponseBody LostStolenModel viewTrackLostDevice (@RequestBody LostStolenModel lostStolenModel,HttpSession session )  {
		lostStolenModel.setPublicIp(session.getAttribute("publicIP").toString());
		lostStolenModel.setBrowser(session.getAttribute("browser").toString());
		log.info("Bulk Stolen  Details for Request= "+lostStolenModel.toString());
		LostStolenModel response= feignCleintImplementation.getBulkDeviceByRequestID(lostStolenModel);
		log.info("response "+response);
		return response;
	}


	public static String getBrowser(String userAgent) {

		String browser = "";

		String version = "";

		Integer startLen = 0;

		Integer endLen = 0;

		if (userAgent.toLowerCase().indexOf("msie") != -1) {

			browser = "IE";

			startLen = userAgent.toLowerCase().indexOf("msie");

			endLen = userAgent.indexOf(";", startLen);

			version = userAgent.substring(startLen + 5, endLen);

		} else if (userAgent.toLowerCase().indexOf("trident/7") != -1) {

			browser = "IE";

			startLen = userAgent.toLowerCase().indexOf("rv:") + 3;

			endLen = userAgent.indexOf(")", startLen);

			version = userAgent.substring(startLen, endLen);

		} else if (userAgent.toLowerCase().indexOf("chrome") != -1) {

			browser = "CHROME";

			startLen = userAgent.toLowerCase().indexOf("chrome") + 7;

			endLen = userAgent.indexOf(" ", startLen);

			version = userAgent.substring(startLen, endLen);

		} else if (userAgent.toLowerCase().indexOf("firefox") != -1) {

			browser = "FIREFOX";

			startLen = userAgent.toLowerCase().indexOf("firefox") + 8;

			endLen = userAgent.length();

			version = userAgent.substring(startLen, endLen);

		} else if (userAgent.toLowerCase().indexOf("safari") != -1) {

			browser = "SAFARI";

			startLen = userAgent.toLowerCase().indexOf("version") + 8;

			endLen = userAgent.indexOf(" ", startLen);

			version = userAgent.substring(startLen, endLen);

		} else if (userAgent.toLowerCase().indexOf("opera") != -1) {

			browser = "OPERA";

			startLen = userAgent.toLowerCase().indexOf("opera") + 6;

			endLen = userAgent.length();

			version = userAgent.substring(startLen, endLen);

		} else {

			browser = "OTHER";

		}

		return browser + "_" + version;
	}

	// *********************************************** Download Sampmle file/
	// *************************************************
	@RequestMapping(value = "/sampleFileDownload/{featureId}", method = {
			org.springframework.web.bind.annotation.RequestMethod.GET })
	public String downloadSampleFile(@PathVariable("featureId") String featureId, HttpSession session, HttpServletRequest request) throws IOException {

		int featureIdForFile = Integer.parseInt(featureId);
		AllRequest allrequest= new AllRequest();
		// UserHeader header=registerService.getUserHeaders(request);

		/*
		 * int userTypeid=(int) session.getAttribute("usertypeId"); String
		 * roleType=String.valueOf(session.getAttribute("usertype")); String
		 * userName=session.getAttribute("username").toString(); int userId= (int)
		 * session.getAttribute("userid");
		 */
		if(session.getAttribute("usertypeId")==null || session.getAttribute("usertype").equals(null) || session.getAttribute("username").equals(null) || session.getAttribute("userid").equals(null))
		{
			allrequest.setUserTypeId(17);
			allrequest.setUserType("End User");
			allrequest.setUserId(0123);
			allrequest.setUsername("End User");
		}
		else {
			allrequest.setUserTypeId((int)  session.getAttribute("usertypeId"));
			allrequest.setUserType(String.valueOf(session.getAttribute("usertype")));
			allrequest.setUserId((int) session.getAttribute("userid"));
			allrequest.setUsername(session.getAttribute("username").toString());
		}

		log.info("publicIP " +session.getAttribute("publicIP").toString()+ " And Browser " +session.getAttribute("browser").toString());
		allrequest.setPublicIp(session.getAttribute("publicIP").toString());
		allrequest.setBrowser(session.getAttribute("browser").toString());

		log.info(" featureIdForFile=="+featureIdForFile+"  request send to the sample file download api=" + allrequest);
		FileExportResponse response = feignCleintImplementation.downloadSampleFile(featureIdForFile,allrequest);
		log.info("response from sample file download file " + response);

		return "redirect:" + response.getUrl();

	}

	@RequestMapping(value = {"/approvePoliceRequest"}, method = RequestMethod.POST, consumes = "multipart/form-data")
	public @ResponseBody GenricResponse approvePoliceRequest(
			@RequestParam(name = "firCopy", required = false) MultipartFile firCopy,
			@RequestParam(name = "file", required = false) MultipartFile file,
			@RequestParam(name = "nidFileName", required = false) MultipartFile nidFileName,
			@RequestParam(name = "otherDocument", required = false) MultipartFile otherDocument,
			HttpServletRequest request, HttpSession session) {

		CopyFileRequest fileCopyRequest = new CopyFileRequest();
		ArrayList<Destination> destination = new ArrayList<Destination>();
		Destination dest = new Destination();
		CopyFileRequest fileCopyRequest1 = new CopyFileRequest();
		ArrayList<Destination> destination1 = new ArrayList<Destination>();
		Destination dest1 = new Destination();
		addMoreFileModel.setTag("system_upload_filepath");
		urlToUpload = feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
		String filter = StringEscapeUtils.unescapeHtml4(request.getParameter("request"));
		Gson gson = new Gson();
		LostStolenModel lostStolenModel = gson.fromJson(filter, LostStolenModel.class);

		if(file!=null) {
			try {

				byte[] bytes = file.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + lostStolenModel.getRequestId() + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + lostStolenModel.getRequestId() + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + file.getOriginalFilename());
				log.info("uploaded file path on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//dest.setDestFilePath(rootPath);
				dest.setDestFilePath(propertyReader.destFilePath + lostStolenModel.getRequestId());
				dest.setDestServerName(propertyReader.destServerName);
				destination.add(dest);
				fileCopyRequest.setDestination(destination);
				fileCopyRequest.setSourceFilePath(rootPath);
				fileCopyRequest.setTxnId(lostStolenModel.getRequestId());
				fileCopyRequest.setSourceFileName(file.getOriginalFilename());
				fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest.setAppName("Bulk File Upload");
				fileCopyRequest.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB Mobile invoice==" + fileCopyRequest);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
				log.info("file move api response Mobile invoice===" + FileUploadResponse);
				lostStolenModel.setMobileInvoiceBill(file.getOriginalFilename());

			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}
		else{
			lostStolenModel.setMobileInvoiceBill(lostStolenModel.getPreviousFile());
		}
		if(nidFileName!=null) {
			try {

				byte[] bytes = nidFileName.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + lostStolenModel.getRequestId() + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + lostStolenModel.getRequestId() + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + nidFileName.getOriginalFilename());
				log.info("uploaded nid file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + lostStolenModel.getRequestId());
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(lostStolenModel.getRequestId());
				fileCopyRequest1.setSourceFileName(nidFileName.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in fir copy file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);
				lostStolenModel.setDeviceOwnerNationalIdUrl(nidFileName.getOriginalFilename());

			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}
		else {
			lostStolenModel.setDeviceOwnerNationalIdUrl(lostStolenModel.getPreviousNidFileName());
		}

		if(otherDocument!=null) {
			try {

				byte[] bytes = otherDocument.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + lostStolenModel.getRequestId() + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + lostStolenModel.getRequestId() + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + otherDocument.getOriginalFilename());
				log.info("uploaded other document file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + lostStolenModel.getRequestId());
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(lostStolenModel.getRequestId());
				fileCopyRequest1.setSourceFileName(otherDocument.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);
				lostStolenModel.setOtherDocument(otherDocument.getOriginalFilename());

			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
		}
		else {
			lostStolenModel.setOtherDocument(lostStolenModel.getPreviousOtherDocument());
		}
		if (firCopy != null)
		{
			try {
				byte[] bytes = firCopy.getBytes();
				String rootPath = urlToUpload.getValue() + "/" + lostStolenModel.getRequestId() + "/";
				File dir = new File(rootPath + File.separator);
				File dir1 = new File(urlToUpload.getValue() + lostStolenModel.getRequestId() + "/" + File.separator);
				if (!dir.exists()) {
					dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
					dir.setReadable(true, false);
					dir.setWritable(true, false);
					dir.setExecutable(true, false);
					dir1.setReadable(true, false);
					dir1.setWritable(true, false);
					dir1.setExecutable(true, false);
				}
				File serverFile = new File(rootPath + firCopy.getOriginalFilename());
				log.info("uploaded fir file  on server" + serverFile);
				BufferedOutputStream
						stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				serverFile.setExecutable(true, false);
				serverFile.setReadable(true, false);
				serverFile.setWritable(true, false);
				stream.write(bytes);
				stream.close();
				//	dest1.setDestFilePath(rootPath);
				dest1.setDestFilePath(propertyReader.destFilePath + lostStolenModel.getRequestId());
				dest1.setDestServerName(propertyReader.destServerName);
				destination1.add(dest1);
				fileCopyRequest1.setDestination(destination1);
				fileCopyRequest1.setSourceFilePath(rootPath);
				fileCopyRequest1.setTxnId(lostStolenModel.getRequestId());
				fileCopyRequest1.setSourceFileName(firCopy.getOriginalFilename());
				fileCopyRequest1.setSourceServerName(propertyReader.sourceServerName);
				fileCopyRequest1.setAppName("Bulk File Upload");
				fileCopyRequest1.setRemarks("File Copy from primary  server to secondary server");
				log.info("request passed to for uploaded_file_to_sync DB in NID file  upload==" + fileCopyRequest1);
				GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest1);
				log.info("file move api response NID file  upload===" + FileUploadResponse);


			} catch (Exception e) { //
				// TODO: handle exception e.printStackTrace(); }

				// set reaquest parameters into model class

			}
	}


		lostStolenModel.setRequestType("Stolen");
		String userAgent = request.getHeader("User-Agent");
		String ip = request.getRemoteAddr();
		lostStolenModel.setPublicIp(ip);
		lostStolenModel.setUserAgent(userAgent);
		lostStolenModel.setBrowser(getBrowser(userAgent));
		lostStolenModel.setRequestMode("Single");
		lostStolenModel.setCreatedBy("End User");
		if (firCopy != null)
		{
			lostStolenModel.setFirCopyUrl(firCopy.getOriginalFilename());
		}
		else {
			lostStolenModel.setFirCopyUrl(lostStolenModel.getFirCopyUrl());
		}
		log.info("request passed to the police approve request API" + lostStolenModel);
		GenricResponse response = new GenricResponse();
		try {
			response = feignCleintImplementation.approveRequest(lostStolenModel);
			log.info("response from police approve request API" + response);
		} catch (Exception e) {
			// TODO: handle exception
			log.info("exception in stolen lost" + e);
			e.printStackTrace();
		}
		return response;
	}
}