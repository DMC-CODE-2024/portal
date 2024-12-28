package org.gl.ceir.CeirPannelCode.Controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.gl.ceir.CeirPannelCode.Feignclient.DBTablesFeignClient;
import org.gl.ceir.CeirPannelCode.Model.DBTableModel;
import org.gl.ceir.CeirPannelCode.Model.DBrowDataModel;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class DBTablesController {

	private final Logger log = LoggerFactory.getLogger(getClass());



	@Autowired
	DBTablesFeignClient dBTablesFeignClient;

	@GetMapping("/dbTables")
	public ModelAndView pageView(@RequestParam(name="via", required = false) String via,
								 @RequestParam(name="tableName", required = false) String tableName,
								 HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		if("other".equals(via)) {

			modelAndView.setViewName("viewDbTables");
		}
		else {
			modelAndView.setViewName("selectTable");
		}
		return modelAndView;
	}


	/*---------------------------------------- Select Table Dropdown ----------------------------------------*/

	@RequestMapping(value="/getallTables",method ={org.springframework.web.bind.annotation.RequestMethod.POST})
	public @ResponseBody DBTableModel dbTableList(@RequestParam(name="dbName") String dbName,
												  @RequestParam(name="featureId", required = false) Integer featureId,
												  @RequestParam(name="userId", required = false) Integer userId,
												  @RequestParam(name="userType", required = false) String userType,HttpSession session
	){
		log.info("going to fetch tables details");
		String publicIp=session.getAttribute("publicIP").toString();
		String browser=session.getAttribute("browser").toString();
		DBTableModel dbTableList = dBTablesFeignClient.getAlltables(dbName,featureId,userId,userType,publicIp,browser);
		return dbTableList;
	}



	/*---------------------------------------- Select DB Dropdown ----------------------------------------*/
	@RequestMapping(value="/getallDB",method ={org.springframework.web.bind.annotation.RequestMethod.POST})
	public @ResponseBody List<String> dbTableDB(HttpSession session){
		log.info("going to fetch db details");
		List<String> dbTableList = dBTablesFeignClient.getDBList();
		dbTableList.removeIf(Objects::isNull);
		dbTableList.sort(Comparator.comparing(x -> x,Comparator.nullsFirst(Comparator.naturalOrder())));
		Collections.sort(dbTableList,String.CASE_INSENSITIVE_ORDER);
		log.info("response of DB API="+dbTableList);
		return dbTableList;
	}

	//***************************************** Export DB Tables  controller *********************************


	@PostMapping("exportDbTablesData")
	@ResponseBody
	public FileExportResponse exportToExcel(@RequestBody DBrowDataModel filterRequest,HttpSession session)
	{
		Gson gsonObject=new Gson();
		Object response;
		Integer file = 1;
		filterRequest.setPublicIp(session.getAttribute("publicIP").toString());
		filterRequest.setBrowser(session.getAttribute("browser").toString());
		log.info("DBrowDataModel:::::::::"+filterRequest);
		response=  dBTablesFeignClient.DBRowDetailsFeign(filterRequest, filterRequest.getPageNo(), filterRequest.getPageSize(), file);
		FileExportResponse fileExportResponse;
		Gson gson= new Gson();
		String apiResponse = gson.toJson(response);
		fileExportResponse = gson.fromJson(apiResponse, FileExportResponse.class);
		log.info("response  from  DB Export  api="+fileExportResponse);

		return fileExportResponse;
	}
}

