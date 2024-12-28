package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService4Feign;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.UserFeaturePagination;
import org.gl.ceir.CeirPannelCode.datatable.model.UserfeatureContent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

@RestController
public class UserFeatureDatatable {
	
	private final Logger log = LoggerFactory.getLogger(getClass());
	String className = "emptyClass";
	@Autowired
	Translator Translator;
	@Autowired
	DatatableResponseModel datatableResponseModel;
	@Autowired
	PageElement pageElement;
	@Autowired
	Button button;
	@Autowired
	IconsState iconState;
	@Autowired
	APIService4Feign apiService4Feign;
	@Autowired
	UserfeatureContent userfeatureContent;
	@Autowired
	UserFeaturePagination userFeaturePagination;
	
	@PostMapping("systemUserfeatureData")
	public ResponseEntity<?> viewuserFeatureMapping(@RequestParam(name="type",defaultValue = "userFeatureMapping",required = false) String role, HttpServletRequest request,HttpSession session) {
		//String userType = (String) session.getAttribute("usertype");
		//int userId=	(int) session.getAttribute("userid");
		int file=0;
		// Data set on this List
		List<List<Object>> finalList=new ArrayList<List<Object>>();
		String filter = request.getParameter("filter");
		Gson gsonObject=new Gson();
		FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);
		Integer pageSize = Integer.parseInt(request.getParameter("length"));
		Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize ;
		filterrequest.setSearchString(request.getParameter("search[value]"));
		log.info("---->"+request.getParameter("order[0][column]")+"============>"+request.getParameter("order[0][dir]"));
		String column="0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Created On":
			"1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Modified On":
				"2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "User Type":
					"3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Feature" :
						"4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Period"	
							:"Modified On";
		log.info("---->"+request.getParameter("order[0][column]")+"============>"+request.getParameter("order[0][dir]"));
		String order;
		if ("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]")==null) {
			order = "desc";
		} 
		else if("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]")=="asc"){
			order ="asc";
		}
		else {
			order = request.getParameter("order[0][dir]");
		}
		filterrequest.setOrderColumnName(column);
		filterrequest.setOrder(order);
		
		try{
			filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
			filterrequest.setBrowser(session.getAttribute("browser").toString());
			log.info("request send to the filter api ="+filterrequest);
			Object response = apiService4Feign.viewUserFeatureMappingRequest(filterrequest,pageNo,pageSize,file);
			log.info("response in datatable"+response);
			Gson gson= new Gson(); 
			String apiResponse = gson.toJson(response);
			userFeaturePagination = gson.fromJson(apiResponse, UserFeaturePagination.class);
			List<UserfeatureContent> paginationContentList = userFeaturePagination.getContent();
			if(paginationContentList.isEmpty()){
				datatableResponseModel.setData(Collections.emptyList());
				
			}else {
				for(UserfeatureContent dataInsideList : paginationContentList) 
				{
				  String id= String.valueOf(dataInsideList.getId());	
				   String createdOn= dataInsideList.getCreatedOn();
				   String modifiedOn = dataInsideList.getModifiedOn();
				   String usertypeInterp = dataInsideList.getUsertypeInterp();
				   String featureInterp = dataInsideList.getFeatureInterp();
				   String period =dataInsideList.getPeriodInterp();
				   String userStatus = (String) session.getAttribute("userStatus");	  
				   String action=iconState.userManagementIcons(id,userStatus);			   
				   Object[] finalData={createdOn,modifiedOn,usertypeInterp,featureInterp,period,action}; 
				   List<Object> finalDataList=new ArrayList<Object>(Arrays.asList(finalData));
					finalList.add(finalDataList);
					datatableResponseModel.setData(finalList);	
			}
			
			}
			datatableResponseModel.setRecordsTotal(userFeaturePagination.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(userFeaturePagination.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK); 
		}catch (Exception e) {
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			log.error(e.getMessage(),e);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR); 
		}
		
	}
	
	
	
	
	@PostMapping("systemUserFeature/pageRendering")
	public ResponseEntity<?> pageRendering(@RequestParam(name="type",defaultValue = "userFeatureMapping",required = false) String role,HttpSession session){

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");
		
		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;
		
		pageElement.setPageTitle(Translator.toLocale("User Feature Mapping"));
		
		List<Button> buttonList = new ArrayList<>();
		List<InputFields> dropdownList = new ArrayList<>();
		List<InputFields> inputTypeDateList = new ArrayList<>();
			
			log.info("USER STATUS:::::::::"+userStatus);
			log.info("session value user Type=="+session.getAttribute("usertype"));
			
			String[] names = { "HeaderButton", Translator.toLocale("button.addCurrency"), "AddCurrencyAddress()", "btnLink",
					"FilterButton", Translator.toLocale("button.filter"),"viewDatatable(" + ConfigParameters.languageParam + ")", "submitFilter" };
			for(int i=0; i< names.length ; i++) {
				button = new Button();
				button.setType(names[i]);
				i++;
				button.setButtonTitle(names[i]);
				i++;
				button.setButtonURL(names[i]);
				i++;
				button.setId(names[i]);
				buttonList.add(button);
			}			
			pageElement.setButtonList(buttonList);
			
		
		  //Dropdown items 
		  String[] selectParam={"select","Select UserType","userType","","select","Select Feature","feature","","select","Select Period","period",""}; 
		  for(int i=0; i<selectParam.length; i++) { 
				inputFields= new InputFields();
		  inputFields.setType(selectParam[i]); 
		  i++;
		  inputFields.setTitle(selectParam[i]);
		  i++; 
		  inputFields.setId(selectParam[i]);
		  i++; 
		  inputFields.setClassName(selectParam[i]);
		  dropdownList.add(inputFields);
		  } 
		pageElement.setDropdownList(dropdownList);
		 
			
			//input type date list		
			String[] dateParam= {"date",Translator.toLocale("input.startDate"),"startDate","","date",Translator.toLocale("input.endDate"),"endDate",""};
			for(int i=0; i< dateParam.length; i++) {
				dateRelatedFields= new InputFields();
				dateRelatedFields.setType(dateParam[i]);
				i++;
				dateRelatedFields.setTitle(dateParam[i]);
				i++;
				dateRelatedFields.setId(dateParam[i]);
				i++;
				dateRelatedFields.setClassName(dateParam[i]);
				inputTypeDateList.add(dateRelatedFields);
			}
			
			pageElement.setInputTypeDateList(inputTypeDateList);
			pageElement.setUserStatus(userStatus);
			return new ResponseEntity<>(pageElement, HttpStatus.OK); 
		
		
	}
}
