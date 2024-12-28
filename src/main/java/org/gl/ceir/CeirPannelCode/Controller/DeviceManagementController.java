package org.gl.ceir.CeirPannelCode.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.DeviceRepositoryFeign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.FileCopierFeignClient;
import org.gl.ceir.CeirPannelCode.Feignclient.GsmaFeignClient;
import org.gl.ceir.CeirPannelCode.Model.*;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class DeviceManagementController {
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	DeviceRepositoryFeign deviceRepositoryFeign;

	@Autowired
	FeignCleintImplementation feignCleintImplementation;

	@Autowired
	AddMoreFileModel addMoreFileModel,urlToUpload,urlToMove;

	@Autowired
	PropertyReader propertyReader;

	@Autowired
	GsmaFeignClient gsmaFeignClient;

	@Autowired
	FileCopierFeignClient fileCopierFeignClient;

	GenricResponse response = new GenricResponse();

	@RequestMapping(value=
			{"/deviceManagement"},method={org.springframework.web.bind.annotation.
			RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}
	)
	public ModelAndView viewManageTypeAdmin(@RequestParam(name = "FeatureId", required = false) String featureId,HttpSession session) {
		ModelAndView mv = new ModelAndView();
		log.info(" view Device Management entry point.");
		mv.setViewName("viewDeviceManagement");
		mv.addObject("featureId", featureId);
		log.info(" view Device Management exit point..");
		return mv;
	}


	//-------------------View by devicID Controller-------------------//

	@PostMapping("viewbyDeviceID")
	public @ResponseBody Object viewDeviceDetails(@RequestBody DeviceFilterRequest deviceManagementRequest,HttpSession session) {
		Integer file = 0;
		log.info("request send to the view Device api=" + deviceManagementRequest);
		Object response = deviceRepositoryFeign.deviceManagementFeign(deviceManagementRequest, deviceManagementRequest.getPageNo(), deviceManagementRequest.getPageSize(), file, deviceManagementRequest.getSource());
		log.info("response from viewUser api " + response);
		return response;
	}

	//-------------------Export Device Management Controller-------------------//

	@PostMapping("exportDeviceDetails")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody DeviceFilterRequest deviceManagementRequest,HttpSession session,HttpServletRequest request)
	{
		Object response;
		Integer file = 1;
		log.info("publicIP " +session.getAttribute("publicIP").toString()+ " And Browser " +session.getAttribute("browser").toString());
		deviceManagementRequest.setPublicIp(session.getAttribute("publicIP").toString());
		log.info("Request to Export:::::::::"+deviceManagementRequest);
		response= deviceRepositoryFeign.deviceManagementExportFeign(deviceManagementRequest, deviceManagementRequest.getPageNo(), deviceManagementRequest.getPageSize(), file, deviceManagementRequest.getSource());
		FileExportResponse fileExportResponse;
		Gson gson= new Gson();
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response Export  api="+fileExportResponse);
		return fileExportResponse;
	}

	//-------------------Save Device Details Controller-------------------//

	@RequestMapping(value= {"/addDeviceDetails"},method= RequestMethod.POST,consumes = "multipart/form-data")
	public @ResponseBody GenricResponse addDevice(@RequestParam(name="files[]",required = false) MultipartFile[] fileUpload,
												  @RequestParam(name="id",required = false) Integer id,
												  HttpServletRequest request,HttpSession session) {
		Gson gson= new Gson();
		String deviceDetails= HtmlUtils.htmlUnescape(request.getParameter("multirequest"));
		log.info("deviceDetails------"+deviceDetails);
		log.info("fileUpload------"+fileUpload);
		addMoreFileModel.setTag("system_upload_filepath");
		urlToUpload=feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);

		//GrievanceModel grievanceRequest  = gson.fromJson(grievanceDetails, GrievanceModel.class);
		DeviceManagementRequest deviceManagementRequest=null;
		try {
			deviceManagementRequest  = gson.fromJson(deviceDetails, DeviceManagementRequest.class);
		} catch (Exception e) {
			// TODO: handle exception
			log.info("Exception Add Request for deviceId " +e.getMessage());
			e.printStackTrace();
		}
		//DeviceManagementRequest deviceManagementRequest  = gson.fromJson(deviceDetails, DeviceManagementRequest.class);

		//FileCopyToOtherServer fileCopyRequest= new FileCopyToOtherServer();
		//grievanceRequest.setUserId(userId);
		//grievanceRequest.setUserType(roletype);
		//grievanceRequest.setGrievanceId(grevnceId);

		log.info("Add Request for deviceId " +deviceManagementRequest.getDeviceId());


		for (int i=0;i<deviceManagementRequest.getAttachedFiles().size();i++) {
			deviceManagementRequest.getAttachedFiles().get(i).setId(id);
			//grievanceRequest.getMultifile().get(i).getDocType();
		}

		//log.info("Random  genrated transaction number ="+grevnceId);

		if(fileUpload==null || fileUpload.equals("")) {
			log.info("no file uploaded " +fileUpload);
			deviceManagementRequest.setAttachedFiles(null);
		}else{
			log.info("file uploaded " +fileUpload.toString());
			int i=0;
			for( MultipartFile file : fileUpload) {

				log.info("-----"+ file.getOriginalFilename());
				log.info("++++"+ file);

				String tagName=deviceManagementRequest.getAttachedFiles().get(i).getDocType();
				log.info("doctype Name==="+tagName+"value of index="+i);


				try {

					byte[] bytes =
							file.getBytes();
					String rootPath = urlToUpload.getValue()+deviceManagementRequest.getDeviceId()+"/"+tagName+"/";
					File dir =   new File(rootPath + File.separator);
					log.info("Add rootPath is " +rootPath+" and File dir is " +dir);
					File dir1 =   new File(urlToUpload.getValue()+deviceManagementRequest.getDeviceId()+"/" + File.separator);
					if (!dir.exists())
					{
						dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
						dir.setReadable(true,false);
						dir.setWritable(true,false);
						dir.setExecutable(true,false);
						dir1.setReadable(true,false);
						dir1.setWritable(true,false);
						dir1.setExecutable(true,false);
					}
					File serverFile = new File(rootPath+file.getOriginalFilename());
					log.info("uploaded file path on server" + serverFile); BufferedOutputStream
							stream = new BufferedOutputStream(new FileOutputStream(serverFile));
					serverFile.setExecutable(true,false);
					serverFile.setReadable(true,false);
					serverFile.setWritable(true,false);
					stream.write(bytes); stream.close();
					/*
					 * fileCopyRequest.setFilePath(rootPath); int
					 * deviceId=Integer.parseInt(deviceManagementRequest.getDeviceId());
					 * fileCopyRequest.setId(deviceId); // take care for id. use device ID.
					 * fileCopyRequest.setFileName(file.getOriginalFilename());
					 * fileCopyRequest.setServerId(propertyReader.serverId);
					 */


					CopyFileRequest fileCopyRequest=new CopyFileRequest();
					ArrayList<Destination> destination=new ArrayList<Destination>();
					Destination dest=new Destination();
					//dest.setDestFilePath(rootPath);
					dest.setDestFilePath(propertyReader.destFilePath+deviceManagementRequest.getDeviceId()+"/"+tagName+"/");
					dest.setDestServerName(propertyReader.destServerName);
					destination.add(dest);
					fileCopyRequest.setDestination(destination);
					fileCopyRequest.setSourceFilePath(rootPath);
					String deviceId=deviceManagementRequest.getDeviceId();
					fileCopyRequest.setTxnId(deviceId);
					fileCopyRequest.setSourceFileName(file.getOriginalFilename());
					fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
					fileCopyRequest.setAppName("MDR File Upload");
					fileCopyRequest.setRemarks("File Copy mango one server to mango2");
					log.info("request passed to for uploaded_file_to_sync DB==" + fileCopyRequest);
					GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
					log.info("file move api response===" + FileUploadResponse);


					/*
					 * log.info("request passed to for uploaded_file_to_sync DB=="+fileCopyRequest);
					 * GenricResponse
					 * fileRespnose=gsmaFeignClient.saveUploadedFileOnANotherServer(fileCopyRequest)
					 * ; log.info("file response for uploaded_file_to_sync DB==="+fileRespnose);
					 *
					 * log.info("request passed to move file to other server=="+fileCopyRequest);
					 * GenricResponse
					 * FileUploadResponse=grievanceFeignClient.saveUploadedFileOnANotherServer(
					 * fileCopyRequest); log.info("FileUploadResponse==="+FileUploadResponse);
					 */




					//  grievanceRequest.setFileName(file.getOriginalFilename());

				}
				catch (Exception e) { //
					// TODO: handle exception e.printStackTrace(); }

					// set reaquest parameters into model class

				}
				i++;


			}
		}
		log.info("publicIP " +session.getAttribute("publicIP").toString()+ " And Browser " +session.getAttribute("browser").toString());
		deviceManagementRequest.setPublicIp(session.getAttribute("publicIP").toString());
		deviceManagementRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("grievance form parameters passed to save Device Details "+deviceManagementRequest);
		response= deviceRepositoryFeign.addDeviceInfo(deviceManagementRequest);
		log.info("response from save Device api"+response);
		log.info("save Device  exit point.");
		return response;
	}
	//-------------------Update Device Management Controller-------------------//

	@RequestMapping(value= {"/updateDeviceDetails"},method= RequestMethod.POST,consumes = "multipart/form-data")
	public @ResponseBody GenricResponse updateDevice(@RequestParam(name="files[]",required = false) MultipartFile[] fileUpload,
													 @RequestParam(name="id",required = false) Integer id,
													 HttpServletRequest request,HttpSession session) {
		Gson gson= new Gson();
		String deviceDetails=HtmlUtils.htmlUnescape(request.getParameter("multirequest"));
		//String files1 = request.getParameter("files1");
		//log.info("files1------"+files1);
		log.info("deviceDetails------"+deviceDetails);
		log.info("fileUpload------"+fileUpload);
		addMoreFileModel.setTag("system_upload_filepath");
		urlToUpload=feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
		String movedFileTime = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
		log.info("Moved File Time value=="+movedFileTime);
		log.info("Request for update for id "+id );

		List <DeviceManagementRequest> deviceManagementRequests = Arrays.asList(gson.fromJson(deviceDetails, DeviceManagementRequest[].class));

		//DeviceRequestModel deviceRequestModel = gson.fromJson(deviceDetails, DeviceRequestModel.class);
		//List <DeviceManagementRequest> deviceManagementRequests = deviceRequestModel.getContent();

		//FileCopyToOtherServer fileCopyRequest= new FileCopyToOtherServer();
		//deviceManagementRequest.setId(id);


		/*
		 * for (int i=0;i<deviceManagementRequest.getAttachedFiles().size();i++) {
		 * deviceManagementRequest.getAttachedFiles().get(i).setId(id);
		 * //grievanceRequest.getMultifile().get(i).getDocType(); }
		 */
		for ( DeviceManagementRequest deviceManagementRequest : deviceManagementRequests ) {
			log.info("publicIP " +session.getAttribute("publicIP").toString()+ " And Browser " +session.getAttribute("browser").toString());
			deviceManagementRequest.setPublicIp(session.getAttribute("publicIP").toString());
			deviceManagementRequest.setBrowser(session.getAttribute("browser").toString());

			if(fileUpload==null || fileUpload.equals("")) {
				log.info("no file uploaded " +fileUpload);
				//deviceManagementRequest.setAttachedFiles(null);
			}else{
				log.info("file uploaded " +fileUpload.toString());
				//int i=0;
				for( MultipartFile file : fileUpload) {
					log.info("-----"+ file.getOriginalFilename());
					log.info("++++"+ file);

					for(int i=0; i<deviceManagementRequest.getAttachedFiles().size(); i++) {
						Object tagName=deviceManagementRequest.getAttachedFiles().get(i).getDocType();
						//Object tagName="MDRFiles";
						log.info("doctype Name==="+tagName+"value of index="+i);
						try {
							if(fileUpload==null || fileUpload.equals(""))
							{
								deviceManagementRequest.setAttachedFiles(null);

							}
							else {
								byte[] bytes =
										file.getBytes();
								String rootPath = urlToUpload.getValue()+deviceManagementRequest.getDeviceId()+"/"+tagName+"/";
								File dir =   new File(rootPath + File.separator);
								log.info("Update rootPath is " +rootPath+" and File dir is " +dir);
								File dir1 =   new File(urlToUpload.getValue()+deviceManagementRequest.getDeviceId()+"/" + File.separator);
								if (!dir.exists())
								{
									dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
									dir.setReadable(true,false);
									dir.setWritable(true,false);
									dir.setExecutable(true,false);
									dir1.setReadable(true,false);
									dir1.setWritable(true,false);
									dir1.setExecutable(true,false);
								}
								File serverFile = new File(rootPath+file.getOriginalFilename());
								log.info("uploaded file path on server" + serverFile); BufferedOutputStream
										stream = new BufferedOutputStream(new FileOutputStream(serverFile));
								serverFile.setExecutable(true,false);
								serverFile.setReadable(true,false);
								serverFile.setWritable(true,false);
								stream.write(bytes); stream.close();
								/*
								 * fileCopyRequest.setFilePath(rootPath); int
								 * deviceId=Integer.parseInt(deviceManagementRequest.getDeviceId());
								 * fileCopyRequest.setId(deviceId); // take care for id. use device ID.
								 * fileCopyRequest.setFileName(file.getOriginalFilename());
								 * fileCopyRequest.setServerId(propertyReader.serverId);
								 */

								CopyFileRequest fileCopyRequest=new CopyFileRequest();
								ArrayList<Destination> destination=new ArrayList<Destination>();
								Destination dest=new Destination();
								//dest.setDestFilePath(rootPath);
								dest.setDestFilePath(propertyReader.destFilePath+deviceManagementRequest.getDeviceId()+"/"+tagName+"/");
								dest.setDestServerName(propertyReader.destServerName);
								destination.add(dest);
								fileCopyRequest.setDestination(destination);
								fileCopyRequest.setSourceFilePath(rootPath);
								String deviceId=deviceManagementRequest.getDeviceId();
								fileCopyRequest.setTxnId(deviceId);
								fileCopyRequest.setSourceFileName(file.getOriginalFilename());
								fileCopyRequest.setSourceServerName(propertyReader.sourceServerName);
								fileCopyRequest.setAppName("MDR File Upload");
								fileCopyRequest.setRemarks("File Copy mango one server to mango2");
								log.info("request passed to for uploaded_file_to_sync DB==" + fileCopyRequest);
								GenricResponse FileUploadResponse = fileCopierFeignClient.saveCopyFileOnANotherServer(fileCopyRequest);
								log.info("file move api response===" + FileUploadResponse);

								/*
								 * log.info("request passed to for uploaded_file_to_sync DB=="+fileCopyRequest);
								 * GenricResponse
								 * fileRespnose=gsmaFeignClient.saveUploadedFileOnANotherServer(fileCopyRequest)
								 * ; log.info("file response for uploaded_file_to_sync DB==="+fileRespnose);
								 *
								 * log.info("request passed to move file to other server=="+fileCopyRequest);
								 * GenricResponse
								 * FileUploadResponse=grievanceFeignClient.saveUploadedFileOnANotherServer(
								 * fileCopyRequest); log.info("FileUploadResponse==="+FileUploadResponse);
								 */

							}
						}catch (Exception e) { //
							// TODO: handle exception e.printStackTrace(); }

							// set reaquest parameters into model class
						}

					}


				}
			}
		}



		//List<DeviceManagementRequest> updateRequest = new ArrayList<>();
		//updateRequest.add(deviceManagementRequest);
		//log.info("parameters passed to update device Api "+deviceManagementRequest.toString());
		response= deviceRepositoryFeign.updateDeviceInfo(deviceManagementRequests);
		log.info("Response from update Device api " +response);
		log.info("update Device  exit point.");
		return response;
	}


	//-------------------Delete Device Controller-------------------//

	@PostMapping ("deleteDevice")
	public @ResponseBody GenricResponse deletePortAddress(@RequestParam(name = "deviceId", required = true) String deviceId,
														  @RequestParam(name = "featureId", required = false) String featureId,
														  @RequestParam(name = "publicIp", required = false) String publicIp,
														  @RequestParam(name = "browser", required = false) String browser,
														  @RequestParam(name = "userId", required = true) String userId,
														  @RequestParam(name = "userType", required = false) String userType,
														  HttpServletRequest request,HttpSession session) {
		publicIp = session.getAttribute("publicIP").toString();
		browser = session.getAttribute("browser").toString();
		log.info("request send to the Delete Device api with Device ID =" +deviceId+" and userId " +userId);
		GenricResponse response= deviceRepositoryFeign.deleteDeviceFeign(deviceId,featureId,publicIp,browser,userId,userType);
		log.info("response after delete Device."+response);
		return response;

	}

	//-------------------get Device Type Drop down Controller-------------------//
	@ResponseBody
	@GetMapping("getDeviceTypeName")
	public List<Object> getDeviceTypeName() {
		List<Object> dropdown = deviceRepositoryFeign.getDeviceTypetListFeign();
		return dropdown;
	}

	//-------------------get Device Type Drop down Controller-------------------//
	@ResponseBody
	@GetMapping("getCountryName")
	public List<Object> getCountryName() {
		List<Object> dropdown = deviceRepositoryFeign.getManufacturerCountryListFeign();
		return dropdown;
	}
}


	
