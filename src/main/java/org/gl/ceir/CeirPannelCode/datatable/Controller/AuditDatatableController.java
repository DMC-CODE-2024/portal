package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.AuditContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.AuditPaginationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import org.springframework.web.util.HtmlUtils;

@RestController
public class AuditDatatableController {
	private final Logger log = LoggerFactory.getLogger(getClass());
	@Autowired
	IconsState iconState;
	@Autowired
	PageElement pageElement;
	@Autowired
	Button button;
	@Autowired
	DatatableResponseModel datatableResponseModel;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	@Autowired
	AuditContentModel auditContentModel;
	@Autowired
	AuditPaginationModel auditPaginationModel;
	@Autowired
	Translator Translator;
	
	@PostMapping("auditManagementData")
	public ResponseEntity<?> viewAuditManagement(@RequestParam(name="type",defaultValue = "AuditManagement",required = false) String role, HttpServletRequest request,HttpSession session) {
		//String userType = (String) session.getAttribute("usertype");
		//int userId=	(int) session.getAttribute("userid");
		// Data set on this List
		List<List<Object>> finalList=new ArrayList<List<Object>>();
		String filter =  HtmlUtils.htmlUnescape(request.getParameter("filter"));
		
		System.out.println("##########################################"+filter);
		
		Gson gsonObject=new Gson();
		FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);
		Integer file = 0;
		Integer pageSize = Integer.parseInt(request.getParameter("length"));
		Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize ;
		if(request.getParameter("order[0][column]") == null && request.getParameter("order[0][dir]") == null) {
			filterrequest.setColumnName("modifiedOn");
			filterrequest.setSort("desc");
			}
		else {
		filterrequest.setColumnName(request.getParameter("order[0][column]"));
		filterrequest.setSort(request.getParameter("order[0][dir]"));
		}
		filterrequest.setSearchString(request.getParameter("search[value]"));
		log.info("pageSize"+pageSize+"-----------pageNo---"+pageNo);
		try {
			log.info("request send to the filter api ="+filterrequest);
			Object response = feignCleintImplementation.auditManagementFeign(filterrequest, pageNo, pageSize, file);
			log.info("response in datatable"+response);
			Gson gson= new Gson(); 
			String apiResponse = gson.toJson(response);
			auditPaginationModel = gson.fromJson(apiResponse, AuditPaginationModel.class);
			List<AuditContentModel> paginationContentList = auditPaginationModel.getContent();
			if(paginationContentList.isEmpty()) {
				datatableResponseModel.setData(Collections.emptyList());
			}else {
				for(AuditContentModel dataInsideList : paginationContentList) 
				{
				  String id = String.valueOf(dataInsideList.getId());	
				  String createdOn = dataInsideList.getCreatedOn();
				  log.info("Transaction ID is ["+dataInsideList.getTxnId()+"]");
				  String userName = "null".equals(dataInsideList.getUserName()) || dataInsideList.getUserName()==null || dataInsideList.getUserName()==" " || dataInsideList.getUserName().isEmpty() ? "NA" : dataInsideList.getUserName();
				//  String txnId = "null".equals(dataInsideList.getTxnId()) || dataInsideList.getTxnId()==null || dataInsideList.getTxnId()==" " || dataInsideList.getTxnId().isEmpty()   ? "NA" : dataInsideList.getTxnId();
				  String txnId = dataInsideList.getTxnId();
				  if (txnId == null || "null".equals(txnId) || txnId.isEmpty() || txnId.equals("") || txnId ==" " || txnId.trim().isEmpty()){
					  txnId = "NA";
				  }else {
					  txnId = dataInsideList.getTxnId();
				  }
				  // String modifiedOn = dataInsideList.getModifiedOn();
				  //String txnId = dataInsideList.getTxnId();
				 // String txnId = dataInsideList.getTxnId()==null ? "NA" : dataInsideList.getTxnId();
				  //String txnId = dataInsideList.getTxnId()=="null" ||dataInsideList.getTxnId()==null || dataInsideList.getTxnId()==" " ? "NA" : dataInsideList.getTxnId();
				  String getuserId = String.valueOf(dataInsideList.getUserId());
				  //String userName = dataInsideList.getUserName()==null ? "NA" : dataInsideList.getUserName();
				  
				 // String getuserId = String.valueOf(dataInsideList.getUserId());
				  //String userName = dataInsideList.getUserName();
				/*  String userTypeName = dataInsideList.getUserType();
				  String roleType = dataInsideList.getRoleType();*/
				  String featureName = dataInsideList.getFeatureName();
				  String subFeature = dataInsideList.getSubFeature();
				  String publicIp = dataInsideList.getPublicIp();
				  String browser = dataInsideList.getBrowser();
				   String userStatus = (String) session.getAttribute("userStatus");
				   String action=iconState.auditManagementIcons(userStatus,getuserId,id);		
				   Object[] finalData={createdOn,txnId,userName,featureName,subFeature,publicIp,browser,action};
				   List<Object> finalDataList=new ArrayList<Object>(Arrays.asList(finalData));
				   finalList.add(finalDataList);
				   datatableResponseModel.setData(finalList);	
			}
			}
			//data set on ModelClass
			datatableResponseModel.setRecordsTotal(auditPaginationModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(auditPaginationModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK); 
			
		}catch(Exception e) {
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			log.error(e.getMessage(),e);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR); 
		}
	}
	
	
	@PostMapping("audit/pageRendering")
	public ResponseEntity<?> pageRendering(@RequestParam(name="type",defaultValue = "Config",required = false) String role,HttpSession session){

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");
		
		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;
		
		pageElement.setPageTitle("Audit Management");
		
		List<Button> buttonList = new ArrayList<>();
		List<InputFields> dropdownList = new ArrayList<>();
		List<InputFields> inputTypeDateList = new ArrayList<>();
			
			log.info("USER STATUS:::::::::"+userStatus);
			log.info("session value user Type=="+session.getAttribute("usertype"));
			
			/*String[] names = { "HeaderButton", Translator.toLocale("button.addCurrency"), "AddCurrencyAddress()", "btnLink",
					"FilterButton", Translator.toLocale("button.filter"),"auditManagementDatatable(" + ConfigParameters.languageParam + ")", "submitFilter" };
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
			
		*/
		  //Dropdown items 
		/*
		 * String[] selectParam={"select","User Type","userType","","select","Role Type"
		 * ,"roleType","","select","Feature","feature",""}; for(int i=0;
		 * i<selectParam.length; i++) { inputFields= new InputFields();
		 * inputFields.setType(selectParam[i]); i++;
		 * inputFields.setTitle(selectParam[i]); i++; inputFields.setId(selectParam[i]);
		 * i++; inputFields.setClassName(selectParam[i]); dropdownList.add(inputFields);
		 * } pageElement.setDropdownList(dropdownList);
		 */
		 
			
			//input type date list		
			String[] dateParam= {"date",Translator.toLocale("input.startDate"),"startDate","","date",Translator.toLocale("input.endDate"),"endDate","",
                    "text",Translator.toLocale("input.transactionID"),"transactionID","18",
                    "text",Translator.toLocale("auditMgmt.UserName"),"userName","20",
                    "select",Translator.toLocale("table.feature"),"feature","",
                    "text",Translator.toLocale("table.SubFeature"),"subfeatureFilter","15",
                    "text",Translator.toLocale("table.publicIp"),"publicIpFilter","18","text",Translator.toLocale("table.browser"),"browserFilter","18"};
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
