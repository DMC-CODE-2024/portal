package org.gl.ceir.CeirPannelCode.Model;

public class PeriodValidate {

	private long usertypeId;
	private long featureId;
	public long getUsertypeId() {
		return usertypeId;
	}
	public void setUsertypeId(long usertypeId) {
		this.usertypeId = usertypeId;
	}
	public long getFeatureId() {
		return featureId;
	}
	public void setFeatureId(long featureId) {
		this.featureId = featureId;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("PeriodValidate [usertypeId=");
		builder.append(usertypeId);
		builder.append(", featureId=");
		builder.append(featureId);
		builder.append("]");
		return builder.toString();
	}
	public PeriodValidate(long usertypeId, long featureId) {
		super();
		this.usertypeId = usertypeId;
		this.featureId = featureId;
	}
	
}
