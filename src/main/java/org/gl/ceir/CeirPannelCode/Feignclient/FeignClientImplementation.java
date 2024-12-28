package org.gl.ceir.CeirPannelCode.Feignclient;

import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.Model.Operator;
import org.gl.ceir.CeirPannelCode.features.addressmgmt.model.AddressMgmtModel;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Service
@FeignClient(url = "${feignClientPath}", value = "dsjs")
public interface FeignClientImplementation {


    //download file(Error or Uploaded file) feign  controller
    @RequestMapping(value = "/Download/uploadFile", method = RequestMethod.GET)
    public @ResponseBody String downloadFile(@RequestParam("txnId") String txnId, @RequestParam("fileType") String fileType, @RequestParam("fileName") String fileName);


    //download file(Error or Uploaded file) feign  controller
    @RequestMapping(value = "/stoke/Download/SampleFile", method = RequestMethod.GET)
    public @ResponseBody String downloadSampleFile(@RequestParam("samplFileType") String fileType);

    @GetMapping("/system-config-list/{tag}")
    public List<Operator> operatorList(@PathVariable("tag") String tag);


    @RequestMapping(value = "/getDistinctAuditFeatureName", method = RequestMethod.GET)
    public List<String> getDistinctAuditFeatureName();


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



}

