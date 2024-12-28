package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

import org.gl.ceir.CeirPannelCode.Model.PortalAccessLog;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

public class VerifyOTPPayload {
    private String requestId;
    private Integer otp;
    private AuditTrailModel auditTrailModel;

    private PortalAccessLog portalAccessLog;

    public String getRequestId() {
        return requestId;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public VerifyOTPPayload setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    public PortalAccessLog getPortalAccessLog() {
        return portalAccessLog;
    }

    public VerifyOTPPayload setPortalAccessLog(PortalAccessLog portalAccessLog) {
        this.portalAccessLog = portalAccessLog;
        return this;
    }

    public VerifyOTPPayload setRequestId(String requestId) {
        this.requestId = requestId;
        return this;
    }

    public Integer getOtp() {
        return otp;
    }

    public VerifyOTPPayload setOtp(Integer otp) {
        this.otp = otp;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("VerifyOTPPayload{");
        sb.append("requestId='").append(requestId).append('\'');
        sb.append(", otp=").append(otp);
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", portalAccessLog=").append(portalAccessLog);
        sb.append('}');
        return sb.toString();
    }
}
