package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.util.HtmlUtils;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.Service.RegistrationService;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.IconsState;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.ConfigContentModel;
import org.gl.ceir.CeirPannelCode.datatable.model.ConfigPaginationModel;
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
public class ConfigDatatableController {

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
	ConfigContentModel configContentModel;
	@Autowired
	ConfigPaginationModel configPaginationModel;
	
	@Autowired
	RegistrationService registerService;

	
	@PostMapping("adminConfigData")
	public ResponseEntity<?> viewAdminConfig(@RequestParam(name="type",defaultValue = "Config",required = false) String role, HttpServletRequest request,HttpSession session) {
		//String userType = (String) session.getAttribute("usertype");
		//int userId=	(int) session.getAttribute("userid");
		// Data set on this List
		System.out.println("##################*****************########################");
		System.out.println("##########################################"+request.toString());
				List<List<Object>> finalList=new ArrayList<List<Object>>();
				String filter = request.getParameter("filter").replace("&#34;", "\"");
				
				System.out.println("##########################################"+filter);
				
				
				Gson gsonObject=new Gson();
				FilterRequest filterrequest = gsonObject.fromJson(filter, FilterRequest.class);
				String column=null;
				 column="0".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Created On":
						"1".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Modified On":
							"2".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Module Name":
							"3".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Description":
								"4".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Value":
									"5".equalsIgnoreCase(request.getParameter("order[0][column]")) ? "Type":
										"Modified On";
					String order;
		/*
		 * if("Modified On".equalsIgnoreCase(column)) { order="desc"; } else {
		 * order=request.getParameter("order[0][dir]"); }
		 *
		 *
		 */
					System.out.println("#########################22222222222222222#################");
					try {
						if ("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]")==null) {
							order = "desc";
						} 
						else if("Modified On".equalsIgnoreCase(column) && request.getParameter("order[0][dir]")=="asc"){
							order ="asc";
						}
						else {
							order = request.getParameter("order[0][dir]");
						} 
						filterrequest.setColumnName(column);
						filterrequest.setSort(order);
						filterrequest.setFilterPublicIp(session.getAttribute("publicIP").toString());
						filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
						filterrequest.setBrowser(session.getAttribute("browser").toString());
						filterrequest.setFilterBrowser(session.getAttribute("browser").toString());
					} catch (Exception e) {
						// TODO: handle exception
						System.out.println("#########################3333333333333#################");
						e.printStackTrace();
						System.out.println("Exception in " +e.getMessage());
					}
					
					
				 
