package org.gl.ceir.CeirPannelCode.features.listmanagement.model;

import org.gl.ceir.CeirPannelCode.Model.User;
import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;


public class BlockTACEntity { private Integer id;
    private String createdOn;
    private String modifiedOn;
    private String complainType;
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

    public String getSource() {
        return source;
    }

    public BlockTACEntity setSource(String source) {
        this.source = source;
        return this;
    }

    public String getUploadedBy() {
        return uploadedBy;
    }

    public BlockTACEntity setUploadedBy(String uploadedBy) {
        this.uploadedBy = uploadedBy;
        return this;
    }

    public User getUser() {
        return user;
    }

    public BlockTACEntity setUser(User user) {
        this.user = user;
        return this;
    }

    public Integer getId() {
        return id;
    }

    public BlockTACEntity setId(Integer id) {
        this.id = id;
        return this;
    }

    public String getAddedBy() {
        return addedBy;
    }

    public BlockTACEntity setAddedBy(String addedBy) {
        this.addedBy = addedBy;
        return this;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public BlockTACEntity setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public BlockTACEntity setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
        return this;
    }

    public String getComplainType() {
        return complainType;
    }

    public BlockTACEntity setComplainType(String complainType) {
        this.complainType = complainType;
        return this;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public BlockTACEntity setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
        return this;
    }

    public String getImei() {
        return imei;
    }

    public BlockTACEntity setImei(String imei) {
        this.imei = imei;
        return this;
    }

    public String getModeType() {
        return modeType;
    }

    public BlockTACEntity setModeType(String modeType) {
        this.modeType = modeType;
        return this;
    }

    public String getRequestType() {
        return requestType;
    }

    public BlockTACEntity setRequestType(String requestType) {
        this.requestType = requestType;
        return this;
    }

    public String getTxnId() {
        return txnId;
    }

    public BlockTACEntity setTxnId(String txnId) {
        this.txnId = txnId;
        return this;
    }

    public String getUserId() {
        return userId;
    }

    public BlockTACEntity setUserId(String userId) {
        this.userId = userId;
        return this;
    }

    public String getUserType() {
        return userType;
    }

    public BlockTACEntity setUserType(String userType) {
        this.userType = userType;
        return this;
    }

    public String getOperatorId() {
        return operatorId;
    }

    public BlockTACEntity setOperatorId(String operatorId) {
        this.operatorId = operatorId;
        return this;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public BlockTACEntity setOperatorName(String operatorName) {
        this.operatorName = operatorName;
        return this;
    }

    public String getActualImei() {
        return actualImei;
    }

    public BlockTACEntity setActualImei(String actualImei) {
        this.actualImei = actualImei;
        return this;
    }

    public String getTac() {
        return tac;
    }

    public BlockTACEntity setTac(String tac) {
        this.tac = tac;
        return this;
    }

    public String getRemarks() {
        return remarks;
    }

    public BlockTACEntity setRemarks(String remarks) {
        this.remarks = remarks;
        return this;
    }

    public String getImsi() {
        return imsi;
    }

    public BlockTACEntity setImsi(String imsi) {
        this.imsi = imsi;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public BlockTACEntity setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public BlockTACEntity setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("BlockTACEntity{");
        sb.append("id=").append(id);
        sb.append(", createdOn='").append(createdOn).append('\'');
        sb.append(", modifiedOn='").append(modifiedOn).append('\'');
        sb.append(", complainType='").append(complainType).append('\'');
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

