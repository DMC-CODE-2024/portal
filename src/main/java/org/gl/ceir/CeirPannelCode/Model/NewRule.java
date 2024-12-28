package org.gl.ceir.CeirPannelCode.Model;

public class NewRule {

	private String failedRuleActionGrace;
	private String failedRuleActionPostGrace;
	private String feature;
	private String graceAction;
	private Integer id;
	private String name;
	private String postGraceAction;
	private Integer ruleOrder;
	private String userType;
	private String output,modifiedBy;
	private String publicIp,browser,existOrNot;
	private Long userId;
	private Integer featureId;
	private Integer userTypeId;
	private String roleType;
	public String userName;
	 
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
	
	public String getUserName() {
		return userName;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public Integer getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(Integer userTypeId) {
		this.userTypeId = userTypeId;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	

	public String getOutput() {
		return output;
	}
	public void setOutput(String output) {
		this.output = output;
	}
	public String getFailedRuleActionGrace() {
		return failedRuleActionGrace;
	}
	public void setFailedRuleActionGrace(String failedRuleActionGrace) {
		this.failedRuleActionGrace = failedRuleActionGrace;
	}
	public String getFailedRuleActionPostGrace() {
		return failedRuleActionPostGrace;
	}
	
	public void setFailedRuleActionPostGrace(String failedRuleActionPostGrace) {
		this.failedRuleActionPostGrace = failedRuleActionPostGrace;
	}
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
	public String getGraceAction() {
		return graceAction;
	}
	public void setGraceAction(String graceAction) {
		this.graceAction = graceAction;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPostGraceAction() {
		return postGraceAction;
	}
	public void setPostGraceAction(String postGraceAction) {
		this.postGraceAction = postGraceAction;
	}
	public Integer getRuleOrder() {
		return ruleOrder;
	}
	public void setRuleOrder(Integer ruleOrder) {
		this.ruleOrder = ruleOrder;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getExistOrNot() {
		return existOrNot;
	}
	public void setExistOrNot(String existOrNot) {
		this.existOrNot = existOrNot;
	}
	@Override
	public String toString() {
		return "NewRule [failedRuleActionGrace=" + failedRuleActionGrace + ", failedRuleActionPostGrace="
				+ failedRuleActionPostGrace + ", feature=" + feature + ", graceAction=" + graceAction + ", id=" + id
				+ ", name=" + name + ", postGraceAction=" + postGraceAction + ", ruleOrder=" + ruleOrder + ", userType="
				+ userType + ", output=" + output + ", modifiedBy=" + modifiedBy + ", publicIp=" + publicIp
				+ ", browser=" + browser + ", existOrNot=" + existOrNot + ", userName=" + userName + ", userId="
				+ userId + ", featureId=" + featureId + ", userTypeId=" + userTypeId + ", roleType=" + roleType + "]";
	}
	 

}

