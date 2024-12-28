package org.gl.ceir.CeirPannelCode.Model;

public class SystemConfigListDb {
	

	private String createdOn;
	private String modifiedOn;
	private String tag;
	private String value; 
	private String interp;
	private Integer listOrder;
	private String tagId;
	private String description;
	private String displayName;
	private String modifiedBy;

	private String interpretation;

	public String getInterpretation() {
		return interpretation;
	}

	public void setInterpretation(String interpretation) {
		this.interpretation = interpretation;
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
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getInterp() {
		return interp;
	}
	public void setInterp(String interp) {
		this.interp = interp;
	}
	public Integer getListOrder() {
		return listOrder;
	}
	public void setListOrder(Integer listOrder) {
		this.listOrder = listOrder;
	}
	public String getTagId() {
		return tagId;
	}
	public void setTagId(String tagId) {
		this.tagId = tagId;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder("SystemConfigListDb{");
		sb.append("createdOn='").append(createdOn).append('\'');
		sb.append(", modifiedOn='").append(modifiedOn).append('\'');
		sb.append(", tag='").append(tag).append('\'');
		sb.append(", value='").append(value).append('\'');
		sb.append(", interp='").append(interp).append('\'');
		sb.append(", listOrder=").append(listOrder);
		sb.append(", tagId='").append(tagId).append('\'');
		sb.append(", description='").append(description).append('\'');
		sb.append(", displayName='").append(displayName).append('\'');
		sb.append(", modifiedBy='").append(modifiedBy).append('\'');
		sb.append(", interpretation='").append(interpretation).append('\'');
		sb.append('}');
		return sb.toString();
	}


}
