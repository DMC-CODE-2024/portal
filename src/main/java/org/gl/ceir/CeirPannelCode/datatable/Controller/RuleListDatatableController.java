package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.RuleListContent;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.RuleListPaginationModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.google.gson.Gson;

@RestController
public class RuleListDatatableController {
	private final Logger log = LoggerFactory.getLogger(getClass());
	String className = "emptyClass";
	@Autowired
	Translator Translator;
	@Autowired
	PageElement pageElement;
	@Autowired
	Button button;
	@Autowired
	FeignCleintImplementation feignCleintImplementation;
	@Autowired
	IconsState iconState;
	@Autowired
	DatatableResponseModel datatableResponseModel;
	@Autowired
	RuleListPaginationModel ruleListPaginationModel;
	@PostMapping("ruleListData")
	public ResponseEntity<?> getData(@RequestParam(name="type",required = false) String role, HttpServletRequest request,HttpSession session) {

		List<List<Object>> finalList=new ArrayList<List<Object>>();
		String filter = request.getParameter("filter").replace("&#34;", "\"");
		
		//System.out.println("##########################################"+filter);
		
		Gson gsonObject=new Gson();
		FilterRequest filterRequest = gsonObject.fromJson(filter, FilterRequest.class);
		Integer file = 0;
		Integer pageSize = Integer.parseInt(request.getParameter("length"));
		Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize ;
		filterRequest.setSearchString(request.getParameter("search[value]"));
		
		log.info("---->"+request.getParameter("order[0][column]")+"============>"+request.getParameter("order[0][dir]"));
		String column="0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Created On":
			"1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Modified On":
				"2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Name":
					"3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Description" :
						"4".equalsIgnoreCase(request .getParameter("order[0][column]")) ? "Status"
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
		filterRequest.setOrderColumnName(column);
		filterRequest.setOrder(order);
		
		
		
		log.info("pageSize"+pageSize+"-----------pageNo---"+pageNo);
		try {
			filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
			filterRequest.setBrowser(session.getAttribute("browser").toString());
			log.info("request send to the filter api ="+filterRequest);
			Object response = feignCleintImplementation.ruleListFeign(filterRequest, pageNo, pageSize, file);
			log.info("response in datatable"+response);
			Gson gson= new Gson(); 
			String apiResponse = gson.toJson(response);
			ruleListPaginationModel = gson.fromJson(apiResponse, RuleListPaginationModel.class);
			List<RuleListContent> ruleListContent = ruleListPaginationModel.getContent();
			if(ruleListContent.isEmpty()) {
				datatableResponseModel.setData(Collections.emptyList());
			}
			else {
			for(RuleListContent dataInsideList : ruleListContent) 
				{
				   String id =  String.valueOf(dataInsideList.getId());	
				   String createdOn = dataInsideList.getCreatedOn();
				   String modifiedOn = dataInsideList.getModifiedOn();
				   String name = dataInsideList.getName();
				   String description = dataInsideList.getDescription();
				   String state=dataInsideList.getState();
				   String output=dataInsideList.getOutput();
				   //log.info("Id-->"+Id+"--userStatus--->"+userStatus+"--StatusName---->"+StatusName+"--createdOn---->"+createdOn+"--id--->"+id+"--userName-->"+username);
				   String action=iconState.ruleListIcons(id,output);			   
				   Object[] finalData={createdOn,modifiedOn,name,description,state,action}; 
				   List<Object> finalDataList=new ArrayList<Object>(Arrays.asList(finalData));
					finalList.add(finalDataList);
					datatableResponseModel.setData(finalList);	
					
			}
		}
			//data set on ModelClass
			datatableResponseModel.setRecordsTotal(ruleListPaginationModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(ruleListPaginationModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK); 
	}catch(Exception e) {
		datatableResponseModel.setRecordsTotal(null);
		datatableResponseModel.setRecordsFiltered(null);
		datatableResponseModel.setData(Collections.emptyList());
		log.error(e.getMessage(),e);
		return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR); 
		}

	}


	@PostMapping("ruleList/pageRendering")
	public ResponseEntity<?> pageRendering(HttpSession session){

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");
		
		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;
		
		pageElement.setPageTitle(Translator.toLocale("title.ruleList"));
		
		List<Button> buttonList = new ArrayList<>();
		List<InputFields> dropdownList = new ArrayList<>();
		List<InputFields> inputTypeDateList = new ArrayList<>();
			
			log.info("USER STATUS:::::::::"+userStatus);
			log.info("session value user Type=="+session.getAttribute("usertype"));
/*
			String[] names = { "HeaderButton", Translator.toLocale("button.addCurrency"), "AddCurrencyAddress()", "btnLink",
					"FilterButton", Translator.toLocale("button.filter"),"filter(" + ConfigParameters.languageParam + ")", "submitFilter" };
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
			}		*/
		//	pageElement.setButtonList(buttonList);
			
		  //Dropdown items
/*			String[] selectParam= {"select",Translator.toLocale("table.status"),"State",""};
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
		*/
		//input type date list		
		String[] dateParam= {"date",Translator.toLocale("input.startDate"),"startDate","","date",Translator.toLocale("input.endDate"),"endDate","","text","Name", "filterRule", "","text","Description", "filterDescription", "","select","Status","State","" };
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













//********************************************** open register page or edit popup *****************************
@GetMapping("/viewRuleListAPI/{id}")
public @ResponseBody RuleListContent view(@PathVariable("id") Integer id,HttpServletRequest request,HttpSession session)
{
RuleListContent ruleListContent= new RuleListContent();
ruleListContent=feignCleintImplementation.fetchData(id);
log.info(" response::::"+ruleListContent);

return ruleListContent;
}







//************************************************ update consignment record page********************************************************************************/

@RequestMapping(value= {"/updateRuleList"},method={org.springframework.web.bind.annotation.RequestMethod.GET,org.springframework.web.bind.annotation.RequestMethod.POST}) 
public @ResponseBody GenricResponse updateRecord(@RequestBody RuleListContent ruleListContent,HttpSession session) 
{
	//RuleListContent ruleList = new RuleListContent();
	ruleListContent.setPublicIp(session.getAttribute("publicIP").toString());
	ruleListContent.setBrowser(session.getAttribute("browser").toString());
	log.info("request::::::"+ruleListContent);
GenricResponse response = feignCleintImplementation.update(ruleListContent);
log.info(" response from update Consignment api="+response);
return response;

}

}