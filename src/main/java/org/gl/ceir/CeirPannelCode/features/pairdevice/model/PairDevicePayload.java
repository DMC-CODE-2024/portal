package org.gl.ceir.CeirPannelCode.features.pairdevice.model;

import org.gl.ceir.CeirPannelCode.Model.PortalAccessLog;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

import java.util.List;

public class PairDevicePayload {
    private List<Pair> pairs;
    private String serialNumber;
    private String contactNumber;
    private String emailId;
    private String language;
    private AuditTrailModel auditTrailModel;

    private PortalAccessLog portalAccessLog;

    public PortalAccessLog getPortalAccessLog() {
        return portalAccessLog;
    }

    public void setPortalAccessLog(PortalAccessLog portalAccessLog) {
        this.portalAccessLog = portalAccessLog;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public void setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public List<Pair> getPairs() {
        return pairs;
    }

    public PairDevicePayload setPairs(List<Pair> pairs) {
        this.pairs = pairs;
        return this;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public PairDevicePayload setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
        return this;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public PairDevicePayload setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
        return this;
    }

    public String getEmailId() {
        return emailId;
    }

    public PairDevicePayload setEmailId(String emailId) {
        this.emailId = emailId;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("PairDevicePayload{");
        sb.append("pairs=").append(pairs);
        sb.append(", serialNumber='").append(serialNumber).append('\'');
        sb.append(", contactNumber='").append(contactNumber).append('\'');
        sb.append(", emailId='").append(emailId).append('\'');
        sb.append(", language='").append(language).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", portalAccessLog=").append(portalAccessLog);
        sb.append('}');
        return sb.toString();
    }
}
