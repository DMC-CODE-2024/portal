package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class Usertype  {
	
	private Integer id;
	private String usertypeName;
	private String createdOn;
	private String modifiedOn;
	private Integer status;
	private String statusInterp;
	private Integer selfRegister;
	private RegistrationHandler hibernateLazyInitializer;
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
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getStatusInterp() {
		return statusInterp;
	}
	public void setStatusInterp(String statusInterp) {
		this.statusInterp = statusInterp;
	}
	public Integer getSelfRegister() {
		return selfRegister;
	}
	public void setSelfRegister(Integer selfRegister) {
		this.selfRegister = selfRegister;
	}
	public RegistrationHandler getHibernateLazyInitializer() {
		return hibernateLazyInitializer;
	}
	public void setHibernateLazyInitializer(RegistrationHandler hibernateLazyInitializer) {
		this.hibernateLazyInitializer = hibernateLazyInitializer;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Usertype [id=");
		builder.append(id);
		builder.append(", usertypeName=");
		builder.append(usertypeName);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", status=");
		builder.append(status);
		builder.append(", statusInterp=");
		builder.append(statusInterp);
		builder.append(", selfRegister=");
		builder.append(selfRegister);
		builder.append(", hibernateLazyInitializer=");
		builder.append(hibernateLazyInitializer);
		builder.append("]");
		return builder.toString();
	}
	
}
