package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

import org.gl.ceir.CeirPannelCode.Model.PortalAccessLog;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

public class RepairDevicePayload {
    private String imei;
    private String oldMsisdn;
    private String newMsisdn;
    private String contactNumber;
    private String emailId;
    private String language;
    private AuditTrailModel auditTrailModel;

    private PortalAccessLog portalAccessLog;

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public RepairDevicePayload setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    public PortalAccessLog getPortalAccessLog() {
        return portalAccessLog;
    }

    public RepairDevicePayload setPortalAccessLog(PortalAccessLog portalAccessLog) {
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

    public RepairDevicePayload setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getOldMsisdn() {
        return oldMsisdn;
    }

    public RepairDevicePayload setOldMsisdn(String oldMsisdn) {
        this.oldMsisdn = oldMsisdn;
        return this;
    }

    public String getNewMsisdn() {
        return newMsisdn;
    }

    public RepairDevicePayload setNewMsisdn(String newMsisdn) {
        this.newMsisdn = newMsisdn;
        return this;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public RepairDevicePayload setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
        return this;
    }

    public String getEmailId() {
        return emailId;
    }

    public RepairDevicePayload setEmailId(String emailId) {
        this.emailId = emailId;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("RepairDevicePayload{");
        sb.append("imei='").append(imei).append('\'');
        sb.append(", oldMsisdn='").append(oldMsisdn).append('\'');
        sb.append(", newMsisdn='").append(newMsisdn).append('\'');
        sb.append(", contactNumber='").append(contactNumber).append('\'');
        sb.append(", emailId='").append(emailId).append('\'');
        sb.append(", language='").append(language).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", portalAccessLog=").append(portalAccessLog);
        sb.append('}');
        return sb.toString();
    }
}
