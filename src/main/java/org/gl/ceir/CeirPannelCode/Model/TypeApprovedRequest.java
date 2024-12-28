package org.gl.ceir.CeirPannelCode.Model;

public class TypeApprovedRequest {
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String fileName;
	private String status;
	private String transactionId;
	private String userId;
	private String requestType;
	private String filePath;
	private Integer pageNo, pageSize;
	private String trademark;
	private String productName;
	private String model;
	private String trcIdentifier;
	private String typeOfEquipment;
	private String remarks;
	private String imei;
	private String serialNumber;
	private String manufactureringDate;
	private String manufacturerId;
	private String manufacturerName;
	private String companyName;
	private String phoneNumber;
	private String email;
	private String uploadedBy;

	private String companyId;
	private String company;
	private String commercialName;
	private String expiryDate;
	private String country;

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

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
	private AuditTrailModel auditTrailModel;
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
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
	public AuditTrailModel getAuditTrailModel() {
		return auditTrailModel;
	}
	public void setAuditTrailModel(AuditTrailModel auditTrailModel) {
		this.auditTrailModel = auditTrailModel;
	}
	
	public String getUploadedBy() {
		return uploadedBy;
	}
	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder("TypeApprovedRequest{");
		sb.append("id=").append(id);
		sb.append(", createdOn='").append(createdOn).append('\'');
		sb.append(", modifiedOn='").append(modifiedOn).append('\'');
		sb.append(", fileName='").append(fileName).append('\'');
		sb.append(", status='").append(status).append('\'');
		sb.append(", transactionId='").append(transactionId).append('\'');
		sb.append(", userId='").append(userId).append('\'');
		sb.append(", requestType='").append(requestType).append('\'');
		sb.append(", filePath='").append(filePath).append('\'');
		sb.append(", pageNo=").append(pageNo);
		sb.append(", pageSize=").append(pageSize);
		sb.append(", trademark='").append(trademark).append('\'');
		sb.append(", productName='").append(productName).append('\'');
		sb.append(", model='").append(model).append('\'');
		sb.append(", trcIdentifier='").append(trcIdentifier).append('\'');
		sb.append(", typeOfEquipment='").append(typeOfEquipment).append('\'');
		sb.append(", remarks='").append(remarks).append('\'');
		sb.append(", imei='").append(imei).append('\'');
		sb.append(", serialNumber='").append(serialNumber).append('\'');
		sb.append(", manufactureringDate='").append(manufactureringDate).append('\'');
		sb.append(", manufacturerId='").append(manufacturerId).append('\'');
		sb.append(", manufacturerName='").append(manufacturerName).append('\'');
		sb.append(", companyName='").append(companyName).append('\'');
		sb.append(", phoneNumber='").append(phoneNumber).append('\'');
		sb.append(", email='").append(email).append('\'');
		sb.append(", uploadedBy='").append(uploadedBy).append('\'');
		sb.append(", companyId='").append(companyId).append('\'');
		sb.append(", company='").append(company).append('\'');
		sb.append(", commercialName='").append(commercialName).append('\'');
		sb.append(", expiryDate='").append(expiryDate).append('\'');
		sb.append(", country='").append(country).append('\'');
		sb.append(", auditTrailModel=").append(auditTrailModel);
		sb.append('}');
		return sb.toString();
	}


}
