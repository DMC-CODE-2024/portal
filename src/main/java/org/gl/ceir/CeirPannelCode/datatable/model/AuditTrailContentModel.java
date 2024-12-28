package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class AuditTrailContentModel {

	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String executionTime;
	private Integer statusCode;
	private Integer count,count2,failureCount;
	private String status;
	private String errorMessage;
	private String moduleName;
	private String featureName;
	private String action;
	private String info;
	private String serverName;
	private String roleType;
	private String publicIp;
	private String browser;
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
	public String getExecutionTime() {
		return executionTime;
	}
	public void setExecutionTime(String executionTime) {
		this.executionTime = executionTime;
	}
	public Integer getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(Integer statusCode) {
		this.statusCode = statusCode;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getCount2() {
		return count2;
	}
	public void setCount2(Integer count2) {
		this.count2 = count2;
	}
	public Integer getFailureCount() {
		return failureCount;
	}
	public void setFailureCount(Integer failureCount) {
		this.failureCount = failureCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getServerName() {
		return serverName;
	}
	public void setServerName(String serverName) {
		this.serverName = serverName;
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
	@Override
	public String toString() {
		return "AuditTrailContentModel [id=" + id + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn
				+ ", executionTime=" + executionTime + ", statusCode=" + statusCode + ", count=" + count + ", count2="
				+ count2 + ", failureCount=" + failureCount + ", status=" + status + ", errorMessage=" + errorMessage
				+ ", moduleName=" + moduleName + ", featureName=" + featureName + ", action=" + action + ", info="
				+ info + ", serverName=" + serverName + ", roleType=" + roleType + ", publicIp=" + publicIp
				+ ", browser=" + browser + "]";
	}
	
	
	
}