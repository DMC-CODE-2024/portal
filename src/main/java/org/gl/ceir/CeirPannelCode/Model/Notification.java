package org.gl.ceir.CeirPannelCode.Model;

public class Notification {

	private String channelType;
	private String createdOn;
	private String featureName;
	private String message;
	private String modifiedOn;
	private String subFeature;
	private int featureId;
	private int id;
	private int userId;
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
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
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
	public String getSubFeature() {
		return subFeature;
	}
	public void setSubFeature(String subFeature) {
		this.subFeature = subFeature;
	}
	public int getFeatureId() {
		return featureId;
	}
	public void setFeatureId(int featureId) {
		this.featureId = featureId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "Notification [channelType=" + channelType + ", createdOn=" + createdOn + ", featureName=" + featureName
				+ ", message=" + message + ", modifiedOn=" + modifiedOn + ", subFeature=" + subFeature + ", featureId="
				+ featureId + ", id=" + id + ", userId=" + userId + "]";
	}
	
	
}
