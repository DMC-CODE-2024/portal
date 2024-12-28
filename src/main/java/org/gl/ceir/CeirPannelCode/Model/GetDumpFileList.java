package org.gl.ceir.CeirPannelCode.Model;

public class GetDumpFileList {
	
	private String id;
	private String tag;
	private String value;
	private String interpretation;
	private String listOrder;
	private String tagId;
	private String description;
	private String displayName;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getInterpretation() {
		return interpretation;
	}
	public void setInterpretation(String interpretation) {
		this.interpretation = interpretation;
	}
	public String getListOrder() {
		return listOrder;
	}
	public void setListOrder(String listOrder) {
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
	@Override
	public String toString() {
		return "GetDumpFileList [id=" + id + ", tag=" + tag + ", value=" + value + ", interpretation=" + interpretation
				+ ", listOrder=" + listOrder + ", tagId=" + tagId + ", description=" + description + ", displayName="
				+ displayName + ", getId()=" + getId() + ", getTag()=" + getTag() + ", getValue()=" + getValue()
				+ ", getInterpretation()=" + getInterpretation() + ", getListOrder()=" + getListOrder()
				+ ", getTagId()=" + getTagId() + ", getDescription()=" + getDescription() + ", getDisplayName()="
				+ getDisplayName() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
	
	

}
