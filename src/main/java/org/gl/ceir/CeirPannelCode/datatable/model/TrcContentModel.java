package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.gl.ceir.CeirPannelCode.Model.AttachedFile;
import org.springframework.stereotype.Component;
@Component
public class TrcContentModel {
	private Integer id;
	private String manufacturerId;
	private String manufacturerName;
	private String country;
	private String requestDate;
	private String tac;
	private Integer approveStatus;
	private Integer adminApproveStatus;
	private Integer userId;
	private String userType;
	private Integer adminUserId;
	private String adminUserType;
	private String approveDisapproveDate;
	private String remark;
	private String adminRemark;
	private String fileName;
	private String createdOn;
	private String modifiedOn;
	private String txnId;
	private String stateInterp;
	private String adminStateInterp;
	private String trademark;
	private String productName;
	private String modelNumber;
	private String manufacturerCountry;
	private String frequencyRange;
	private String productNameInterp;
	private String modelNumberInterp;
	private String userDisplayName;
	private List<AttachedFile> attachedFiles; 
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getManufacturerId() {
		return manufacturerId;
	}
	public void setManufacturerId(String manufacturerId) {
		this.manufacturerId = manufacturerId;
	}
	public String getManufacturerName() {
		return manufacturerName;
	}
	public void setManufacturerName(String manufacturerName) {
		this.manufacturerName = manufacturerName;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}
	public String getTac() {
		return tac;
	}
	public void setTac(String tac) {
		this.tac = tac;
	}
	public Integer getApproveStatus() {
		return approveStatus;
	}
	public void setApproveStatus(Integer approveStatus) {
		this.approveStatus = approveStatus;
	}
	public Integer getAdminApproveStatus() {
		return adminApproveStatus;
	}
	public void setAdminApproveStatus(Integer adminApproveStatus) {
		this.adminApproveStatus = adminApproveStatus;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public Integer getAdminUserId() {
		return adminUserId;
	}
	public void setAdminUserId(Integer adminUserId) {
		this.adminUserId = adminUserId;
	}
	public String getAdminUserType() {
		return adminUserType;
	}
	public void setAdminUserType(String adminUserType) {
		this.adminUserType = adminUserType;
	}
	public String getApproveDisapproveDate() {
		return approveDisapproveDate;
	}
	public void setApproveDisapproveDate(String approveDisapproveDate) {
		this.approveDisapproveDate = approveDisapproveDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getAdminRemark() {
		return adminRemark;
	}
	public void setAdminRemark(String adminRemark) {
		this.adminRemark = adminRemark;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
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
	public String getTxnId() {
		return txnId;
	}
	public void setTxnId(String txnId) {
		this.txnId = txnId;
	}
	public String getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}
	public String getAdminStateInterp() {
		return adminStateInterp;
	}
	public void setAdminStateInterp(String adminStateInterp) {
		this.adminStateInterp = adminStateInterp;
	}
	public String getTrademark() {
		return trademark;
	}
	public void setTrademark(String trademark) {
		this.trademark = trademark;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getModelNumber() {
		return modelNumber;
	}
	public void setModelNumber(String modelNumber) {
		this.modelNumber = modelNumber;
	}
	public String getManufacturerCountry() {
		return manufacturerCountry;
	}
	public void setManufacturerCountry(String manufacturerCountry) {
		this.manufacturerCountry = manufacturerCountry;
	}
	public String getFrequencyRange() {
		return frequencyRange;
	}
	public void setFrequencyRange(String frequencyRange) {
		this.frequencyRange = frequencyRange;
	}
	public String getProductNameInterp() {
		return productNameInterp;
	}
	public void setProductNameInterp(String productNameInterp) {
		this.productNameInterp = productNameInterp;
	}
	public String getModelNumberInterp() {
		return modelNumberInterp;
	}
	public void setModelNumberInterp(String modelNumberInterp) {
		this.modelNumberInterp = modelNumberInterp;
	}
	public String getUserDisplayName() {
		return userDisplayName;
	}
	public void setUserDisplayName(String userDisplayName) {
		this.userDisplayName = userDisplayName;
	}
	public List<AttachedFile> getAttachedFiles() {
		return attachedFiles;
	}
	public void setAttachedFiles(List<AttachedFile> attachedFiles) {
		this.attachedFiles = attachedFiles;
	}
	public Map<String, Object> getAdditionalProperties() {
		return additionalProperties;
	}
	public void setAdditionalProperties(Map<String, Object> additionalProperties) {
		this.additionalProperties = additionalProperties;
	}
	@Override
	public String toString() {
		return "TrcContentModel [id=" + id + ", manufacturerId=" + manufacturerId + ", manufacturerName="
				+ manufacturerName + ", country=" + country + ", requestDate=" + requestDate + ", tac=" + tac
				+ ", approveStatus=" + approveStatus + ", adminApproveStatus=" + adminApproveStatus + ", userId="
				+ userId + ", userType=" + userType + ", adminUserId=" + adminUserId + ", adminUserType="
				+ adminUserType + ", approveDisapproveDate=" + approveDisapproveDate + ", remark=" + remark
				+ ", adminRemark=" + adminRemark + ", fileName=" + fileName + ", createdOn=" + createdOn
				+ ", modifiedOn=" + modifiedOn + ", txnId=" + txnId + ", stateInterp=" + stateInterp
				+ ", adminStateInterp=" + adminStateInterp + ", trademark=" + trademark + ", productName=" + productName
				+ ", modelNumber=" + modelNumber + ", manufacturerCountry=" + manufacturerCountry + ", frequencyRange="
				+ frequencyRange + ", productNameInterp=" + productNameInterp + ", modelNumberInterp="
				+ modelNumberInterp + ", userDisplayName=" + userDisplayName + ", attachedFiles=" + attachedFiles
				+ ", additionalProperties=" + additionalProperties + "]";
	}
	
	
}
