package org.gl.ceir.CeirPannelCode.Model;

import java.util.HashMap;
import java.util.Map;

public class UserDepartment {


private String createdOn;
private String departmentId;
private String modifiedOn;
private String name,departmentFilename;
private Map<String, Object> additionalProperties = new HashMap<String, Object>();
@Override
public String toString() {
	return "UserDepartment [createdOn=" + createdOn + ", departmentId=" + departmentId + ", modifiedOn=" + modifiedOn
			+ ", name=" + name + ", departmentFilename=" + departmentFilename + ", additionalProperties="
			+ additionalProperties + "]";
}
public String getCreatedOn() {
	return createdOn;
}
public void setCreatedOn(String createdOn) {
	this.createdOn = createdOn;
}
public String getDepartmentId() {
	return departmentId;
}
public void setDepartmentId(String departmentId) {
	this.departmentId = departmentId;
}
public String getModifiedOn() {
	return modifiedOn;
}
public void setModifiedOn(String modifiedOn) {
	this.modifiedOn = modifiedOn;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getDepartmentFilename() {
	return departmentFilename;
}
public void setDepartmentFilename(String departmentFilename) {
	this.departmentFilename = departmentFilename;
}
public Map<String, Object> getAdditionalProperties() {
	return additionalProperties;
}
public void setAdditionalProperties(Map<String, Object> additionalProperties) {
	this.additionalProperties = additionalProperties;
}



}
