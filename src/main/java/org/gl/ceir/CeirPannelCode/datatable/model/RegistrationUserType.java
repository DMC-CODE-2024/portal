package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.Map;

public class RegistrationUserType {

	
	private Integer id;
	private String usertypeName;
	private String createdOn;
	private String modifiedOn;

	private RegistrationHandler hibernateLazyInitializer;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsertypeName() {
		return usertypeName;
	}
	public void setUsertypeName(String usertypeName) {
		this.usertypeName = usertypeName;
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
	public RegistrationHandler getHibernateLazyInitializer() {
		return hibernateLazyInitializer;
	}
	public void setHibernateLazyInitializer(RegistrationHandler hibernateLazyInitializer) {
		this.hibernateLazyInitializer = hibernateLazyInitializer;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "RegistrationUserType [id=" + id + ", usertypeName=" + usertypeName + ", createdOn=" + createdOn
				+ ", modifiedOn=" + modifiedOn + ", hibernateLazyInitializer=" + hibernateLazyInitializer
				+ ", additionalProperties=" + additionalProperties + "]";
	}
	
}
