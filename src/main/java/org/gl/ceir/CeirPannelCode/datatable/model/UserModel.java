package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class UserModel {
	private Integer id;
	private String username;
	private String password;
	private String createdOn;
	private String modifiedOn;
	private Integer currentStatus;
	private Integer previousStatus;
	private UserProfileModel userProfile;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public Integer getCurrentStatus() {
		return currentStatus;
	}
	public void setCurrentStatus(Integer currentStatus) {
		this.currentStatus = currentStatus;
	}
	public Integer getPreviousStatus() {
		return previousStatus;
	}
	public void setPreviousStatus(Integer previousStatus) {
		this.previousStatus = previousStatus;
	}
	public UserProfileModel getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(UserProfileModel userProfile) {
		this.userProfile = userProfile;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "UserModel [id=" + id + ", username=" + username + ", password=" + password + ", createdOn=" + createdOn
				+ ", modifiedOn=" + modifiedOn + ", currentStatus=" + currentStatus + ", previousStatus=" + previousStatus
				+ ", userProfile=" + userProfile + ", additionalProperties=" + additionalProperties + "]";
	}

}
