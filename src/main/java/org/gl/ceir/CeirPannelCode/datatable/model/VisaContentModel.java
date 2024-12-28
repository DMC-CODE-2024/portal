package org.gl.ceir.CeirPannelCode.datatable.model;

import org.springframework.stereotype.Component;

@Component
public class VisaContentModel {
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private Integer visaType;
	private String visaNumber;
	private String visaFileName;
	private Object entryDateInCountry;
	private String visaExpiryDate;
	private String visaTypeInterp,txnId,nid;
	private Integer status;
	private Object stateInterp;
	private Integer userId;
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
	public Integer getVisaType() {
		return visaType;
	}
	public void setVisaType(Integer visaType) {
		this.visaType = visaType;
	}
	public String getVisaNumber() {
		return visaNumber;
	}
	public void setVisaNumber(String visaNumber) {
		this.visaNumber = visaNumber;
	}
	public String getVisaFileName() {
		return visaFileName;
	}
	public void setVisaFileName(String visaFileName) {
		this.visaFileName = visaFileName;
	}
	public Object getEntryDateInCountry() {
		return entryDateInCountry;
	}
	public void setEntryDateInCountry(Object entryDateInCountry) {
		this.entryDateInCountry = entryDateInCountry;
	}
	public String getVisaExpiryDate() {
		return visaExpiryDate;
	}
	public void setVisaExpiryDate(String visaExpiryDate) {
		this.visaExpiryDate = visaExpiryDate;
	}
	public String getVisaTypeInterp() {
		return visaTypeInterp;
	}
	public void setVisaTypeInterp(String visaTypeInterp) {
		this.visaTypeInterp = visaTypeInterp;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Object getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(Object stateInterp) {
		this.stateInterp = stateInterp;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("VisaContentModel [id=");
		builder.append(id);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", visaType=");
		builder.append(visaType);
		builder.append(", visaNumber=");
		builder.append(visaNumber);
		builder.append(", visaFileName=");
		builder.append(visaFileName);
		builder.append(", entryDateInCountry=");
		builder.append(entryDateInCountry);
		builder.append(", visaExpiryDate=");
		builder.append(visaExpiryDate);
		builder.append(", visaTypeInterp=");
		builder.append(visaTypeInterp);
		builder.append(", txnId=");
		builder.append(txnId);
		builder.append(", nid=");
		builder.append(nid);
		builder.append(", status=");
		builder.append(status);
		builder.append(", stateInterp=");
		builder.append(stateInterp);
		builder.append(", userId=");
		builder.append(userId);
		builder.append("]");
		return builder.toString();
	}
	
	
	
	
}
