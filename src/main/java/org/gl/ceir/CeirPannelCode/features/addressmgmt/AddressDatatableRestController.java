package org.gl.ceir.CeirPannelCode.features.addressmgmt;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignClientImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.features.addressmgmt.AddressMgmtListService;
import org.gl.ceir.CeirPannelCode.features.addressmgmt.model.AddressMgmtModel;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.EIRSListManagementEntity;
import org.gl.ceir.CeirPannelCode.features.listmanagement.model.ExceptionListEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/address-management")
public class AddressDatatableRestController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    private final AddressMgmtListService addressMgmtListService;
    private final APIService6Feign apiService6Feign;
    private FeignClientImplementation feignClientImplementation;

    public AddressDatatableRestController(AddressMgmtListService addressMgmtListService, APIService6Feign apiService6Feign, FeignClientImplementation feignClientImplementation) {
        this.addressMgmtListService = addressMgmtListService;
        this.apiService6Feign = apiService6Feign;
        this.feignClientImplementation = feignClientImplementation;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return addressMgmtListService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return addressMgmtListService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody AddressMgmtModel addressMgmtModel, HttpSession session) {
        return addressMgmtListService.export(addressMgmtModel, session);
    }

    @PostMapping("/distinctCommune")
    public Map<String, List<?>> distinctCommune(@RequestBody List<String> list) {
        return feignClientImplementation.distinctCommune(list);
    }

    @PostMapping("/distinctDistrict")
    public Map<String, List<?>> distinctDistrict(@RequestBody List<String> list) {
        return feignClientImplementation.distinctDistrict(list);
    }

    @PostMapping("/distinctProvince")
    public Map<String, List<?>> distinctProvince(@RequestBody List<String> list) {
        return feignClientImplementation.distinctProvince(list);
    }

    @PostMapping("/ids")
    public Object findByID(@RequestBody AddressMgmtModel addressMgmtModel) {
        return feignClientImplementation.findByID(addressMgmtModel);
    }

    @DeleteMapping
    public ResponseEntity<GenricResponse> delete(@RequestBody AddressMgmtModel addressMgmtModel) {
        return feignClientImplementation.delete(addressMgmtModel);
    }

    @PostMapping("/getDistrict")
    public ResponseEntity<?> getDistrict(@RequestBody AddressMgmtModel addressMgmtModel) {
        return feignClientImplementation.getDistrict(addressMgmtModel);
    }

    @PostMapping("/getCommune")
    public ResponseEntity<?> getCommune(@RequestBody AddressMgmtModel addressMgmtModel) {
        return feignClientImplementation.getCommune(addressMgmtModel);
    }

    @PutMapping
    public GenricResponse update(@RequestBody AddressMgmtModel addressMgmtModel) {
        return feignClientImplementation.update(addressMgmtModel);
    }

}
