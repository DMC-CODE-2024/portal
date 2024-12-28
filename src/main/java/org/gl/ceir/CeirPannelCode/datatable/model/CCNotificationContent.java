package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class CCNotificationContent {
	private String channelType;	
	private String createdOn;
	private Integer featureId;
	private String featureName;
	private String featureTxnId;
	private Integer id;
	private String message;
	private String modifiedOn;
	private String receiverUserType;
	private String referTable;
	private Integer retryCount;
	private String roleType;
	private Integer status;
	private String subFeature;
	private String subject;
	private Integer userId;
	public String getChannelType() {
		return channelType;
	}
	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	public String getFeatureTxnId() {
		return featureTxnId;
	}
	public void setFeatureTxnId(String featureTxnId) {
		this.featureTxnId = featureTxnId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getModifiedOn() {
		return modifiedOn;
	}
	public void setModifiedOn(String modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
	public String getReceiverUserType() {
		return receiverUserType;
	}
	public void setReceiverUserType(String receiverUserType) {
		this.receiverUserType = receiverUserType;
	}
	public String getReferTable() {
		return referTable;
	}
	public void setReferTable(String referTable) {
		this.referTable = referTable;
	}
	public Integer getRetryCount() {
		return retryCount;
	}
	public void setRetryCount(Integer retryCount) {
		this.retryCount = retryCount;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getSubFeature() {
		return subFeature;
	}
	public void setSubFeature(String subFeature) {
		this.subFeature = subFeature;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "CCNotificationContent [channelType=" + channelType + ", createdOn=" + createdOn + ", featureId="
				+ featureId + ", featureName=" + featureName + ", featureTxnId=" + featureTxnId + ", id=" + id
				+ ", message=" + message + ", modifiedOn=" + modifiedOn + ", receiverUserType=" + receiverUserType
				+ ", referTable=" + referTable + ", retryCount=" + retryCount + ", roleType=" + roleType + ", status="
				+ status + ", subFeature=" + subFeature + ", subject=" + subject + ", userId=" + userId + "]";
	}
	
	
		
}
