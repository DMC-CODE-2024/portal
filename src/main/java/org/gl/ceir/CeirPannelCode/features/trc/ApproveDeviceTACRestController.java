package org.gl.ceir.CeirPannelCode.features.trc;

import com.google.gson.Gson;
import org.gl.ceir.CeirPannelCode.Model.FileExportResponse;
import org.gl.ceir.CeirPannelCode.Model.FilterRequest;
import org.gl.ceir.CeirPannelCode.features.operatorconfiguration.MSISDNSeriesService;
import org.gl.ceir.CeirPannelCode.features.trc.model.MDR;
import org.gl.ceir.CeirPannelCode.features.trc.model.ResponseModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/approve-device-tac")
public class ApproveDeviceTACRestController {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    private final ApproveDeviceTACService approveDeviceTACService;
    private final ApproveDeviceTACFeignClient approveDeviceTACFeignClient;

    public ApproveDeviceTACRestController(ApproveDeviceTACService approveDeviceTACService, ApproveDeviceTACFeignClient approveDeviceTACFeignClient) {
        this.approveDeviceTACService = approveDeviceTACService;
        this.approveDeviceTACFeignClient = approveDeviceTACFeignClient;
    }

    @PostMapping("/paging")
    public ResponseEntity<?> paging(HttpServletRequest request, HttpSession session) {
        return approveDeviceTACService.paging(request, session);
    }

    @PostMapping("/page-rendering")
    public ResponseEntity<?> pageRendering(@RequestParam(name = "type", defaultValue = "", required = false) String role,
                                           @RequestParam(name = "FeatureId", defaultValue = "", required = false) int featureId,
                                           HttpSession session) {
        return approveDeviceTACService.pageRendering(role, session, featureId);
    }

    @PostMapping("/export")
    public FileExportResponse export(@RequestBody MDR mdr, HttpSession session) {
        return approveDeviceTACService.export(mdr, session);
    }

    @PostMapping
    public ResponseModel update(@RequestBody MDR mdr, HttpSession session) {
        mdr.getAuditTrailModel().setPublicIp(session.getAttribute("publicIP").toString());
        mdr.getAuditTrailModel().setBrowser(session.getAttribute("browser").toString());
        return approveDeviceTACFeignClient.update(mdr);
    }

}
