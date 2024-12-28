package org.gl.ceir.CeirPannelCode.Service;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream; 
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.Dropdown;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.Otp;
import org.gl.ceir.CeirPannelCode.Model.OtpResponse;
import org.gl.ceir.CeirPannelCode.Model.Registration;
import org.gl.ceir.CeirPannelCode.Model.ResendOtp;
import org.gl.ceir.CeirPannelCode.Model.SecurityQuestion;
import org.gl.ceir.CeirPannelCode.Model.Tag;
import org.gl.ceir.CeirPannelCode.Model.UserHeader;
import org.gl.ceir.CeirPannelCode.Model.Usertype;
import org.gl.ceir.CeirPannelCode.Util.GenerateRandomDigits;
import org.gl.ceir.CeirPannelCode.Util.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.blueconic.browscap.Capabilities;
import com.blueconic.browscap.ParseException;
import com.blueconic.browscap.UserAgentParser;
import com.blueconic.browscap.UserAgentService;
import com.google.gson.Gson;
@Service 
public class RegistrationService {

//	@Value("${FilePath1}") 
//	String filePath; 

	@Autowired
	APIService4Feign registrationFeignImpl;
	@Autowired
	APIService4Feign userRegistrationFeignImpl;
	@Autowired
	GenerateRandomDigits randomDigits;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	 UserAgentService userAgentService = new UserAgentService();
	 UserAgentParser parser;
	private final Logger log = LoggerFactory.getLogger(getClass());

	public String registrationView(String usertype,Model model,HttpSession session) {
		log.info("inside registration view controller");
		log.info("usertype given: "+usertype);
		HashMap<String, String> map=new HashMap<String,String>();
		map.put("Importer", "registration");
		map.put("Distributor", "registration");
		map.put("Retailer", "registration");
		map.put("TRC", "customRegistration");
		map.put("Manufacturer", "customRegistration");
		map.put("Lawful Agency", "customRegistration");
		map.put("Custom", "customRegistration");
		map.put("Operator", "operatorRegistration");
		map.put("Immigration", "customRegistration");
		map.put("DRT", "customRegistration");
		if(usertype!=null) {
			String output= map.get(usertype);
			log.info("value for key: "+output);
			if(output==null || ("").equals(output)) {
				output="index";
			}
			else {
				Usertype usertypeData=userRegistrationFeignImpl.userypeDataByName(usertype);
				log.info("usertypeData by usertypeName"+usertypeData);
				model.addAttribute("usertypeId", usertypeData.getId());
				log.info("now check registration available or not");;
                HttpResponse response=userRegistrationFeignImpl.checkRegistration(usertypeData.getId());
                log.info("response got: "+response);
                session.removeAttribute("response");
                session.removeAttribute("statusCode");
                session.removeAttribute("usertypeId");
                session.setAttribute("tag",response.getTag());
                session.setAttribute("statusCode",response.getStatusCode());
                session.setAttribute("usertypeId",usertypeData.getId());
			}
			return output;

		}
		else {
			log.info("if usertype is null");
			return "index";
		}
	}
	public ModelAndView ImporterRegistrationView(Integer usertypeId) {
		log.info("view registration page starting point");
		log.info("usertypeId from registration page:  "+usertypeId);
		ModelAndView mv=new ModelAndView();   
		mv.setViewName("registration");
		log.info("view registration page ending point");
		return mv;                
	}

	public ModelAndView customRegistrationView(Integer usertypeId) {
		log.info("view registration page starting point");
		log.info("usertypeId from registration page:  "+usertypeId);
		ModelAndView mv=new ModelAndView();       
		mv.setViewName("customRegistration");
		log.info("view registration page ending point");
		return mv;                
	}                                                 

	public ModelAndView operatorRegistrationView(Integer usertypeId) {
		log.info("view registration page starting point");
		log.info("usertypeId from registration page:  "+usertypeId);
		ModelAndView mv=new ModelAndView();    
		mv.setViewName("operatorRegistration");
		log.info("view registration page ending point");
		return mv;                
	}                    

