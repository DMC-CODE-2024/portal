package org.gl.ceir.CeirPannelCode.features.eirs_response_param;

import org.gl.ceir.CeirPannelCode.Feignclient.APIService6Feign;
import org.gl.ceir.CeirPannelCode.Feignclient.FeignCleintImplementation;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.GenricResponse;
import org.gl.ceir.CeirPannelCode.features.addressmgmt.model.AddressMgmtModel;
import org.gl.ceir.CeirPannelCode.features.eirs_response_param.model.EirsResponseParamModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/eirs-response-param")
public class EirsResponseParamDatatableRestController {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    private final EirsResponseParamService eirsResponseParamService;
    private final FeignCleintImplementation feignCleintImplementation;

    public EirsResponseParamDatatableRestController(EirsResponseParamService eirsResponseParamService, FeignCleintImplementation feignCleintImplementation) {
        this.eirsResponseParamService = eirsResponseParamService;
        this.feignCleintImplementation = feignCleintImplementation;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return eirsResponseParamService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role, HttpSession session) {
        return eirsResponseParamService.pageRendering(role, session);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody EirsResponseParamModel eirsResponseParamModel, HttpSession session) {
        return eirsResponseParamService.export(eirsResponseParamModel, session);
    }

    @PutMapping
    public GenricResponse update(@RequestBody EirsResponseParamModel eirsResponseParamModel) {
        logger.info("update request :  " + eirsResponseParamModel);
        return feignCleintImplementation.update(eirsResponseParamModel);
    }

    @PostMapping("/ids")
    public Object findByID(@RequestBody EirsResponseParamModel eirsResponseParamModel) {
        return feignCleintImplementation.findByID(eirsResponseParamModel);
    }

    @PostMapping("/distinct")
    public Map<String, List<?>> distinctProvince(@RequestBody List<String> list) {
        return feignCleintImplementation.distinct(list);
    }

}