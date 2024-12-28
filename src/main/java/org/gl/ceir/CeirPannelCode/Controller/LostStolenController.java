package org.gl.ceir.CeirPannelCode.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.AddMoreFileModel;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;

import org.gl.ceir.CeirPannelCode.Model.LostStolenModel;
import org.gl.ceir.CeirPannelCode.Model.OTPRequest;
import org.gl.ceir.CeirPannelCode.Util.UtilDownload;
import org.gl.ceir.CeirPannelCode.config.PropertyReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

@Controller
public class LostStolenController {

	
	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	UtilDownload utildownload;
	
	@Autowired
    PropertyReader propertyReader;

	@Autowired
	AddMoreFileModel addMoreFileModel,urlToUpload,urlToMove;
	
	@Autowired

	FeignCleintImplementation feignCleintImplementation;
	
//	@RequestMapping(value={"/requestStolenRecovery"},method={org.springframework.web.bind.annotation.RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST})
//	public ModelAndView  viewLostStolenRecovery( HttpSession session ,
//			@RequestParam(name="type" ,required = false,defaultValue = "0") Integer type) {
//			
//		log.info("entry point in lost/stolen recovery/found "+type);
//		ModelAndView mv = new ModelAndView();
//		
//		try {
//		
//			if(type==0) {
//				mv.setViewName("LostStolen");
//			}
//			else if(type==1) {
//				mv.setViewName("FoundRecovery");
//			}
//			else if(type==2) {
//				mv.setViewName("CheckRequestID");
//			}
//			
//		}
//		catch (Exception e) {
//			// TODO: handle exception
//			log.info("this is catch block session is blank or something went wrong.");
//		}
//				
//				return mv; 
//			}
//	
	
	//@PostMapping("lawfulIndivisualStolen")
//	@RequestMapping(value= {"/lostStolenSave"},method= RequestMethod.POST,consumes = "multipart/form-data") 
//	public @ResponseBody GenricResponse register(@RequestParam(name="file",required = false) MultipartFile file,
//			@RequestParam(name="nidFileName",required = false) MultipartFile nidFileName,
//			HttpServletRequest request,HttpSession session) {
//		log.info("inside controller lost Stolen-------request---------"+request.getParameter("request"));
//
//		//String userName=session.getAttribute("username").toString();
//		//Integer userId= (Integer) session.getAttribute("userid");
//		//String roletype=session.getAttribute("usertype").toString();
//		//String name=session.getAttribute("name").toString();
//		String txnNumber="L" + utildownload.getTxnId();
//		log.info("Random transaction id number="+txnNumber);
//		//String filter = request.getParameter("request");
//		String filter = request.getParameter("request").replace("&#34;", "\"");
//	//	FileCopyToOtherServer fileCopyRequest= new FileCopyToOtherServer();
//
//		addMoreFileModel.setTag("system_upload_filepath");
//		urlToUpload=feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
//		
//				
//				try {
//
//					byte[] bytes = file.getBytes();
//					String rootPath = urlToUpload.getValue()+"/"+txnNumber+"/"; 
//							File dir =   new File(rootPath + File.separator);
//							File dir1 =   new File(urlToUpload.getValue()+txnNumber+"/" + File.separator);
//							if (!dir.exists())
//								{
//								dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
//								dir.setReadable(true,false);
//								dir.setWritable(true,false);
//								dir.setExecutable(true,false);
//								dir1.setReadable(true,false);
//								dir1.setWritable(true,false);
//								dir1.setExecutable(true,false);
//								}
//							File serverFile = new File(rootPath+file.getOriginalFilename());
//							log.info("uploaded file path on server" + serverFile); BufferedOutputStream
//							stream = new BufferedOutputStream(new FileOutputStream(serverFile));
//							serverFile.setExecutable(true,false);
//							serverFile.setReadable(true,false);
//							serverFile.setWritable(true,false);
//							stream.write(bytes); stream.close();
//							//  grievanceRequest.setFileName(file.getOriginalFilename());
//
//				}
//				catch (Exception e) { //
//					// TODO: handle exception e.printStackTrace(); }
//
//					// set reaquest parameters into model class
//
//				}
//				
//				try {
//
//					byte[] bytes = nidFileName.getBytes();
//					String rootPath = urlToUpload.getValue()+"/"+txnNumber+"/"; 
//							File dir =   new File(rootPath + File.separator);
//							File dir1 =   new File(urlToUpload.getValue()+txnNumber+"/" + File.separator);
//							if (!dir.exists())
//								{
//								dir.mkdirs(); // Create the file on server // Calendar now = Calendar.getInstance();
//								dir.setReadable(true,false);
//								dir.setWritable(true,false);
//								dir.setExecutable(true,false);
//								dir1.setReadable(true,false);
//								dir1.setWritable(true,false);
//								dir1.setExecutable(true,false);
//								}
//							File serverFile = new File(rootPath+nidFileName.getOriginalFilename());
//							log.info("uploaded nid file  on server" + serverFile); BufferedOutputStream
//							stream = new BufferedOutputStream(new FileOutputStream(serverFile));
//							serverFile.setExecutable(true,false);
//							serverFile.setReadable(true,false);
//							serverFile.setWritable(true,false);
//							stream.write(bytes); stream.close();
//							//  grievanceRequest.setFileName(file.getOriginalFilename());
//
//				}
//				catch (Exception e) { //
//					// TODO: handle exception e.printStackTrace(); }
//
//					// set reaquest parameters into model class
//
//				}
//			Gson gson= new Gson(); 
//		log.info("*********"+filter);
//
//		//addMoreFileModel.setTag("system_upload_filepath");
//		//urlToUpload=feignCleintImplementation.addMoreBuutonCount(addMoreFileModel);
//
//		LostStolenModel lawfulIndivisualStolen  = gson.fromJson(filter, LostStolenModel.class);
//		log.info(""+lawfulIndivisualStolen.toString());
//		lawfulIndivisualStolen.setRequestId(txnNumber);
//		lawfulIndivisualStolen.setRequestType("Stolen");
//		 lawfulIndivisualStolen.setMobileInvoiceBill(file.getOriginalFilename());
//		
//		 lawfulIndivisualStolen.setDeviceOwnerNationalIdUrl(nidFileName.getOriginalFilename());
//		log.info("request passed to the save stolen device api"+lawfulIndivisualStolen);
//		GenricResponse response = new GenricResponse();
//		try {
//			response=feignCleintImplementation.saveStolenDevice(lawfulIndivisualStolen);
//		log.info("---------response--------"+response);
//		}
//		catch (Exception e) {
//			// TODO: handle exception
//			log.info("exception in stolen lost"+e);
//			e.printStackTrace();
//
//		}
//		return response;
//	}
	
	
//	@RequestMapping(value= {"/verifyOTPRequest"},method= RequestMethod.POST,consumes = "multipart/form-data") 
//	public @ResponseBody GenricResponse OTPRequest(
//			HttpServletRequest request,HttpSession session) {
//		log.info("inside OTP verify request---------"+request.getParameter("request"));
//		
//		Gson gson= new Gson(); 
//		String filter = request.getParameter("request").replace("&#34;", "\"");
//		log.info("*********"+filter);
//		LostStolenModel OTPrequest  = gson.fromJson(filter, LostStolenModel.class);
//		
//		log.info(" get otp request ="+ OTPrequest);
//		GenricResponse response = new GenricResponse();
//		response=feignCleintImplementation.getOTP(OTPrequest);
//		log.info("response from verify OTP "+response);
//		return response;
//		}
	
//	@RequestMapping(value= {"/resendOTPRequest"},method= RequestMethod.POST,consumes = "multipart/form-data") 
//	public @ResponseBody GenricResponse resendOTPRequest(
//			HttpServletRequest request,HttpSession session) {
//		log.info("inside  resend OTP  request---------"+request.getParameter("request"));
//		
//		Gson gson= new Gson(); 
//		String filter = request.getParameter("request").replace("&#34;", "\"");
//		log.info("*********"+filter);
//		OTPRequest OTPrequest  = gson.fromJson(filter, OTPRequest.class);
//		GenricResponse response = new GenricResponse();
//		response=feignCleintImplementation.resendOTP(OTPrequest);
//		log.info("response from resend OTP "+response);
//		
//		return response;
//		}
	
