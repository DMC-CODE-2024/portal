package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.TypeApprovedRequest;
import org.gl.ceir.CeirPannelCode.features.addressmgmt.model.AddressMgmtModel;
import org.gl.ceir.CeirPannelCode.features.cc.model.CustomerCareRequest;
import org.gl.ceir.CeirPannelCode.features.cc.model.CustomerCareResponse;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.*;
import org.gl.ceir.CeirPannelCode.features.notification.model.NotificationModel;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.model.MSISDNSeriesLengthResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Service
@FeignClient(url = "${trcModulefeignClientPath}", value = "service6Feign")
public interface APIService6Feign {


    //-------------------get all TA details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/paging", method = RequestMethod.POST)
    public Object typeApprovedFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "0") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);

    //-------------------get all TA details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/type-approved-data/paging", method = RequestMethod.POST)
    public Object typeApprovedViewFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "0") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


    //-------------------Upload TA feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/upload", method = RequestMethod.POST)
    public GenricResponse uploadTAFile(@RequestBody TypeApprovedRequest typeApprovedRequest);

    //-------------------get all TA Drop down feign Controller-------------------//

    @RequestMapping(value = "/trc/distinct", method = RequestMethod.POST)
    public Map<String, List<?>> typeApprovedDropdownFeign(@RequestBody List<String> list);


    //-------------------get all Type of Equipment Drop down feign Controller-------------------//

    @RequestMapping(value = "/trc/distinct/ta-data", method = RequestMethod.POST)
    public Map<String, List<?>> typeOfEquipmentDropdownFeign(@RequestBody List<String> list);


    //-------------------Export TA details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/export", method = RequestMethod.POST)
    public Object TAExportFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);

    //-------------------Export view TA details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/type-approved-data/export", method = RequestMethod.POST)
    public Object TAViewExportFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);


    //-------------------get all Local Manufacture details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/lm-data/paging", method = RequestMethod.POST)
    public Object localManufactureViewFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "0") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);

    //-------------------Export view TA details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/lm-data/export", method = RequestMethod.POST)
    public Object LMViewExportFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);


    //-------------------get all Qualified Agent details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/qualified-agents-data/paging", method = RequestMethod.POST)
    public Object qualifiedAgentViewFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "0") Integer file, @RequestParam(name = "source", defaultValue = "menu", required = false) String source);


    //-------------------Export view QA details feign Controller-------------------//

    @RequestMapping(value = "/v1/trc/qualified-agents-data/export", method = RequestMethod.POST)
    public Object QAViewExportFeign(@RequestBody TypeApprovedRequest typeApprovedRequest, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize, @RequestParam(value = "file", defaultValue = "1") Integer file);


    /*Exception List*/
    @PostMapping("/v1/list-mgmt/eirs-list-mgmt")
    public Object findByID(@RequestBody EIRSListManagementEntity eirsListManagementEntity);


    @PostMapping("/v1/list-mgmt/eirs-list-mgmt/paging")
    public Object paging(@RequestBody EIRSListManagementEntity eirsListManagementEntity, @RequestParam(value = "pageNo", defaultValue = "0") int pageNo, @RequestParam(value = "pageSize", defaultValue = "10") int pageSize);


    @PostMapping("/v1/list-mgmt/eirs-list-mgmt/export")
    public FileExportResponse export(@RequestBody EIRSListManagementEntity eirsListManagementEntity);


    @PostMapping("/v1/list-mgmt/exception-list/paging")
    public Object exceptionListPaging(@RequestBody ExceptionListEntity exceptionListEntity, @RequestParam(value = "pageNo", defaultValue = "0") int pageNo, @RequestParam(value = "pageSize", defaultValue = "10") int pageSize);

    @PostMapping("/v1/list-mgmt/exception-list/export")
    public FileExportResponse exceptionListExport(@RequestBody ExceptionListEntity exceptionListEntity);

    @PostMapping("/list-mgmt/distinct")
    public Map<String, List<?>> distinctEirsListMgmt(@RequestBody List<String> param);

    @PostMapping("/list-mgmt/distinct/exception-list")
    public Map<String, List<?>> distinctExceptionList(@RequestBody List<String> param);

    @PostMapping("/list-mgmt/distinct/block-list")
    public Map<String, List<?>> distinctBlockList(@RequestBody List<String> param);

    @PostMapping("/list-mgmt/distinct/gray-list")
    public Map<String, List<?>> distinctGrayList(@RequestBody List<String> param);

    @PostMapping("/list-mgmt/distinct/block-tac")
    public Map<String, List<?>> distinctBlockTAC(@RequestBody List<String> param);

    @PostMapping("/v1/list-mgmt/eirs-list-mgmt/upload")
    public GenricResponse single(EIRSListManagementEntity eirsListManagementEntity);

    @PostMapping("/v1/list-mgmt/block-list/paging")
    public Object blockListPaging(@RequestBody BlockListEntity blockListEntity, @RequestParam(value = "pageNo", defaultValue = "0") int pageNo, @RequestParam(value = "pageSize", defaultValue = "10") int pageSize);

    @PostMapping("/v1/list-mgmt/block-list/export")
    public FileExportResponse blockListExport(@RequestBody BlockListEntity blockListEntity);

    @PostMapping("/v1/list-mgmt/gray-list/paging")
    public Object grayListPaging(@RequestBody GrayListEntity grayListEntity, @RequestParam(value = "pageNo", defaultValue = "0") int pageNo, @RequestParam(value = "pageSize", defaultValue = "10") int pageSize);

    @PostMapping("/v1/list-mgmt/gray-list/export")
    public FileExportResponse grayListExport(@RequestBody GrayListEntity grayListEntity);

    @PostMapping("/v1/list-mgmt/block-tac/paging")
    public Object blockTACPaging(@RequestBody BlockTACEntity blockTACEntity, @RequestParam(value = "pageNo", defaultValue = "0") int pageNo, @RequestParam(value = "pageSize", defaultValue = "10") int pageSize);

    @PostMapping("/v1/list-mgmt/block-tac/export")
    public FileExportResponse blockTACExport(@RequestBody BlockTACEntity blockTACEntity);

    @RequestMapping(value = "/v1/notification", method = RequestMethod.POST)
    public Object viewById(@RequestBody NotificationModel notificationModel);

    @RequestMapping(value = "/v1/notification/paging", method = RequestMethod.POST)
    public Object view(@RequestBody NotificationModel notificationModel, @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo, @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize);

    @PostMapping("/v1/notification/export")
    public FileExportResponse export(@RequestBody NotificationModel notificationModel);
