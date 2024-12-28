package org.gl.ceir.CeirPannelCode.features.pairdevice;

import org.gl.ceir.CeirPannelCode.Feignclient.PairDeviceFeign;
import org.gl.ceir.CeirPannelCode.Model.PortalAccessLog;
import org.gl.ceir.CeirPannelCode.Util.BrowserUtility;
import org.gl.ceir.CeirPannelCode.features.pairdevice.model.*;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/pair-device")
public class PairDeviceRestController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    private  final PairDeviceFeign pairDeviceFeign;
    private  final BrowserUtility browserUtility;

    public PairDeviceRestController(PairDeviceFeign pairDeviceFeign, BrowserUtility browserUtility) {
        this.pairDeviceFeign = pairDeviceFeign;
        this.browserUtility = browserUtility;
    }

    @PostMapping
    public PairDeviceResponse save(HttpServletRequest request, @RequestBody PairDevicePayload pairDevicePayload) {
        AuditTrailModel auditTrailModel = browserUtility.<AuditTrailModel>auditTrailOperation(request, "Pair Device", "Save", "Public Portal");
        PortalAccessLog portalAccessLog = browserUtility.<PortalAccessLog>portalAccessLogOperation(request, "Public Portal");
        pairDevicePayload.setAuditTrailModel(auditTrailModel);
        pairDevicePayload.setPortalAccessLog(portalAccessLog);
        logger.info("pairDevicePayload [" + pairDevicePayload + "]");
        return pairDeviceFeign.save(pairDevicePayload);
    }


    @PostMapping("/repair")
    public PairDeviceResponse repareDeviceSave(HttpServletRequest request, @RequestBody RepairDevicePayload repairDevicePayload) {
        AuditTrailModel auditTrailModel = browserUtility.<AuditTrailModel>auditTrailOperation(request, "Repair Device", "Save", "Public Portal");
        PortalAccessLog portalAccessLog = browserUtility.<PortalAccessLog>portalAccessLogOperation(request, "Public Portal");
        repairDevicePayload.setAuditTrailModel(auditTrailModel);
        repairDevicePayload.setPortalAccessLog(portalAccessLog);
        logger.info("repairDevicePayload [" + repairDevicePayload + "]");
        return pairDeviceFeign.repairDeviceSave(repairDevicePayload);
    }

    @PostMapping("/status")
    public PairDeviceResponse pairStatus(HttpServletRequest request, @RequestBody PairStatusPayload pairStatusPayload) {
        AuditTrailModel auditTrailModel = browserUtility.<AuditTrailModel>auditTrailOperation(request, "Check Pair Status", "Save", "Public Portal");
        PortalAccessLog portalAccessLog = browserUtility.<PortalAccessLog>portalAccessLogOperation(request, "Public Portal");
        pairStatusPayload.setAuditTrailModel(auditTrailModel);
        pairStatusPayload.setPortalAccessLog(portalAccessLog);
        logger.info("pairStatusPayload [" + pairStatusPayload + "]");
        return pairDeviceFeign.pairStatus(pairStatusPayload);
    }

    @PostMapping("/otp")
    public PairDeviceResponse verifyOTP(HttpServletRequest request, @RequestBody VerifyOTPPayload verifyOTPPayload) {
        AuditTrailModel auditTrailModel = browserUtility.<AuditTrailModel>auditTrailOperation(request, "OTP Reqeust", "OTP", "Public Portal");
        PortalAccessLog portalAccessLog = browserUtility.<PortalAccessLog>portalAccessLogOperation(request, "Public Portal");
        verifyOTPPayload.setAuditTrailModel(auditTrailModel);
        verifyOTPPayload.setPortalAccessLog(portalAccessLog);
        logger.info("verifyOTPPayload [" + verifyOTPPayload + "]");
        return pairDeviceFeign.verifyOTP(verifyOTPPayload);
    }

    @PostMapping("/resend-otp")
    public PairDeviceResponse resendOTP(HttpServletRequest request, @RequestBody VerifyOTPPayload verifyOTPPayload) {
        AuditTrailModel auditTrailModel = browserUtility.<AuditTrailModel>auditTrailOperation(request, "Resend OTP Reqeust", "Resend OTP", "Public Portal");
        PortalAccessLog portalAccessLog = browserUtility.<PortalAccessLog>portalAccessLogOperation(request, "Public Portal");
        verifyOTPPayload.setAuditTrailModel(auditTrailModel);
        verifyOTPPayload.setPortalAccessLog(portalAccessLog);
        logger.info("verifyOTPPayload [" + verifyOTPPayload + "]");
        return pairDeviceFeign.resendOTP(verifyOTPPayload);
    }
}
