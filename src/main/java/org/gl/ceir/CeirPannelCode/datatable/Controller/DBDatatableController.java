package org.gl.ceir.CeirPannelCode.datatable.Controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DBTablesFeignClient;
import org.gl.ceir.CeirPannelCode.Model.DBrowDataModel;
import org.gl.ceir.CeirPannelCode.Model.MapDatatableResponse;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableHeaderModel;
import org.gl.ceir.CeirPannelCode.datatable.HeadersTitle.DatatableResponseModel;
import org.gl.ceir.CeirPannelCode.configuration.ConfigParameters;
import org.gl.ceir.CeirPannelCode.configuration.Translator;
import org.gl.ceir.CeirPannelCode.datatable.model.Button;
import org.gl.ceir.CeirPannelCode.datatable.model.InputFields;
import org.gl.ceir.CeirPannelCode.datatable.model.PageElement;
import org.gl.ceir.CeirPannelCode.datatable.model.DbTablesPaginationModel;
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
public class DBDatatableController {

	private final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	Translator Translator;
	@Autowired
	PageElement pageElement;
	@Autowired
	Button button;
	@Autowired
	DBTablesFeignClient dBTablesFeignClient;
	@Autowired
	DBrowDataModel dBrowDataModel;
	@Autowired
	DbTablesPaginationModel dbTablesPaginationModel;
	@Autowired
	DatatableResponseModel datatableResponseModel;

	@PostMapping("dbManagementData")
	public ResponseEntity<?> viewdbTable(HttpServletRequest request, HttpSession session) {
		List<List<Object>> finalList = new ArrayList<List<Object>>();
		
		String filter = request.getParameter("filter").replace("&#34;", "\"");
		
		log.info("##########################################"+filter);
		
		MapDatatableResponse map = new MapDatatableResponse();
		Gson gsonObject = new Gson();
		DBrowDataModel filterrequest = gsonObject.fromJson(filter, DBrowDataModel.class);
		Integer file = 0;
		Integer pageSize = Integer.parseInt(request.getParameter("length"));
		Integer pageNumber = Integer.parseInt(request.getParameter("start")) / pageSize ;

		log.info("pageSize"+pageSize+"-----------pageNumber---"+pageNumber);


		DBrowDataModel paginationContentList = null;
		try {
			filterrequest.setPublicIp(session.getAttribute("publicIP").toString());
			filterrequest.setBrowser(session.getAttribute("browser").toString());
			log.info("request passed to API:::::::::" + filterrequest);
			Object response = dBTablesFeignClient.DBRowDetailsFeign(filterrequest, pageNumber, pageSize,file);
			Gson gson = new Gson();
			String apiResponse = gson.toJson(response);
			log.info("apiResponse ::::::::::::::" + apiResponse);
			dbTablesPaginationModel = gson.fromJson(apiResponse, DbTablesPaginationModel.class);
			log.info("response::::::" + dbTablesPaginationModel);
			paginationContentList = dbTablesPaginationModel.getContent();
			log.info("paginationContentList----------->" +paginationContentList);
		}catch(Exception ex) {
			datatableResponseModel.setData(Collections.emptyList());
			datatableResponseModel.setRecordsTotal(0);
			datatableResponseModel.setRecordsFiltered(0);
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);
		}

		try {
			if(paginationContentList != null ) {
				if(dbTablesPaginationModel.getContent().getRowData() != null && dbTablesPaginationModel.getContent().getRowData().size()>0) {
					log.info("in if paginationContentList isnt null");
					for(Map<String, String> dataModel : dbTablesPaginationModel.getContent().getRowData()) {
						List<Object> datatableList = new ArrayList<Object>();
						for( String key : dataModel.keySet() ) {
							datatableList.add( dataModel.get(key));
						}
						finalList.add(datatableList);
						datatableResponseModel.setData(finalList);
					}
				}else {
					datatableResponseModel.setData(Collections.emptyList());
					log.info("else paginationContentList is null");
				}

			}else {
				datatableResponseModel.setData(Collections.emptyList());
			}


			datatableResponseModel.setRecordsTotal(dbTablesPaginationModel.getNumberOfElements());
			datatableResponseModel.setRecordsFiltered(dbTablesPaginationModel.getTotalElements());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.OK);

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			datatableResponseModel.setRecordsTotal(null);
			datatableResponseModel.setRecordsFiltered(null);
			datatableResponseModel.setData(Collections.emptyList());
			return new ResponseEntity<>(datatableResponseModel, HttpStatus.INTERNAL_SERVER_ERROR);

		}
	}



	private Object row(Map<String, String> column) {
		// TODO Auto-generated method stub
		return null;
	}

	@PostMapping("dbtableHeaders")
	public ResponseEntity<?> headers(@RequestParam("dbName") String dbName, @RequestParam("tableName") String tableName){
		List<DatatableHeaderModel> dataTableInputs = new ArrayList<>();
		try {

			DBrowDataModel filterrequest = dBTablesFeignClient.dbtableHeaders(dbName,tableName);
			for(String header : filterrequest.getColumns()) {
				dataTableInputs.add(new DatatableHeaderModel(header));
			}
			return new ResponseEntity<>(dataTableInputs, HttpStatus.OK);	
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(Collections.emptyList(), HttpStatus.UNAVAILABLE_FOR_LEGAL_REASONS);
		}

	}


	@PostMapping("dbTable/pageRendering")
	public ResponseEntity<?> pageRendering(String displayName, HttpSession session,@RequestParam("tableName") String tableName) {

		String userType = (String) session.getAttribute("usertype");
		String userStatus = (String) session.getAttribute("userStatus");
		
		InputFields inputFields = new InputFields();
		InputFields dateRelatedFields;

		List<Button> buttonList = new ArrayList<>();
		List<InputFields> dropdownList = new ArrayList<>();
		List<InputFields> inputTypeDateList = new ArrayList<>();
		log.info("USER STATUS:::::::::" + userStatus);
		log.info("session value user Type==" + session.getAttribute("usertype"));

		String[] names = { "HeaderButton", Translator.toLocale("button.addTag"), "AddField()", "btnLink"};
		for (int i = 0; i < names.length; i++) {
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

		/*
		 * //Dropdown items String[]
		 * selectParam={"select",Translator.toLocale("select.filterTagId"),"filterTagId"
		 * ,""}; for(int i=0; i<selectParam.length; i++) { inputFields= new
		 * InputFields(); inputFields.setType(selectParam[i]); i++;
		 * inputFields.setTitle(selectParam[i]); i++; inputFields.setId(selectParam[i]);
		 * i++; inputFields.setClassName(selectParam[i]); dropdownList.add(inputFields);
		 * } pageElement.setDropdownList(dropdownList);
		 */

		// input type date list
		String[] dateParam = { "date", Translator.toLocale("input.startDate"), "startDate", "", "date",
				Translator.toLocale("input.endDate"), "endDate", "" };
		for (int i = 0; i < dateParam.length; i++) {
			dateRelatedFields = new InputFields();
			dateRelatedFields.setType(dateParam[i]);
			i++;
			dateRelatedFields.setTitle(dateParam[i]);
			i++;
			dateRelatedFields.setId(dateParam[i]);
			i++;
			dateRelatedFields.setClassName(dateParam[i]);
			inputTypeDateList.add(dateRelatedFields);
		}
		
		pageElement.setPageTitle(Translator.toLocale("sidebar.DB_Tables")+" - "+tableName);
		pageElement.setInputTypeDateList(inputTypeDateList);
		pageElement.setUserStatus(userStatus);
		return new ResponseEntity<>(pageElement, HttpStatus.OK);
	}

}
