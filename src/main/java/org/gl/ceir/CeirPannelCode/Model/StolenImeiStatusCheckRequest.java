package org.gl.ceir.CeirPannelCode.Model;

import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;

public class StolenImeiStatusCheckRequest {
    private Integer pageNo, pageSize;
    private String sort;
    public String order,orderColumnName;

    //filter Params
    private String createdOn;
    private String modifiedOn;
    private String imei1;
    private String imei2;
    private String imei3;
    private String imei4;
    private String remark;
    private String transactionId;
    private String requestMode;
    private String fileName;
    private Integer fileRecordCount;
    private Integer countFoundInLost;
    private String status;
    //private String remarks;
    private String requestId;
    private String otp;
    private String lang;
    private String contactNumber;

    //initiate recovery form
    private String recoveryReason;
    private String deviceLostDateTime;
    private String province;
    private String district;
    private String commune;

     //Audit Params
    private AuditTrailModel auditTrailModel;

    private Integer featureId;
    private Integer userId;
    private String userName;
    private Integer userTypeId;
    private String userType;
    private String featureName;
    private String subFeature;
    private String getjSessionId;
    private String roleType;
    private String publicIp;
    private String browser;

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getImei2() {
        return imei2;
    }

    public void setImei2(String imei2) {
        this.imei2 = imei2;
    }

    public String getImei3() {
        return imei3;
    }

    public void setImei3(String imei3) {
        this.imei3 = imei3;
    }

    public String getImei4() {
        return imei4;
    }

    public void setImei4(String imei4) {
        this.imei4 = imei4;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public String getRequestId() {
        return requestId;
    }

    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public void setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
    }




    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getOrderColumnName() {
        return orderColumnName;
    }

    public void setOrderColumnName(String orderColumnName) {
        this.orderColumnName = orderColumnName;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public String getImei1() {
        return imei1;
    }

    public void setImei1(String imei1) {
        this.imei1 = imei1;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getRequestMode() {
        return requestMode;
    }

    public void setRequestMode(String requestMode) {
        this.requestMode = requestMode;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Integer getFileRecordCount() {
        return fileRecordCount;
    }

    public void setFileRecordCount(Integer fileRecordCount) {
        this.fileRecordCount = fileRecordCount;
    }

    public Integer getCountFoundInLost() {
        return countFoundInLost;
    }

    public void setCountFoundInLost(Integer countFoundInLost) {
        this.countFoundInLost = countFoundInLost;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getFeatureId() {
        return featureId;
    }

    public void setFeatureId(Integer featureId) {
        this.featureId = featureId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getUserTypeId() {
        return userTypeId;
    }

    public void setUserTypeId(Integer userTypeId) {
        this.userTypeId = userTypeId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getFeatureName() {
        return featureName;
    }

    public void setFeatureName(String featureName) {
        this.featureName = featureName;
    }

    public String getSubFeature() {
        return subFeature;
    }

    public void setSubFeature(String subFeature) {
        this.subFeature = subFeature;
    }

    public String getGetjSessionId() {
        return getjSessionId;
    }

    public void setGetjSessionId(String getjSessionId) {
        this.getjSessionId = getjSessionId;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public String getPublicIp() {
        return publicIp;
    }

    public void setPublicIp(String publicIp) {
        this.publicIp = publicIp;
    }

    public String getBrowser() {
        return browser;
    }

    public void setBrowser(String browser) {
        this.browser = browser;
    }

    public String getRecoveryReason() {
        return recoveryReason;
    }

    public void setRecoveryReason(String recoveryReason) {
        this.recoveryReason = recoveryReason;
    }

    public String getDeviceLostDateTime() {
        return deviceLostDateTime;
    }

    public void setDeviceLostDateTime(String deviceLostDateTime) {
        this.deviceLostDateTime = deviceLostDateTime;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    @Override
    public String toString() {
        return "StolenImeiStatusCheckRequest{" +
                "pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", sort='" + sort + '\'' +
                ", order='" + order + '\'' +
                ", orderColumnName='" + orderColumnName + '\'' +
                ", createdOn='" + createdOn + '\'' +
                ", modifiedOn='" + modifiedOn + '\'' +
                ", imei1='" + imei1 + '\'' +
                ", imei2='" + imei2 + '\'' +
                ", imei3='" + imei3 + '\'' +
                ", imei4='" + imei4 + '\'' +
                ", remark='" + remark + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", requestMode='" + requestMode + '\'' +
                ", fileName='" + fileName + '\'' +
                ", fileRecordCount=" + fileRecordCount +
                ", countFoundInLost=" + countFoundInLost +
                ", status='" + status + '\'' +
                ", requestId='" + requestId + '\'' +
                ", otp='" + otp + '\'' +
                ", lang='" + lang + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                ", recoveryReason='" + recoveryReason + '\'' +
                ", deviceLostDateTime='" + deviceLostDateTime + '\'' +
                ", province='" + province + '\'' +
                ", district='" + district + '\'' +
                ", commune='" + commune + '\'' +
                ", auditTrailModel=" + auditTrailModel +
                ", featureId=" + featureId +
                ", userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userTypeId=" + userTypeId +
                ", userType='" + userType + '\'' +
                ", featureName='" + featureName + '\'' +
                ", subFeature='" + subFeature + '\'' +
                ", getjSessionId='" + getjSessionId + '\'' +
                ", roleType='" + roleType + '\'' +
                ", publicIp='" + publicIp + '\'' +
                ", browser='" + browser + '\'' +
                '}';
    }
}
