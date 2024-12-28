package org.gl.ceir.CeirPannelCode.Model;

public class RuleEngineMapping {

	private Long id;
	private String createdOn;
	private String modifiedOn;
	private String feature;
	private String name;
	private String graceAction;
	private String postGraceAction;
	private Integer ruleOrder;
	private String userType;
	private String failedRuleActionGrace;
	private String failedRuleActionPostGrace;
	private String output;
	private String modifiedBy;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
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
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGraceAction() {
		return graceAction;
	}
	public void setGraceAction(String graceAction) {
		this.graceAction = graceAction;
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
	public String getOutput() {
		return output;
	}
	public void setOutput(String output) {
		this.output = output;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	@Override
	public String toString() {
		return "RuleEngnineMapping [id=" + id + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn + ", feature="
				+ feature + ", name=" + name + ", graceAction=" + graceAction + ", postGraceAction=" + postGraceAction
				+ ", ruleOrder=" + ruleOrder + ", userType=" + userType + ", failedRuleActionGrace="
				+ failedRuleActionGrace + ", failedRuleActionPostGrace=" + failedRuleActionPostGrace + ", output="
				+ output + ", modifiedBy=" + modifiedBy + "]";
	}
}
