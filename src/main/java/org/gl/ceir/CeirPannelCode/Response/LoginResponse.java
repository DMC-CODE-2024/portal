package org.gl.ceir.CeirPannelCode.Response;

import java.util.List;

import org.gl.ceir.CeirPannelCode.Model.Usertype;


public class LoginResponse {
	private String response;
	private Integer statusCode;
	private List<Usertype> userRoles;
	private String username; 
	private Integer userId;
	private String name; 
	private String primaryRole;
	private Integer primaryRoleId; 
	private String status;
	private String operatorTypeName;
    private Integer operatorTypeId;
    private String period;
    private String userLanguage;
    private String tag;
	private Integer statusValue;
	private Integer selfRegister;
	private String defaultLink;
	private String token;
    
	public String getOperatorTypeName() {
		return operatorTypeName;
	}
	public void setOperatorTypeName(String operatorTypeName) {
		this.operatorTypeName = operatorTypeName;
	}
	public Integer getOperatorTypeId() {
		return operatorTypeId;
	}
	public void setOperatorTypeId(Integer operatorTypeId) {
		this.operatorTypeId = operatorTypeId;
	}
	public String getResponse() {
		return response;
	}
	public void setResponse(String response) {
		this.response = response;
	}
	public Integer getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(Integer statusCode) {
		this.statusCode = statusCode;
	}
	  
	public List<Usertype> getUserRoles() {
		return userRoles;
	}
	public void setUserRoles(List<Usertype> userRoles) {
		this.userRoles = userRoles;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrimaryRole() {
		return primaryRole;
	}
	public void setPrimaryRole(String primaryRole) {
		this.primaryRole = primaryRole;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	public Integer getPrimaryRoleId() {
		return primaryRoleId;
	}
	public void setPrimaryRoleId(Integer primaryRoleId) {
		this.primaryRoleId = primaryRoleId;
	}
	
	
	public String getUserLanguage() {
		return userLanguage;
	}
	public void setUserLanguage(String userLanguage) {
		this.userLanguage = userLanguage;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	
	public Integer getStatusValue() {
		return statusValue;
	}
	public void setStatusValue(Integer statusValue) {
		this.statusValue = statusValue;
	}
	public Integer getSelfRegister() {
		return selfRegister;
	}
	public void setSelfRegister(Integer selfRegister) {
		this.selfRegister = selfRegister;
	}
	public String getDefaultLink() {
		return defaultLink;
	}
	public void setDefaultLink(String defaultLink) {
		this.defaultLink = defaultLink;
	}
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("LoginResponse [response=");
		builder.append(response);
		builder.append(", statusCode=");
		builder.append(statusCode);
		builder.append(", userRoles=");
		builder.append(userRoles);
		builder.append(", username=");
		builder.append(username);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", name=");
		builder.append(name);
		builder.append(", primaryRole=");
		builder.append(primaryRole);
		builder.append(", primaryRoleId=");
		builder.append(primaryRoleId);
		builder.append(", status=");
		builder.append(status);
		builder.append(", operatorTypeName=");
		builder.append(operatorTypeName);
		builder.append(", operatorTypeId=");
		builder.append(operatorTypeId);
		builder.append(", period=");
		builder.append(period);
		builder.append(", userLanguage=");
		builder.append(userLanguage);
		builder.append(", tag=");
		builder.append(tag);
		builder.append(", statusValue=");
		builder.append(statusValue);
		builder.append(", selfRegister=");
		builder.append(selfRegister);
		builder.append(", defaultLink=");
		builder.append(defaultLink);
		builder.append("]");
		return builder.toString();
	}
	
	
}