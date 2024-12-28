package org.gl.ceir.CeirPannelCode.Model;

import org.springframework.stereotype.Component;

@Component
public class RuleFeatureName {
	private String featureName;

	public String getFeatureName() {
		return featureName;
	}

	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("RuleFeatureName [featureName=");
		builder.append(featureName);
		builder.append("]");
		return builder.toString();
	}
}