	@RequestMapping(value= {"/getOTPRequest"},method= RequestMethod.POST,consumes = "multipart/form-data") 
	public @ResponseBody GenricResponse getOTPRequest(
			HttpServletRequest request,HttpSession session) {
		log.info("inside  get OTP  request---------"+request.getParameter("request"));
		
		Gson gson= new Gson(); 
		String filter = request.getParameter("request").replace("&#34;", "\"");
		log.info("*********"+filter);
		OTPRequest OTPrequest  = gson.fromJson(filter, OTPRequest.class);
		GenricResponse response = new GenricResponse();
		response=feignCleintImplementation.resendOTP(OTPrequest);
		log.info("response from resend OTP "+response);
		
		return response;
		}
	
	
	@RequestMapping(value= {"/recoveryFoundSave"},method= RequestMethod.POST,consumes = "multipart/form-data") 
	public @ResponseBody GenricResponse recoverySave(HttpServletRequest request,HttpSession session) {
		String filter = request.getParameter("request").replace("&#34;", "\"");
		log.info("inside controller recovery-------request---------"+filter);
		String txnNumber="R" + utildownload.getTxnId();
		log.info("Random recovery request id number="+txnNumber);
		Gson gson= new Gson(); 
		GenricResponse response = new GenricResponse();
		LostStolenModel lawfulIndivisualStolen  = gson.fromJson(filter, LostStolenModel.class);
		//lawfulIndivisualStolen.setRequestId(txnNumber);
		lawfulIndivisualStolen.setRequestType("Recovery");
		response=feignCleintImplementation.saveRecoveryFound(lawfulIndivisualStolen);
		return response;
		
	}
	
	@RequestMapping(value= {"/checkRequestStatus"},method= RequestMethod.POST,consumes = "multipart/form-data") 
	public @ResponseBody GenricResponse checkRequestStatus(HttpServletRequest request,HttpSession session) {
		String filter = request.getParameter("request").replace("&#34;", "\"");
		log.info("inside controller recovery stolen check status-------request---------"+filter);
		Gson gson= new Gson(); 
		GenricResponse response = new GenricResponse();
		LostStolenModel lawfulIndivisualStolen  = gson.fromJson(filter, LostStolenModel.class);
		response=feignCleintImplementation.checkRequestStatus(lawfulIndivisualStolen);
		log.info("response---------"+response);
		return response;
		
	}
}
