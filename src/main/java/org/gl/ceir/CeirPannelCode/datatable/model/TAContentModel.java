package org.gl.ceir.CeirPannelCode.datatable.model;

import org.gl.ceir.CeirPannelCode.Model.User;
import org.springframework.stereotype.Component;

@Component
public class TAContentModel {
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String fileName;
	private String status;
	private Object transactionId;
	private Object userId;
	private String requestType;
	private Object filePath;
	private Integer no;
	private String company;
	private String trademark;
	private String productName;
	private String model;
	private String country;
	private String txFrequency;
	private String rxFrequency;
	private String trcIdentifier;
	private String typeOfEquipment;
	private String approvalDate;
	private String imei;
	private String serialNumber;
	private String manufactureringDate;
	private String manufacturerId;
	private String manufacturerName;
	private String companyName;
	private String phoneNumber;
	private String email;
	private User user;
	private String actualImei;
private String companyId;
private String commercialName;
private String expiryDate;

	public String getCommercialName() {
		return commercialName;
	}

	public void setCommercialName(String commercialName) {
		this.commercialName = commercialName;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getActualImei() {
		return actualImei;
	}

	public void setActualImei(String actualImei) {
		this.actualImei = actualImei;
	}

	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public String getManufactureringDate() {
		return manufactureringDate;
	}
	public void setManufactureringDate(String manufactureringDate) {
		this.manufactureringDate = manufactureringDate;
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Object getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(Object transactionId) {
		this.transactionId = transactionId;
	}
	public Object getUserId() {
		return userId;
	}
	public void setUserId(Object userId) {
		this.userId = userId;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public Object getFilePath() {
		return filePath;
	}
	public void setFilePath(Object filePath) {
		this.filePath = filePath;
	}
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
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
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getTxFrequency() {
		return txFrequency;
	}
	public void setTxFrequency(String txFrequency) {
		this.txFrequency = txFrequency;
	}
	public String getRxFrequency() {
		return rxFrequency;
	}
	public void setRxFrequency(String rxFrequency) {
		this.rxFrequency = rxFrequency;
	}
	public String getTrcIdentifier() {
		return trcIdentifier;
	}
	public void setTrcIdentifier(String trcIdentifier) {
		this.trcIdentifier = trcIdentifier;
	}
	public String getTypeOfEquipment() {
		return typeOfEquipment;
	}
	public void setTypeOfEquipment(String typeOfEquipment) {
		this.typeOfEquipment = typeOfEquipment;
	}
	public String getApprovalDate() {
		return approvalDate;
	}
	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "TAContentModel{" +
				"id=" + id +
				", createdOn='" + createdOn + '\'' +
				", modifiedOn='" + modifiedOn + '\'' +
				", fileName='" + fileName + '\'' +
				", status='" + status + '\'' +
				", transactionId=" + transactionId +
				", userId=" + userId +
				", requestType='" + requestType + '\'' +
				", filePath=" + filePath +
				", no=" + no +
				", company='" + company + '\'' +
				", trademark='" + trademark + '\'' +
				", productName='" + productName + '\'' +
				", model='" + model + '\'' +
				", country='" + country + '\'' +
				", txFrequency='" + txFrequency + '\'' +
				", rxFrequency='" + rxFrequency + '\'' +
				", trcIdentifier='" + trcIdentifier + '\'' +
				", typeOfEquipment='" + typeOfEquipment + '\'' +
				", approvalDate='" + approvalDate + '\'' +
				", imei='" + imei + '\'' +
				", serialNumber='" + serialNumber + '\'' +
				", manufactureringDate='" + manufactureringDate + '\'' +
				", manufacturerId='" + manufacturerId + '\'' +
				", manufacturerName='" + manufacturerName + '\'' +
				", companyName='" + companyName + '\'' +
				", phoneNumber='" + phoneNumber + '\'' +
				", email='" + email + '\'' +
				", user=" + user +
				", actualImei='" + actualImei + '\'' +
				", companyId='" + companyId + '\'' +
				", commercialName='" + commercialName + '\'' +
				", expiryDate='" + expiryDate + '\'' +
				'}';
	}
}
