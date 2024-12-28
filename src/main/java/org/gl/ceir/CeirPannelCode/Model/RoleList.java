package org.gl.ceir.CeirPannelCode.Model;

import java.util.HashMap;
import java.util.Map;

public class RoleList {
	private Integer id;
	private String role;
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "RoleList [id=" + id + ", role=" + role + ", additionalProperties=" + additionalProperties + "]";
	}
	
	
}
