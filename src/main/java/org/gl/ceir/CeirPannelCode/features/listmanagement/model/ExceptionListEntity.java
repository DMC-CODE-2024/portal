package org.gl.ceir.CeirPannelCode.features.listmanagement.model;

import org.gl.ceir.CeirPannelCode.Model.User;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

import java.time.LocalDateTime;


public class ExceptionListEntity { private Integer id;
    private String createdOn;
    private String modifiedOn;
    private String complaintType;
    private String expiryDate;
    private String imei;
    private String modeType;
    private String requestType;
    private String txnId;
    private String userId;
    private String userType;
    private String operatorId;
    private String operatorName;
    private String addedBy;
    private String actualImei;
    private String tac;
    private String remarks;
    private String imsi;
    private String msisdn;
    private String source;
    private User user;
    private AuditTrailModel auditTrailModel;

    private String uploadedBy;

    public String getUploadedBy() {
        return uploadedBy;
    }

    public String getSource() {
        return source;
    }

    public ExceptionListEntity setSource(String source) {
        this.source = source;
        return this;
    }

    public ExceptionListEntity setUploadedBy(String uploadedBy) {
        this.uploadedBy = uploadedBy;
        return this;
    }

    public User getUser() {
        return user;
    }

    public ExceptionListEntity setUser(User user) {
        this.user = user;
        return this;
    }

    public Integer getId() {
        return id;
    }

    public ExceptionListEntity setId(Integer id) {
        this.id = id;
        return this;
    }

    public String getAddedBy() {
        return addedBy;
    }

    public ExceptionListEntity setAddedBy(String addedBy) {
        this.addedBy = addedBy;
        return this;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public ExceptionListEntity setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public ExceptionListEntity setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
        return this;
    }

    public String getComplaintType() {
        return complaintType;
    }

    public ExceptionListEntity setComplaintType(String complaintType) {
        this.complaintType = complaintType;
        return this;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public ExceptionListEntity setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
        return this;
    }

    public String getImei() {
        return imei;
    }

    public ExceptionListEntity setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getModeType() {
        return modeType;
    }

    public ExceptionListEntity setModeType(String modeType) {
        this.modeType = modeType;
        return this;
    }

    public String getRequestType() {
        return requestType;
    }

    public ExceptionListEntity setRequestType(String requestType) {
        this.requestType = requestType;
        return this;
    }

    public String getTxnId() {
        return txnId;
    }

    public ExceptionListEntity setTxnId(String txnId) {
        this.txnId = txnId;
        return this;
    }

    public String getUserId() {
        return userId;
    }

    public ExceptionListEntity setUserId(String userId) {
        this.userId = userId;
        return this;
    }

    public String getUserType() {
        return userType;
    }

    public ExceptionListEntity setUserType(String userType) {
        this.userType = userType;
        return this;
    }

    public String getOperatorId() {
        return operatorId;
    }

    public ExceptionListEntity setOperatorId(String operatorId) {
        this.operatorId = operatorId;
        return this;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public ExceptionListEntity setOperatorName(String operatorName) {
        this.operatorName = operatorName;
        return this;
    }

    public String getActualImei() {
        return actualImei;
    }

    public ExceptionListEntity setActualImei(String actualImei) {
        this.actualImei = actualImei;
        return this;
    }

    public String getTac() {
        return tac;
    }

    public ExceptionListEntity setTac(String tac) {
        this.tac = tac;
        return this;
    }

    public String getRemarks() {
        return remarks;
    }

    public ExceptionListEntity setRemarks(String remarks) {
        this.remarks = remarks;
        return this;
    }

    public String getImsi() {
        return imsi;
    }

    public ExceptionListEntity setImsi(String imsi) {
        this.imsi = imsi;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public ExceptionListEntity setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public ExceptionListEntity setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("ExceptionListEntity{");
        sb.append("id=").append(id);
        sb.append(", createdOn='").append(createdOn).append('\'');
        sb.append(", modifiedOn='").append(modifiedOn).append('\'');
        sb.append(", complaintType='").append(complaintType).append('\'');
        sb.append(", expiryDate='").append(expiryDate).append('\'');
        sb.append(", imei='").append(imei).append('\'');
        sb.append(", modeType='").append(modeType).append('\'');
        sb.append(", requestType='").append(requestType).append('\'');
        sb.append(", txnId='").append(txnId).append('\'');
        sb.append(", userId='").append(userId).append('\'');
        sb.append(", userType='").append(userType).append('\'');
        sb.append(", operatorId='").append(operatorId).append('\'');
        sb.append(", operatorName='").append(operatorName).append('\'');
        sb.append(", addedBy='").append(addedBy).append('\'');
        sb.append(", actualImei='").append(actualImei).append('\'');
        sb.append(", tac='").append(tac).append('\'');
        sb.append(", remarks='").append(remarks).append('\'');
        sb.append(", imsi='").append(imsi).append('\'');
        sb.append(", msisdn='").append(msisdn).append('\'');
        sb.append(", source='").append(source).append('\'');
        sb.append(", user=").append(user);
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", uploadedBy='").append(uploadedBy).append('\'');
        sb.append('}');
        return sb.toString();
    }
}

