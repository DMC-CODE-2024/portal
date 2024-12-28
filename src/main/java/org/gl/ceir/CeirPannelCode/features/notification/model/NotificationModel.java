package org.gl.ceir.CeirPannelCode.features.notification.model;

import org.gl.ceir.CeirPannelCode.features.trc.model.AuditTrailModel;


public class NotificationModel {
    private Long id;
    private String channelType;
    private Integer featureId;
    private String featureName;
    private String featureTxnId;
    private String msgLang;
    private String message;
    private String receiverUserType;
    private String referTable;
    private Integer retryCount;
    private String roleType;
    private Integer status;
    private String subFeature;
    private String subject;
    private Integer userId;
    private String operatorName;
    private String msisdn;
    private String email;
    private String corelationId;
    private Integer deliveryStatus;
    private String sendSmsInterface;
    private String attachment;
    private Integer checkImeiId;
    private String createdOn;
    private String modifiedOn;
    private String notificationSentTime;
    private String deliveryTime;
    private String deliveryDateTime;
    private AuditTrailModel auditTrailModel;

    private String interp;

    public String getInterp() {
        return interp;
    }

    public NotificationModel setInterp(String interp) {
        this.interp = interp;
        return this;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public NotificationModel setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
        return this;
    }

    public String getModifiedOn() {
        return modifiedOn;
    }

    public NotificationModel setModifiedOn(String modifiedOn) {
        this.modifiedOn = modifiedOn;
        return this;
    }

    public String getNotificationSentTime() {
        return notificationSentTime;
    }

    public NotificationModel setNotificationSentTime(String notificationSentTime) {
        this.notificationSentTime = notificationSentTime;
        return this;
    }

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public NotificationModel setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
        return this;
    }

    public String getDeliveryDateTime() {
        return deliveryDateTime;
    }

    public NotificationModel setDeliveryDateTime(String deliveryDateTime) {
        this.deliveryDateTime = deliveryDateTime;
        return this;
    }

    public Long getId() {
        return id;
    }

    public NotificationModel setId(Long id) {
        this.id = id;
        return this;
    }

    public String getChannelType() {
        return channelType;
    }

    public NotificationModel setChannelType(String channelType) {
        this.channelType = channelType;
        return this;
    }

    public Integer getFeatureId() {
        return featureId;
    }

    public NotificationModel setFeatureId(Integer featureId) {
        this.featureId = featureId;
        return this;
    }

    public String getFeatureName() {
        return featureName;
    }

    public NotificationModel setFeatureName(String featureName) {
        this.featureName = featureName;
        return this;
    }

    public String getFeatureTxnId() {
        return featureTxnId;
    }

    public NotificationModel setFeatureTxnId(String featureTxnId) {
        this.featureTxnId = featureTxnId;
        return this;
    }

    public String getMsgLang() {
        return msgLang;
    }

    public NotificationModel setMsgLang(String msgLang) {
        this.msgLang = msgLang;
        return this;
    }

    public String getMessage() {
        return message;
    }

    public NotificationModel setMessage(String message) {
        this.message = message;
        return this;
    }

    public String getReceiverUserType() {
        return receiverUserType;
    }

    public NotificationModel setReceiverUserType(String receiverUserType) {
        this.receiverUserType = receiverUserType;
        return this;
    }

    public String getReferTable() {
        return referTable;
    }

    public NotificationModel setReferTable(String referTable) {
        this.referTable = referTable;
        return this;
    }

    public Integer getRetryCount() {
        return retryCount;
    }

    public NotificationModel setRetryCount(Integer retryCount) {
        this.retryCount = retryCount;
        return this;
    }

    public String getRoleType() {
        return roleType;
    }

    public NotificationModel setRoleType(String roleType) {
        this.roleType = roleType;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public NotificationModel setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public String getSubFeature() {
        return subFeature;
    }

    public NotificationModel setSubFeature(String subFeature) {
        this.subFeature = subFeature;
        return this;
    }

    public String getSubject() {
        return subject;
    }

    public NotificationModel setSubject(String subject) {
        this.subject = subject;
        return this;
    }

    public Integer getUserId() {
        return userId;
    }

    public NotificationModel setUserId(Integer userId) {
        this.userId = userId;
        return this;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public NotificationModel setOperatorName(String operatorName) {
        this.operatorName = operatorName;
        return this;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public NotificationModel setMsisdn(String msisdn) {
        this.msisdn = msisdn;
        return this;
    }

    public String getEmail() {
        return email;
    }

    public NotificationModel setEmail(String email) {
        this.email = email;
        return this;
    }

    public String getCorelationId() {
        return corelationId;
    }

    public NotificationModel setCorelationId(String corelationId) {
        this.corelationId = corelationId;
        return this;
    }

    public Integer getDeliveryStatus() {
        return deliveryStatus;
    }

    public NotificationModel setDeliveryStatus(Integer deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
        return this;
    }

    public String getSendSmsInterface() {
        return sendSmsInterface;
    }

    public NotificationModel setSendSmsInterface(String sendSmsInterface) {
        this.sendSmsInterface = sendSmsInterface;
        return this;
    }

    public String getAttachment() {
        return attachment;
    }

    public NotificationModel setAttachment(String attachment) {
        this.attachment = attachment;
        return this;
    }

    public Integer getCheckImeiId() {
        return checkImeiId;
    }

    public NotificationModel setCheckImeiId(Integer checkImeiId) {
        this.checkImeiId = checkImeiId;
        return this;
    }

    public AuditTrailModel getAuditTrailModel() {
        return auditTrailModel;
    }

    public NotificationModel setAuditTrailModel(AuditTrailModel auditTrailModel) {
        this.auditTrailModel = auditTrailModel;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("NotificationModel{");
        sb.append("id=").append(id);
        sb.append(", channelType='").append(channelType).append('\'');
        sb.append(", featureId=").append(featureId);
        sb.append(", featureName='").append(featureName).append('\'');
        sb.append(", featureTxnId='").append(featureTxnId).append('\'');
        sb.append(", msgLang='").append(msgLang).append('\'');
        sb.append(", message='").append(message).append('\'');
        sb.append(", receiverUserType='").append(receiverUserType).append('\'');
        sb.append(", referTable='").append(referTable).append('\'');
        sb.append(", retryCount=").append(retryCount);
        sb.append(", roleType='").append(roleType).append('\'');
        sb.append(", status=").append(status);
        sb.append(", subFeature='").append(subFeature).append('\'');
        sb.append(", subject='").append(subject).append('\'');
        sb.append(", userId=").append(userId);
        sb.append(", operatorName='").append(operatorName).append('\'');
        sb.append(", msisdn='").append(msisdn).append('\'');
        sb.append(", email='").append(email).append('\'');
        sb.append(", corelationId='").append(corelationId).append('\'');
        sb.append(", deliveryStatus=").append(deliveryStatus);
        sb.append(", sendSmsInterface='").append(sendSmsInterface).append('\'');
        sb.append(", attachment='").append(attachment).append('\'');
        sb.append(", checkImeiId=").append(checkImeiId);
        sb.append(", createdOn='").append(createdOn).append('\'');
        sb.append(", modifiedOn='").append(modifiedOn).append('\'');
        sb.append(", notificationSentTime='").append(notificationSentTime).append('\'');
        sb.append(", deliveryTime='").append(deliveryTime).append('\'');
        sb.append(", deliveryDateTime='").append(deliveryDateTime).append('\'');
        sb.append(", auditTrailModel=").append(auditTrailModel);
        sb.append(", interp='").append(interp).append('\'');
        sb.append('}');
        return sb.toString();
    }
}