	public OtpResponse saveOtherRegistration(String data,MultipartFile photo,MultipartFile nationalIdImage,MultipartFile idCard,HttpSession session,HttpServletRequest request,MultipartFile vatFile) throws IOException {
		Gson gson=new Gson();                       
		Registration registration=gson.fromJson(data, Registration.class);
		UserHeader header=getUserHeaders(request);
		registration.setUserAgent(header.getUserAgent());
		registration.setPublicIp(header.getPublicIp());
		log.info("save registration page starting point");
		log.info("registration data:  "+registration);        
		String validCaptcha=(String)session.getAttribute("captcha_security");      
		log.info("captcha from session:  "+validCaptcha); 
		if(registration.getCaptcha().equals(validCaptcha)) {
			log.info("if captcha match");  
			if(registration.getRePassword().equals(registration.getPassword())) {
				
				log.info("if password and confirm password match");
				String username=randomDigits.getAlphaNumericString(4)+randomDigits.getNumericString(4)+randomDigits.getAlphaNumericString(1);
				registration.setUsername(username);
				Tag tagData=new Tag("user_upload_filepath");
				Dropdown dropdown = feignCleintImplementation.dataByTag(tagData);
				log.info("user upload file path value from db: "+dropdown.getValue());
				StringBuilder combinedPath=new StringBuilder(dropdown.getValue()).append("/"+username);
				//give file read and write  permission to txnId Directory
				/*
				 * File dir1 = new File(combinedPath + File.separator);
				 * dir1.setReadable(true,false); dir1.setWritable(true,false);
				 * dir1.setExecutable(true,false);
				 */
				File dir1 = new File(combinedPath + File.separator);
				String nationalIdPath=new String(combinedPath+"/NID");  
				String photoPath=new String(combinedPath+"/photo");
				String idCardPath=new String(combinedPath+"/IDCard");  
				String vatFilePath=new String(combinedPath+"/Vat");
				if(nationalIdImage.isEmpty()==false) {
					log.info("going to save user NationalId file");
					log.info("file name: " +nationalIdImage.getOriginalFilename());
					log.info("finalPath:   "+nationalIdPath);  
					File dir = new File(nationalIdPath);
				
					if (!dir.exists()) {
						
						dir.mkdirs();
						dir.setReadable(true,false);
						dir.setWritable(true,false);
						dir.setExecutable(true,false);
						
						dir1.setReadable(true,false);
						dir1.setWritable(true,false);
						dir1.setExecutable(true,false);
						
					}
					byte barr[]=nationalIdImage.getBytes();
					BufferedOutputStream bout=new BufferedOutputStream(new FileOutputStream(nationalIdPath + "/" + nationalIdImage.getOriginalFilename()));
					File files =	new File(nationalIdPath + "/" + nationalIdImage.getOriginalFilename());
					  files.setReadable(true,false);
					  files.setWritable(true,false);
					  files.setExecutable(true,false);
					bout.write(barr);
					bout.flush();
					bout.close(); 
					registration.setNidFilename(nationalIdImage.getOriginalFilename());
				} 

				if(photo.isEmpty()==false) {
					log.info("going to save user photo file");
					log.info("file name: " +photo.getOriginalFilename());
					log.info("finalPath:   "+photoPath);  
					File dir = new File(photoPath);
					
					if (!dir.exists()) 
						{
						dir.mkdirs();
						dir.setReadable(true,false);
						dir.setWritable(true,false);
						dir.setExecutable(true,false);
						dir1.setReadable(true,false);
						dir1.setWritable(true,false);
						dir1.setExecutable(true,false);
						}
					byte barr[]=photo.getBytes();
					BufferedOutputStream bout=new BufferedOutputStream(new FileOutputStream(photoPath + "/" + photo.getOriginalFilename()));
					File files =	new File(photoPath + "/" + photo.getOriginalFilename());
					  files.setReadable(true,false);
					  files.setWritable(true,false);
					  files.setExecutable(true,false);
					bout.write(barr);
					bout.flush();
					bout.close();  
					registration.setPhotoFilename(photo.getOriginalFilename());
				} 

				if(idCard.isEmpty()==false) {
					log.info("going to save user id card file");
					log.info("file name: " +idCard.getOriginalFilename());
					log.info("finalPath:   "+idCardPath);  
					log.info("going to save id card file in server");
					File dir = new File(idCardPath);   
					if (!dir.exists()) {
						dir.mkdirs();
						  dir.setReadable(true,false);
						  dir.setWritable(true,false);
						  dir.setExecutable(true,false);
							dir1.setReadable(true,false);
							dir1.setWritable(true,false);
							dir1.setExecutable(true,false);
					}
					byte barr[]=idCard.getBytes();
					BufferedOutputStream bout=new BufferedOutputStream(new FileOutputStream(idCardPath + "/" + idCard.getOriginalFilename()));
					File files =	new File(idCardPath + "/" + idCard.getOriginalFilename());
					  files.setReadable(true,false);
					  files.setWritable(true,false);
					  files.setExecutable(true,false);
					bout.write(barr);
					bout.flush();
					bout.close(); 
					registration.setIdCardFilename(idCard.getOriginalFilename());
					log.info("id card file save in server");
				} 
				if(registration.getUserTypeId()==12) {
					log.info("vat file "+vatFile.getOriginalFilename());
				if(vatFile.isEmpty()==false) {
					log.info("file name: " +vatFile.getOriginalFilename());
					log.info("finalPath:   "+vatFilePath);
					log.info("path plus filename: "+vatFilePath+vatFile.getOriginalFilename());
					File dir = new File(vatFilePath);
					if (!dir.exists()) {
						  dir.mkdirs();
						  dir.setReadable(true,false);
						  dir.setWritable(true,false);
						  dir.setExecutable(true,false);
							dir1.setReadable(true,false);
							dir1.setWritable(true,false);
							dir1.setExecutable(true,false);
					}
					byte barr[]=vatFile.getBytes();
					BufferedOutputStream bout=new BufferedOutputStream(new FileOutputStream(vatFilePath + "/" + vatFile.getOriginalFilename()));
					  File files =	new File(vatFilePath + "/" + vatFile.getOriginalFilename());
					  files.setReadable(true,false);
					  files.setWritable(true,false);
					  files.setExecutable(true,false);
					bout.write(barr);
					bout.flush();
					bout.close();
					registration.setVatFilename(vatFile.getOriginalFilename());
				}
				}

				log.info("now going to call registration api");
				OtpResponse response=userRegistrationFeignImpl.registration(registration);
				log.info("registration response:  "+response);
				return response;

			}  
			else {

				OtpResponse response=new OtpResponse();
				log.info("confirm password is not same as password");
				response.setTag("password_mismatch");
				response.setResponse("Password and Confirm password must be same");
				return response;
			}
		}
		else {
			log.info("if captcha not match");
			OtpResponse response=new OtpResponse();
			response.setTag("Wrong_captcha");
			response.setResponse("You have entered the wrong Captcha. Please enter the correct value");
			return response;
		}


	}