/*

    @RequestMapping(value = "/v1/address-mgmt/address/paging", method = RequestMethod.POST)
    public Object paging(@RequestBody AddressMgmtModel addressMgmtModel,
                         @RequestParam(value = "pageNo", defaultValue = "0") Integer pageNo,
                         @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize);

    @PostMapping("/v1/address-mgmt/address/export")
    public FileExportResponse addressMgmtExport(@RequestBody AddressMgmtModel addressMgmtModel);


    @RequestMapping(value = "/v1/address-mgmt/address/distinctProvince", method = RequestMethod.POST)
    public Map<String, List<?>> distinctProvince(@RequestBody List<String> list);


    @RequestMapping(value = "/v1/address-mgmt/address/distinctDistrict", method = RequestMethod.POST)
    public Map<String, List<?>> distinctDistrict(@RequestBody List<String> list);


    @RequestMapping(value = "/v1/address-mgmt/address/distinctCommune", method = RequestMethod.POST)
    public Map<String, List<?>> distinctCommune(@RequestBody List<String> list);

    @PostMapping("/v1/address-mgmt/address")
    public Object findByID(@RequestBody AddressMgmtModel addressMgmtModel);

    @DeleteMapping("/v1/address-mgmt/address")
    public ResponseEntity<GenricResponse> delete(@RequestBody AddressMgmtModel addressMgmtModel);

    @PostMapping("/v1/address-mgmt/address/getDistrict")
    public ResponseEntity<?> getDistrict(@RequestBody AddressMgmtModel addressMgmtModel);

    @PostMapping("/v1/address-mgmt/address/getCommune")
    public ResponseEntity<?> getCommune(@RequestBody AddressMgmtModel addressMgmtModel);

    @PutMapping("/v1/address-mgmt/address")
    public GenricResponse update(@RequestBody AddressMgmtModel addressMgmtModel);
*/


    @PostMapping("/v1/customer-care/ids")
    public CustomerCareResponse getByRequestID(@RequestBody CustomerCareRequest customerCareRequest);

    @GetMapping("/actuator/health")
    public Object applicationHealth();
}

