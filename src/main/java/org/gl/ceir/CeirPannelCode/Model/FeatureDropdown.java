package org.gl.ceir.CeirPannelCode.Model;

public class FeatureDropdown {

	
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private Object category;
	private String name;
	private String logo;
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
	public Object getCategory() {
		return category;
	}
	public void setCategory(Object category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	@Override
	public String toString() {
		return "FeatureDropdown [id=" + id + ", createdOn=" + createdOn + ", modifiedOn=" + modifiedOn + ", category="
				+ category + ", name=" + name + ", logo=" + logo + "]";
	}
	
	
}
