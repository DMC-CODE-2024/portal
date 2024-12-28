package org.gl.ceir.CeirPannelCode.Model;



public class Usertype { 
	private Integer id;
	private String usertypeName;
	private String createdOn;
	private String modifiedOn;

	//private String usertypeInterp;
	
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
	@Override
	public String toString() {
		return "Usertype [id=" + id + ", usertypeName=" + usertypeName + ", createdOn=" + createdOn + ", modifiedOn="
				+ modifiedOn + "]";
	}
	
  
	
}