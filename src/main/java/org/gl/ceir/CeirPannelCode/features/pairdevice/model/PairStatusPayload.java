package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

import org.gl.ceir.CeirPannelCode.Model.PortalAccessLog;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

public class PairStatusPayload {
    private String imei;
    private String msisdn;
    private String contactNumber;
    private String emailId;
    private String language;
    private AuditTrailModel auditTrailModel;

    private PortalAccessLog portalAccessLog;

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public PairStatusPayload setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    public PortalAccessLog getPortalAccessLog() {
        return portalAccessLog;
    }

    public PairStatusPayload setPortalAccessLog(PortalAccessLog portalAccessLog) {
        this.portalAccessLog = portalAccessLog;
        return this;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getImei() {
        return imei;
    }

    public PairStatusPayload setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public PairStatusPayload setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public PairStatusPayload setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
        return this;
    }

    public String getEmailId() {
        return emailId;
    }

    public PairStatusPayload setEmailId(String emailId) {
        this.emailId = emailId;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("PairStatusPayload{");
        sb.append("imei='").append(imei).append('\'');
        sb.append(", msisdn='").append(msisdn).append('\'');
        sb.append(", contactNumber='").append(contactNumber).append('\'');
        sb.append(", emailId='").append(emailId).append('\'');
        sb.append(", language='").append(language).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", portalAccessLog=").append(portalAccessLog);
        sb.append('}');
        return sb.toString();
    }
}
