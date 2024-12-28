package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class RuleFeatureMappingContent {
	private Integer id;
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
	public String getOutput() {
		return output;
	}
	public void setOutput(String output) {
		this.output = output;
	}
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
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RuleFeatureMappingContent [id=");
		builder.append(id);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", feature=");
		builder.append(feature);
		builder.append(", name=");
		builder.append(name);
		builder.append(", graceAction=");
		builder.append(graceAction);
		builder.append(", postGraceAction=");
		builder.append(postGraceAction);
		builder.append(", ruleOrder=");
		builder.append(ruleOrder);
		builder.append(", userType=");
		builder.append(userType);
		builder.append(", failedRuleActionGrace=");
		builder.append(failedRuleActionGrace);
		builder.append(", failedRuleActionPostGrace=");
		builder.append(failedRuleActionPostGrace);
		builder.append(", output=");
		builder.append(output);
		builder.append("]");
		return builder.toString();
	}
	
}
