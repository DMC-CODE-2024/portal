package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class NotificationContent {

	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String channelType;
	private String message;
	private Integer userId;
	private Integer featureId;
	private String featureTxnId;
	private String featureName;
	private String subFeature;
	private Integer status;
	 private String subject;
	 private Integer retryCount;
	 private String referTable;
	 private String roleType;
	 private String receiverUserType;
	public String getReceiverUserType() {
		return receiverUserType;
	}
	public void setReceiverUserType(String receiverUserType) {
		this.receiverUserType = receiverUserType;
	}
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getChannelType() {
		return channelType;
	}
	public void setChannelType(String channelType) {
		this.channelType = channelType;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public String getFeatureTxnId() {
		return featureTxnId;
	}
	public void setFeatureTxnId(String featureTxnId) {
		this.featureTxnId = featureTxnId;
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Integer getRetryCount() {
		return retryCount;
	}
	public void setRetryCount(Integer retryCount) {
		this.retryCount = retryCount;
	}
	public String getReferTable() {
		return referTable;
	}
	public void setReferTable(String referTable) {
		this.referTable = referTable;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "NotificationContent [id=" + id + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn
				+ ", channelType=" + channelType + ", message=" + message + ", userId=" + userId + ", featureId="
				+ featureId + ", featureTxnId=" + featureTxnId + ", featureName=" + featureName + ", subFeature="
				+ subFeature + ", status=" + status + ", subject=" + subject + ", retryCount=" + retryCount
				+ ", referTable=" + referTable + ", roleType=" + roleType + ", receiverUserType=" + receiverUserType
				+ ", additionalProperties=" + additionalProperties + "]";
	}
	
}
