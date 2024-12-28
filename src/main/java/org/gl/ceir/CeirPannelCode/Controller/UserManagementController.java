package org.gl.ceir.CeirPannelCode.Controller;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.NewSystemUser;
import org.gl.ceir.CeirPannelCode.Util.GenerateRandomDigits;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class UserManagementController {

	@Autowired
	GenerateRandomDigits randomDigits;
	@Autowired
	APIService4Feign apiService4Feign;

	private final Logger log = LoggerFactory.getLogger(getClass());

	@RequestMapping(value = { "/userManagement" }, method = { org.springframework.web.bind.annotation.RequestMethod.GET,
			org.springframework.web.bind.annotation.RequestMethod.POST })
	public ModelAndView viewUserManagement(
			@RequestParam(name = "type", defaultValue = "user_modal", required = false) String type,
			HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if ("user_view".equalsIgnoreCase(type)) {
			mv.setViewName("userManagementView");
		} else {
			mv.setViewName("userManagement");
		}
		log.info(" view viewUserManagement exit point.");
		return mv;
	}

	@GetMapping("register-user-form")
	public ModelAndView save() {
		return new ModelAndView("addSystemUser");

	}

	@RequestMapping(value = { "/saveNewSystemUser" }, method = {
			org.springframework.web.bind.annotation.RequestMethod.GET,
			org.springframework.web.bind.annotation.RequestMethod.POST })
	public @ResponseBody GenricResponse saveRecord(@RequestBody NewSystemUser newSystemUser, HttpSession session) {

		if (newSystemUser.getRePassword().equals(newSystemUser.getPassword())) {
			log.info("if password and confirm password match");
			String username = randomDigits.getAlphaNumericString(4) + randomDigits.getNumericString(4)
					+ randomDigits.getAlphaNumericString(1);
			newSystemUser.setUserName(username);
			newSystemUser.setPublicIp(session.getAttribute("publicIP").toString());
			newSystemUser.setBrowser(session.getAttribute("browser").toString());
			log.info("request::::::" + newSystemUser);
			GenricResponse response = apiService4Feign.saveSystemUser(newSystemUser);
			log.info("response::::::" + response);
			return response;
		} else {
			GenricResponse response = new GenricResponse();
			log.info("confirm password is not same as password");
			response.setTag("password_mismatch");
			response.setResponse("Password and Confirm password must be same");
			return response;
		}

	}

	// ------------------------------------- view User
	// ----------------------------------------

	@PostMapping("viewUser")
	public @ResponseBody GenricResponse viewUser(@RequestBody NewSystemUser newSystemUser,HttpSession session) {
		newSystemUser.setPublicIp(session.getAttribute("publicIP").toString());
		newSystemUser.setBrowser(session.getAttribute("browser").toString());
		log.info("request send to the viewUser api=" + newSystemUser);
		GenricResponse response = apiService4Feign.viewUserFeign(newSystemUser);
		log.info("response from viewUser api " + response);
		return response;
	}

	// ------------------------------------- update user type
	// ----------------------------------------

	@PostMapping("updateUser")
	public @ResponseBody GenricResponse updateUserDetail(@RequestBody NewSystemUser newSystemUser,HttpSession session) {
		newSystemUser.setPublicIp(session.getAttribute("publicIP").toString());
		newSystemUser.setBrowser(session.getAttribute("browser").toString());
		log.info("request send to the Update user api=" + newSystemUser);
		GenricResponse response = apiService4Feign.updateUserFeign(newSystemUser);
		log.info("response from update api " + response);
		return response;
	}

	// ------------------------------------- Delete User
	// ----------------------------------------

	@PostMapping("deleteSystemUserType")
	public @ResponseBody GenricResponse delete(@RequestBody NewSystemUser newSystemUser,HttpSession session) {
		newSystemUser.setPublicIp(session.getAttribute("publicIP").toString());
		newSystemUser.setBrowser(session.getAttribute("browser").toString());
		GenricResponse response = apiService4Feign.deleteUserFeign(newSystemUser);
		return response;

	}

	// ------------------------------------ Export Field controller
	// ------------------------------------

	@PostMapping("exportUserManagementData")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody FilterRequest filterRequest, HttpSession session) {
		Gson gsonObject = new Gson();
		Object response;
		Integer file = 1;
		String userType = (String) session.getAttribute("usertype");
		Integer usertypeId = (int) session.getAttribute("usertypeId");
		filterRequest.setUserType(userType);
		filterRequest.setUserTypeId(usertypeId);
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("filterRequest:::::::::" + filterRequest);
		response = apiService4Feign.viewSystemUserManagementRequest(filterRequest, filterRequest.getPageNo(),
				filterRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson = new Gson();
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response  from  Export user management api=" + fileExportResponse);

		return fileExportResponse;
	}
}
