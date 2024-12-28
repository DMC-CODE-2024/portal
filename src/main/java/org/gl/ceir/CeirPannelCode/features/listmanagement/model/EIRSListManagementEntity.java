package org.gl.ceir.CeirPannelCode.features.listmanagement.model;

import org.gl.ceir.CeirPannelCode.Model.User;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

import java.time.LocalDateTime;

public class EIRSListManagementEntity {
    private Long id;
    private String createdOn;
    private String modifiedOn;
    private String msisdn;

    private String imei;

    private String imsi;
    private String tac;

    private String fileName;

    private String requestMode;


    private String remarks;


    private String status;

    private String category;

    private String transactionId;

    private String userId;

    private Integer quantity;
    private String action;
    private String requestType;
    private String addedBy;
    private String uploadedBy;
    private AuditTrailModel auditTrailModel;
    private User user;

    public User getUser() {
        return user;
    }

    public EIRSListManagementEntity setUser(User user) {
        this.user = user;
        return this;
    }

    public String getUploadedBy() {
        return uploadedBy;
    }

    public EIRSListManagementEntity setUploadedBy(String uploadedBy) {
        this.uploadedBy = uploadedBy;
        return this;
    }

    public String getAddedBy() {
        return addedBy;
    }

    public EIRSListManagementEntity setAddedBy(String addedBy) {
        this.addedBy = addedBy;
        return this;
    }

    public Long getId() {
        return id;
    }

    public EIRSListManagementEntity setId(Long id) {
        this.id = id;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public EIRSListManagementEntity setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public String getImei() {
        return imei;
    }

    public EIRSListManagementEntity setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getImsi() {
        return imsi;
    }

    public EIRSListManagementEntity setImsi(String imsi) {
        this.imsi = imsi;
        return this;
    }

    public String getTac() {
        return tac;
    }

    public EIRSListManagementEntity setTac(String tac) {
        this.tac = tac;
        return this;
    }

    public String getFileName() {
        return fileName;
    }

    public EIRSListManagementEntity setFileName(String fileName) {
        this.fileName = fileName;
        return this;
    }

    public String getRequestMode() {
        return requestMode;
    }

    public EIRSListManagementEntity setRequestMode(String requestMode) {
        this.requestMode = requestMode;
        return this;
    }

    public String getRemarks() {
        return remarks;
    }

    public EIRSListManagementEntity setRemarks(String remarks) {
        this.remarks = remarks;
        return this;
    }

    public String getStatus() {
        return status;
    }

    public EIRSListManagementEntity setStatus(String status) {
        this.status = status;
        return this;
    }

    public String getCategory() {
        return category;
    }

    public EIRSListManagementEntity setCategory(String category) {
        this.category = category;
        return this;
    }


    public String getUserId() {
        return userId;
    }

    public EIRSListManagementEntity setUserId(String userId) {
        this.userId = userId;
        return this;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public EIRSListManagementEntity setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public EIRSListManagementEntity setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
        return this;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public EIRSListManagementEntity setQuantity(Integer quantity) {
        this.quantity = quantity;
        return this;
    }

    public String getAction() {
        return action;
    }

    public EIRSListManagementEntity setAction(String action) {
        this.action = action;
        return this;
    }

    public String getRequestType() {
        return requestType;
    }

    public EIRSListManagementEntity setRequestType(String requestType) {
        this.requestType = requestType;
        return this;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public EIRSListManagementEntity setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public EIRSListManagementEntity setTransactionId(String transactionId) {
        this.transactionId = transactionId;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("EIRSListManagementEntity{");
        sb.append("id=").append(id);
        sb.append(", createdOn='").append(createdOn).append('\'');
        sb.append(", modifiedOn='").append(modifiedOn).append('\'');
        sb.append(", msisdn='").append(msisdn).append('\'');
        sb.append(", imei='").append(imei).append('\'');
        sb.append(", imsi='").append(imsi).append('\'');
        sb.append(", tac='").append(tac).append('\'');
        sb.append(", fileName='").append(fileName).append('\'');
        sb.append(", requestMode='").append(requestMode).append('\'');
        sb.append(", remarks='").append(remarks).append('\'');
        sb.append(", status='").append(status).append('\'');
        sb.append(", category='").append(category).append('\'');
        sb.append(", transactionId='").append(transactionId).append('\'');
        sb.append(", userId='").append(userId).append('\'');
        sb.append(", quantity=").append(quantity);
        sb.append(", action='").append(action).append('\'');
        sb.append(", requestType='").append(requestType).append('\'');
        sb.append(", addedBy='").append(addedBy).append('\'');
        sb.append(", uploadedBy='").append(uploadedBy).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", user=").append(user);
        sb.append('}');
        return sb.toString();
    }
}