				Integer file = 0;
				Integer pageSize = Integer.parseInt(request.getParameter("length"));
				Integer pageNo = Integer.parseInt(request.getParameter("start")) / pageSize ;
				log.info("pageSize"+pageSize+"-----------pageNo---"+pageNo);
				filterrequest.setSearchString(request.getParameter("search[value]"));
		try {
			
			//This method responding slow for getting public IP and Browser.
			//UserHeader header=registerService.getUserHeaders(request);
			//filterrequest.setPublicIp(header.getPublicIp());
			//filterrequest.setBrowser(header.getBrowser());
			
			//log.info("importer dashboard entry point..");log.info("publicIP " +session.getAttribute("publicIP").toString()+ " And Browser " +session.getAttribute("browser").toString());
			//filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
			//filterrequest.setBrowser(session.getAttribute("browser").toString());
			log.info("+++++++++++_______________++++++++++++++++++____________________+++++++++++++++++___________________+++++++");
			log.info("request send to the filter api ="+filterrequest);
			Object response = feignCleintImplementation.adminConfigFeign(filterrequest, pageNo, pageSize, file);
			log.info("response in datatable"+response);
			
			Gson gson= new Gson(); 
			String apiResponse = gson.toJson(response);
			log.info("################# start inside apiResponse -->"+apiResponse);
			configPaginationModel = gson.fromJson(apiResponse, ConfigPaginationModel.class);
			List<ConfigContentModel> paginationContentList = configPaginationModel.getContent();
			if(paginationContentList.isEmpty()) {
				log.info("################# start inside paginationContentList.isEmpty() -->");
				datatableResponseModel.setData(Collections.emptyList());
			}else {
				String 	featureName="";
				log.info("################# start inside -->"+featureName);
				for(ConfigContentModel dataInsideList : paginationContentList) 
				{
				   String createdOn = (String) dataInsideList.getCreatedOn();
				   String modifiedOn = (String) dataInsideList.getModifiedOn();
				   log.info("################# start inside featureName -->"+featureName);
				   if(dataInsideList.getFeatureName()==null || dataInsideList.getFeatureName().equalsIgnoreCase("") || dataInsideList.getFeatureName().isEmpty()) {
					   featureName="NA";
					   log.info("################# if inside featureName -->"+dataInsideList.getFeatureName());
				   }else {
					   log.info("################# else inside featureName -->"+dataInsideList.getFeatureName());
					   featureName=dataInsideList.getFeatureName();
				   }
				   
				   log.info("################# Final End  inside featureName -->"+featureName+"#"+dataInsideList.getFeatureName());
				   String description = dataInsideList.getDescription();
				   String value = HtmlUtils.htmlEscape(dataInsideList.getValue());
				   String typeInterp = dataInsideList.getTypeInterp();
				   String tag = dataInsideList.getTag();
				   String type = String.valueOf(dataInsideList.getType());
				   String userStatus = (String) session.getAttribute("userStatus");
				   //log.info("----Id------"+Id+"-------id----------------"+id+"---userName-----"+username);
				   String action=iconState.adminConfigIcons(userStatus,tag, type);			   
				   Object[] finalData={createdOn,modifiedOn,featureName,description,value,typeInterp,action};
					List<Object> finalDataList=new ArrayList<Object>(Arrays.asList(finalData));
					finalList.add(finalDataList);
					datatableResponseModel.setData(finalList);	
			}
		}	
			
			//data set on ModelClass
			datatableResponseModel.setRecordsTotal(configPaginationModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(configPaginationModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK); 
		
		}catch(Exception e) {
			System.out.println("#########################4444444444444#################");
			e.printStackTrace();
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			log.error(e.getMessage(),e);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR); 
		}		
		
	}
	
	

	@PostMapping("configManagement/pageRendering")
	public ResponseEntity<?> pageRendering(@RequestParam(name="type",defaultValue = "Config",required = false) String role,HttpSession session){

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");
		
		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;
		
		pageElement.setPageTitle("System Management");
		
		List<Button> buttonList = new ArrayList<>();
		List<InputFields> dropdownList = new ArrayList<>();
		List<InputFields> inputTypeDateList = new ArrayList<>();
			
			log.info("USER STATUS:::::::::"+userStatus);
			log.info("session value user Type=="+session.getAttribute("usertype"));
			
	/*		String[] names= {"FilterButton", "Apply Filter","configManagementDatatable("+ConfigParameters.languageParam+")","submitFilter"};
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
			pageElement.setButtonList(buttonList);*/
			//input type date list	
			String[] dateParam= {"date","Start Date","startDate","","date","End Date","endDate","","select","Module Name","featureName","","text","Description","descriptionID","50","text","Value","valueID","50","select","Type","type",""};
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
			
			//Dropdown items			
		/*
		 * String[] selectParam= {"select","Type","type","",}; for(int i=0; i<
		 * selectParam.length; i++) { inputFields= new InputFields();
		 * inputFields.setType(selectParam[i]); i++;
		 * inputFields.setTitle(selectParam[i]); i++; inputFields.setId(selectParam[i]);
		 * i++; inputFields.setClassName(selectParam[i]); dropdownList.add(inputFields);
		 * } pageElement.setDropdownList(dropdownList);
		 */
			
			pageElement.setInputTypeDateList(inputTypeDateList);
			pageElement.setUserStatus(userStatus);
			return new ResponseEntity<>(pageElement, HttpStatus.OK); 
		
		
	}
	
}