	public OtpResponse saveRegistration(String data, MultipartFile file,MultipartFile vatFile,HttpSession session,HttpServletRequest request) throws IOException {
		Gson gson=new Gson();                       
		Registration registration=gson.fromJson(data, Registration.class);
		UserHeader header=getUserHeaders(request);
		registration.setUserAgent(header.getUserAgent());
		registration.setPublicIp(header.getPublicIp());
		registration.setBrowser(header.getBrowser());
		log.info("save registration page starting point");
		log.info("registration data:  "+registration);        
		String validCaptcha=(String)session.getAttribute("captcha_security");      
		log.info("captcha from session:  "+validCaptcha); 
		if(registration.getCaptcha().equals(validCaptcha)) {
			log.info("if captcha match");  
			if(registration.getRePassword().equals(registration.getPassword())) {
				log.info("if password and confirm password match");
				String username=randomDigits.getAlphaNumericString(4)+randomDigits.getNumericString(4)+randomDigits.getAlphaNumericString(1);
				registration.setUsername(username);
				Tag tagData=new Tag("user_upload_filepath");
				Dropdown dropdown = feignCleintImplementation.dataByTag(tagData);	
				log.info("user upload file path value from db: "+dropdown.getValue());
				StringBuilder combinedPath=new StringBuilder(dropdown.getValue()).append("/"+username);
				//give file read and write  permission to txnId Directory
				File dir1 = new File(combinedPath + File.separator);
				
				String nationalIdPath=new String(combinedPath+"/NID");  
				String vatFilePath=new String(combinedPath+"/Vat");
				if(registration.getVatStatus()==1) {
					if(vatFile.isEmpty()==false) {
						log.info("file name: " +vatFile.getOriginalFilename());
						log.info("finalPath:   "+vatFilePath);
						log.info("path plus filename: "+vatFilePath+vatFile.getOriginalFilename());
						File dir = new File(vatFilePath);
						if (!dir.exists()) {
							dir.mkdirs();
							dir.setReadable(true,false);
							dir.setWritable(true,false);
							dir.setExecutable(true,false);
							dir1.setReadable(true,false);
							dir1.setWritable(true,false);
							dir1.setExecutable(true,false);
						}
						byte barr[]=vatFile.getBytes();
						BufferedOutputStream bout=new BufferedOutputStream(new FileOutputStream(vatFilePath + "/" + vatFile.getOriginalFilename()));
			            File files =	new File(vatFilePath + "/" + vatFile.getOriginalFilename());
			            files.setReadable(true,false);
			            files.setWritable(true,false);
			            files.setExecutable(true,false);
						bout.write(barr);
						bout.flush();
						bout.close();
						registration.setVatFilename(vatFile.getOriginalFilename());
					}
				}
				else {}
				if(registration.getType()==0){
					log.info("if user is individual");       
					if(file.isEmpty()==true) { 
						log.info("if file is empty");
						OtpResponse response=new OtpResponse();
						response.setResponse("please upload national information");
						return response;
					}     
					else{ 
						log.info("if user is individual  "); 
						log.info("file name: " +file.getOriginalFilename());
						log.info("finalPath:   "+nationalIdPath);  
						File dir = new File(nationalIdPath);
						if (!dir.exists()) {
							dir.mkdirs();
							dir.setReadable(true,false);
					        dir.setWritable(true,false);
					        dir.setExecutable(true,false);
					        dir1.setReadable(true,false);
							dir1.setWritable(true,false);
							dir1.setExecutable(true,false);
						}
						byte barr[]=file.getBytes();
						BufferedOutputStream bout=new BufferedOutputStream(new FileOutputStream(nationalIdPath + "/" + file.getOriginalFilename()));
						 File files =	new File(nationalIdPath + "/" + file.getOriginalFilename());
						  files.setReadable(true,false);
				          files.setWritable(true,false);
				          files.setExecutable(true,false);
						 bout.write(barr);
						bout.flush();
						bout.close();   
						registration.setNidFilename(file.getOriginalFilename());
						OtpResponse response=userRegistrationFeignImpl.registration(registration);
						log.info("registration response:  "+response);
						return response;

					}  
				}  
				else { 
					log.info("if user either company , organization or government");  

					OtpResponse response=userRegistrationFeignImpl.registration(registration);
					log.info("response from server:  "+response);
					return response;

				}


			}  
			else {

				OtpResponse response=new OtpResponse();
				response.setTag("password_mismatch");
				log.info("confirm password is not same as password");
				response.setResponse("Password and Confirm password must be same");
				return response;
			}
		}
		else {
			log.info("if captcha not match");
			OtpResponse response=new OtpResponse();
			response.setTag("Wrong_captcha");
			response.setResponse("You have entered the wrong Captcha. Please enter the correct value");
			return response;
		}
	}  

