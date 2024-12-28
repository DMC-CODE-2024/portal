package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class UserfeatureContent {

	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String usertypeInterp;
	private String featureInterp;
	private Integer period;
	private String periodInterp;
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
	public String getUsertypeInterp() {
		return usertypeInterp;
	}
	public void setUsertypeInterp(String usertypeInterp) {
		this.usertypeInterp = usertypeInterp;
	}
	public String getFeatureInterp() {
		return featureInterp;
	}
	public void setFeatureInterp(String featureInterp) {
		this.featureInterp = featureInterp;
	}
	public Integer getPeriod() {
		return period;
	}
	public void setPeriod(Integer period) {
		this.period = period;
	}
	public String getPeriodInterp() {
		return periodInterp;
	}
	public void setPeriodInterp(String periodInterp) {
		this.periodInterp = periodInterp;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("UserfeatureContent [id=");
		builder.append(id);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", usertypeInterp=");
		builder.append(usertypeInterp);
		builder.append(", featureInterp=");
		builder.append(featureInterp);
		builder.append(", period=");
		builder.append(period);
		builder.append(", periodInterp=");
		builder.append(periodInterp);
		builder.append("]");
		return builder.toString();
	} 
	
}
