package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
@Component
public class RegistrationUser {
	private Integer id;
	private String username;
	private String createdOn;
	private String modifiedOn;
	private Integer currentStatus;
	private Integer previousStatus;
	private String stateInterp;
	private String referenceId;
	private String approvedBy;
	private RegistrationUserType usertype;
	private RegistrationHandler hibernateLazyInitializer;
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
	public String getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}
	public String getReferenceId() {
		return referenceId;
	}
	public void setReferenceId(String referenceId) {
		this.referenceId = referenceId;
	}
	public String getApprovedBy() {
		return approvedBy;
	}
	public void setApprovedBy(String approvedBy) {
		this.approvedBy = approvedBy;
	}
	public RegistrationUserType getUsertype() {
		return usertype;
	}
	public void setUsertype(RegistrationUserType usertype) {
		this.usertype = usertype;
	}
	public RegistrationHandler getHibernateLazyInitializer() {
		return hibernateLazyInitializer;
	}
	public void setHibernateLazyInitializer(RegistrationHandler hibernateLazyInitializer) {
		this.hibernateLazyInitializer = hibernateLazyInitializer;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RegistrationUser [id=");
		builder.append(id);
		builder.append(", username=");
		builder.append(username);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", currentStatus=");
		builder.append(currentStatus);
		builder.append(", previousStatus=");
		builder.append(previousStatus);
		builder.append(", stateInterp=");
		builder.append(stateInterp);
		builder.append(", referenceId=");
		builder.append(referenceId);
		builder.append(", approvedBy=");
		builder.append(approvedBy);
		builder.append(", usertype=");
		builder.append(usertype);
		builder.append(", hibernateLazyInitializer=");
		builder.append(hibernateLazyInitializer);
		builder.append(", additionalProperties=");
		builder.append(additionalProperties);
		builder.append("]");
		return builder.toString();
	}
	
		
}