	public String otpPage() {
		log.info("inside verify otp page");
		return "verifyOtp";  
	} 

	public HttpResponse verifyOtp(Otp otp,HttpServletRequest request) {
		log.info("inside verify otp controller");
		  
		UserHeader header=getUserHeaders(request);
		otp.setUserAgent(header.getUserAgent());
		otp.setPublicIp(header.getPublicIp());
		otp.setBrowser(header.getBrowser());
		log.info("otp data:  "+otp);  
		HttpResponse response=userRegistrationFeignImpl.otpValidate(otp);
		log.info("verify otp api response:  "+response);
		log.info("exit from verify otp controller");
		return response;
	}

	public GenricResponse securityQuestionList(String username){
		log.info("inside security question controller and username: "+username);
		GenricResponse response =userRegistrationFeignImpl.securityQuestionList(username);
		return response; 
	}
	
	public List<SecurityQuestion> allSecurityQuestionList(){
		log.info("inside security question controller");
		List<SecurityQuestion> response =userRegistrationFeignImpl.getAllSecurityQuestion();
		return response; 
	}
	public HttpResponse resendOtp(Integer id,HttpServletRequest request) {
		log.info("inside resend otp controller");
		log.info("id:   "+id);     
		UserHeader header=getUserHeaders(request);
		ResendOtp otp=new ResendOtp(header.getUserAgent(),header.getPublicIp(),id);
		otp.setBrowser(header.getBrowser());
		log.info("otp resend:   "+otp);
		HttpResponse response=userRegistrationFeignImpl.otpResend(otp); 
		log.info("resend otp api response:  "+response);
		log.info("exit from resend otp controller");
		return response;
	}
	
