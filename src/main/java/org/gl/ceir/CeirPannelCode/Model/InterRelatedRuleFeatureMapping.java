package org.gl.ceir.CeirPannelCode.Model;

import org.springframework.stereotype.Component;
@Component
public class InterRelatedRuleFeatureMapping {
	private Integer id;
	private String ruleName;
	private String featureName;
	private String actions;
	private Object createdOn;
	private Object modifiedOn;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRuleName() {
		return ruleName;
	}
	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	public String getActions() {
		return actions;
	}
	public void setActions(String actions) {
		this.actions = actions;
	}
	public Object getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(Object createdOn) {
		this.createdOn = createdOn;
	}
	public Object getModifiedOn() {
		return modifiedOn;
	}
	public void setModifiedOn(Object modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("InterRelatedRuleFeatureMapping [id=");
		builder.append(id);
		builder.append(", ruleName=");
		builder.append(ruleName);
		builder.append(", featureName=");
		builder.append(featureName);
		builder.append(", actions=");
		builder.append(actions);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append("]");
		return builder.toString();
	}

}