	public HttpResponse profileResendOtp(Integer id,HttpServletRequest request) {
		log.info("inside resend otp controller");
		log.info("id:   "+id);     
		UserHeader header=getUserHeaders(request);
		ResendOtp otp=new ResendOtp(header.getUserAgent(),header.getPublicIp(),id);
		otp.setBrowser(header.getBrowser());
		log.info("resend otp api request:  "+otp);
		HttpResponse response=userRegistrationFeignImpl.profileResendOtp(otp); 
		log.info("resend otp api response:  "+response);
		log.info("exit from resend otp controller");
		return response;
	}

	public void captcha(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException{
		log.info("inside captcha controller");
		response.setContentType("image/jpg");
		int iTotalChars = 6;
		int iHeight = 40;
		int iWidth = 150; 
		Font fntStyle1 = new Font("Arial", Font.BOLD, 30);
		Random randChars = new Random();
		String sImageCode = (Long.toString(Math.abs(randChars.nextLong()), 36)).substring(0, iTotalChars);
		BufferedImage biImage = new BufferedImage(iWidth, iHeight, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2dImage = (Graphics2D) biImage.getGraphics();
		int iCircle = 15;
		for (int i = 0; i < iCircle; i++) {
			g2dImage.setColor(new Color(randChars.nextInt(255), randChars.nextInt(255), randChars.nextInt(255)));
		}
		g2dImage.setFont(fntStyle1);
		for (int i = 0; i < iTotalChars; i++) {
			g2dImage.setColor(new Color(randChars.nextInt(255), randChars.nextInt(255), randChars.nextInt(255)));
			if (i % 2 == 0) {
				g2dImage.drawString(sImageCode.substring(i, i + 1), 25 * i, 24);
			} else {
				g2dImage.drawString(sImageCode.substring(i, i + 1), 25 * i, 35);
			}
		}
		OutputStream osImage = response.getOutputStream();
		ImageIO.write(biImage, "jpeg", osImage);
		g2dImage.dispose();
		session.setAttribute("captcha_security", sImageCode);
		log.info("exit from captcha controller");
	}

	public UserHeader getUserHeaders(HttpServletRequest request) {
		
	
		try {
			parser = userAgentService.loadParser();
			/*
			 * Arrays.asList(BrowsCapField.BROWSER, BrowsCapField.BROWSER_TYPE,
			 * BrowsCapField.BROWSER_MAJOR_VERSION, BrowsCapField.DEVICE_TYPE,
			 * BrowsCapField.PLATFORM, BrowsCapField.PLATFORM_VERSION,
			 * BrowsCapField.RENDERING_ENGINE_VERSION, BrowsCapField.RENDERING_ENGINE_NAME,
			 * BrowsCapField.PLATFORM_MAKER, BrowsCapField.RENDERING_ENGINE_MAKER)
			 */
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		String userIp = request.getHeader("HTTP_CLIENT_IP");
		
		  if(userIp == null) { userIp = request.getHeader("X-FORWARDED-FOR"); if(userIp
		  == null) { userIp = request.getRemoteAddr(); } }
		 
		log.info("client Ip:  "+userIp);
		final String userAgentHeader = request.getHeader("User-Agent");
		final Capabilities capabilities = parser.parse(userAgentHeader);
		// the default fields have getters
		String userAgent = request.getHeader("User-Agent");
		String browser = capabilities.getBrowser();
		if(userAgent!=null) {
			log.info("user agent: "+userAgent);
		}
		else {
			log.info("user-agent not available");
		}
		UserHeader headers=new UserHeader(userAgent,userIp,browser+"/"+capabilities.getPlatform());
		return headers;
	}
}
